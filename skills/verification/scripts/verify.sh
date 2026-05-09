#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  verify.sh <tool> [args...]

Examples:
  verify.sh pytest tests/test_example.py
  verify.sh ruff check .
  verify.sh pyright .
  verify.sh python -m pytest tests/test_example.py

The script selects venv/ or .venv/, prepends its bin directory to PATH,
and forwards all arguments to the requested tool.
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

export PATH="$PWD/$venv_bin:$PATH"

tool="$1"
shift

case "$tool" in
  python)
    exec python "$@"
    ;;
  pytest|ruff)
    exec python -m "$tool" "$@"
    ;;
  *)
    exec "$tool" "$@"
    ;;
esac
