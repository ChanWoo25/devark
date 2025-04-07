#! /bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_PATH="${SCRIPT_DIR}/$(basename "${BASH_SOURCE[0]}")"
source $SCRIPT_DIR/utils/bash_functions.sh

source $SCRIPT_DIR/.venv/devark/bin/activate