#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

#adding the proxy for apt
printf "${RED}Coping Proxy for apt${NC}"
sudo cp ./proxy/02proxy /etc/apt/apt.conf.d/02proxy
sudo chown root:root /etc/apt/apt.conf.d/02proxy

#install non installed packages
printf "${RED}Intalling git wget curl build-essential gcc cmake make${NC}"
sudo apt-get install -y git wget curl build-essential gcc-9
sudo apt-get install -y cmake make bat openssh-server openssh-client

#install gnome-tweaks and vlc
printf "${RED}Installing Gnome-Tweaks and VLC${NC}"
sudo apt-get install -y gnome-tweaks vlc

#install lollypop
printf "${RED}Installing Lollypop${NC}"
sudo apt-get install -y lollypop

#install Docker and Docker-compose
printf "${RED}Installing Docker${NC}"
sudo apt-get install -y docker docker.io docker-compose

#add gimp repo and install it
printf "${RED}Installing GIMP${NC}"
sudo add-apt-repository -y ppa:otto-kesselgulasch/gimp
sudo apt-get install -y gimp

#install homebrew
printf "${RED}Installing HomeBrew${NC}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

#install zsh and ohmyzsh
printf "${RED}Installing ZSH and oh-my-zsh${NC}"
sudo apt-get install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#install vscodium
printf "${RED}Installing Codium${NC}"
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add -
sudo apt-add-repository 'deb https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/debs/ vscodium main'
sudo apt-get update
sudo apt-get install -y codium

#install vscode
printf "${RED}Installing VSCode${NC}"
sudo apt-get update
sudo apt-get install -y curl apt-transport-https
curl -sSL https://packages.microsoft.com/keys/microsoft.asc -o microsoft.asc
sudo apt-key add microsoft.asc
rm microsoft.asc
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"  | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt-get update
sudo apt-get install -y code

#install amazon-corretto-jdk
printf "${RED}Installing Amazon-Corretto OpenJDK Version 11${NC}"
wget -O- https://apt.corretto.aws/corretto.key | sudo apt-key add -
sudo add-apt-repository -y 'deb [arch=amd64] https://apt.corretto.aws stable main'
sudo apt-get update
sudo apt-get install -y java-11-amazon-corretto-jdk

#install gradle
printf "${RED}Installing Gradle${NC}"
brew install gradle

#load saved containers in the current directory
printf "${RED}Loading Docker Images${NC}"
for image in ./docker-images/*.tar; do
	sudo docker load -i $image
	printf "${RED}$image has been loaded${NC}"
done

#install atom
printf "${RED}Installing Atom${NC}"
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c "echo 'deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main' > /etc/apt/sources.list.d/atom.list"
sudo apt-get update
sudo apt-get install -y atom

#install firefox-dev
printf "${RED}Installing Firefox-dev${NC}"
sudo add-apt-repository -y ppa:ubuntu-mozilla-daily/firefox-aurora
sudo apt-get update
sudo apt-get install -y firefox

#install node js
printf "${RED}Installing Nodejs and npm${NC}"
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get update
sudo apt-get install -y nodejs

#copy my .bashrc ,.zshrc and .profile to the home dir
printf "${RED}Copy My .bashrc ,.zshrc and .profile to the Home Directory${NC}"

cp ./shell-config-files/.bashrc ~/
printf "${RED}.bashrc has been Copied ${NC}"

cp ./shell-config-files/.zshrc ~/
printf "${RED}.zshrc has been Copied ${NC}"

cp ./shell-config-files/.profile ~/
printf "${RED}.profile has been Copied ${NC}"

#install my code extentions
printf "${RED}Installing code-insiders extensions${NC}"
while IFS= read -r line; do
    printf "${RED}Installing $line for code-insiders ${NC}\n"
    code-insiders --install-extension $line
done < ./code-extensions/extensions.txt

printf "${RED}Installing codium extension${NC}"
while IFS= read -r line; do
    printf "${RED}Installing $line for codium ${NC}\n"
    codium --install-extension $line
done < ./code-extensions/extensions.txt

#while IFS= read -r line; do
#    printf "${RED}Installing $line for code ${NC}\n"
#    code-insiders --install-extension $line
#done < ./code-extensions/extensions.txt