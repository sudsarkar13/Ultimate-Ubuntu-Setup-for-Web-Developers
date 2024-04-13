#!/bin/bash

# Install macOs themes for Ubuntu
# Usage: ./Downloader.sh



# Download the gtk themes inside Downloads folder
mkdir -p ~/MacOS-Theme/
cd ~/MacOS-Theme/
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
echo "Downloaded WhiteSur-gtk-theme"
echo
# Download the icon themes
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
echo "Downloaded WhiteSur-icon-theme"
echo

# Download wallpapers for MacOs themes
git clone https://github.com/vinceliuice/WhiteSur-wallpapers.git
echo "Downloaded WhiteSur-wallpapers"
echo
echo "Download Complete"
echo
echo "Export Installer script to ~/MacOS-Theme"
echo
sleep 5
# Creating the installation script of required packages and extesion manager
echo "Please wait while the installation script is being created..."
# Export installer script
cat << EOF > ~/MacOS-Theme/installer.sh
#!/bin/bash

# Usage: ./installer.sh
echo "Installing required packages and extension manager..."
sudo apt-get install -y gnome-tweaks gnome-shell-extension-manager
echo
sudo ubuntu-drivers autoinstall
echo
sleep 10
exit

EOF
chmod +x ~/MacOS-Theme/installer.sh
echo
echo "Installation script created"
sleep 60
exit