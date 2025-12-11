# How to Open the Boot Theme Issue on GitHub

This guide will help you create the issue on GitHub for the Dragon Boot theme black screen problem.

## Quick Method (Using the Template)

1. **Go to the Issues Page:**
   - Visit: https://github.com/statikfintechllc/dragon-boot/issues/new/choose

2. **Select the Template:**
   - Click "Get started" next to **"Boot Theme Not Working"**

3. **Fill in the Information:**
   - Add your system details (OS, kernel, graphics card)
   - Describe what you see during boot
   - Run the diagnostic commands and paste the outputs
   - Note any troubleshooting steps you've tried

4. **Add Labels:**
   The template will auto-add these labels:
   - `bug`
   - `good first issue`
   - `help wanted`
   - `linux`
   - `plymouth`
   - `boot-theme`
   - `graphics`

5. **Submit the Issue:**
   - Click "Submit new issue"

## Alternative: Copy the Comprehensive Issue

If you want to create a more detailed tracking issue:

1. **Go to New Issue:**
   - Visit: https://github.com/statikfintechllc/dragon-boot/issues/new

2. **Copy Content:**
   - Open `.github/ISSUE_BOOT_THEME_NOT_WORKING.md` from this repository
   - Copy all the content

3. **Paste and Edit:**
   - Paste into the issue description
   - The labels are listed at the top - add them manually:
     - `bug`
     - `good first issue`
     - `help wanted`
     - `linux`
     - `ubuntu`
     - `plymouth`
     - `boot-theme`
     - `graphics`
     - `documentation`

4. **Customize:**
   - Add your specific findings or test results
   - Note your system configuration

5. **Submit:**
   - Use title: "🐉 Dragon Boot Theme Shows Black Screen on Ubuntu 22.04"
   - Click "Submit new issue"

## What Happens Next?

After creating the issue:

1. **Community Attention:**
   - The `good first issue` and `help wanted` labels will attract contributors
   - Other users with the same problem can add their findings

2. **Investigation:**
   - Contributors can follow the diagnostic steps
   - Test on different systems
   - Identify the root cause

3. **Solution:**
   - Once someone finds the fix, they'll submit a Pull Request
   - You can test the fix on your system
   - The issue will be closed when resolved

## Running Diagnostic Commands

To provide useful information in your issue, run these commands and paste the output:

```bash
# System information
uname -r
lspci | grep VGA

# Plymouth status
sudo journalctl -b | grep -i plymouth
update-alternatives --list default.plymouth

# Check framebuffer
ls -la /dev/fb*

# GRUB configuration
grep -E "GRUB_CMDLINE_LINUX_DEFAULT|GRUB_GFXMODE|GRUB_GFXPAYLOAD" /etc/default/grub

# Theme files
ls -la /usr/share/plymouth/themes/dragon/

# Check if theme is in initramfs
lsinitramfs /boot/initrd.img-$(uname -r) | grep dragon
```

## Tips for a Good Issue Report

✅ **Do:**
- Be specific about what you see (or don't see)
- Include all system information
- Paste command outputs in code blocks
- Mention if you've tried any troubleshooting steps
- Add screenshots/photos if possible

❌ **Don't:**
- Say "it doesn't work" without details
- Skip system information
- Assume everyone knows your setup
- Mix multiple unrelated issues in one report

## Need Help?

- Check the [Troubleshooting Guide](docs/TROUBLESHOOTING.md)
- Read the [Contributing Guide](.github/CONTRIBUTING.md)
- Look at existing issues for similar problems

---

**Ready to create the issue? Let's get this dragon flying!** 🐉🔥
