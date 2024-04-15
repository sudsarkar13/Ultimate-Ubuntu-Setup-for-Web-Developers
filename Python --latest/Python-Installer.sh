#!/bin/bash

# File to store logs
LOG_FILE="logs.txt"

# Remove the existing log file if it exists
rm -f $LOG_FILE

# Redirect stdout and stderr to a new log file
exec > >(tee $LOG_FILE)
exec 2> >(tee $LOG_FILE >&2)

# Python Installer Script

# Check if Python is already installed
if command -v python3\n
then
    echo "Python 3 is already installed."
else
    echo "Installing Python 3..."
    sudo apt install python3 -y
fi

# Check if pip3 is already installed
if command -v pip3\n
then
    echo "pip3 is already installed."
else
    echo "Installing pip3..."
    sudo apt install python3-pip -y
fi

echo "Python 3 and pip3 installation completed."
echo

# Python Upgrade Script
echo "Installing Dependencies..."
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev pkg-config libgdbm-dev libc6-dev
echo
echo "Installing latest version of Python..."
curl -O https://www.python.org/ftp/python/3.12.3/Python-3.12.3.tar.xz
tar -xJf Python-3.12.3.tar.xz &> /dev/null
cd Python-3.12.3
./configure --enable-optimizations
make
make test
sudo make install
echo
echo "Installing pip latest version..."
pip install --upgrade pip
cd ..
rm -rf Python-3.12.3.tar.xz Python-3.12.3
echo
echo "Latest version of Python installed successfully."
echo
echo "Checking current Python version..."
python3 --version
echo
echo "Checking current pip3 version..."
pip3 --version
echo
echo "Python and pip3 installation and upgrade completed."
sleep 30
exit