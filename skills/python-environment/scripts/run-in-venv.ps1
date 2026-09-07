param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]] $ToolArgs
)

function Show-Usage {
    @"
Usage:
  .\run-in-venv.ps1 <tool> [args...]

Examples:
  .\run-in-venv.ps1 python tests/test_example.py
  .\run-in-venv.ps1 pytest tests/test_example.py
  .\run-in-venv.ps1 ruff check .
  .\run-in-venv.ps1 pyright .
  .\run-in-venv.ps1 python -m pytest tests/test_example.py

The script selects venv/ or .venv/ and executes its interpreter or local tool.
Missing tools fail rather than falling back to a global executable.
"@
}

if (-not $ToolArgs -or $ToolArgs.Count -eq 0) {
    Show-Usage
    exit 2
}

$candidates = @(
    @{ Bin = "venv\Scripts"; Python = "venv\Scripts\python.exe" },
    @{ Bin = ".venv\Scripts"; Python = ".venv\Scripts\python.exe" },
    @{ Bin = "venv/bin"; Python = "venv/bin/python" },
    @{ Bin = ".venv/bin"; Python = ".venv/bin/python" }
)

$selected = $null
foreach ($candidate in $candidates) {
    if (Test-Path -LiteralPath $candidate.Python -PathType Leaf) {
        $selected = $candidate
        break
    }
}

if (-not $selected) {
    Write-Error "No local virtual environment found: expected venv/ or .venv/."
    exit 1
}

$venvBin = (Resolve-Path -LiteralPath $selected.Bin).Path
$python = (Resolve-Path -LiteralPath $selected.Python).Path
$env:PATH = "$venvBin;$env:PATH"

$tool = $ToolArgs[0]
$remainingArgs = @()
if ($ToolArgs.Count -gt 1) {
    $remainingArgs = $ToolArgs[1..($ToolArgs.Count - 1)]
}

switch ($tool) {
    "python" {
        & $python @remainingArgs
        exit $LASTEXITCODE
    }
    "pytest" {
        & $python -m pytest @remainingArgs
        exit $LASTEXITCODE
    }
    "ruff" {
        & $python -m ruff @remainingArgs
        exit $LASTEXITCODE
    }
    default {
        if ([string]::IsNullOrEmpty($tool) -or $tool.Contains('/') -or $tool.Contains('\') -or $tool -eq '.' -or $tool -eq '..') {
            Write-Error 'Expected a tool name, not a path.'
            exit 2
        }
        foreach ($suffix in @('', '.exe', '.cmd', '.bat', '.ps1')) {
            $executable = Join-Path $venvBin "$tool$suffix"
            if (Test-Path -LiteralPath $executable -PathType Leaf) {
                $LASTEXITCODE = 0
                & $executable @remainingArgs
                $succeeded = $?
                if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
                if (-not $succeeded) { exit 1 }
                exit 0
            }
        }
        Write-Error "Tool '$tool' is not installed in $venvBin; global fallback is disabled."
        exit 127
    }
}
