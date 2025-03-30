#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_PATH="${SCRIPT_DIR}/$(basename "${BASH_SOURCE[0]}")"
source $SCRIPT_DIR/utils/bash_functions.sh

# Signal Handling Functions
Interrupted() {
  PrintWarn "Interrupted by user $USER..."
  exit 1
}

# Implement with Cleanup()
Cleanup() {
  echo "Cleaning up before exit..."
}

Initialize() {
  PrintDebug "SCRIPT_DIR: ${SCRIPT_DIR}"
  PrintDebug "SCRIPT_PATH: ${SCRIPT_PATH}"
}

# INT (Ctrl+C)나 EXIT 시 cleanup 함수 호출
trap Cleanup EXIT
trap Interrupted INT

# ┌─────────┐
# │ M A I N │
# └─────────┘
echo -e "${GRN}
┌───────────────────────────────────────────────────┐
│ ██████╗ ███████╗██╗   ██╗ █████╗ ██████╗ ██╗  ██╗ │
│ ██╔══██╗██╔════╝██║   ██║██╔══██╗██╔══██║██║ ██╔╝ │
│ ██║  ██║█████╗  ██║   ██║███████║██████╚╗█████╔╝  │
│ ██║  ██║██╔══╝  ╚██╗ ██╔╝██╔══██║██╔═╗██║██╔═██╗  │
│ ██████╔╝███████╗ ╚████╔╝ ██║  ██║██║ ║██║██║  ██╗ │
│ ╚═════╝ ╚══════╝  ╚═══╝  ╚═╝  ╚═╝╚═╝ ╚══╝╚═╝  ╚═╝ │
└───────────────────────────────────────────────────┘
${RESET}"

# ➤ → ⇒ › ⋯ … • ▪ ▶ ⏵ ◇ ◆ — ╭─ / ├─ / ╰─
# TestColorCodes
Initialize

PrintInfo "◇ Install UV Manager"
if ! command -v uv &> /dev/null; then
  PrintInfo "  ◆ Not found. Installing..."
  echo ''
  echo '────────── WORK ──────────'
  curl -LsSf https://astral.sh/uv/install.sh | sh
  echo '────────── DONE ──────────'
  echo ''
else
  PrintInfo "  ◆ Already installed."
fi