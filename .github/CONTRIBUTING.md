# Contributing to Dragon Boot

Thank you for your interest in contributing to Dragon Boot! 🐉

This guide will help you get started with contributing to this Plymouth boot theme project.

## 🐛 Reporting Issues

Before creating a new issue, please:
1. Check existing [issues](https://github.com/statikfintechllc/dragon-boot/issues) to avoid duplicates
2. Read the [Troubleshooting Guide](../docs/TROUBLESHOOTING.md)
3. Use the appropriate issue template:
   - **Boot Theme Not Working** - For black screen issues during boot
   - **Bug Report** - For other bugs or unexpected behavior
   - **Feature Request** - For suggesting enhancements

### Issue Quality Guidelines
Please include:
- Clear description of the problem or suggestion
- System information (OS, kernel version, graphics hardware)
- Steps to reproduce (for bugs)
- Diagnostic command output (when applicable)
- Error messages or logs

## 🔧 Development Setup

Dragon Boot is a distribution project (theme files + installation scripts), not a traditional software project requiring compilation.

### Prerequisites
- Linux system (Ubuntu 22.04+ recommended for testing)
- Plymouth boot splash system installed
- GRUB bootloader
- Git for version control
- Virtual machine recommended for testing (to avoid breaking your boot process)

### Repository Structure
```
dragon-boot/
├── frames/                    # 24 PNG animation frames
├── scripts/                   # Installation and testing scripts
├── usr/share/plymouth/themes/dragon/ # Plymouth theme files
├── etc/plymouth/              # Plymouth configuration
└── docs/                      # Documentation
```

## 🚀 Making Changes

### 1. Fork and Clone
```bash
# Fork the repository on GitHub, then:
git clone https://github.com/YOUR-USERNAME/dragon-boot.git
cd dragon-boot
```

### 2. Create a Branch
```bash
git checkout -b fix/descriptive-name
# or
git checkout -b feature/descriptive-name
```

### 3. Make Your Changes
- **For theme script changes:** Edit `usr/share/plymouth/dragon/dragon.script`
- **For installation fixes:** Edit `scripts/install.script`
- **For documentation:** Edit files in `docs/`
- **For animation:** Modify PNG files in `frames/` (maintain 24 frames)

### 4. Test Your Changes

**Testing in a VM (Recommended):**
```bash
# Install your modified version
sudo bash scripts/install.script

# Reboot to see the theme
sudo reboot
```

**Testing without reboot:**
```bash
# Quick preview (may not work exactly like real boot)
sudo plymouthd --debug --no-daemon &
sudo plymouth --show-splash
# Wait a few seconds
sudo plymouth --quit
```

### 5. Validate Changes
- Ensure install script runs without errors
- Verify theme displays correctly on target OS
- Check that documentation is updated (if applicable)
- Test on a clean system/VM if possible

### 6. Commit Changes
```bash
git add .
git commit -m "fix: descriptive commit message"
```

**Commit Message Guidelines:**
- Use present tense ("add feature" not "added feature")
- Use imperative mood ("move cursor to..." not "moves cursor to...")
- Prefix with type: `fix:`, `feat:`, `docs:`, `style:`, `refactor:`, `test:`, `chore:`
- Keep first line under 72 characters
- Reference issues: "fix: resolve black screen issue (#123)"

### 7. Push and Create Pull Request
```bash
git push origin fix/descriptive-name
```

Then create a Pull Request on GitHub with:
- Clear description of what changed and why
- Reference to related issue(s)
- Screenshots/photos if visual changes
- Testing details (what OS/system you tested on)

## 🎯 Good First Issues

Looking for where to start? Check issues labeled [`good first issue`](https://github.com/statikfintechllc/dragon-boot/labels/good%20first%20issue).

### Example Good First Contributions:
1. **Boot Theme Display Investigation**
   - Test installation on different Ubuntu versions
   - Document findings from diagnostic commands
   - Identify patterns in what works vs. doesn't work

2. **Documentation Improvements**
   - Add platform-specific installation notes
   - Improve troubleshooting guide with new solutions
   - Create visual guides or screenshots

3. **Script Enhancements**
   - Add better error handling to install script
   - Create automated diagnostic script
   - Improve installation progress feedback

4. **Testing**
   - Test on different Linux distributions
   - Document compatibility
   - Create test cases

## 📋 Pull Request Guidelines

### PR Requirements:
- [ ] Code/changes are tested and working
- [ ] Documentation is updated if needed
- [ ] Commit messages follow guidelines
- [ ] PR description explains what and why
- [ ] No unrelated changes included

### PR Review Process:
1. Maintainer reviews the changes
2. Feedback is provided if needed
3. You address feedback in new commits
4. Once approved, PR is merged
5. Your contribution is live! 🎉

## 🔍 Debugging Tips

### Common Issues to Investigate:

1. **Black Screen During Boot**
   - Check Plymouth logs: `sudo journalctl -b | grep plymouth`
   - Verify framebuffer: `ls /dev/fb*`
   - Test graphics drivers
   - Check theme registration: `update-alternatives --list default.plymouth`

2. **Installation Failures**
   - Verify all dependencies are available
   - Check file permissions
   - Ensure paths are correct for target distribution

3. **Animation Not Smooth**
   - Profile frame loading time
   - Test with fewer/smaller frames
   - Adjust refresh rate in script

### Useful Commands:
```bash
# View Plymouth theme list
update-alternatives --list default.plymouth

# Check initramfs contents
lsinitramfs /boot/initrd.img-$(uname -r) | grep plymouth

# Test with debug output
sudo plymouthd --debug --no-daemon

# Check graphics info
lspci | grep VGA
sudo lshw -c video

# View boot logs
sudo journalctl -b
```

## 🤝 Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on what's best for the project
- Help others learn and grow

## 📞 Getting Help

- **Issue Tracker:** For bug reports and feature requests
- **Discussions:** For questions and general discussion
- **Documentation:** Check `docs/` directory for guides

## 🎓 Learning Resources

New to Plymouth theming? Check out:
- [Plymouth Theme Guide](https://www.freedesktop.org/wiki/Software/Plymouth/)
- System documentation: `/usr/share/doc/plymouth/`
- Example themes: `/usr/share/plymouth/themes/`

## 📜 License

By contributing, you agree that your contributions will be licensed under the same MIT License that covers this project.

---

**Thank you for contributing to Dragon Boot!** 🐉🔥

Every contribution, no matter how small, helps make this project better.
