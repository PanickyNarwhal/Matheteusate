#!/usr/bin/env bash

# Matheteusate Bootstrapper
# This script sets up a virtual environment, installs dependencies,
# and launches the application in TUI mode.

set -e

# Detect if we are in the right directory
if [ ! -d "matheteusate" ]; then
    echo "Error: Please run this script from the root of the Matheteusate project directory."
    exit 1
fi

echo "--- Setting up Matheteusate ---"

# 1. Check for Python
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is required but not found."
    exit 1
fi

# 2. Create Virtual Environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# 3. Activate and Install Dependencies
echo "Installing/Updating dependencies..."
# We use 'python -m pip' to ensure we use the venv's pip
./venv/bin/python3 -m pip install --upgrade pip
./venv/bin/python3 -m pip install distro packaging psutil pythondialog requests inotify

echo "--- Setup Complete ---"
echo "Launching Matheteusate in TUI mode..."
echo "Note: If you are using the Fish shell, you can later run 'source venv/bin/activate.fish' to enter the environment manually."

# 4. Launch the App
# We force DIALOG=curses to bypass the missing tkinter requirement
env DIALOG=curses ./venv/bin/python3 -m matheteusate.main "$@"
