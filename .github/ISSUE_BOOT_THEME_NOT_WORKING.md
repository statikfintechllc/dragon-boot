# 🐉 Dragon Boot Theme Shows Black Screen on Ubuntu 22.04

## Labels
`bug` `good first issue` `help wanted` `linux` `ubuntu` `plymouth` `boot-theme` `graphics` `documentation`

---

## 📋 Problem Statement

The Dragon Boot Plymouth theme installation script completes successfully on Ubuntu 22.04, but instead of displaying the animated dragon boot splash screen, the system shows only a **black screen** during boot. The boot process completes normally, but the visual theme does not appear.

**Expected Behavior:**  
A smooth 24-frame dragon animation should display during system boot with a progress bar at the bottom.

**Actual Behavior:**  
Black screen appears during boot - no animation, no progress bar, no visual feedback.

---

## 🎯 Overall Goal

Make the Dragon Boot Plymouth theme fully operational on:
- ✅ **Primary Target:** Ubuntu 22.04 LTS (user's current OS)
- 🔄 **Secondary Targets:** Other Linux distributions that support custom Plymouth boot themes (Debian, Arch, Pop!_OS, Fedora, etc.)

The theme should display a cinematic glowing dragon animation during boot on UEFI systems with proper graphics framebuffer support.

---

## 📦 What's Present in the Repository

### ✅ Working Components

1. **Installation Script** (`scripts/install.script`)
   - Successfully installs dependencies (plymouth, grub, etc.)
   - Copies all 24 PNG animation frames to `/usr/share/plymouth/themes/dragon/`
   - Copies theme definition files (`.plymouth` and `.script`)
   - Configures `/etc/plymouth/plymouthd.conf`
   - Updates GRUB configuration in `/etc/default/grub`
   - Runs `update-grub` and `update-initramfs -u -v`
   - Registers theme with `update-alternatives`
   - Completes without errors

2. **Animation Assets** (`frames/` directory)
   - 24 high-quality PNG frames (frame_000.png through frame_023.png)
   - Each frame is approximately 2MB (1920x1080 resolution)
   - Total of ~50MB of animation assets

3. **Theme Configuration Files**
   - `usr/share/plymouth/themes/dragon/dragon.plymouth` - Theme metadata
   - `usr/share/plymouth/themes/dragon/dragon.script` - Animation script (126 lines)
   - `etc/plymouth/plymouthd.conf` - Daemon configuration

4. **Documentation**
   - `docs/README.md` - Installation and feature documentation
   - `docs/TROUBLESHOOTING.md` - Comprehensive troubleshooting guide
   - `docs/STRUCTURE.md` - Repository structure documentation

### ❌ What's Not Working

1. **Plymouth Theme Display**
   - Theme doesn't render during boot
   - Black screen appears instead of animation
   - No visible errors during installation
   - System boots normally otherwise

---

## 🔍 What We Know (Technical Details)

### Installation Process (Works ✅)
The install script successfully performs these steps:
```bash
# 1. Installs dependencies
sudo apt install -y plymouth plymouth-themes grub2-common plymouth-label plymouth-x11

# 2. Copies theme files to system directory
/usr/share/plymouth/themes/dragon/
├── frame_000.png ... frame_023.png (24 frames)
├── dragon.plymouth
└── dragon.script

# 3. Configures plymouthd.conf
/etc/plymouth/plymouthd.conf
  Theme=dragon
  ShowDelay=0

# 4. Updates GRUB configuration
/etc/default/grub
  GRUB_CMDLINE_LINUX_DEFAULT="quiet splash loglevel=3 fbcon=map:1 gfxpayload=keep video=efifb"
  GRUB_GFXMODE=1024x768
  GRUB_GFXPAYLOAD_LINUX=keep

# 5. Registers and activates theme
sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/dragon/dragon.plymouth 100
sudo update-alternatives --set default.plymouth /usr/share/plymouth/themes/dragon/dragon.plymouth

# 6. Updates system
sudo update-grub
sudo update-initramfs -u -v
```

### Theme Script Structure
The `dragon.script` file includes:
- Frame loading logic (loads all 24 PNG frames)
- Animation update function (cycles through frames)
- Progress bar rendering
- Callback functions for Plymouth events
- 25 FPS refresh rate

### Potential Issues (Need Investigation 🔍)

Based on the troubleshooting guide, possible causes include:

1. **Graphics/Framebuffer Issues**
   - Missing kernel framebuffer support (`/dev/fb*` devices)
   - Graphics driver compatibility (NVIDIA, AMD, Intel)
   - EFI framebuffer not initializing properly
   - Secure Boot blocking unsigned themes

2. **Plymouth Script Issues**
   - Script may have syntax errors not caught during installation
   - Image loading paths may be incorrect
   - Plymouth script engine may not support all functions used

3. **GRUB Configuration Issues**
   - Resolution mismatch between GRUB and Plymouth
   - Graphics payload not properly preserved
   - Console parameters interfering with framebuffer

4. **Theme Registration Issues**
   - Theme may not be properly registered in initramfs
   - Alternative selection may not be persisting
   - Plymouth may be reverting to fallback theme

5. **File Path Issues**
   - Duplicate theme directories exist (`usr/share/plymouth/themes/dragon/` and `usr/share/plymouth/dragon/`)
   - Installation may be copying to wrong location
   - Script `ImageDir` variable may not match actual file locations

---

## 🛠 Suggested Investigation Areas

### For Contributors (Good First Issue)

1. **Verify Plymouth Installation**
   ```bash
   # Check if Plymouth is actually running during boot
   sudo journalctl -b | grep -i plymouth
   
   # Verify theme is registered
   update-alternatives --list default.plymouth
   
   # Check initramfs contains theme files
   lsinitramfs /boot/initrd.img-$(uname -r) | grep dragon
   ```

2. **Test Theme Without Rebooting**
   ```bash
   sudo plymouthd --debug --no-daemon &
   sudo plymouth --show-splash
   # Wait a few seconds to see if animation appears
   sudo plymouth --quit
   ```

3. **Check Script Syntax**
   ```bash
   # Plymouth script syntax checker (if available)
   sudo plymouth --check-script /usr/share/plymouth/themes/dragon/dragon.script
   ```

4. **Verify Frame Files Load Correctly**
   - Check if PNG files are valid: `file frames/frame_000.png`
   - Verify file permissions: `ls -la /usr/share/plymouth/themes/dragon/`
   - Ensure paths in script match actual file locations

5. **Compare with Working Themes**
   ```bash
   # Test with default theme to confirm Plymouth works
   sudo update-alternatives --set default.plymouth /usr/share/plymouth/themes/fade-in/fade-in.plymouth
   sudo update-initramfs -u
   # Reboot and verify fade-in works
   ```

### Advanced Investigation

1. **Enable Plymouth Debug Logging**
   - Add debug flags to understand what's failing
   - Check kernel logs for framebuffer initialization
   - Monitor Plymouth's startup sequence

2. **Graphics Driver Testing**
   - Verify graphics drivers are properly loaded
   - Test with different kernel parameters (nomodeset, etc.)
   - Check if framebuffer devices exist (`ls /dev/fb*`)

3. **Resolution and Scaling**
   - Test with lower resolution (800x600, 1024x768)
   - Reduce PNG file sizes (optimize/compress images)
   - Try different GRUB graphics modes

4. **Script Debugging**
   - Add debug output to dragon.script
   - Verify all Plymouth callbacks are functioning
   - Test with simplified animation (fewer frames)

---

## 📚 Resources

- **Installation Command:**
  ```bash
  sudo wget -qO- https://raw.githubusercontent.com/statikfintechllc/dragon-boot/master/scripts/install.script | bash
  ```

- **Repository Files:**
  - Installation script: `scripts/install.script`
  - Theme script: `usr/share/plymouth/dragon/dragon.script`
  - Theme definition: `usr/share/plymouth/dragon/dragon.plymouth`
  - Troubleshooting guide: `docs/TROUBLESHOOTING.md`

- **External Documentation:**
  - Plymouth Theming Guide: https://www.freedesktop.org/wiki/Software/Plymouth/
  - Plymouth Script API: Check system docs at `/usr/share/doc/plymouth/`

---

## 🎯 Success Criteria

The issue will be considered resolved when:

1. ✅ Dragon animation displays during boot on Ubuntu 22.04
2. ✅ No black screen - animation is visible and smooth
3. ✅ Progress bar appears and functions correctly
4. ✅ Theme works after clean install using the one-line install command
5. ✅ Documentation is updated with any required fixes or prerequisites
6. ✅ Root cause is identified and documented for future reference

---

## 🤝 How to Contribute

This is a **good first issue** - perfect for contributors who want to learn about:
- Linux boot process and Plymouth themes
- Graphics framebuffer systems
- GRUB bootloader configuration
- Shell scripting and system configuration

**Steps to help:**
1. Fork the repository
2. Test the installation on Ubuntu 22.04 (or VM)
3. Run diagnostic commands from "Suggested Investigation Areas"
4. Document your findings in comments on this issue
5. If you find a fix, submit a PR with explanation

**No prior Plymouth experience needed!** The troubleshooting guide provides comprehensive debugging steps.

---

## 💬 Additional Context

- **Creator's Note:** "I built this as a cool idea, I have no idea how boot themes need to work, but would love to have this operational."
- **Current Status:** Install script works perfectly, but the visual theme doesn't display
- **Hardware:** The issue has been observed on Ubuntu 22.04 systems
- **Urgency:** Low - system still boots normally, this is a cosmetic enhancement

---

## 🏷️ Related Issues

- None yet - this is the primary tracking issue for boot theme functionality

---

**Let's make this dragon breathe fire! 🐉🔥**
