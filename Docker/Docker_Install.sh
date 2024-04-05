#!/bin/bash
set -ex
set -o pipefail

# Check for sudo
if [[ $EUID -eq 0 ]]; then
   echo "This script must not be run as root"
   exit 1
fi

# vars
arch=$(dpkg --print-architecture)
rel=$(. /etc/os-release && echo "$VERSION_CODENAME")

# Install tools and deps
sudo apt-get update
sudo apt-get install -y \
  tldr ripgrep tree \
  git-gui tig \
  wget curl unzip apt-transport-https \
  lshw pciutils iperf ncdu \
  ca-certificates gnupg gnupg2 pass pinentry-tty

#########
## GIT ##
#########

# git config from https://gist.github.com/agirault/a69a7eb5862d479e68b92eef8840e5d9
wget https://gist.githubusercontent.com/agirault/a69a7eb5862d479e68b92eef8840e5d9/raw/.gitconfig -O $HOME/.gitconfig

###############
## NOMACHINE ##
###############

if ! apt list --installed | grep -q nomachine; then
   nomachine_platform=$([ "$arch" = "arm64" ] && echo "Arm" || echo "Linux")
   nomachine_dl_page_id=$([ "$arch" = "arm64" ] && echo "118" || echo "5")
   nomachine_version=$(wget "https://downloads.nomachine.com/download/?id=${nomachine_dl_page_id}" -q -O - | grep -A 1 "Version:" | grep -oP "[0-9]+(\.[0-9]+)*_[0-9]+")
   nomachine_ver=$(echo "$nomachine_version" | cut -d . -f1,2)
   nomachine_deb_url="https://download.nomachine.com/download/${nomachine_ver}/${nomachine_platform}/nomachine_${nomachine_version}_${arch}.deb"
   nomachine_deb_tmp="$(mktemp).deb"
   wget -O "$nomachine_deb_tmp" "$nomachine_deb_url"
   sudo apt-get install "$nomachine_deb_tmp" -y
   rm "$nomachine_deb_tmp"
fi

############
## VSCODE ##
############

if ! command -v code > /dev/null; then
   wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
   sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
   sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
   rm -f packages.microsoft.gpg
   sudo apt-get update
fi
sudo apt-get install -y code

############
## DOCKER ##
############

# Install if needed
if ! command -v docker > /dev/null; then
   docker_gpg_path="/etc/apt/keyrings/docker.gpg"
   sudo install -m 0755 -d $(dirname "$docker_gpg_path")
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o "$docker_gpg_path"
   sudo chmod a+r "$docker_gpg_path"
   echo "deb [arch="$arch" signed-by="$docker_gpg_path"] https://download.docker.com/linux/ubuntu "$rel" stable" | \
     sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   sudo apt-get update
   sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi
if ! docker buildx version &> /dev/null ; then
  sudo apt-get install -y docker-buildx
fi

# Install docker-credential-pass
docker_creds_pass_version="v0.8.0"
docker_creds_pass_url="https://github.com/docker/docker-credential-helpers/releases/download/$docker_creds_pass_version/docker-credential-pass-$docker_creds_pass_version.linux-$arch"
docker_creds_pass_path="/usr/local/bin/docker-credential-pass"
sudo wget "$docker_creds_pass_url" -O "$docker_creds_pass_path"
sudo chown $USER "$docker_creds_pass_path"
sudo chmod u+x "$docker_creds_pass_path"

# Make docker use the docker-credential-pass
docker_config_path="$HOME/.docker.config.json"
docker_creds_config='"credsStore": "pass"'
if [[ -f "$docker_config_path" ]]; then
   if ! grep -qF "$docker_creds_config" "$docker_config_path"; then
      # Append to config
      sed -i "0,/{/s|{|{\n\t$docker_creds_config,|" "$docker_config_path"
   fi
else
   # Create config
   printf "{\n\t$docker_creds_config\n}\n" > "$docker_config_path"
fi

# Generate GPG key and add to pass
gpgconf --kill gpg-agent
export GPG_TTY=$(tty)
gpg_id=$(gpg2 --generate-key | grep -oP '^\s*\K[[:alnum:]]+$')
pass init $gpg_id
docker-credential-pass list >/dev/null # errors out if not setup properly

# Enable TTY pinentry when there is no display
# https://superuser.com/questions/520980/how-to-force-gpg-to-use-console-mode-pinentry-to-prompt-for-passwords
sudo update-alternatives --set pinentry $(which pinentry-tty)
tty_comment="\n# Enable TTY pinentry for GPG password when there is no display\n"
fish_tty_cmd='set -gx GPG_TTY $(tty)'
fish_config_path="$HOME/.config/fish/config.fish"
bash_tty_cmd='export GPG_TTY=$(tty)'
bash_config_path="$HOME/.bashrc"
if ! grep -qF "$fish_tty_cmd" "$fish_config_path"; then
   printf "${tty_comment}${fish_tty_cmd}\n" >> "$fish_config_path"
fi
if ! grep -qF "$bash_tty_cmd" "$bash_config_path"; then
   printf "${tty_comment}${bash_tty_cmd}\n" >> "$bash_config_path"
fi

# Add user to docker group
sudo groupadd docker || true
sudo usermod -aG docker $USER
newgrp docker << END
docker run hello-world
END


###########
## SHELL ##
###########

# Install recent fish
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install -y fish

# Make fish default
fish_path=$(which fish)
if ! cat /etc/shells | grep $fish_path; then
   echo $fish_path | sudo tee -a /etc/shells
fi
sudo chsh -s $fish_path $USER

# Configure Nerd Font
if ! find /usr/share/fonts -name "*FiraCodeNerdFont*" | grep -q "."; then
   font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip"
   font_name=$(basename $font_url | cut -d. -f1)
   sudo wget -O /tmp/$font_name.zip "$font_url"
   sudo unzip -o /tmp/$font_name.zip -d "/usr/share/fonts/truetype/$font_name"
   sudo rm -rf /tmp/$font_name.zip
   fc-cache -f -v
fi

# Fisher (fish plugin manager) + Tide (fish prompt)
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source \
&& fisher install jorgebucaran/fisher IlanCosman/tide@v6 \
&& tide configure --auto --style=Classic --prompt_colors='True color' --classic_prompt_color=Light --show_time='12-hour format' --classic_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Slanted --powerline_prompt_style='Two lines, character and frame' --prompt_connection=Solid --powerline_right_prompt_frame=No --prompt_connection_andor_frame_color=Light --prompt_spacing=Sparse --icons='Many icons' --transient=No"

# Start new interactive shell
newgrp docker # `fish` is not sufficient to reload the user groups