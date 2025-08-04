# 🐉 Dragon Boot

*Bring fire to your bootloader.*

***A cinematic sci-fi* Plymouth theme for Linux featuring a *black-red-gold* glowing dragon animation, rendered at *full resolution* with zero flicker.

---

## 🔥 Features

- ✅ 1920×1080 HD animation (24 frames, PNG)  
- ✅ Full GRUB + Initramfs patching  
- ✅ Splash-safe: disables vendor logos and BGRT override  
- ✅ Mobile + tower friendly  
- ✅ One-liner install

---

## 🚀 Quick Install

```bash
# Install with wget
sudo wget -qO- https://raw.githubusercontent.com/statikfintechllc/dragon-boot/master/scripts/install.script | bash
```
```bash
# Or with curl
sudo curl -fsSL https://raw.githubusercontent.com/statikfintechllc/dragon-boot/master/scripts/install.script | bash
```

> ℹ️ Requires sudo access. Safe to run on any Linux distro with GRUB and Plymouth.

---

## 🛠  What It Does

The install script:

1. Installs all animation frames and scripts to:

```sql
   /usr/share/plymouth/themes/dragon/
```
2. Copies plymouthd.conf to:

```sql
   /etc/plymouth/
```
3. Appends to /etc/default/grub:

```sql
   GRUB_CMDLINE_LINUX_DEFAULT="quiet splash loglevel=3 fbcon=map:1 gfxpayload=keep video=efifb bgrt_disable"  
   GRUB_GFXMODE=1920x1080  
   GRUB_GFXPAYLOAD_LINUX=keep
```

4. Calls:

```bash
   sudo update-grub  
   sudo update-initramfs -u -v
```

5. Prompts for reboot

---

## 🧪 Test Compatibility

This theme works best on:

- Ubuntu 22.04+, Debian 12+, Arch, Pop!_OS, Mint  
- GRUB 2.06+ with plymouth installed  
- Systems with EFI framebuffer enabled (disable Secure Boot)

---

## ❌ Known Issues

- Windows Boot Logo: If dual booting, some UEFI systems may show the Windows logo due to BGRT fallback. The theme disables BGRT, but some firmware may ignore it.  
- Low-res Scaling: On older BIOS systems, animation may downscale or stutter.

---

## ✨ License

MIT — fork, remix, deploy. Credit appreciated but not required.

---

## 🧙 Built by

**Statik DK Smoke**  
Founder of GremlinGPT  
Architect of the GovSeverance Doctrine  
https://github.com/statikfintechllc  
https://medium.com/@ascend.gremlin

---

🩸 May your machine boot in fire and rise like a dragon.
