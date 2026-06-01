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

The script selects venv/ or .venv/, prepends its Scripts/bin directory to PATH,
and forwards all arguments to the requested tool.
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
    if (Test-Path $candidate.Python) {
        $selected = $candidate
        break
    }
}

if (-not $selected) {
    Write-Error "No local virtual environment found: expected venv/ or .venv/."
    exit 1
}

$env:PATH = "$(Resolve-Path $selected.Bin);$env:PATH"

$tool = $ToolArgs[0]
$remainingArgs = @()
if ($ToolArgs.Count -gt 1) {
    $remainingArgs = $ToolArgs[1..($ToolArgs.Count - 1)]
}

switch ($tool) {
    "python" {
        & python @remainingArgs
        exit $LASTEXITCODE
    }
    "pytest" {
        & python -m pytest @remainingArgs
        exit $LASTEXITCODE
    }
    "ruff" {
        & python -m ruff @remainingArgs
        exit $LASTEXITCODE
    }
    default {
        & $tool @remainingArgs
        exit $LASTEXITCODE
    }
}
