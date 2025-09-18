# 🧙‍♂️ ManjaroWizard

<div align="center">

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![Bash](https://img.shields.io/badge/Language-Bash-blue.svg)](https://www.gnu.org/software/bash/)
[![Manjaro](https://img.shields.io/badge/OS-Manjaro-35bf5c.svg)](https://manjaro.org/)
[![Version](https://img.shields.io/badge/Version-2.0-brightgreen.svg)](https://github.com/HAKORADev/ManjaroWizard/releases)
[![GitHub stars](https://img.shields.io/github/stars/HAKORADev/ManjaroWizard.svg?style=social&label=Star)](https://github.com/HAKORADev/ManjaroWizard)

**🚀 The Ultimate Manjaro Linux Post-Installation Setup Script**

*Transform your fresh Manjaro installation into a fully-featured powerhouse with intelligent presets and advanced system optimization!*

[🔥 Quick Install](#-installation) • [🎯 Features](#-features) • [📖 Usage](#-usage) • [📋 Releases](https://github.com/HAKORADev/ManjaroWizard/releases) • [🤝 Contributing](#-contributing)

</div>

---

## 🎯 About ManjaroWizard

ManjaroWizard is an **intelligent post-installation automation script** designed to transform your fresh Manjaro Linux installation into a production-ready system in minutes. With smart presets, comprehensive package management, and advanced system optimization, it eliminates the tedious setup process and gets you up and running fast.

### 🏆 Why Choose ManjaroWizard?

- ⚡ **Lightning Fast Setup** - Complete system configuration in under 20 minutes
- 🤖 **Intelligent Presets** - Gaming, Development, and Office configurations  
- 🎛️ **Interactive Management** - Advanced package search, install, and removal
- 📊 **Progress Tracking** - Real-time counters and status indicators
- 🔄 **Robust Error Handling** - Automatic retry mechanisms and fallbacks
- 🔧 **Performance Optimization** - ZRAM, kernel tuning, hardware detection
- 🛡️ **Security Focused** - Firewall, antivirus, and system hardening

---

## 🔥 Installation

### 🚀 One-Line Install (Latest Version)

```bash
git clone https://github.com/HAKORADev/ManjaroWizard.git && cd ManjaroWizard && chmod +x Manjarowizard-v2.sh && ./Manjarowizard-v2.sh
```

### 📋 Step-by-Step

1. **Clone Repository**
   ```bash
   git clone https://github.com/HAKORADev/ManjaroWizard.git
   cd ManjaroWizard
   ```

2. **Choose Version & Run**
   ```bash
   # Latest (v2.0) - Recommended
   chmod +x Manjarowizard-v2.sh
   ./Manjarowizard-v2.sh
   
   # Legacy (v1.0) - Compatibility
   chmod +x Manjarowizard-v1.sh  
   ./Manjarowizard-v1.sh
   ```

---

## 🌟 Features

### 🤖 **Intelligent Presets**
- **Gaming PC (333)**: Steam, Lutris, Wine, performance optimization, ZRAM
- **Development PC (666)**: Python 3.13.7, Node.js, Java, VS Code, compilers, containers
- **Office PC (999)**: LibreOffice, communication apps, browsers, printing support

### 📦 **Comprehensive Software Suite**

| Category | Tools Included |
|----------|----------------|
| **Development** | Python (PyEnv), Node.js (NVM), Java, VS Code, Thonny, GCC, Clang |
| **Browsers** | Brave, Edge, Firefox, Chromium, Opera, Vivaldi |
| **Gaming** | Steam, Lutris, Wine, GameMode, MangoHUD, Proton GE |
| **Productivity** | LibreOffice, OnlyOffice, Okular, GIMP, Inkscape, Blender |
| **Communication** | Discord, Telegram, Zoom, Slack, Teams, RustDesk |
| **System Tools** | Btop, GParted, Timeshift, UFW, ClamAV, Docker |
| **Multimedia** | Complete codec support, FFmpeg tools |

### ⚡ **Performance & Optimization**
- **ZRAM Integration** - Compressed swap for improved performance
- **Hardware Detection** - Automatic GPU drivers (NVIDIA, AMD, Intel)
- **System Tuning** - Kernel parameters, I/O schedulers, memory optimization
- **Boot Optimization** - Faster startup and service optimization

### 🎛️ **Advanced Package Management**
- **Fuzzy Search** - Find packages with interactive search using `fzf`
- **Multi-Manager Support** - pacman, yay, flatpak, snap compatibility
- **Interactive Removal** - Safe package removal with dependency checking
- **Progress Tracking** - Real-time installation counters and status

---

## 📖 Usage

### 🤖 Quick Setup with Presets

```
=================================
        Manjaro Wizard Setup        
=================================
333 - Setup Gaming PC      (15-20 min)
666 - Setup Development PC (20-25 min)  
999 - Setup Office PC      (12-18 min)
=================================
```

Simply enter your desired preset number for instant configuration!

### 🎛️ Manual Installation

Use the interactive menu for granular control:

```
Installation / Management Options:
1.  Update system
2.  [3/6] Install starter tools    ← Progress indicators
3.  Install AUR helper (yay)
...
37. Custom package installer       ← Fuzzy search
38. Remove / uninstall packages    ← Interactive removal
```

### 🔍 Advanced Features

- **Custom Package Search**: Type `37` to search and install any package interactively
- **Package Removal**: Type `38` to safely remove packages with dependency checking
- **System Information**: Live system stats displayed in main menu
- **Performance Tuning**: Automatic ZRAM, kernel optimization, hardware detection

---

## 📊 System Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| **OS** | Manjaro Linux (any edition) | Latest stable |
| **RAM** | 4 GB | 8 GB+ (16 GB for development) |
| **Storage** | 20 GB free | 50 GB+ free |
| **Internet** | Stable connection required | Broadband preferred |
| **Privileges** | sudo access | Required |

---

## 🤝 Contributing

We welcome contributions! Here's how to help:

### 🐛 **Bug Reports**
- Include system info (`neofetch` output)
- Attach log file (`~/manjaro_wizard_install.log`)  
- Specify version (v1.0 or v2.0)
- Provide reproduction steps

### 💡 **Feature Requests**
- Describe the use case and benefits
- Suggest implementation approach
- Consider alternatives

### 🔧 **Pull Requests**
1. Fork the repository
2. Create feature branch
3. Test on fresh Manjaro installation  
4. Include proper error handling
5. Submit with detailed description

---

## 📚 Documentation & Support

- **📋 Release Notes**: [View all releases](https://github.com/HAKORADev/ManjaroWizard/releases)
- **🐛 Issues**: [Report bugs](https://github.com/HAKORADev/ManjaroWizard/issues)
- **💬 Discussions**: [Community Q&A](https://github.com/HAKORADev/ManjaroWizard/discussions)
- **📖 Wiki**: [Detailed guides](https://github.com/HAKORADev/ManjaroWizard/wiki)

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## ⭐ Show Your Support

If ManjaroWizard helped you:

- ⭐ **Star** this repository  
- 🐛 **Report bugs** to improve the project
- 💡 **Suggest features** for future versions
- 📢 **Share** with the Linux community
- 🤝 **Contribute** code or documentation

---

<div align="center">

**Made with ❤️ by [HAKORADev](https://github.com/HAKORADev)**

*Empowering Manjaro users worldwide with intelligent automation* 🌍

[![GitHub](https://img.shields.io/badge/GitHub-HAKORADev-181717?logo=github)](https://github.com/HAKORADev)
[![Current Version](https://img.shields.io/badge/Current_Version-2.0-brightgreen.svg)](https://github.com/HAKORADev/ManjaroWizard/releases/latest)

</div>
