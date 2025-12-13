---
name: Boot Theme Not Working
about: Report that the Dragon Boot theme shows a black screen instead of the animation
title: '[BUG] Dragon Boot Theme Shows Black Screen on Boot'
labels: bug, good first issue, help wanted, linux, plymouth, boot-theme, graphics
assignees: ''
---

## 🐉 Dragon Boot Theme Not Displaying

### System Information
**Please complete the following information:**
- OS: [e.g., Ubuntu 22.04 LTS]
- Kernel Version: [e.g., 5.15.0-91-generic] (run `uname -r`)
- Graphics Card: [e.g., NVIDIA GTX 1660, Intel UHD 620, AMD RX 580] (run `lspci | grep VGA`)
- Boot Mode: [e.g., UEFI, Legacy BIOS]
- Secure Boot: [e.g., Enabled, Disabled]

### Description of the Issue
**What happened:**
<!-- Describe what you see during boot instead of the dragon animation -->

**Expected behavior:**
A smooth 24-frame dragon animation should display during system boot with a progress bar at the bottom.

**Actual behavior:**
<!-- e.g., Black screen, text messages visible, frozen frame, etc. -->

### Installation Method Used
<!-- Check the method you used to install -->
- [ ] One-line wget install: `sudo wget -qO- https://raw.githubusercontent.com/statikfintechllc/dragon-boot/master/scripts/install.script | bash`
- [ ] One-line curl install: `sudo curl -fsSL https://raw.githubusercontent.com/statikfintechllc/dragon-boot/master/scripts/install.script | bash`
- [ ] Manual installation from cloned repository
- [ ] Other (please specify): 

### Installation Output
**Did the installation complete successfully?**
- [ ] Yes, no errors
- [ ] No, there were errors (please include error messages below)
- [ ] Unsure

**Installation errors (if any):**
```
Paste any error messages here
```

### Diagnostic Information

**1. Check if Plymouth is running:**
```bash
sudo journalctl -b | grep -i plymouth
```
<details>
<summary>Output:</summary>

```
Paste output here
```
</details>

**2. Verify theme registration:**
```bash
update-alternatives --list default.plymouth
```
<details>
<summary>Output:</summary>

```
Paste output here
```
</details>

**3. Check framebuffer devices:**
```bash
ls -la /dev/fb*
```
<details>
<summary>Output:</summary>

```
Paste output here
```
</details>

**4. Check GRUB configuration:**
```bash
grep -E "GRUB_CMDLINE_LINUX_DEFAULT|GRUB_GFXMODE|GRUB_GFXPAYLOAD" /etc/default/grub
```
<details>
<summary>Output:</summary>

```
Paste output here
```
</details>

**5. Verify theme files exist:**
```bash
ls -la /usr/share/plymouth/themes/dragon/
```
<details>
<summary>Output:</summary>

```
Paste output here
```
</details>

### Testing Without Reboot
**Have you tested the theme without rebooting?**
```bash
sudo plymouthd --debug --no-daemon &
sudo plymouth --show-splash
# Wait 5 seconds
sudo plymouth --quit
```

**Result:**
- [ ] Animation appeared correctly
- [ ] Black screen appeared
- [ ] Error occurred (please specify):
- [ ] Haven't tested yet

### Additional Context
<!-- Add any other context about the problem here -->
<!-- Screenshots or photos of the boot screen can be very helpful -->

### Troubleshooting Steps Attempted
<!-- Check any troubleshooting steps you've already tried -->
- [ ] Disabled Secure Boot
- [ ] Verified graphics drivers are installed
- [ ] Tested with default Plymouth theme (fade-in or similar)
- [ ] Checked `/var/log/` for errors
- [ ] Tried different GRUB_GFXMODE resolutions
- [ ] Ran `sudo update-initramfs -u -v`
- [ ] Other (please specify): 

---

**For maintainers:** See the comprehensive investigation guide at `.github/ISSUE_BOOT_THEME_NOT_WORKING.md` for detailed debugging steps.
