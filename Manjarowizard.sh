#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

LOG_FILE="$HOME/manjaro_wizard_install.log"

log_command() {
    echo -e "${BLUE}[INFO]${NC} Running: $1" | tee -a "$LOG_FILE"
    eval "$1" 2>&1 | tee -a "$LOG_FILE"
    if [ ${PIPESTATUS[0]} -eq 0 ]; then
        echo -e "${GREEN}[SUCCESS]${NC} Command completed successfully" | tee -a "$LOG_FILE"
    else
        echo -e "${RED}[ERROR]${NC} Command failed" | tee -a "$LOG_FILE"
    fi
}

install_packages() {
    echo -e "${YELLOW}Installing: $1${NC}" | tee -a "$LOG_FILE"
    log_command "sudo pacman -S --noconfirm $2"
}

update_system() {
    echo -e "${YELLOW}Updating system...${NC}" | tee -a "$LOG_FILE"
    log_command "sudo pacman -Syu --noconfirm"
}

install_starter_tools() {
    install_packages "Starter tools" "base-devel git wget curl nano htop neofetch inxi"
}

install_aur_helper() {
    echo -e "${YELLOW}Installing yay (AUR helper)...${NC}" | tee -a "$LOG_FILE"
    log_command "git clone https://aur.archlinux.org/yay.git /tmp/yay"
    log_command "cd /tmp/yay && makepkg -si --noconfirm"
}

install_python() {
    install_packages "Python" "python python-pip"
}

setup_pyenv() {
    echo -e "${YELLOW}Setting up pyenv...${NC}" | tee -a "$LOG_FILE"
    install_packages "Pyenv dependencies" "base-devel git curl wget openssl zlib xz tk libffi sqlite"
    log_command "git clone https://github.com/pyenv/pyenv.git ~/.pyenv"
    
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc
    
    log_command "source ~/.bashrc"
    log_command "pyenv install 3.13.7"
    log_command "pyenv global 3.13.7"
    log_command "python -m pip install --upgrade pip setuptools wheel"
    log_command "pip install numpy pygame flask requests pillow matplotlib"
    
    echo -e "${YELLOW}Python version:${NC}"
    log_command "python -V"
    echo -e "${YELLOW}Python location:${NC}"
    log_command "which python"
    echo -e "${YELLOW}Pip location:${NC}"
    log_command "which pip"
    echo -e "${YELLOW}Installed packages:${NC}"
    log_command "pip list | grep -E 'numpy|pygame|flask|requests|pillow|matplotlib'"
}

install_thonny() {
    echo -e "${YELLOW}Installing Thonny IDE...${NC}" | tee -a "$LOG_FILE"
    log_command "yay -S --noconfirm thonny"
}

create_python_desktop_entry() {
    echo -e "${YELLOW}Creating Python desktop entry...${NC}" | tee -a "$LOG_FILE"
    mkdir -p ~/.local/share/applications
    cat > ~/.local/share/applications/pyenv-python.desktop << EOF
[Desktop Entry]
Type=Application
Name=Pyenv Python
Exec=/home/$USER/.pyenv/versions/3.13.7/bin/python %f
Icon=utilities-terminal
Terminal=true
MimeType=text/x-python;
EOF
    log_command "update-desktop-database ~/.local/share/applications/"
}

install_compilers() {
    install_packages "Compilers" "gcc make cmake gdb"
}

install_java() {
    install_packages "Java JDK" "jdk-open-jdk"
}

install_nodejs() {
    install_packages "Node.js" "nodejs npm"
}

install_vscode() {
    echo -e "${YELLOW}Installing Visual Studio Code...${NC}" | tee -a "$LOG_FILE"
    log_command "yay -S --noconfirm visual-studio-code-bin"
}

install_archive_tools() {
    install_packages "Archive tools" "p7zip unzip unrar"
}

install_btop() {
    install_packages "System monitor" "btop"
}

install_brave() {
    echo -e "${YELLOW}Installing Brave browser...${NC}" | tee -a "$LOG_FILE"
    log_command "yay -S --noconfirm brave-bin"
}

install_edge() {
    echo -e "${YELLOW}Installing Microsoft Edge...${NC}" | tee -a "$LOG_FILE"
    log_command "sudo pacman -S --needed base-devel git"
    log_command "git clone https://aur.archlinux.org/microsoft-edge-stable-bin.git /tmp/edge"
    log_command "cd /tmp/edge && makepkg -si --noconfirm"
}

install_multimedia() {
    install_packages "Multimedia codecs" "gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav ffmpegthumbs"
}

install_productivity() {
    install_packages "Productivity tools" "libreoffice-fresh onlyoffice-desktopeditors okular"
}

install_graphics_tools() {
    install_packages "Graphics tools" "gimp inkscape krita blender"
}

install_system_utils() {
    install_packages "System utilities" "gparted gnome-disk-utility timeshift grub-customizer"
}

install_networking_tools() {
    install_packages "Networking tools" "networkmanager-openvpn openconnect networkmanager-strongswan"
}

install_virtualization_tools() {
    install_packages "Virtualization tools" "virtualbox virtualbox-host-dkms qemu virt-manager"
}

install_security_tools() {
    install_packages "Security tools" "ufw gufw clamav clamtk"
}

install_gaming_tools() {
    install_packages "Gaming tools" "steam lutris wine-staging"
}

install_communication_apps() {
    install_packages "Communication apps" "discord telegram-desktop zoom"
}

install_browsers() {
    install_packages "Web browsers" "firefox chromium opera"
}

install_drivers() {
    echo -e "${YELLOW}Installing display drivers...${NC}" | tee -a "$LOG_FILE"
    if lspci | grep -E "VGA|3D" | grep -iq "nvidia"; then
        install_packages "NVIDIA drivers" "nvidia nvidia-utils nvidia-settings"
    elif lspci | grep -E "VGA|3D" | grep -iq "amd"; then
        install_packages "AMD drivers" "xf86-video-amdgpu vulkan-radeon"
    elif lspci | grep -E "VGA|3D" | grep -iq "intel"; then
        install_packages "Intel drivers" "xf86-video-intel vulkan-intel"
    fi
}

install_printing_support() {
    install_packages "Printing support" "cups print-manager hplip"
    log_command "sudo systemctl enable cups.service"
}

install_firmware() {
    install_packages "Additional firmware" "linux-firmware sof-firmware"
}

configure_system() {
    echo -e "${YELLOW}Configuring system settings...${NC}" | tee -a "$LOG_FILE"
    log_command "sudo ufw enable"
    log_command "sudo systemctl enable fstrim.timer"
    log_command "sudo ln -sf /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/"
    log_command "sudo ln -sf /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/"
}

setup_mirrors() {
    echo -e "${YELLOW}Setting up fastest mirrors...${NC}" | tee -a "$LOG_FILE"
    log_command "sudo pacman-mirrors -f 5"
}

cleanup_system() {
    echo -e "${YELLOW}Cleaning up system...${NC}" | tee -a "$LOG_FILE"
    log_command "sudo pacman -Sc --noconfirm"
    log_command "sudo pacman -Rns $(pacman -Qtdq) --noconfirm 2>/dev/null || true"
}

main_menu() {
    while true; do
        clear
        echo -e "${GREEN}=================================${NC}"
        echo -e "${BLUE}        Manjaro Wizard           ${NC}"
        echo -e "${GREEN}=================================${NC}"
        echo -e ""
        echo -e "1.  Update system"
        echo -e "2.  Install starter tools"
        echo -e "3.  Install AUR helper (yay)"
        echo -e "4.  Install Python"
        echo -e "5.  Setup PyEnv + Python 3.13.7"
        echo -e "6.  Install Thonny IDE"
        echo -e "7.  Create Python desktop entry"
        echo -e "8.  Install compilers (GCC, CMake)"
        echo -e "9.  Install Java JDK"
        echo -e "10. Install Node.js"
        echo -e "11. Install VS Code"
        echo -e "12. Install archive tools"
        echo -e "13. Install Btop system monitor"
        echo -e "14. Install Brave browser"
        echo -e "15. Install Microsoft Edge"
        echo -e "16. Install multimedia codecs"
        echo -e "17. Install productivity tools"
        echo -e "18. Install graphics tools"
        echo -e "19. Install system utilities"
        echo -e "20. Install networking tools"
        echo -e "21. Install virtualization tools"
        echo -e "22. Install security tools"
        echo -e "23. Install gaming tools"
        echo -e "24. Install communication apps"
        echo -e "25. Install additional browsers"
        echo -e "26. Install display drivers"
        echo -e "27. Install printing support"
        echo -e "28. Install additional firmware"
        echo -e "29. Configure system settings"
        echo -e "30. Set up mirrors"
        echo -e "31. Clean up system"
        echo -e "32. Run ALL operations"
        echo -e "0.  Exit"
        echo -e ""
        echo -e "Select an option [0-32]: "
        
        read -n 2 choice
        case $choice in
            1) update_system;;
            2) install_starter_tools;;
            3) install_aur_helper;;
            4) install_python;;
            5) setup_pyenv;;
            6) install_thonny;;
            7) create_python_desktop_entry;;
            8) install_compilers;;
            9) install_java;;
            10) install_nodejs;;
            11) install_vscode;;
            12) install_archive_tools;;
            13) install_btop;;
            14) install_brave;;
            15) install_edge;;
            16) install_multimedia;;
            17) install_productivity;;
            18) install_graphics_tools;;
            19) install_system_utils;;
            20) install_networking_tools;;
            21) install_virtualization_tools;;
            22) install_security_tools;;
            23) install_gaming_tools;;
            24) install_communication_apps;;
            25) install_browsers;;
            26) install_drivers;;
            27) install_printing_support;;
            28) install_firmware;;
            29) configure_system;;
            30) setup_mirrors;;
            31) cleanup_system;;
            32) run_all_operations;;
            0) exit 0;;
            *) echo -e "${RED}Invalid option!${NC}"; sleep 2;;
        esac
        echo -e "${YELLOW}Press any key to continue...${NC}"
        read -n 1
    done
}

run_all_operations() {
    update_system
    install_starter_tools
    install_aur_helper
    install_python
    setup_pyenv
    install_thonny
    create_python_desktop_entry
    install_compilers
    install_java
    install_nodejs
    install_vscode
    install_archive_tools
    install_btop
    install_brave
    install_edge
    install_multimedia
    install_productivity
    install_graphics_tools
    install_system_utils
    install_networking_tools
    install_virtualization_tools
    install_security_tools
    install_gaming_tools
    install_communication_apps
    install_browsers
    install_drivers
    install_printing_support
    install_firmware
    configure_system
    setup_mirrors
    cleanup_system
}

echo -e "${GREEN}Starting Manjaro Wizard...${NC}"
main_menu