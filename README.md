# Ultimate Vim Keybindings Cheat sheet
my key bindings for vim + vs code and vimium for chrome

```sh
#!/bin/bash

# This script automates the installation of several common developer tools
# on a Debian/Ubuntu-based system.
#
# Tools included:
# - Google Chrome
# - Tmux
# - Neovim
# - Java (OpenJDK 17)
# - Go
# - AWS CLI v2
#
# Usage:
# 1. Make the script executable: chmod +x install_dev_tools.sh
# 2. Run the script: ./install_dev_tools.sh
#
# IMPORTANT: This script uses 'sudo' and will prompt for your password
#            when necessary. It's designed for Debian/Ubuntu-based systems.
#            For other distributions, the package managers and commands
#            might differ.
#
# !!! SECURITY WARNING !!!
# Embedding your password directly in this script is a significant security risk.
# This is done ONLY at your explicit request for temporary convenience.
# It is highly recommended to remove your password from this script after use,
# or to use more secure methods like 'sudoers' configuration for passwordless sudo
# for specific commands, if you truly need to automate without manual input.
# !!! SECURITY WARNING !!!

# Replace <YOUR_SUDO_PASSWORD_HERE> with your actual sudo password.
# For example: SUDO_PASSWORD="mysecretpassword"
SUDO_PASSWORD="<YOUR_SUDO_PASSWORD_HERE>"

echo "Starting installation of developer tools..."

# --- Update package lists ---
echo "Updating package lists..."
echo "$SUDO_PASSWORD" | sudo -S apt update -y || { echo "Failed to update package lists. Exiting."; exit 1; }

# --- Install Google Chrome ---
echo "Installing Google Chrome..."
# Download the Google Chrome .deb package
wget -q -O /tmp/google-chrome-stable.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
if [ $? -ne 0 ]; then
    echo "Failed to download Google Chrome. Skipping Chrome installation."
else
    # Install the .deb package and its dependencies
    echo "$SUDO_PASSWORD" | sudo -S dpkg -i /tmp/google-chrome-stable.deb
    if [ $? -ne 0 ]; then
        echo "dpkg failed for Google Chrome, attempting to fix broken dependencies..."
        echo "$SUDO_PASSWORD" | sudo -S apt --fix-broken install -y
        echo "$SUDO_PASSWORD" | sudo -S dpkg -i /tmp/google-chrome-stable.deb # Try installing again after fixing dependencies
        if [ $? -ne 0 ]; then
            echo "Failed to install Google Chrome even after fixing dependencies. Skipping."
        else
            echo "Google Chrome installed successfully."
        fi
    else
        echo "Google Chrome installed successfully."
    fi
    rm /tmp/google-chrome-stable.deb
fi

# --- Install Tmux ---
echo "Installing Tmux..."
echo "$SUDO_PASSWORD" | sudo -S apt install tmux -y
if [ $? -ne 0 ]; then
    echo "Failed to install Tmux. Skipping."
else
    echo "Tmux installed successfully."
fi

# --- Install Neovim ---
echo "Installing Neovim..."
echo "$SUDO_PASSWORD" | sudo -S apt install neovim -y
if [ $? -ne 0 ]; then
    echo "Failed to install Neovim. Skipping."
else
    echo "Neovim installed successfully."
fi

# --- Install Java (OpenJDK 17) ---
echo "Installing Java (OpenJDK 17)..."
echo "$SUDO_PASSWORD" | sudo -S apt install openjdk-17-jdk -y
if [ $? -ne 0 ]; then
    echo "Failed to install OpenJDK 17. Skipping."
else
    echo "Java (OpenJDK 17) installed successfully."
    java -version
fi

# --- Install Go ---
echo "Installing Go..."
# Get the latest Go version from the official downloads page (this might need manual update if the URL changes frequently)
# As of current knowledge, 1.22.4 is a recent stable version.
GO_VERSION="1.22.4"
GO_ARCH="amd64" # Assuming 64-bit architecture
GO_TAR="go${GO_VERSION}.linux-${GO_ARCH}.tar.gz"
GO_URL="https://go.dev/dl/${GO_TAR}"

wget -q -O /tmp/${GO_TAR} ${GO_URL}
if [ $? -ne 0 ]; then
    echo "Failed to download Go. Skipping Go installation."
else
    echo "$SUDO_PASSWORD" | sudo -S rm -rf /usr/local/go # Remove any previous Go installation
    echo "$SUDO_PASSWORD" | sudo -S tar -C /usr/local -xzf /tmp/${GO_TAR}
    if [ $? -ne 0 ]; then
        echo "Failed to extract Go archive. Skipping Go installation."
    else
        # Add Go to PATH if not already present in .bashrc or .profile
        # This part assumes .bashrc for interactive shells. You might need to adjust for other shell configs.
        if ! grep -q "/usr/local/go/bin" "$HOME/.bashrc"; then
            echo 'export PATH=$PATH:/usr/local/go/bin' >> "$HOME/.bashrc"
            echo "Added Go to PATH in ~/.bashrc. Please source your .bashrc (source ~/.bashrc) or open a new terminal."
        fi
        echo "Go installed successfully."
        go version
    fi
    rm /tmp/${GO_TAR}
fi

# --- Install AWS CLI v2 ---
echo "Installing AWS CLI v2..."
AWS_CLI_INSTALLER="awscliv2.zip"
AWS_CLI_URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"

wget -q -O /tmp/${AWS_CLI_INSTALLER} ${AWS_CLI_URL}
if [ $? -ne 0 ]; then
    echo "Failed to download AWS CLI v2. Skipping AWS CLI installation."
else
    unzip -q /tmp/${AWS_CLI_INSTALLER} -d /tmp/
    if [ $? -ne 0 ]; then
        echo "Failed to unzip AWS CLI v2. Skipping AWS CLI installation."
    else
        echo "$SUDO_PASSWORD" | sudo -S /tmp/aws/install --update
        if [ $? -ne 0 ]; then
            echo "Failed to install AWS CLI v2. Skipping."
        else
            echo "AWS CLI v2 installed successfully."
            aws --version
        fi
    fi
    rm -rf /tmp/aws /tmp/${AWS_CLI_INSTALLER}
fi

echo "Installation script finished."
echo "Please remember to source your .bashrc (source ~/.bashrc) or open a new terminal for Go to be available in your PATH."
```
