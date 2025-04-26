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

# Download the gtk MacOs themes for Ubuntu
echo "Downloading the MacOs themes for Ubuntu..."
echo
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
# Download the cursor themes
git clone https://github.com/vinceliuice/WhiteSur-cursors.git
echo "Downloaded WhiteSur-cursors"
echo "Download Complete"
echo
echo "Exporting the Installer script to ~/MacOS-Theme"
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
    echo "Installing the theme into gtk4.0 config for libadwaita in sudo mode..."
    sudo ./install.sh -o normal -a normal -t blue -s standard -m -N glassy -l -f -HD --round --shell -i apple -sf
    echo
    echo "Ignore this warning \"Do not run '--libadwaita' option with sudo!\""
    sleep 5
    echo
    echo "Installing the theme into gtk4.0 config for libadwaita..."
    ./install.sh -o normal -a normal -t blue -s standard -m -N glassy -l -f -HD --round --shell -i apple -sf
    echo
    echo "Theme installation for gtk4.0 config for libadwaita is complete"
    echo
    sleep 2
    echo "Applying gdm theme tweaks..."
    echo
    echo "Running ./tweaks.sh ..."
    echo
    echo "Running in sudo mode..."
    echo
    sudo ./tweaks.sh -d
    sleep 5
    echo
    echo "Running in normal mode..."
    ./tweaks.sh -d
    echo
    echo "Tweaks applied successfully"
    echo
    echo "Switching to WhiteSur-icon-theme directory..."
    cd ~/MacOS-Theme/WhiteSur-icon-theme
    echo
    echo "Installing the icons in sudo mode..."
    sleep 2
    echo
    echo "Running the icon installation script..."
    sudo ./install.sh -b -t all
    echo
    echo "Installing the icons in the normal mode..."
    sleep 2
    echo
    echo "Running the icon installation script..."
    ./install.sh -b -t all
    echo
    echo "Icon installation complete."
    echo
    sleep 2
    echo "Switching to WhiteSur-wallpapers directory..."
    cd ~/MacOS-Theme/WhiteSur-wallpapers
    echo
    echo "Installing the wallpaper in sudo mode..."
    sleep 2
    echo
    echo "Running the wallpaper installation script..."
    sudo ./install-wallpapers.sh -s 4k
    echo
    echo "Installing the wallpaper in the normal mode..."
    sleep 2
    echo
    echo "Running the wallpaper installation script..."
    ./install-wallpapers.sh -s 4k
    echo
    echo "Wallpaper installation complete."
    echo
    echo "Switching to WhiteSur-cursors directory..."
    cd ~/MacOS-Theme/WhiteSur-cursors
    echo
    echo "Installing the cursor theme in sudo mode..."
    sleep 2
    sudo ./install.sh
    echo
    echo "Installing the cursor theme in the normal mode..."
    sleep 2
    ./install.sh
    echo
    echo "Setup completed."
    sleep 5
    echo "Installation completed successfully."
    sleep 5
    echo
    echo -n "Quitting in 10 seconds..."
    for i in {10..1}; do
        echo -ne "\rQuitting in $i seconds..."
        sleep 1
    done
    echo -ne "\rQuitting now!          \n"
    echo
    echo "Please logOut/restart your system to apply the changes."
    sleep 5
    exit
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
# Mac OS theme installation instructions if you want to install the theme manually.

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
