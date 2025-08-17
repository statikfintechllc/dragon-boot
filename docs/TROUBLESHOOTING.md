# Dragon Boot Theme Troubleshooting Guide

## Common Issues and Solutions

### Issue 1: Black Screen During Boot
**Symptoms:** Boot shows a black screen instead of the dragon animation.

**Possible Causes & Solutions:**

1. **Graphics Driver Issues**
   ```bash
   # Check current graphics driver
   lspci | grep VGA
   sudo lshw -c video
   
   # For NVIDIA users, ensure nouveau or nvidia drivers are properly installed
   # For AMD users, ensure amdgpu drivers are loaded
   # For Intel users, ensure i915 drivers are loaded
   ```

2. **Missing Kernel Framebuffer Support**
   ```bash
   # Check if framebuffer devices exist
   ls /dev/fb*
   
   # If no framebuffer devices, you may need to add framebuffer support
   # Add to GRUB_CMDLINE_LINUX_DEFAULT in /etc/default/grub:
   # "video=1920x1080 vga=791"
   ```

3. **Incorrect Resolution Settings**
   - Edit `/etc/default/grub` and try different resolutions:
   ```bash
   GRUB_GFXMODE=1024x768
   # or
   GRUB_GFXMODE=auto
   ```

### Issue 2: Text/Code Visible During Boot
**Symptoms:** Boot messages or console text appears instead of splash screen.

**Solutions:**

1. **Check GRUB Configuration**
   ```bash
   sudo nano /etc/default/grub
   
   # Ensure you have:
   GRUB_CMDLINE_LINUX_DEFAULT="quiet splash loglevel=3"
   
   # Update GRUB after changes:
   sudo update-grub
   ```

2. **Disable Console Output**
   ```bash
   # Add these parameters to GRUB_CMDLINE_LINUX_DEFAULT:
   # "console=tty12 fbcon=map:1"
   ```

### Issue 3: Animation Not Smooth/Laggy
**Symptoms:** Dragon animation stutters or runs slowly.

**Solutions:**

1. **Reduce Image File Sizes**
   - The frame images might be too large (currently ~2MB each)
   - Consider optimizing images:
   ```bash
   # Install imagemagick
   sudo apt install imagemagick
   
   # Optimize PNG files (run in frames directory)
   for file in frame_*.png; do
       convert "$file" -strip -quality 85 "optimized_$file"
   done
   ```

2. **Adjust Animation Speed**
   - Edit the refresh rate in `dragon.script`:
   ```javascript
   // Change from 25fps to 15fps for slower hardware
   Plymouth.SetRefreshRate(15);
   ```

### Issue 4: Plymouth Not Starting
**Symptoms:** No splash screen at all, normal boot text appears.

**Solutions:**

1. **Check Plymouth Installation**
   ```bash
   sudo apt list --installed | grep plymouth
   systemctl status plymouth-start
   ```

2. **Verify Theme Registration**
   ```bash
   # For Ubuntu/Debian systems:
   update-alternatives --list default.plymouth
   sudo update-alternatives --set default.plymouth /usr/share/plymouth/themes/dragon/dragon.plymouth
   sudo update-initramfs -u
   
   # For other systems with plymouth-set-default-theme:
   # /usr/sbin/plymouth-set-default-theme --list
   # /usr/sbin/plymouth-set-default-theme dragon
   ```

3. **Check Init System Integration**
   ```bash
   # For systemd systems
   systemctl is-enabled plymouth-start
   sudo systemctl enable plymouth-start
   ```

### Issue 5: Password Prompt Not Showing
**Symptoms:** System hangs when encrypted disk password is needed.

**Solutions:**

1. **Test Password Prompt**
   ```bash
   sudo plymouthd --debug --no-daemon &
   sudo plymouth --show-splash
   sudo plymouth ask-for-password --prompt="Test Password:"
   sudo plymouth --quit
   ```

2. **Check Encryption Integration**
   ```bash
   # Ensure cryptsetup integrates with Plymouth
   sudo apt install plymouth-theme-script
   ```

## Debugging Commands

### Test Theme Without Rebooting
```bash
# Run the included test script
sudo ./scripts/test-theme.sh

# Or manually test
sudo plymouthd --debug --no-daemon --tty=$(tty) &
sudo plymouth --show-splash
# Wait a few seconds
sudo plymouth --quit
```

### Check Plymouth Logs
```bash
# Check system logs for Plymouth messages
sudo journalctl -b | grep -i plymouth

# Enable Plymouth debug logging
sudo mkdir -p /etc/plymouth
echo "[Daemon]" | sudo tee /etc/plymouth/plymouthd.conf
echo "Theme=dragon" | sudo tee -a /etc/plymouth/plymouthd.conf
echo "ShowDelay=0" | sudo tee -a /etc/plymouth/plymouthd.conf
echo "DeviceTimeout=5" | sudo tee -a /etc/plymouth/plymouthd.conf
```

### Verify File Permissions
```bash
# Check that all theme files are readable
sudo find /usr/share/plymouth/themes/dragon -type f -exec ls -la {} \;

# Fix permissions if needed
sudo chmod 644 /usr/share/plymouth/themes/dragon/*
sudo chown root:root /usr/share/plymouth/themes/dragon/*
```

## Platform-Specific Issues

### Ubuntu/Debian
- Ensure `plymouth-theme-script` package is installed
- Check that Plymouth is enabled in initramfs: `lsinitramfs /boot/initrd.img | grep plymouth`

### Arch Linux
- Install `plymouth` from AUR if not already installed
- Enable Plymouth hook in `/etc/mkinitcpio.conf`: `HOOKS=(... plymouth ...)`
- Regenerate initramfs: `sudo mkinitcpio -p linux`

### Fedora/CentOS
- Install `plymouth-scripts` package
- Check SELinux context: `sudo restorecon -R /usr/share/plymouth/themes/dragon`

## Recovery Instructions

If the theme breaks your boot process:

1. **Boot to Recovery Mode**
   - Select "Advanced options" in GRUB
   - Choose "Recovery mode"

2. **Disable Plymouth**
   ```bash
   # For Ubuntu/Debian systems:
   sudo update-alternatives --set default.plymouth /usr/share/plymouth/themes/text/text.plymouth
   sudo update-initramfs -u
   sudo update-grub
   
   # For other systems:
   # sudo /usr/sbin/plymouth-set-default-theme text
   ```

3. **Reset to Default Theme**
   ```bash
   # For Ubuntu/Debian systems:
   sudo update-alternatives --set default.plymouth /usr/share/plymouth/themes/fade-in/fade-in.plymouth
   sudo update-initramfs -u
   
   # For other systems:
   # sudo /usr/sbin/plymouth-set-default-theme fade-in
   ```

## Contact and Support

If none of these solutions work:

1. Run the test script and save output: `sudo ./scripts/test-theme.sh > debug.log 2>&1`
2. Check hardware compatibility with Plymouth
3. Consider using a simpler theme temporarily
4. Report issues with full system information (distro, kernel version, graphics hardware)
