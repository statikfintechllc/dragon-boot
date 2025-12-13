# 🚀 Quick Start: Opening the GitHub Issue

## TL;DR - Fastest Way to Open the Issue

1. **Click this link:** https://github.com/statikfintechllc/dragon-boot/issues/new/choose

2. **Select:** "Boot Theme Not Working" → Click "Get started"

3. **Fill in:**
   - Your OS (Ubuntu 22.04)
   - Kernel version: Run `uname -r` and paste the result
   - Graphics card: Run `lspci | grep VGA` and paste the result
   - Boot mode: UEFI or Legacy BIOS
   - Secure Boot: Enabled or Disabled

4. **Run these diagnostic commands and paste the outputs:**

```bash
# Command 1: Check Plymouth status
sudo journalctl -b | grep -i plymouth

# Command 2: Verify theme registration
update-alternatives --list default.plymouth

# Command 3: Check framebuffer
ls -la /dev/fb*

# Command 4: Check GRUB config
grep -E "GRUB_CMDLINE_LINUX_DEFAULT|GRUB_GFXMODE|GRUB_GFXPAYLOAD" /etc/default/grub

# Command 5: Verify theme files
ls -la /usr/share/plymouth/themes/dragon/
```

5. **Describe what you see during boot** (black screen, text, frozen, etc.)

6. **Click "Submit new issue"**

That's it! The labels will be automatically added, and contributors will be able to help.

---

## What Happens Next?

- Issue gets labeled automatically: `bug`, `good first issue`, `help wanted`, `linux`, `plymouth`, `boot-theme`, `graphics`
- Contributors see the issue and can help investigate
- Community members with the same problem can add their findings
- Someone finds a fix and submits a Pull Request
- You test the fix
- Dragon boots with fire! 🐉🔥

---

## Need More Details?

- Full documentation: See `ISSUE_TEMPLATES_SUMMARY.md`
- Step-by-step guide: See `.github/HOW_TO_OPEN_ISSUE.md`
- Contributing info: See `.github/CONTRIBUTING.md`

---

**Questions?** Just open the issue with what you can provide, and ask questions in the comments!
