# Uninstallation Procedure for WineHQ

echo "Starting WineHQ uninstallation..."

# Remove the WineHQ packages
echo "Removing WineHQ packages..."
sudo apt remove --autoremove winehq-stable -y
echo "WineHQ packages have been removed."
echo

# Remove the WineHQ repository
echo "Removing the WineHQ repository from the system..."
sudo add-apt-repository --remove 'deb https://dl.winehq.org/wine-builds/ubuntu/ jammy main' -y
echo "WineHQ repository has been removed."
echo

# Remove the WineHQ key
echo "Removing the WineHQ key..."
sudo apt-key del $(sudo apt-key list | grep -B 1 "WineHQ" | head -n1 | awk '{print $2}')
echo "WineHQ key has been removed."
echo

# Update package list
echo "Updating package list..."
sudo apt update
echo "Package list updated."
echo

echo "WineHQ uninstallation completed."
