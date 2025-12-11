# GitHub Issue Templates

This directory contains issue templates to help contributors report bugs and request features effectively.

## Available Templates

### 1. Boot Theme Not Working (`boot-theme-not-working.md`)
**Use this template if:** The Dragon Boot theme installation completes but shows a black screen instead of the animation during boot.

**Labels:** `bug`, `good first issue`, `help wanted`, `linux`, `plymouth`, `boot-theme`, `graphics`

This is the **primary issue template** for the most common problem users encounter. It includes:
- System information checklist
- Diagnostic commands to run
- Installation verification steps
- Troubleshooting checklist

### 2. Feature Request (`feature-request.md`)
**Use this template if:** You want to suggest a new feature, enhancement, or improvement to Dragon Boot.

**Labels:** `enhancement`

### 3. General Bug Report (`bug-report.md`)
**Use this template if:** You've encountered a bug that's NOT related to the boot theme display issue (e.g., installation script errors, documentation issues, etc.).

**Labels:** `bug`

## Additional Resources

### Comprehensive Investigation Guide
See `.github/ISSUE_BOOT_THEME_NOT_WORKING.md` for:
- Detailed technical background
- In-depth investigation areas
- Contributing guidelines
- Success criteria for resolving the issue

This guide is intended for maintainers and contributors working on fixing the boot theme display issue.

## How to Create an Issue

1. Go to the [Issues](https://github.com/statikfintechllc/dragon-boot/issues) page
2. Click "New Issue"
3. Select the appropriate template
4. Fill in all requested information
5. Submit the issue

## For Maintainers

When an issue is reported:
1. Verify it uses the correct template
2. Check that all system information is provided
3. Request diagnostic output if missing
4. Add appropriate labels
5. Link to the comprehensive guide if investigating the boot theme issue

## Labels Reference

- `bug` - Something isn't working
- `enhancement` - New feature or request
- `good first issue` - Good for newcomers
- `help wanted` - Extra attention is needed
- `linux` - Linux-specific issues
- `ubuntu` - Ubuntu-specific issues
- `plymouth` - Plymouth boot theme system
- `boot-theme` - Boot theme rendering/display
- `graphics` - Graphics/framebuffer related
- `documentation` - Improvements or additions to documentation
