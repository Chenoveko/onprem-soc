#!/bin/bash
sudo apt update && sudo apt upgrade -y
###############################################################################
#                                 CONTAINERD                                 #
###############################################################################
# Instalation via apt
sudo apt install containerd -y
# Start and enable the containerd service
sudo systemctl start containerd
sudo systemctl enable containerd
sudo systemctl restart containerd
# Verify containerd is running
sudo systemctl status containerd
###############################################################################
#                                  NERDCTL                                    #
###############################################################################
# Install nerdctl with dependencies (CNI plugins,BuildKit and RootlessKit and slirp4netns )
NERDCTL_VERSION=$(curl -s https://api.github.com/repos/containerd/nerdctl/releases/latest | grep tag_name | cut -d '"' -f 4 | sed 's/v//')
wget https://github.com/containerd/nerdctl/releases/download/v${NERDCTL_VERSION}/nerdctl-full-${NERDCTL_VERSION}-linux-amd64.tar.gz
sudo tar -xzf nerdctl-full-${NERDCTL_VERSION}-linux-amd64.tar.gz -C /usr/local/
# Clean up the downloaded files
rm nerdctl-full-${NERDCTL_VERSION}-linux-amd64.tar.gz 
# Create a systemd service for BuildKit
sudo tee /etc/systemd/system/buildkit.service > /dev/null << EOF
[Unit]
Description=BuildKit
Documentation=https://github.com/moby/buildkit

[Service]
ExecStart=/usr/local/bin/buildkitd --oci-worker=false --containerd-worker=true

[Install]
WantedBy=multi-user.target
EOF
# Start and enable the BuildKit service
sudo systemctl daemon-reload
sudo systemctl start buildkitq
sudo systemctl enable buildkit
sudo systemctl restart buildkit
# Verify BuildKit is running
sudo systemctl status buildkit
# Check that buildctl can communicate with the daemon
sudo buildctl debug workers
# Rootless mode
# Configuring AppArmor is needed only on Ubuntu 24.04 or later, with RootlessKit installed under a non-standard path.
cat <<EOT | sudo tee "/etc/apparmor.d/usr.local.bin.rootlesskit"
abi <abi/4.0>,
include <tunables/global>

/usr/local/bin/rootlesskit flags=(unconfined) {
  userns,

  # Site-specific additions and overrides. See local/README for details.
  include if exists <local/usr.local.bin.rootlesskit>
}
EOT

sudo systemctl restart apparmor.service
sudo apt install -y uidmap
/usr/local/bin/containerd-rootless-setuptool.sh install
###############################################################################
#                                    BREW                                     #
###############################################################################
# Install Homebrew, The Missing Package Manager for macOS (or Linux)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# add Homebrew to your PATH
echo >> $HOME/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"' >> $HOME/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
# Install Homebrew's dependencies and GCC recommended
sudo apt-get install build-essential gcc -y
###############################################################################
#                                    K9S                                      #
###############################################################################
brew install k9s
###############################################################################
#                                    HELM                                     #
###############################################################################
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4 | /bin/bash
