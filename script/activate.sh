#!/bin/bash
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
script_path="${script_dir}/$(basename "${BASH_SOURCE[0]}")"
# echo "Script Directory: $script_dir"
# echo "Script Path: $script_path"

source "$script_dir/core/shell_utils.sh"

logi "Activating DevArk virtual environment..."
logw "Warning: Make sure to have Python and virtualenv installed."
loge "Error: If activation fails, check the virtual environment setup."

test_color_codes

# source $SCRIPT_DIR/.venv/devark/bin/activate