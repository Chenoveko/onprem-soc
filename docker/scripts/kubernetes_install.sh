#!/bin/bash
sudo apt update && sudo apt upgrade -y && sudo apt install containerd
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> /home/$USER/.bashrc
brew install gcc nerdctl k9s
