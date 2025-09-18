# 🧙‍♂️ ManjaroWizard

<div align="center">

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![Bash](https://img.shields.io/badge/Language-Bash-blue.svg)](https://www.gnu.org/software/bash/)
[![Manjaro](https://img.shields.io/badge/OS-Manjaro-35bf5c.svg)](https://manjaro.org/)
[![Arch Linux](https://img.shields.io/badge/Based_on-Arch_Linux-1793d1.svg)](https://archlinux.org/)
[![Version](https://img.shields.io/badge/Version-2.0-brightgreen.svg)](https://github.com/HAKORADev/ManjaroWizard/releases)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/HAKORADev/ManjaroWizard/graphs/commit-activity)
[![GitHub stars](https://img.shields.io/github/stars/HAKORADev/ManjaroWizard.svg?style=social&label=Star)](https://github.com/HAKORADev/ManjaroWizard)
[![GitHub forks](https://img.shields.io/github/forks/HAKORADev/ManjaroWizard.svg?style=social&label=Fork)](https://github.com/HAKORADev/ManjaroWizard/fork)

**🚀 The Ultimate Manjaro Linux Post-Installation Setup Script**

*Transform your fresh Manjaro installation into a fully-featured powerhouse with intelligent presets and advanced system optimization!*

[🔥 Quick Install](#-quick-installation) • [🎯 Features](#-features) • [📖 Usage](#-usage) • [📋 What's New](#-whats-new-in-v20) • [🤖 Presets](#-intelligent-presets) • [🤝 Contributing](#-contributing) • [📄 License](#-license)

</div>

---

## 🎯 Why Choose ManjaroWizard v2.0?

ManjaroWizard v2.0 is the **most advanced** and **intelligent** post-installation script for Manjaro Linux. With smart presets, enhanced error handling, and comprehensive system optimization, this wizard transforms your fresh installation into a production-ready system in minutes.

### 🏆 Key Benefits

- ⚡ **Lightning Fast Setup** - Complete system configuration in under 20 minutes
- 🤖 **Intelligent Presets** - Gaming, Development, and Office configurations
- 🎛️ **Advanced Menu System** - Interactive package management and custom installs
- 📊 **Enhanced Progress Tracking** - Real-time counters and status indicators
- 🔄 **Robust Error Handling** - Automatic retry mechanisms and fallback options
- 🔧 **System Optimization** - Performance tuning, ZRAM, and hardware detection
- 📦 **Package Management** - Install/remove packages with fuzzy search
- 🛡️ **Security Focused** - Firewall, antivirus, and system hardening included
- 📈 **Performance Tools** - System monitoring, optimization, and resource management

---

## 📋 What's New in v2.0?

### 🚀 Major Enhancements

#### 🤖 **Intelligent Presets**
- **333 - Gaming PC**: Steam, Lutris, Wine, performance optimizations, ZRAM
- **666 - Development PC**: Complete dev stack with Python 3.13.7, Node.js, Java, VS Code
- **999 - Office PC**: Productivity suite, communication apps, printing support

#### 🔍 **Advanced Package Management**
- **Fuzzy Search Integration**: Find packages easily with `fzf`
- **Multi-Manager Support**: pacman, yay, flatpak, snap compatibility
- **Interactive Package Removal**: Safe removal with dependency checking
- **Custom Package Installation**: Search, preview, and install any package

#### ⚡ **Performance & System Optimization**
- **ZRAM Configuration**: Automatic compressed swap setup
- **Performance Tuning**: Kernel parameters, I/O schedulers, cache optimization
- **Hardware Detection**: Automatic GPU driver installation (NVIDIA, AMD, Intel)
- **Screen Resolution Config**: Custom resolution setup with CVT modelines

#### 🛠️ **Enhanced System Tools**
- **Progress Counters**: Real-time installation progress tracking
- **Error Recovery**: Automatic retry mechanisms with exponential backoff
- **System Information**: Live system stats display
- **Backup Integration**: Automatic Timeshift backup creation

#### 🔧 **Developer Improvements**
- **PyEnv Integration**: Complete Python environment management
- **NVM Support**: Node.js version management
- **Container Support**: Docker with user group configuration
- **Development Desktop Entries**: Custom application launchers

### 🔄 **Improved Architecture**

#### 📊 **Enhanced Logging & Monitoring**
- Color-coded progress indicators with package counters
- Comprehensive error handling with retry mechanisms
- System validation checks (Manjaro detection, internet connectivity)
- Real-time system information display

#### 🎨 **Better User Experience**
- Improved menu navigation with clear categorization
- System information display in main menu
- Progress indicators for long-running operations
- Confirmation prompts for destructive operations

---

## 🌟 Features

### 🤖 **Intelligent Presets**
- **Gaming PC (333)**: Complete gaming setup with Steam, Lutris, Wine, performance optimization
- **Development PC (666)**: Full development environment with all major languages and tools  
- **Office PC (999)**: Productivity-focused setup with office applications and communication tools

### 📦 **Development Environment**
- **Python Ecosystem**: Python 3.13.7 with PyEnv, extensive package library
- **IDE & Editors**: VS Code, Thonny IDE with custom desktop integration
- **Programming Languages**: Java JDK with Maven/Gradle, Node.js with NVM
- **Build Tools**: GCC, Clang, CMake, Make, GDB, LLDB debuggers
- **Version Control**: Git with development workflow tools

### 🌐 **Web Browsers & Communication**
- **Modern Browsers**: Brave, Microsoft Edge, Firefox, Chromium, Opera, Vivaldi
- **Communication Suite**: Discord, Telegram, Zoom, Slack, Teams integration
- **Remote Access**: RustDesk with AppImage fallback
- **Privacy Focused**: Secure browsing options and VPN support

### 🎨 **Creative & Productivity Suite**
- **Graphics Suite**: GIMP, Inkscape, Krita, Blender 3D, DarkTable
- **Office Applications**: LibreOffice Fresh, OnlyOffice Desktop
- **Document Viewers**: Okular, Evince PDF readers
- **Multimedia**: Complete codec support, FFmpeg tools

### 🎮 **Gaming & Entertainment**
- **Gaming Platforms**: Steam, Lutris game manager, Proton GE
- **Compatibility**: Wine staging, Wine AppImage with desktop integration
- **Performance**: GameMode, MangoHUD for gaming optimization
- **Multimedia**: Full codec support for all media formats

### 🛠️ **System Tools & Utilities**
- **System Monitoring**: Btop, htop, neofetch, inxi system information
- **Disk Management**: GParted, GNOME Disk Utility, Baobab disk analyzer
- **Backup Solutions**: Timeshift snapshots with automated backup creation
- **Archives**: Complete archive support (7z, rar, zip, tar)
- **System Optimization**: Stacer system cleaner, performance tuning tools

### 🔒 **Security & Networking**
- **Firewall Management**: UFW with GUFW graphical interface
- **Antivirus Protection**: ClamAV with ClamTK frontend
- **Security Auditing**: rkhunter, chkrootkit system scanning
- **VPN Support**: OpenVPN, OpenConnect, StrongSwan integration
- **Network Tools**: Wireshark, nmap network analysis

### 🖥️ **Hardware Support**
- **Graphics Drivers**: Automatic detection and installation (NVIDIA, AMD, Intel)
- **Audio Systems**: ALSA, PulseAudio with complete firmware support
- **Printing**: CUPS with HP printer support and system-config-printer
- **Firmware**: Latest Linux firmware, SOF audio, fwupd support
- **Virtualization**: VirtualBox, QEMU, Virt-Manager, Docker containers

### ⚡ **Performance Optimization**
- **ZRAM Integration**: Compressed swap for improved performance
- **I/O Optimization**: Automatic scheduler selection based on storage type
- **Memory Management**: Advanced kernel parameters and cache optimization
- **Boot Optimization**: Faster boot times with optimized services
- **Resource Management**: TLP power management, preload optimization

---

## 🔥 Quick Installation

### 🚀 One-Line Install (Latest Version)

```bash
git clone https://github.com/HAKORADev/ManjaroWizard.git && cd ManjaroWizard && chmod +x Manjarowizard-v2.sh && ./Manjarowizard-v2.sh
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

3. **Make Executable (v2.0)**
   ```bash
   chmod +x Manjarowizard-v2.sh
   ```

4. **Run the Wizard**
   ```bash
   ./Manjarowizard-v2.sh
   ```

### 🔄 Version Selection

- **Latest (v2.0)**: `./Manjarowizard-v2.sh` - Recommended for new installations
- **Legacy (v1.0)**: `./Manjarowizard-v1.sh` - For compatibility with older systems

---

## 📖 Usage

### 🤖 Intelligent Presets

ManjaroWizard v2.0 introduces smart presets for instant setup:

```
=================================
        Manjaro Wizard Setup
=================================
333 - Setup Gaming PC
666 - Setup Development PC  
999 - Setup Office PC
=================================
```

| Preset | Description | Includes | Time |
|--------|-------------|----------|------|
| **333** | **Gaming PC** | Steam, Lutris, Wine, drivers, performance optimization | ~15-20 min |
| **666** | **Development PC** | Python, Node.js, Java, VS Code, compilers, containers | ~20-25 min |
| **999** | **Office PC** | LibreOffice, communication apps, browsers, printing | ~12-18 min |

### 🎛️ Interactive Menu System

Enhanced menu with real-time system information and package counters:

```
=================================
        Manjaro Wizard Setup        
=================================
System Information
OS: Manjaro Linux x86_64
Kernel: 6.1.0-1-MANJARO
Memory: 8.2G / 16G
Disk: 45G / 256G (18% used)
=================================

Installation / Management Options:
1.  Update system
2.  [3/6] Install starter tools
3.  Install AUR helper (yay)
...
37. Custom package installer (search/pick)
38. Remove / uninstall packages
```

### 🔍 Advanced Package Management

#### Custom Package Installation
- **Fuzzy Search**: Find packages with partial matching
- **Multi-Manager**: Choose between pacman, yay, flatpak, snap
- **Live Preview**: See package information before installation

#### Package Removal
- **Safe Removal**: Dependency checking and confirmation
- **Multi-Select**: Remove multiple packages at once
- **Cross-Platform**: Works with all package managers

### 📊 Progress Tracking & Monitoring

- **Real-time Counters**: `[3/6] Package Category` shows installation progress
- **Color-coded Output**: Green (success), Red (error), Yellow (info), Blue (running)
- **Retry Mechanisms**: Automatic retry with exponential backoff
- **Comprehensive Logging**: All operations logged to `~/manjaro_wizard_install.log`

---

## 🔧 Advanced Configuration

### 🐍 Python Development Environment

Complete Python setup with PyEnv management:

```bash
# Python 3.13.7 with PyEnv
~/.pyenv/versions/3.13.7/bin/python

# Enhanced package library
- numpy (scientific computing)
- pygame (game development)  
- flask (web framework)
- requests (HTTP library)
- pillow (image processing)
- matplotlib (plotting)
- pandas (data analysis)
- scipy (scientific computing)
- jupyter (notebooks)
```

### 🌐 Node.js Development

Advanced Node.js setup with version management:

```bash
# NVM for version management
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# Package managers
- npm (default)
- yarn (alternative)
```

### ⚡ Performance Optimization

#### ZRAM Configuration
Automatic compressed swap setup for improved performance:

```bash
# ZRAM configuration in /etc/systemd/zram-generator.conf
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
swap-priority = 100
fs-type = swap
```

#### System Optimization
Advanced kernel parameters and system tuning:

```bash
# I/O schedulers based on storage type
- BFQ for rotating drives
- optimized read-ahead settings
- request queue optimization

# Memory management
- vm.swappiness=1
- optimized cache pressure
- dirty ratio optimization
```

### 🎮 Gaming Optimizations

Complete gaming setup with performance tuning:

```bash
# Gaming tools
- Steam (native client)
- Lutris (game manager)
- Wine staging (Windows compatibility)
- GameMode (performance optimization)
- MangoHUD (performance overlay)
- Proton GE (enhanced compatibility)

# Performance optimizations
- ZRAM for memory compression
- optimized kernel parameters
- GPU driver auto-detection
```

---

## 📊 System Requirements

| Requirement | Minimum | Recommended |
|-------------|---------|-------------|
| **OS** | Manjaro Linux (any edition) | Latest stable release |
| **RAM** | 4 GB | 8 GB+ (16 GB for development) |
| **Storage** | 20 GB free | 50 GB+ free |
| **Internet** | Stable connection | Broadband (for faster downloads) |
| **User Privileges** | sudo access | Required for system modifications |
| **Architecture** | x86_64 | Native support only |

---

## 📚 Version History

### 🚀 **Version 2.0** (Current)
**Release Date**: December 2024

#### 🎉 **Major Features**
- **Intelligent Presets**: Gaming (333), Development (666), Office (999) configurations
- **Advanced Package Management**: Fuzzy search, multi-manager support, interactive removal
- **Performance Optimization**: ZRAM, system tuning, hardware detection
- **Enhanced User Experience**: Progress counters, system information display, better navigation

#### 🔧 **Technical Improvements**
- **Robust Error Handling**: Automatic retry mechanisms with exponential backoff
- **System Validation**: Manjaro detection, internet connectivity checks
- **Enhanced Logging**: Comprehensive operation logging with timestamps
- **Code Architecture**: Modular functions, improved maintainability

#### 🛠️ **New Tools & Applications**
- **RustDesk**: Remote desktop with AppImage fallback
- **Wine AppImage**: Windows application compatibility
- **Advanced Browsers**: Vivaldi, Falkon additions
- **Development Tools**: Clang, LLDB, enhanced Python libraries
- **System Tools**: Stacer, Baobab, advanced monitoring

#### ⚡ **Performance Features**  
- **ZRAM Integration**: Compressed swap configuration
- **I/O Optimization**: Automatic scheduler selection
- **Memory Management**: Advanced kernel parameter tuning
- **Boot Optimization**: Service optimization, faster startup

### 📜 **Version 1.0** (Legacy)
**Release Date**: Early 2024

#### 🎯 **Core Features**
- **Basic Installation**: Essential tools and applications
- **Simple Menu System**: Linear menu with 32 options
- **Package Installation**: Standard pacman and AUR support
- **System Configuration**: Basic firewall and font setup
- **Developer Tools**: Python, Java, Node.js installation
- **Multimedia Support**: Codec installation and media tools

#### 🏗️ **Architecture**
- **Single Script**: Monolithic approach with basic functions
- **Simple Logging**: Basic operation logging
- **Error Handling**: Simple success/failure detection
- **User Interface**: Color-coded terminal output

---

## 🤝 Contributing

We welcome contributions from the community! Here's how you can help improve ManjaroWizard v2.0:

### 🐛 Bug Reports

Found a bug? Please create an issue with:
- **System Information**: `neofetch` or `inxi` output
- **Log File**: Contents of `~/manjaro_wizard_install.log`
- **Steps to Reproduce**: Detailed reproduction steps
- **Expected vs Actual**: What should happen vs what happened
- **Version**: Specify v1.0 or v2.0

### 💡 Feature Requests

Have an idea? Open an issue with:
- **Use Case**: Why this feature would be useful
- **Implementation**: How you think it should work
- **Target Version**: Which version should include this feature
- **Alternatives**: Any alternative solutions you've considered

### 🔧 Pull Requests

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Test** on fresh Manjaro installation
4. **Commit** your changes (`git commit -m 'Add amazing feature'`)
5. **Push** to the branch (`git push origin feature/amazing-feature`)
6. **Open** a Pull Request with detailed description

### 📝 Code Style Guidelines

- **Indentation**: Use 4 spaces consistently
- **Comments**: Comment complex sections and functions
- **Error Handling**: Include proper error checking and logging
- **Testing**: Test on fresh Manjaro installation
- **Compatibility**: Ensure compatibility with both v1.0 and v2.0 where applicable

---

## 🗂️ Architecture

### 📁 Project Structure

```
ManjaroWizard/
├── Manjarowizard-v2.sh      # Main v2.0 script (latest)
├── Manjarowizard-v1.sh      # Legacy v1.0 script  
├── README.md                # This documentation
├── LICENSE                  # MIT License
└── .github/
    └── workflows/           # CI/CD workflows
```

### 🔄 Function Architecture (v2.0)

```bash
# Core Infrastructure
check_manjaro()              # System validation
check_internet()            # Connectivity verification
log_command()               # Enhanced logging with retry
install_dependencies()      # Dependency management

# Package Management
install_packages()          # Smart package installation
counter_init()              # Progress tracking
counter_show()              # Progress display
custom_package_install()   # Interactive package search
remove_packages()           # Safe package removal

# Intelligent Presets
setup_gaming_pc()           # Gaming configuration (333)
setup_development_pc()      # Development setup (666)
setup_office_pc()           # Office configuration (999)

# Performance & Optimization
configure_zram()            # ZRAM compressed swap
optimize_system_performance() # Kernel parameter tuning
detect_display_info()       # Hardware detection
configure_screen_resolution() # Custom resolution setup

# System Management
create_backup()             # Timeshift backup creation
show_system_info()          # Live system statistics
cleanup_system()            # System maintenance
```

## 📚 Documentation

### 🎓 Tutorials

- [First Time Setup Guide](../../wiki/First-Time-Setup)
- [Gaming PC Configuration](../../wiki/Gaming-PC-Setup)
- [Development Environment](../../wiki/Developer-Environment)  
- [Office PC Setup](../../wiki/Office-PC-Setup)
- [Performance Optimization](../../wiki/Performance-Tuning)
- [Troubleshooting Guide](../../wiki/Troubleshooting)

### 📖 References

- [Manjaro Wiki](https://wiki.manjaro.org/)
- [Arch Linux Documentation](https://wiki.archlinux.org/)
- [AUR Guidelines](https://wiki.archlinux.org/title/AUR_submission_guidelines)
- [PyEnv Documentation](https://github.com/pyenv/pyenv)
- [ZRAM Configuration](https://wiki.archlinux.org/title/Zram)

---

## 🙏 Acknowledgments

- **Manjaro Team** - For the amazing Linux distribution and continued development
- **Arch Linux Community** - For the robust package ecosystem and AUR
- **AUR Maintainers** - For maintaining thousands of community packages
- **Open Source Contributors** - For the tools and applications we integrate
- **Community Members** - Everyone who tests, reports bugs, and suggests improvements
- **Beta Testers** - Special thanks to early v2.0 testers for their feedback

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
- **Version Specific**: Tag issues with v1.0 or v2.0 for faster resolution

### 📧 Contact

- **Developer**: HAKORADev
- **Twitter**: [@HAKORAdev](https://twitter.com/HAKORAdev)
- **Email**: [Create an issue for support](../../issues/new)
- **Response Time**: Usually within 24-48 hours
- **Priority Support**: Critical bugs and security issues

---

## ⭐ Show Your Support

If ManjaroWizard v2.0 helped you, please consider:

- ⭐ **Star** this repository to help others discover it
- 🐛 **Report bugs** to help improve the project for everyone
- 💡 **Suggest features** for future versions
- 📢 **Share** with the Linux community on social media
- 👥 **Contribute** code, documentation, or testing
- 💬 **Join discussions** and help other users

---

<div align="center">

**Made with ❤️ by [HAKORADev](https://github.com/HAKORADev)**

*Empowering Manjaro users worldwide with intelligent automation* 🌍

[![GitHub](https://img.shields.io/badge/GitHub-HAKORADev-181717?logo=github)](https://github.com/HAKORADev)
[![Version](https://img.shields.io/badge/Current_Version-2.0-brightgreen.svg)](https://github.com/HAKORADev/ManjaroWizard/releases)

**🚀 Ready to transform your Manjaro installation? [Get started now!](#-quick-installation)**

</div>

---

### 🏷️ Tags

`manjaro` `linux` `arch-linux` `automation` `post-installation` `setup-script` `development-environment` `python` `nodejs` `gaming` `productivity` `system-administration` `bash` `aur` `pacman` `performance-optimization` `zram` `intelligent-presets` `fuzzy-search` `package-management`
