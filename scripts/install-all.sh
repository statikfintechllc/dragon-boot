#!/bin/bash

set -e

# Change this to your actual tar.gz bundle URL
BOOT_URL="https://example.com/dragon-boot.tar.gz"

echo "[🐉] Downloading Dragon Boot Theme Package..."
mkdir -p /tmp/dragon-boot
cd /tmp/dragon-boot

# 🔧 Dependency Check
echo "[🔍] Checking for required packages..."
if command -v apt &>/dev/null; then
    sudo apt update
    sudo apt install -y plymouth plymouth-themes grub2-common
elif command -v pacman &>/dev/null; then
    sudo pacman -Sy --noconfirm plymouth grub
elif command -v dnf &>/dev/null; then
    sudo dnf install -y plymouth grub2
else
    echo "❌ Unsupported package manager. Install dependencies manually."
    exit 1
fi

# Download and extract
wget -q --show-progress "$BOOT_URL" -O dragon-boot.tar.gz
echo "[📦] Extracting dragon-boot.tar.gz..."
tar -xzf dragon-boot.tar.gz
cd dragon-boot

echo "[🔧] Installing Dragon Boot Theme..."

# Ensure structure is valid
if [ ! -d "frames" ] || [ ! -f "usr/share/plymouth/themes/dragon/dragon.plymouth" ]; then
    echo "❌ Invalid theme directory structure. Install failed."
    exit 1
fi

# Copy frame PNGs
echo "[📦] Copying frame assets to /usr/share/plymouth/themes/dragon"
sudo mkdir -p /usr/share/plymouth/themes/dragon
sudo cp frames/frame_*.png /usr/share/plymouth/themes/dragon/

# Copy plymouth theme files
echo "[📜] Copying plymouth theme definition and script"
sudo cp usr/share/plymouth/themes/dragon/*.plymouth /usr/share/plymouth/themes/dragon/
sudo cp usr/share/plymouth/themes/dragon/*.script /usr/share/plymouth/themes/dragon/

# Copy plymouthd.conf
echo "[🗂️] Setting plymouthd.conf to use dragon theme"
sudo mkdir -p /etc/plymouth
sudo cp etc/plymouth/plymouthd.conf /etc/plymouth/plymouthd.conf

# Patch /etc/default/grub
echo "[⚙️] Patching /etc/default/grub..."
sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash loglevel=3 fbcon=map:1 gfxpayload=keep video=efifb bgrt_disable"/' /etc/default/grub

if ! grep -q "^GRUB_GFXMODE=" /etc/default/grub; then
    echo 'GRUB_GFXMODE=1920x1080' | sudo tee -a /etc/default/grub
else
    sudo sed -i 's/^GRUB_GFXMODE=.*/GRUB_GFXMODE=1920x1080/' /etc/default/grub
fi

if ! grep -q "^GRUB_GFXPAYLOAD_LINUX=" /etc/default/grub; then
    echo 'GRUB_GFXPAYLOAD_LINUX=keep' | sudo tee -a /etc/default/grub
else
    sudo sed -i 's/^GRUB_GFXPAYLOAD_LINUX=.*/GRUB_GFXPAYLOAD_LINUX=keep/' /etc/default/grub
fi

# Update GRUB and initramfs
echo "[🔄] Updating bootloader and initramfs..."
sudo update-grub
sudo update-initramfs -u -v || echo "ℹ️ Skipped initramfs update (not available on this distro)"

echo "[✅] Dragon Boot Theme Installed Successfully!"

read -rp $'\n[🚀] Reboot now to apply changes? [y/N]: ' confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "[♻️] Rebooting..."
    sudo reboot
else
    echo "[⏭️] Reboot skipped. Please reboot manually to see your dragon."
fi
