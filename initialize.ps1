# PowerShell Script: install_python_venv.ps1
Write-Output "Running on Windows..."

# Check if Python 3.12 is installed
$pythonVersion = python --version 2>$null
if ($pythonVersion -match "3\.12") {
    Write-Output "Python 3.12 is already installed."
} else {
    Write-Output "Installing Python 3.12..."
    winget install Python.Python.3.12
}

# Wait for installation
Start-Sleep -Seconds 5

# Verify installation
$pythonVersion = python --version 2>$null
if ($pythonVersion -match "3\.12") {
    Write-Output "Python 3.12 installation successful."
} else {
    Write-Output "Python 3.12 installation failed."
    exit 1
}

# Create virtual environment
Write-Output "Creating virtual environment..."
python -m venv .venv
Write-Output "Virtual environment created successfully."

# Activation instruction
Write-Output "To activate the virtual environment, run:"
Write-Output ".\.venv\Scripts\Activate"