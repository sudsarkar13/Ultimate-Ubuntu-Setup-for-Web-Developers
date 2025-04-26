#!/bin/bash

# File to store logs
LOG_FILE="logs.txt"

# Remove the existing log file if it exists
rm -f $LOG_FILE

# Redirect stdout and stderr to a new log file
exec > >(tee $LOG_FILE)
exec 2> >(tee $LOG_FILE >&2)

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

# File to store logs
LOG_FILE="logs.txt"

# Remove the existing log file if it exists
rm -f $LOG_FILE

# Redirect stdout and stderr to a new log file
exec > >(tee $LOG_FILE)
exec 2> >(tee $LOG_FILE >&2)
echo "Log file created at $LOG_FILE"

# Usage: ./installer.sh
echo "Installing required packages and extension manager..."
sudo apt-get install -y gnome-tweaks gnome-shell-extension-manager
echo
sudo ubuntu-drivers autoinstall
echo
sleep 5
echo "Would you like to install the macOS theme on your system now?"
read -p "Please enter [y/n]: " response
if [[ "$response" == "y" ]]; then
    echo "Proceeding with the installation..."
    echo
    echo "Starting the installation of the theme..."
    sleep 5
    echo
    echo "Switching to WhiteSur-gtk-theme directory..."
    cd ~/MacOS-Theme/WhiteSur-gtk-theme
    echo
    echo "Installing the theme..."
    sleep 2
    echo
    echo "Installing the theme into gtk4.0 config for libadwaita..."
    ./install.sh -o normal -a normal -t blue -s standard -m -N glassy -l -f -HD --round --shell -i apple -sf
    echo
    echo "Theme installation for gtk4.0 config for libadwaita is complete"
    echo
    echo "Installing theme tweaks..."
    sleep 2
    echo
    echo "Applying gdm theme tweaks..."
    echo
    echo "Running ./tweaks.sh ..."
    sleep 5
    sudo ./tweaks.sh -g
    ./tweaks.sh -c dark -t blue -s standard -d
    echo
    echo "Applying tweaks in the root..."
    sudo ./tweaks.sh -c dark -t blue -s standard -d
    echo
    echo "Tweaks applied successfully"
else
    echo
    echo "Installation aborted."
    sleep 20
    exit 1
fi
EOF
echo
# Make the installer script executable
echo "Making the installer script executable..."
chmod +x ~/MacOS-Theme/installer.sh
echo
echo "Installation script created"

# Create Instructions.txt
cat << EOF > ~/MacOS-Theme/Instructions.txt
# Mac OS theme installation instructions.
1. Run ./installer.sh in ~/MacOS-Theme folder.
2. Open terminal from the ~/MacOS-Theme folder.
3. Go to ~/MacOS-Theme/WhiteSur-gtk-theme by "cd WhiteSur-gtk-theme" using terminal.
4. In terminal type "./install.sh -t all -N glassy -s 220" to install the theme.
5. Then type "sudo ./tweaks.sh -g" to apply the tweaks.
6. Go to ~/MacOS-Theme/WhiteSur-icon-theme by "cd WhiteSur-icon-theme" using terminal.
7. In terminal type "./install.sh -b -t all" to install the icons.
8. Go to ~/MacOS-Theme/WhiteSur-wallpapers by "cd WhiteSur-wallpapers" using terminal.
9. In terminal type "./install.sh" to install the wallpaper.
10. Then in terminal type "./install-wallpapers.sh" to install the wallpaper.
11. Then type "sudo ./install-gnome-backgrounds.sh" to install the wallpaper.

# Preffered extensions
1. User Themes by fmuellner
2. Blur my Shell by aunetx
3. Apps Menu by fmuellner
4. Compiz alike magic lamp effect by hermes83
    For this effect to work go to terminal and type "gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'"

5. Emoji Copy by FelipeFTN 
6. Clipboard Indicator by Tudmotu
7. Net speed Simplified by Prateek SU
8. Alphabetical App Grid by Stuart Hayhurst
9. Extension List by grroot

EOF
echo
echo "Instructions file generated Successfully"
sleep 30
exit
