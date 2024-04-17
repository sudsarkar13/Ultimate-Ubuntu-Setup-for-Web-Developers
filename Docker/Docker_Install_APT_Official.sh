# Docker's Official method APT Installer
# Install using the repository
echo "Starting docker installation"
# Add Docker's official GPG key:
echo
sudo apt-get update
echo
sudo apt-get install -y ca-certificates curl
echo
sudo install -m 0755 -d /etc/apt/keyrings
echo
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
echo
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo
sudo apt-get update
echo
echo "Installing Docker Packages..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo
echo "Docker installation complete"

# To check if Docker is installed and working successfully
echo "Checking if Docker is installed and working successfully..."
sudo docker run hello-world
echo
docker run hello-world
echo
echo "Docker is installed and working successfully"
echo
echo "Post installation steps are on the official docs: https://docs.docker.com/desktop/install/ubuntu/"
xdg-open "https://docs.docker.com/desktop/install/ubuntu/"
sleep 60
exit