# Linux Dotfiles

> Just another generic Arch Linux rice with Hyprland

## Overview

This is a custom Linux desktop environment configuration built around Hyprland as the Wayland compositor. It includes configurations for various tools to create my workflow. Currently using Caelestia (QuickShell-based) as the desktop shell, but I'm planning to create a new version with a custom one... I just some free time to do that ;-; 

## Components

### Core

- **Window Manager**: [Hyprland](https://hypr.land/) - Dynamic tiling Wayland compositor
- **Shell**: [Caelestia Shell](https://github.com/caelestia-dots/shell) - QuickShell-based desktop shell (current)
- **Terminal**: [Alacritty](https://github.com/alacritty/alacritty) - GPU-accelerated terminal emulator
- **Shell**: [Fish](https://fishshell.com/) - Friendly interactive shell
- **Prompt**: [Starship](https://starship.rs/) - Cross-shell prompt

### Utilities

- **System Info**: Fastfetch
- **Multiplexer**: Zellij
- **Editor**: Lazyvim
- **Media Player**: MPV
- **Image Viewer**: QIMGV
- **File Explorer**: Nemo
- **Status Bar**: Caelestia (I have some configuration for a barebones waybar, but I'll remove it later) 

### Additional

- Wireplumber - Audio session manager
- XDG Desktop Portal - Desktop integration
- Hyprlock configuration (I need to remove this)

## Installation

> **Note**: This is a WIP configuration. Not all components may be fully configured or stable.

### Dependencies

#### Essential Packages

```bash
# CPU microcode (choose one based on your processor)
sudo pacman -S intel-ucode  # Intel processors
sudo pacman -S amd-ucode    # AMD processors

# Core system packages
sudo pacman -S hyprland hyprlock hyprpaper hypridle \
               pipewire wireplumber \
               xdg-desktop-portal-hyprland \
               qt5-wayland qt6-wayland

# Terminal & Shell
sudo pacman -S alacritty fish starship

# System utilities
sudo pacman -S fastfetch eza \
               git wget curl ufw \
               zip unzip ntfs-3g \
               fwupd dosfstools mtools \
               reflector pacman-contrib

# Wayland utilities
sudo pacman -S grim slurp wl-clipboard wl-clip-persist

# Multimedia
sudo pacman -S mpv ffmpeg \
               gst-plugins-ugly gst-plugins-good \
               gst-plugins-base gst-plugins-bad \
               gst-libav gstreamer

# Audio
sudo pacman -S pipewire-audio pipewire-alsa pipewire-pulse \
               pipewire-jack wireplumber wiremix

# Fonts
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji \
               ttf-liberation ttf-dejavu \
               ttf-jetbrains-mono-nerd ttf-cascadia-code-nerd

# Development tools
# For runtimes/language specific tools, you can install them separately: go, rustup, node, bun, zig...
sudo pacman -S vim neovim base-devel cmake ninja \
               zellij zoxide fzf fd ripgrep

# Applications
sudo pacman -S firefox
```

#### AUR Packages

```bash
# Install an AUR helper first (if not already installed)
sudo pacman -S --needed git base-devel && 
git clone https://aur.archlinux.org/yay.git &&
cd yay &&
makepkg -si

# Desktop shell & utilities
yay -S quickshell-git \
       hyprshell \
       mpvpaper # If you want to setup video based wpp

# Optional: Additional tools
yay -S spotify_player \
       gitui
```

#### Optional Dependencies

```bash
# File manager
sudo pacman -S nemo

# Image viewer
sudo pacman -S qimgv

# Docker (if needed)
sudo pacman -S docker docker-compose
sudo systemctl enable docker.service

# Gaming/Emulation
sudo pacman -S steam # (https://wiki.archlinux.org/title/Steam) 

# Proton Up (You can also follow this guide to setup everything: https://github.com/popcar2/SimpleLinuxGamingGuide)
yay -S protonup-qt # (https://github.com/DavidoTek/ProtonUp-Qt)

# A nice way to setup games
# You can also use Heroic/bottles...
yay -S faugus-launcher # (https://github.com/Faugus/faugus-launcher)
yay -S ryujinx

# Additional CLI tools
sudo pacman -S htop btop
```

#### Post-Installation Setup

After installing the packages, initialize required tools:

```bash
# Initialize Rust toolchain
rustup default stable

# Set Fish as default shell (optional)
chsh -s /usr/bin/fish

# Enable Docker service (if installed)
sudo systemctl enable --now docker.service
sudo usermod -aG docker $USER
```


Just remember to cherry-pick configurations you want to use config directory and test everything, it's not a fully fledged configuration:

```bash
# Example: Move specific configs
mv [repository]/.config/fish ~/.config/

# Refresh font cache
fc-cache -fv
```

## System Configuration

### Recommended Setup

Enable colors and multilib repositories:

```bash
sudo nvim /etc/pacman.conf
```

Update mirror list:

```bash
sudo reflector --country Brazil --protocol https --sort rate \
  --save /etc/pacman.d/mirrorlist && sudo pacman -Syyu
```

Enable services:

```bash
# Firewall
sudo systemctl enable ufw.service

# Package cache cleanup
sudo systemctl enable --now paccache.timer

# Systemd-boot auto-update
sudo systemctl enable systemd-boot-update.service
```

Adjust zram size (optional):

```bash
sudo nvim /etc/systemd/zram-generator.conf
```

## Project Structure

```
.
├── .config/
│   ├── hypr/              # Hyprland configuration
│   ├── caelestia/         # Caelestia shell config
│   ├── quickshell/        # QuickShell components
│   ├── alacritty/         # Terminal config
│   ├── fish/              # Shell configuration 
│   ├── waybar/            # Status bar config (Barebones, it's optional you can remove this)
│   ├── nvim/              # Neovim configuration (Basic Lazyvim config with a few changes)
│   ├── mpv/               # Media player config
│   ├── zellij/            # Terminal multiplexer (just like tmux)
│   └── ...
├── .local/                # Fonts/icons
├── .icons/                # Custom icons
└── .cargo/                # Fish environment file
```

## Preview

### Screenshots

<img width="3444" height="1440" alt="image" src="https://github.com/user-attachments/assets/77bb3e0d-3379-45bb-8799-22c3930fbb66" />

<img width="3442" height="1439" alt="image" src="https://github.com/user-attachments/assets/c9f81022-3318-4c3b-9cdc-c22c11ef04f0" />

## Known Issues

It's messy, so don't expect a clear setup/configuration.

- I'm constatly tweaking the configuration, so it will break stuff. I recommend just cloning and creating a new git repository.
- Some components may be incomplete or experimental
- Package list may be outdated

## Resources

- [Arch Wiki - General Recommendations](https://wiki.archlinux.org/title/General_recommendations)
- [Diolinux Guide](https://plus.diolinux.com.br/t/dicas-sobre-instalacao-de-pacotes-basicos-e-configuracao-do-arch/68708) (PT-BR)

- [Pipewire](https://wiki.archlinux.org/title/PipeWire)
- [Linux Audio Setup](https://forum.manjaro.org/t/how-to-make-linux-sound-great/146143)
- [Professional Audio](https://wiki.archlinux.org/title/Professional_audio)
- [RT Pipewire](https://wiki.archlinux.org/title/Realtime_process_management)
- [PipeWire Troubleshooting](https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/Troubleshooting)


## References

- [Caelestia Shell](https://github.com/caelestia-dots/shell)
- [End4](https://github.com/end-4/dots-hyprland)
