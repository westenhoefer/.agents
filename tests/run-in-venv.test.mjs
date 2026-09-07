import assert from "node:assert/strict";
import { spawnSync } from "node:child_process";
import { copyFileSync, mkdirSync, mkdtempSync, rmSync, writeFileSync } from "node:fs";
import path from "node:path";
import { after, before, test } from "node:test";
import { fileURLToPath } from "node:url";

// These tests use stand-ins, not Python or installed project dependencies.
const root = fileURLToPath(new URL("../", import.meta.url));
const scripts = path.join(root, "skills/python-environment/scripts");
const windows = process.platform === "win32";
const bash = process.env.TEST_BASH ?? (windows ? "C:/Program Files/Git/bin/bash.exe" : "/bin/bash");
const powershell = process.env.TEST_POWERSHELL ?? "powershell.exe";
let fixture;
let environment;

before(() => {
  const temporaryRoot = path.join(root, ".test-tmp");
  mkdirSync(temporaryRoot, { recursive: true });
  fixture = mkdtempSync(path.join(temporaryRoot, "venv wrappers "));
  const globalBin = path.join(fixture, "global");
  mkdirSync(globalBin);
  writeFileSync(path.join(globalBin, "global-only"), "#!/bin/sh\nprintf 'GLOBAL FALLBACK\\n'\nexit 91\n", { mode: 0o755 });
  writeFileSync(path.join(globalBin, "global-only.cmd"), "@echo GLOBAL FALLBACK\r\n@exit /b 91\r\n");
  environment = { ...process.env };
  const pathKey = Object.keys(environment).find((key) => key.toUpperCase() === "PATH");
  environment[pathKey] = `${globalBin}${path.delimiter}${environment[pathKey]}`;
});

after(() => {
  if (fixture) rmSync(fixture, { recursive: true, force: true });
});

function run(shell, cwd, args) {
  const command = shell === "bash" ? bash : powershell;
  const wrapper = path.join(scripts, shell === "bash" ? "run-in-venv.sh" : "run-in-venv.ps1");
  const prefix = shell === "bash" ? [wrapper] : ["-NoProfile", "-NonInteractive", "-File", wrapper];
  const result = spawnSync(command, [...prefix, ...args], {
    cwd,
    env: environment,
    encoding: "utf8",
    timeout: 20_000,
  });
  assert.ifError(result.error);
  return result;
}

function bashProject(name, venv = ".venv") {
  const cwd = path.join(fixture, name);
  const bin = path.join(cwd, venv, "bin");
  mkdirSync(bin, { recursive: true });
  writeFileSync(path.join(bin, "python"), "#!/bin/sh\nprintf 'LOCAL PYTHON\\n'\nprintf '<%s>\\n' \"$@\"\n", { mode: 0o755 });
  return { cwd, bin };
}

test("Bash uses the selected interpreter, preserves arguments, and routes modules", () => {
  const { cwd } = bashProject("bash selected");
  for (const tool of ["python", "pytest", "ruff"]) {
    const result = run("bash", cwd, [tool, "argument with spaces", "--flag"]);
    assert.equal(result.status, 0, result.stderr);
    assert.match(result.stdout, /LOCAL PYTHON/);
    assert.match(result.stdout, /<argument with spaces>\s+<--flag>/);
    if (tool !== "python") assert.ok(result.stdout.includes(`<-m>\n<${tool}>`));
  }
});

test("Bash runs local tools, preserves exit status, and refuses global fallback", () => {
  const { cwd, bin } = bashProject("bash tools", "venv");
  writeFileSync(path.join(bin, "local-check"), "#!/bin/sh\nprintf 'LOCAL TOOL <%s>\\n' \"$1\"\nexit 23\n", { mode: 0o755 });
  const local = run("bash", cwd, ["local-check", "argument with spaces"]);
  assert.equal(local.status, 23, local.stderr);
  assert.match(local.stdout, /LOCAL TOOL <argument with spaces>/);
  const missing = run("bash", cwd, ["global-only"]);
  assert.equal(missing.status, 127);
  assert.match(missing.stderr, /global fallback is disabled/);
  assert.doesNotMatch(missing.stdout, /GLOBAL FALLBACK/);
});

test("Bash refuses missing environments and tool paths", () => {
  const empty = path.join(fixture, "empty bash");
  mkdirSync(empty);
  assert.equal(run("bash", empty, ["python"]).status, 1);
  assert.equal(run("bash", empty, []).status, 2);
  const { cwd } = bashProject("bash traversal");
  for (const tool of ["../global-only", "..\\global-only", "/bin/sh", ".", ".."]) {
    assert.equal(run("bash", cwd, [tool]).status, 2, tool);
  }
});

test("Bash prefers venv over .venv within the native layout", () => {
  const { cwd } = bashProject("bash precedence", "venv");
  const alternate = path.join(cwd, ".venv/bin");
  mkdirSync(alternate, { recursive: true });
  writeFileSync(path.join(alternate, "python"), "#!/bin/sh\nexit 91\n", { mode: 0o755 });
  assert.equal(run("bash", cwd, ["python"]).status, 0);
});

test("PowerShell uses the explicit interpreter and refuses global tools", { skip: !windows }, () => {
  const cwd = path.join(fixture, "powershell selected");
  const bin = path.join(cwd, ".venv/Scripts");
  mkdirSync(bin, { recursive: true });
  // Node renamed to python.exe proves the exact selected executable is used.
  copyFileSync(process.execPath, path.join(bin, "python.exe"));
  const interpreter = run("powershell", cwd, ["python", "--version"]);
  assert.equal(interpreter.status, 0, interpreter.stderr);
  assert.equal(interpreter.stdout.trim(), process.version);
  writeFileSync(path.join(bin, "local-check.cmd"), "@echo LOCAL TOOL %~1\r\n@exit /b 23\r\n");
  const local = run("powershell", cwd, ["local-check", "argument with spaces"]);
  assert.equal(local.status, 23, local.stderr);
  assert.match(local.stdout, /LOCAL TOOL argument with spaces/);
  const missing = run("powershell", cwd, ["global-only"]);
  assert.equal(missing.status, 127);
  assert.match(missing.stderr, /global fallback is disabled/);
  assert.doesNotMatch(missing.stdout, /GLOBAL FALLBACK/);
  for (const tool of ["../global-only", "..\\global-only", ".", ".."]) {
    assert.equal(run("powershell", cwd, [tool]).status, 2, tool);
  }
});

test("PowerShell refuses missing environments and missing arguments", { skip: !windows }, () => {
  const cwd = path.join(fixture, "empty powershell");
  mkdirSync(cwd);
  assert.equal(run("powershell", cwd, ["python"]).status, 1);
  assert.equal(run("powershell", cwd, []).status, 2);
});
