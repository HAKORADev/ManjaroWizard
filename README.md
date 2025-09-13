# 🧙‍♂️ ManjaroWizard

<div align="center">

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![Bash](https://img.shields.io/badge/Language-Bash-blue.svg)](https://www.gnu.org/software/bash/)
[![Manjaro](https://img.shields.io/badge/OS-Manjaro-35bf5c.svg)](https://manjaro.org/)
[![Arch Linux](https://img.shields.io/badge/Based_on-Arch_Linux-1793d1.svg)](https://archlinux.org/)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/HAKORADev/ManjaroWizard/graphs/commit-activity)
[![GitHub stars](https://img.shields.io/github/stars/HAKORADev/ManjaroWizard.svg?style=social&label=Star)](https://github.com/HAKORADev/ManjaroWizard)
[![GitHub forks](https://img.shields.io/github/forks/HAKORADev/ManjaroWizard.svg?style=social&label=Fork)](https://github.com/HAKORADev/ManjaroWizard/fork)

**🚀 The Ultimate Manjaro Linux Post-Installation Setup Script**

*Transform your fresh Manjaro installation into a fully-featured development powerhouse with just one command!*

[📥 Quick Install](#-quick-installation) • [🎯 Features](#-features) • [📖 Usage](#-usage) • [🤝 Contributing](#-contributing) • [📄 License](#-license)

</div>

---

## 🎯 Why Choose ManjaroWizard?

ManjaroWizard is the **fastest** and **most comprehensive** post-installation script for Manjaro Linux. Whether you're a developer, content creator, gamer, or power user, this wizard automates the tedious setup process and gets you productive in minutes, not hours.

### 🏆 Key Benefits

- ⚡ **Lightning Fast Setup** - Complete system configuration in under 30 minutes
- 🎛️ **Interactive Menu** - Choose exactly what you need, skip what you don't
- 📝 **Comprehensive Logging** - Every operation is logged for debugging and review
- 🔧 **Developer Ready** - Full development environment with Python, Node.js, Java, and more
- 🎨 **Creative Suite** - Graphics tools, multimedia codecs, and productivity software
- 🎮 **Gaming Ready** - Steam, Lutris, Wine, and gaming optimizations
- 🛡️ **Security Focused** - Firewall, antivirus, and system hardening included

---

## 🌟 Features

### 📦 **Development Environment**
- **Python Ecosystem**: Latest Python 3.13.7 with PyEnv, pip packages (NumPy, Flask, Pygame, etc.)
- **IDE & Editors**: VS Code, Thonny IDE with desktop integration
- **Programming Languages**: Java JDK, Node.js with NPM
- **Build Tools**: GCC, CMake, Make, GDB debugger
- **Version Control**: Git with essential development tools

### 🌐 **Web Browsers & Communication**
- **Browsers**: Brave, Microsoft Edge, Firefox, Chromium, Opera
- **Communication**: Discord, Telegram, Zoom integration
- **Privacy Focused**: Secure browsing options and VPN support

### 🎨 **Creative & Productivity Suite**
- **Graphics**: GIMP, Inkscape, Krita, Blender 3D
- **Office**: LibreOffice Fresh, OnlyOffice Desktop
- **PDF**: Okular document viewer
- **Multimedia**: Complete codec support, FFmpeg tools

### 🎮 **Gaming & Entertainment**
- **Gaming Platforms**: Steam, Lutris game manager
- **Compatibility**: Wine staging for Windows applications
- **Multimedia**: Full codec support for all media formats

### 🛠️ **System Tools & Utilities**
- **System Monitoring**: Btop, htop, neofetch, inxi
- **Disk Management**: GParted, GNOME Disk Utility
- **Backup**: Timeshift system snapshots
- **Archives**: 7-Zip, unrar, comprehensive extraction tools
- **Boot Management**: GRUB Customizer

### 🔒 **Security & Networking**
- **Firewall**: UFW with GUI frontend
- **Antivirus**: ClamAV with ClamTK interface
- **VPN**: OpenVPN, OpenConnect, StrongSwan support
- **Network**: Advanced NetworkManager plugins

### 🖥️ **Hardware Support**
- **Graphics Drivers**: Auto-detection and installation (NVIDIA, AMD, Intel)
- **Printing**: CUPS with HP printer support
- **Firmware**: Latest Linux firmware packages
- **Virtualization**: VirtualBox, QEMU, Virt-Manager

---

## 📥 Quick Installation

### 🚀 One-Line Install

```bash
git clone https://github.com/HAKORADev/ManjaroWizard.git && cd ManjaroWizard && chmod +x Manjarowizard.sh && ./Manjarowizard.sh
```

### 📋 Step-by-Step Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/HAKORADev/ManjaroWizard.git
   ```

2. **Navigate to Directory**
   ```bash
   cd ManjaroWizard
   ```

3. **Make Executable**
   ```bash
   chmod +x Manjarowizard.sh
   ```

4. **Run the Wizard**
   ```bash
   ./Manjarowizard.sh
   ```

---

## 📖 Usage

### 🎛️ Interactive Menu

ManjaroWizard presents a beautiful, color-coded interactive menu with 32+ options:

```
=================================
        Manjaro Wizard           
=================================

1.  Update system
2.  Install starter tools
3.  Install AUR helper (yay)
4.  Install Python
5.  Setup PyEnv + Python 3.13.7
...
32. Run ALL operations
0.  Exit
```

### 🎯 Quick Start Options

| Option | Description | Time |
|--------|-------------|------|
| `32` | **Complete Setup** - Install everything | ~25-30 min |
| `1-5` | **Developer Essentials** - Basic dev environment | ~8-12 min |
| `14-15` | **Browsers Only** - Brave + Edge installation | ~3-5 min |
| `17-18` | **Creative Suite** - Graphics and productivity tools | ~10-15 min |

### 📊 Progress Tracking

- **Real-time Logging**: All operations logged to `~/manjaro_wizard_install.log`
- **Color-coded Output**: Green (success), Red (error), Yellow (info), Blue (running)
- **Error Handling**: Automatic error detection and reporting

---

## 🔧 Advanced Configuration

### 🐍 Python Development

The script sets up a complete Python development environment:

```bash
# Python 3.13.7 via PyEnv
~/.pyenv/versions/3.13.7/bin/python

# Pre-installed packages
- numpy (scientific computing)
- pygame (game development)
- flask (web framework)
- requests (HTTP library)
- pillow (image processing)
- matplotlib (plotting)
```

### 🌍 AUR Helper Integration

Automatic installation of `yay` (Yet Another Yaourt) for AUR package management:

```bash
# Install AUR packages
yay -S package-name

# Search AUR
yay -Ss search-term
```

### 🔥 System Optimization

Automatic system optimizations included:
- **SSD Optimization**: Automatic TRIM scheduling
- **Font Rendering**: Subpixel rendering for crisp fonts
- **Security**: UFW firewall activation
- **Mirrors**: Fastest mirror selection

---

## 📊 System Requirements

| Requirement | Minimum | Recommended |
|-------------|---------|-------------|
| **OS** | Manjaro Linux | Latest stable release |
| **RAM** | 4 GB | 8 GB+ |
| **Storage** | 20 GB free | 50 GB+ free |
| **Internet** | Stable connection | Broadband recommended |
| **User Privileges** | sudo access | Required |

---

## 🤝 Contributing

We welcome contributions from the community! Here's how you can help:

### 🐛 Bug Reports

Found a bug? Please create an issue with:
- **System Information**: `neofetch` output
- **Log File**: Contents of `~/manjaro_wizard_install.log`
- **Steps to Reproduce**: Detailed reproduction steps
- **Expected vs Actual**: What should happen vs what happened

### 💡 Feature Requests

Have an idea? Open an issue with:
- **Use Case**: Why this feature would be useful
- **Implementation**: How you think it should work
- **Alternatives**: Any alternative solutions you've considered

### 🔧 Pull Requests

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### 📝 Code Style

- Use **4 spaces** for indentation
- **Comment** complex sections
- Follow **bash best practices**
- Test on **fresh Manjaro installation**

---

## 🏗️ Architecture

### 📁 Project Structure

```
ManjaroWizard/
├── Manjarowizard.sh        # Main script
├── README.md               # This file
├── LICENSE                 # MIT License
└── .github/
    └── workflows/          # CI/CD workflows
```

### 🔄 Function Overview

```bash
# Core Functions
log_command()               # Logging and error handling
install_packages()          # Package installation wrapper
update_system()            # System updates

# Installation Categories
install_starter_tools()     # Essential tools
setup_pyenv()              # Python environment
install_vscode()           # Development IDE
install_multimedia()       # Media codecs
configure_system()         # System optimization
```

---

## 📈 Roadmap

### 🎯 Upcoming Features

- [ ] **GUI Version** - GTK-based graphical interface
- [ ] **Custom Profiles** - Save and load installation profiles
- [ ] **Docker Support** - Containerized development environments
- [ ] **Dotfiles Integration** - Automatic dotfiles setup
- [ ] **Theme Manager** - Icon and theme installation
- [ ] **Backup Integration** - Pre-installation system backup

### 🔮 Future Enhancements

- [ ] **Multi-Distribution Support** - Arch, EndeavourOS compatibility
- [ ] **Cloud Integration** - Sync settings across devices
- [ ] **Plugin System** - Extensible architecture
- [ ] **Performance Monitoring** - Installation time analytics

---

## 📚 Documentation

### 🎓 Tutorials

- [First Time Setup Guide](../../wiki/First-Time-Setup)
- [Developer Environment](../../wiki/Developer-Environment)
- [Gaming Setup](../../wiki/Gaming-Setup)
- [Troubleshooting Guide](../../wiki/Troubleshooting)

### 📖 References

- [Manjaro Wiki](https://wiki.manjaro.org/)
- [Arch Linux Documentation](https://wiki.archlinux.org/)
- [AUR Guidelines](https://wiki.archlinux.org/title/AUR_submission_guidelines)

---

## 🙏 Acknowledgments

- **Manjaro Team** - For the amazing Linux distribution
- **Arch Linux Community** - For the robust package ecosystem
- **AUR Maintainers** - For maintaining community packages
- **Contributors** - Everyone who helps improve this project

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2024 HAKORADev

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

---

## 📞 Support

### 🆘 Getting Help

- **GitHub Issues**: [Report bugs or request features](../../issues)
- **Discussions**: [Community Q&A and discussions](../../discussions)
- **Wiki**: [Documentation and guides](../../wiki)

### 📧 Contact

- **Developer**: HAKORADev
-**Twitter**: [@HAKORAdev](https://twitter.com/HAKORAdev)
- **Email**: [Create an issue for support](../../issues/new)
- **Response Time**: Usually within 24-48 hours

---

## ⭐ Show Your Support

If ManjaroWizard helped you, please consider:

- ⭐ **Star** this repository
- 🐛 **Report bugs** to help improve the project
- 📢 **Share** with the Linux community
- 💝 **Contribute** code or documentation

---

<div align="center">

**Made with ❤️ by [HAKORADev](https://github.com/HAKORADev)**

*Empowering Manjaro users worldwide* 🌍

[![GitHub](https://img.shields.io/badge/GitHub-HAKORADev-181717?logo=github)](https://github.com/HAKORADev)

</div>

---

### 🏷️ Tags

`manjaro` `linux` `arch-linux` `automation` `post-installation` `setup-script` `development-environment` `python` `nodejs` `gaming` `productivity` `system-administration` `bash` `aur` `pacman`