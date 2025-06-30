#!/bin/bash

# SafeScan Installer Script
# This script installs all required dependencies and sets up SafeScan

echo "Installing SafeScan dependencies..."

# Update package list
sudo apt update

# Install APT-based tools
sudo apt install -y figlet lolcat whois dnsutils whatweb firefox

# Install theHarvester (if not already installed)
if ! command -v theHarvester &> /dev/null; then
    echo "Installing theHarvester..."
    sudo apt install -y theharvester
fi

# Install Burp Suite via snap if not already installed
if ! command -v burpsuite &> /dev/null; then
    echo "Installing Burp Suite..."
    sudo snap install burpsuite
fi

# Make safescan.sh executable
chmod +x safescan.sh

# Optionally create a symlink to run safescan globally
read -p "Do you want to create a global 'safescan' command? (y/n): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    sudo ln -sf "$(pwd)/safescan.sh" /usr/local/bin/safescan
    echo "You can now run SafeScan from anywhere using: safescan"
fi

echo "✅ Installation complete. You can now run ./safescan.sh"
