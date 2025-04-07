#! /bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_PATH="${SCRIPT_DIR}/$(basename "${BASH_SOURCE[0]}")"
source $SCRIPT_DIR/utils/bash_functions.sh

# Signal Handling Functions
Interrupted() {
  PrintWarn "Interrupted by user $USER ..."
  exit 1
}

# Implement with Cleanup()
Cleanup() {
  PrintInfo "◇ Cleaning up before exit ..."
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
# echo -e "${GRN}
# ┌───────────────────────────────────────────────────┐
# │ ██████╗ ███████╗██╗   ██╗ █████╗ ██████╗ ██╗  ██╗ │
# │ ██╔══██╗██╔════╝██║   ██║██╔══██╗██╔══██║██║ ██╔╝ │
# │ ██║  ██║█████╗  ██║   ██║███████║██████╚╗█████╔╝  │
# │ ██║  ██║██╔══╝  ╚██╗ ██╔╝██╔══██║██╔═╗██║██╔═██╗  │
# │ ██████╔╝███████╗ ╚████╔╝ ██║  ██║██║ ║██║██║  ██╗ │
# │ ╚═════╝ ╚══════╝  ╚═══╝  ╚═╝  ╚═╝╚═╝ ╚══╝╚═╝  ╚═╝ │
# └───────────────────────────────────────────────────┘
# ${RESET}"
echo -e "${GRN} >>> DEVARK <<< ${RESET}"

# ➤ → ⇒ › ⋯ … • ▪ ▶ ⏵ ◇ ◆ — ╭─ / ├─ / ╰─
# TestColorCodes
Initialize

PrintInfo "◇ Install UV Manager ..."
if ! command -v uv &> /dev/null; then
  PrintInfo "  ◆ Not found. Installing..."
  echo ''
  echo '────────── WORK ──────────'
  curl -LsSf https://astral.sh/uv/install.sh | sh
  echo '────────── DONE ──────────'
  echo ''
  source ~/.bashrc
else
  PrintInfo "  ◆ Already installed."
fi

PrintInfo "◇ Create Python 3.12 venv ..."
if [ ! -d "${SCRIPT_DIR}/.venv/devark" ]; then
  PrintInfo "  ◆ no virtual environment exists, create 'devark' venv."
  uv venv --python 3.12 --no-cache --seed --link-mode copy -v ${SCRIPT_DIR}/.venv/devark
else
  PrintInfo "  ◆ [PASS] virtual environment already exist."
fi

PrintInfo ${SCRIPT_DIR}/.venv/devark/bin/activate
. "${SCRIPT_DIR}/.venv/devark/bin/activate"

# NVIDIA & CUDA
nvidia_gpu_detected=$(lspci | grep -i vga | grep -i nvidia)
# echo ${nvidia_gpu_detected}
if [ -n "${nvidia_gpu_detected}" ]; then
  gpu_description=$(sudo lshw -C display -short 2> /dev/null | awk 'NR > 2 && $3 == "display" { $1=$2=$3=""; sub(/^ +/, ""); print; exit }')
  PrintInfo "◇ NVIDIA GPU is detected. (Model: ${BOLD}${gpu_description}${RESET})"

  ppa_already_added=$(ls /etc/apt/sources.list.d | grep -i graphic | grep -i ppa)
  # echo ${ppa_already_added}
  if [ ! -n "${nvidia_gpu_detected}" ]; then
    PrintInfo "  ◆ Add PPA for graphics-drivers."
    sudo add-apt-repository -y ppa:graphics-drivers/ppa
  else
    PrintInfo "  ◆ PPA for graphics-drivers is already added."
  fi

  if command -v nvidia-smi &> /dev/null; then
    PrintInfo "  ◆ 'nvidia-driver' is already installed."
  else
    recommended=$(ubuntu-drivers devices | awk '/recommended/ {print $3}')
    PrintInfo "  ◆ Install ${recommended} ..."
    sudo apt install -y -qq ${recommended}
  fi

else
  PrintInfo "◇ NVIDIA GPU is not detected ..."
fi