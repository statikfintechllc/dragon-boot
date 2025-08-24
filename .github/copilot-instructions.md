# Dragon Boot Plymouth Theme

Dragon Boot is a cinematic Plymouth boot theme for Linux featuring a glowing dragon animation. This is a **distribution project** (theme files and installation scripts), not a traditional software development project requiring compilation.

**Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.**

## Working Effectively

### Repository Setup and Validation
- **NEVER CANCEL ANY OPERATION** - All commands listed here have been tested and validated
- Bootstrap and validate the repository:
  ```bash
  # Clone takes ~2 seconds - NEVER CANCEL, set timeout to 30+ seconds
  git clone https://github.com/statikfintechllc/dragon-boot.git
  
  # Validate repository structure and files (takes ~2 seconds)
  bash scripts/verify-install-flow.sh
  ```
- **File structure verification** - Always check these files exist:
  - `frames/frame_000.png` through `frame_023.png` (24 PNG animation frames)
  - `usr/share/plymouth/dragon/dragon.plymouth` (Plymouth theme definition)
  - `usr/share/plymouth/dragon/dragon.script` (Plymouth animation script)
  - `etc/plymouth/plymouthd.conf` (Plymouth daemon configuration)
  - `scripts/install.script` (Main installation script)

### Installation Process
- **Installation timing**: Repository clone: ~2s, File operations: <1s, System updates: 10-60s (varies by system)
- **CRITICAL: NEVER CANCEL update-grub or update-initramfs** - These can take 10-60 seconds depending on system
- Main installation command (end users run this):
  ```bash
  # Option 1: wget - NEVER CANCEL, set timeout to 120+ seconds
  sudo wget -qO- https://raw.githubusercontent.com/statikfintechllc/dragon-boot/master/scripts/install.script | bash
  
  # Option 2: curl - NEVER CANCEL, set timeout to 120+ seconds  
  sudo curl -fsSL https://raw.githubusercontent.com/statikfintechllc/dragon-boot/master/scripts/install.script | bash
  ```
- **Installation steps the script performs**:
  1. Checks dependencies (plymouth, grub) - ~5s
  2. Clones repository to ~/dragon-boot - ~2s
  3. Copies 24 frame files to /usr/share/plymouth/themes/dragon/ - ~1s
  4. Copies Plymouth theme files - <1s
  5. Updates GRUB configuration (/etc/default/grub) - <1s
  6. **update-grub - 10-60s, NEVER CANCEL, set timeout to 120+ seconds**
  7. **update-initramfs -u -v - 10-60s, NEVER CANCEL, set timeout to 120+ seconds**
  8. Prompts for reboot

### Testing and Validation
- **ALWAYS validate your changes** with this command:
  ```bash
  # Comprehensive validation (takes ~5 seconds total)
  # This validates file structure, syntax, dependencies
  bash scripts/verify-install-flow.sh
  ```
- **Theme preview testing** (requires root):
  ```bash
  # Preview theme without rebooting - NEVER CANCEL, set timeout to 60+ seconds
  sudo plymouthd --debug --no-daemon
  ```
- **Manual validation scenarios** after making changes:
  1. Run file structure validation
  2. Verify all 24 PNG frames exist and are valid
  3. Check Plymouth script syntax contains required variables
  4. Test installation script syntax: `bash -n scripts/install.script`

## Critical Timing and "NEVER CANCEL" Warnings

- **Repository clone: ~2s** - Set timeout to 30+ seconds, NEVER CANCEL
- **update-grub: 10-60s depending on system** - Set timeout to 120+ seconds, NEVER CANCEL
- **update-initramfs: 10-60s depending on system** - Set timeout to 120+ seconds, NEVER CANCEL  
- **Plymouth preview: Variable timing** - Set timeout to 60+ seconds, NEVER CANCEL
- **Total installation time: 30-180s** excluding reboot

## Repository Structure

```
dragon-boot/
├── .github/                    # (after your changes)
├── docs/
│   ├── README.md              # Main documentation with install instructions
│   ├── STRUCTURE.md           # Repository structure documentation
│   └── TROUBLESHOOTING.md     # Common issues and solutions
├── frames/                    # 24 PNG animation frames (frame_000.png - frame_023.png)
├── scripts/
│   ├── install.script         # Main installation script (users run this)
│   └── verify-install-flow.sh # Validation and testing script
├── usr/share/plymouth/themes/dragon/ # Plymouth theme files
│   ├── dragon.plymouth               # Theme definition
│   └── dragon.script                 # Animation script (JavaScript-like syntax)
├── etc/plymouth/
│   └── plymouthd.conf        # Plymouth daemon configuration
└── LICENSE                   # MIT license
```

## Dependencies and System Requirements

- **Required system packages**: plymouth, plymouth-themes, grub2-common (Debian/Ubuntu) or equivalent
- **System commands required**: git, plymouth, update-grub, update-initramfs
- **Supported systems**: Ubuntu 22.04+, Debian 12+, Arch, Pop!_OS, Mint
- **Graphics requirements**: EFI framebuffer support (Secure Boot should be disabled)

## Common Tasks and Commands

### Validate Repository Integrity
```bash
# Check all files exist and are valid (takes ~2s)
ls frames/frame_*.png | wc -l  # Should output 24
file frames/frame_000.png       # Should show: PNG image data
bash -n scripts/install.script # Should exit cleanly
```

### Test Installation Script
```bash
# Syntax validation
bash -n scripts/install.script

# Dry run validation (our custom validator)
bash scripts/verify-install-flow.sh
```

### Check Theme File Integrity
```bash
# Verify Plymouth script contains required variables
grep "frame_count = 24" usr/share/plymouth/dragon/dragon.script
grep "Window.GetWidth" usr/share/plymouth/dragon/dragon.script

# Verify theme definition file
cat usr/share/plymouth/dragon/dragon.plymouth
```

## Important Notes for Developers

- **This is NOT a compiled software project** - no build steps, no unit tests, no linting tools
- **No package.json, Makefile, or CMakeLists.txt** - this is a theme distribution project
- **File operations are the "build process"** - copying PNGs and scripts to system directories
- **Testing requires root privileges** - Plymouth themes can only be tested with sudo
- **Installation modifies system files** - /etc/default/grub, /usr/share/plymouth/, /etc/plymouth/
- **Always test on a virtual machine first** - boot themes affect the entire system startup

## Troubleshooting

If installation or theme issues occur:
1. Check Plymouth logs: `sudo journalctl -b | grep plymouth`
2. Test theme manually: `sudo plymouthd --debug --no-daemon`
3. Verify graphics drivers are installed properly
4. See complete troubleshooting guide: `docs/TROUBLESHOOTING.md`

## Repository File Locations Summary

**Reference these locations when working on the codebase:**

- **Main installation script**: `scripts/install.script`
- **Documentation**: `docs/README.md`, `docs/TROUBLESHOOTING.md`
- **Animation frames**: `frames/frame_000.png` through `frames/frame_023.png`
- **Plymouth theme files**: `usr/share/plymouth/dragon/dragon.plymouth` and `dragon.script`
- **System configuration**: `etc/plymouth/plymouthd.conf`

**File count verification:**
```bash
ls frames/frame_*.png | wc -l  # Must be exactly 24
find usr/share/plymouth/dragon/ -name "*.plymouth" | wc -l  # Must be 1
find usr/share/plymouth/dragon/ -name "*.script" | wc -l    # Must be 1
```

Always run the validation script after making any changes to ensure repository integrity.