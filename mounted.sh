#!/bin/bash

# RafeOS Installer (for ArchLinux)
# Copyright (c) RafeOS Contributors

echo "RafeOS Installer (For ArchLinux, Mounted Install)"
echo "Copyright (c) RafeOS Contributors"
echo ""
echo "Only run when chrooted into the new drive."
echo ""

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "[RafeOS Installer] Installation must be run as root (sudo mode)"
    echo "[RafeOS Installer] Installation Aborted."
    echo "[RafeOS Installer] Please try again as the root user."
    exit 1
fi

echo "[RafeOS Installer:Dependencies] Installing [Arch Linux Tweak Tool, ZSH, Wget] from the AUR"
yay -S archlinux-tweak-tool-git zsh wget neofetch discord git

if [[ "$@" == *"-di"* ]]; then
  echo "[RafeOS Installer:ArchDI] Running Arch Desktop Installer (-di specified)" # TODO: Include archdi to the main script
  wget archdi.sf.net/archdi -O archdi
  sleep 5
  chmod +x archdi
  ./archdi
  echo "[RafeOS Installer:ArchDI] Running Arch Desktop Installer (-di specified)" # TODO: Include archdi to the main script
else
  echo "[RafeOS Installer:ArchDI] Skipping (Specify -di)"
fi

if [[ "$@" == *"-df"* ]]; then
  echo "[RafeOS Installer:DotFiles] Downloading dotfiles (-df specified)" # TODO: Revamp dotfiles
  git clone https://github.com/rafedaniels/RafeOS dotfiles
  echo "[RafeOS Installer:DotFiles] Done"
else
  echo "[RafeOS Installer:DotFiles] Skipping (Specify -df)"
fi

if [[ "$@" == *"-si"* ]]; then
  echo "[RafeOS Installer:Shell] installing Shell (-si)" # TODO: Include to the main script

  # OhMyPosh Install
  wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
  chmod +x /usr/local/bin/oh-my-posh 

  # Poshthemes Install
  mkdir ~/.poshthemes
  wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
  unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
  chmod u+rw ~/.poshthemes/*.omp.*
  rm ~/.poshthemes/themes.zip

  # PoshFont
  echo "[RafeOS Installer:Shell] Please select a Nerd Font to install:"
  oh-my-posh font install

  # Activate OhMyPosh
  echo "[RafeOS Installer:Shell] Activating OhMyPosh"
  echo "eval '$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/rafedaniels/RafeOS/main/shell/ohmyposh-rafeos')'" >> .zshrc
else
  echo "[RafeOS Installer:Shell] Skipping (Specify -df)"
fi

echo "[RafeOS Installer:Done] Installation finished"
