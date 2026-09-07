#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  run-in-venv.sh <tool> [args...]

Examples:
  run-in-venv.sh python tests/test_example.py
  run-in-venv.sh pytest tests/test_example.py
  run-in-venv.sh ruff check .
  run-in-venv.sh pyright .
  run-in-venv.sh python -m pytest tests/test_example.py

The script selects venv/ or .venv/ and executes its interpreter or local tool.
Missing tools fail rather than falling back to a global executable.
EOF
}

if [[ $# -eq 0 ]]; then
  usage
  exit 2
fi

if [[ -x "venv/bin/python" ]]; then
  venv_bin="venv/bin"
elif [[ -x ".venv/bin/python" ]]; then
  venv_bin=".venv/bin"
elif [[ -x "venv/Scripts/python.exe" ]]; then
  venv_bin="venv/Scripts"
elif [[ -x ".venv/Scripts/python.exe" ]]; then
  venv_bin=".venv/Scripts"
else
  echo "No local virtual environment found: expected venv/ or .venv/." >&2
  exit 1
fi

venv_bin="$PWD/$venv_bin"
export PATH="$venv_bin:$PATH"
python="$venv_bin/python"
if [[ -f "$venv_bin/python.exe" ]]; then
  python="$venv_bin/python.exe"
fi

tool="$1"
shift

case "$tool" in
  python)
    exec "$python" "$@"
    ;;
  pytest|ruff)
    exec "$python" -m "$tool" "$@"
    ;;
esac

# An explicit local path prevents PATH from selecting a global fallback.
if [[ -z "$tool" || "$tool" == */* || "$tool" == *\\* || "$tool" == "." || "$tool" == ".." ]]; then
  echo "Expected a tool name, not a path." >&2
  exit 2
fi
for suffix in "" .exe .cmd .bat; do
  executable="$venv_bin/$tool$suffix"
  if [[ -f "$executable" && -x "$executable" ]]; then
    exec "$executable" "$@"
  fi
done
echo "Tool '$tool' is not installed in $venv_bin; global fallback is disabled." >&2
exit 127
