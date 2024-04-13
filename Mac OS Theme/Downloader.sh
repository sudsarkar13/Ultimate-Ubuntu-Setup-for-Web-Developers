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

# Export installer script
cat << EOF > ~/MacOS-Theme/installer.sh
#!/bin/bash

# Install macOs themes for Ubuntu
# Usage: ./installer.sh

# Install gtk themes
cd WhiteSur-gtk-theme/
./install.sh -m -t all -l -c Dark -N stable --normal --round -i ubuntu
cd ..

# Install icon themes
cd WhiteSur-icon-theme/
./install.sh
cd ..

# Install wallpapers
cd WhiteSur-wallpapers/
for i in */ ; do
  echo "Installing wallpaper: $i"
  gsettings set org.gnome.desktop.background picture-uri "file://$PWD/$i/$(ls $i | shuf -n1)"
done
cd ..

echo "Installation Complete"

EOF

chmod +x ~/MacOS-Theme/installer.sh
echo
