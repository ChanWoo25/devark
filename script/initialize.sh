#! /bin/bash
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
script_path="${script_dir}/$(basename "${BASH_SOURCE[0]}")"
# echo "Script Directory: $script_dir"
# echo "Script Path: $script_path"
source "$script_dir/core/shell_utils.sh"

# Signal Handling Functions
Interrupted() {
  logw "Interrupted by user $USER ..."
  exit 1
}

# Implement with Cleanup()
Cleanup() {
  log "◇ Cleaning up before exit ..."
}

Initialize() {
  logi "script_dir: ${script_dir}"
  logi "script_path: ${script_path}"
}

# INT (Ctrl+C)나 EXIT 시 cleanup 함수 호출
trap Cleanup EXIT
trap Interrupted INT

# ┌─────────┐
# │ M A I N │
# └─────────┘
log "
┌───────────────────────────────────────────────────┐
│ ██████╗ ███████╗██╗   ██╗ █████╗ ██████╗ ██╗  ██╗ │
│ ██╔══██╗██╔════╝██║   ██║██╔══██╗██╔══██║██║ ██╔╝ │
│ ██║  ██║█████╗  ██║   ██║███████║██████╚╗█████╔╝  │
│ ██║  ██║██╔══╝  ╚██╗ ██╔╝██╔══██║██╔═╗██║██╔═██╗  │
│ ██████╔╝███████╗ ╚████╔╝ ██║  ██║██║ ║██║██║  ██╗ │
│ ╚═════╝ ╚══════╝  ╚═══╝  ╚═╝  ╚═╝╚═╝ ╚══╝╚═╝  ╚═╝ │
└───────────────────────────────────────────────────┘
"


# ➤ → ⇒ › ⋯ … • ▪ ▶ ⏵ ◇ ◆ — ╭─ / ├─ / ╰─
# TestColorCodes
Initialize

exit 0

logi "◇ Install UV Manager ..."
if ! command -v uv &> /dev/null; then
  logi "  ◆ Not found. Installing..."
  echo ''
  echo '────────── WORK ──────────'
  curl -LsSf https://astral.sh/uv/install.sh | sh
  echo '────────── DONE ──────────'
  echo ''
  source ~/.bashrc
else
  logi "  ◆ Already installed."
fi

logi "◇ Create Python 3.12 venv ..."
if [ ! -d "${SCRIPT_DIR}/.venv/devark" ]; then
  logi "  ◆ no virtual environment exists, create 'devark' venv."
  uv venv --python 3.12 --no-cache --seed --link-mode copy -v ${SCRIPT_DIR}/.venv/devark
else
  logi "  ◆ [PASS] virtual environment already exist."
fi

logi ${SCRIPT_DIR}/.venv/devark/bin/activate
. "${SCRIPT_DIR}/.venv/devark/bin/activate"

# NVIDIA & CUDA
nvidia_gpu_detected=$(lspci | grep -i vga | grep -i nvidia)
# echo ${nvidia_gpu_detected}
if [ -n "${nvidia_gpu_detected}" ]; then
  gpu_description=$(sudo lshw -C display -short 2> /dev/null | awk 'NR > 2 && $3 == "display" { $1=$2=$3=""; sub(/^ +/, ""); print; exit }')
  logi "◇ NVIDIA GPU is detected. (Model: ${BOLD}${gpu_description}${RESET})"

  ppa_already_added=$(ls /etc/apt/sources.list.d | grep -i graphic | grep -i ppa)
  # echo ${ppa_already_added}
  if [ ! -n "${nvidia_gpu_detected}" ]; then
    logi "  ◆ Add PPA for graphics-drivers."
    sudo add-apt-repository -y ppa:graphics-drivers/ppa
  else
    logi "  ◆ PPA for graphics-drivers is already added."
  fi

  if command -v nvidia-smi &> /dev/null; then
    logi "  ◆ 'nvidia-driver' is already installed."
  else
    recommended=$(ubuntu-drivers devices | awk '/recommended/ {print $3}')
    logi "  ◆ Install ${recommended} ..."
    sudo apt install -y -qq ${recommended}
  fi

else
  logi "◇ NVIDIA GPU is not detected ..."
fi