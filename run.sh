echo "======================================="
echo " Instagram Mass Unliker - Setup Utility"
echo "======================================="
echo

# Function to check if a command exists
check_command() {
    command -v "$1" >/dev/null 2>&1
}

# Ensure Python 3.7+
echo "[*] Checking Python version..."
PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
if [[ $(echo "$PYTHON_VERSION < 3.7" | bc) -eq 1 ]]; then
    echo "[!] Python 3.7 or higher is required."
    exit 1
fi
echo "[✓] Python version $PYTHON_VERSION OK"

# Create virtual environment
echo "[*] Setting up virtual environment..."
if [ ! -d "venv" ]; then
    python3 -m venv venv
    if [ $? -ne 0 ]; then
        echo "[!] Failed to create virtual environment"
        exit 1
    fi
fi

# Activate virtual environment
source venv/bin/activate

# Install dependencies
echo "[*] Installing dependencies..."
pip install --upgrade pip
pip install ensta==5.2.9 tqdm==4.67.1 colorama==0.4.6 requests==2.32.3 moviepy==1.0.3 psutil

if [ $? -ne 0 ]; then
    echo "[!] Failed to install one or more dependencies"
    deactivate
    exit 1
fi

echo "[✓] All dependencies installed successfully"

# Run the main script
echo "[*] Starting Instagram Mass Unliker..."
python3 instagram_unliker.py

# Deactivate venv after running
deactivate

echo "[✓] Program completed successfully"
