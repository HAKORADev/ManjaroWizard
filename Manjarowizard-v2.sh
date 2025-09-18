#!/bin/bash

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; MAGENTA='\033[0;35m'; NC='\033[0m'

LOG_FILE="$HOME/manjaro_wizard_install.log"
TEMP_DIR="/tmp/manjaro_wizard"
CONFIG_FILE="$HOME/.config/manjaro_wizard.conf"
MAX_RETRIES=3; RETRY_DELAY=5

echo "Manjaro Wizard — $(date)" > "$LOG_FILE"
echo "==============================================" >> "$LOG_FILE"

show_progress(){
    local pid=$1; local msg="$2"; local delay=0.1; local spin='|/-\'
    echo -n -e "${BLUE}[INFO]${NC} ${msg}... "
    while kill -0 "$pid" 2>/dev/null; do
        printf "[%c] " "$spin"
        local spin=${spin#?}${spin%?}
        sleep $delay; printf "\b\b\b\b"
    done; printf "    \b\b\b\b"
}
log_command(){
    local cmd="$1"; local desc="${2:-Running: $1}"; local attempt=1; local result=1
    echo -e "${BLUE}[INFO]${NC} $desc" | tee -a "$LOG_FILE"; echo "Command: $cmd" >> "$LOG_FILE"
    while [ $attempt -le $MAX_RETRIES ]; do
        [ $attempt -gt 1 ] && {
            echo -e "${YELLOW}[ATTEMPT $attempt]${NC} Retrying in $RETRY_DELAY seconds…" | tee -a "$LOG_FILE"
            sleep $RETRY_DELAY
        }
        eval "$cmd" 2>&1 | tee -a "$LOG_FILE"; result=${PIPESTATUS[0]}
        [ $result -eq 0 ] && { echo -e "${GREEN}[SUCCESS]${NC} $desc" | tee -a "$LOG_FILE"; return 0; }
        echo -e "${YELLOW}[WARNING]${NC} Command failed (attempt $attempt/$MAX_RETRIES)" | tee -a "$LOG_FILE"
        attempt=$((attempt+1))
    done
    echo -e "${RED}[ERROR]${NC} $desc — failed after $MAX_RETRIES attempts" | tee -a "$LOG_FILE"
    return $result
}
check_manjaro(){
    grep -qi manjaro /etc/os-release || {
        echo -e "${RED}[ERROR]${NC} This script is for Manjaro Linux only." | tee -a "$LOG_FILE"; exit 1
    }
}
check_internet(){
    echo -e "${BLUE}[INFO]${NC} Checking internet…" | tee -a "$LOG_FILE"
    ping -c1 archlinux.org &>/dev/null || {
        echo -e "${RED}[ERROR]${NC} No internet detected." | tee -a "$LOG_FILE"; exit 1
    }
}
install_dependencies(){
    local deps=(git wget curl fzf)
    local miss=(); for d in "${deps[@]}"; do command -v "$d" &>/dev/null || miss+=("$d"); done
    ((${#miss[@]})) && {
        echo -e "${YELLOW}[INFO]${NC} Installing missing deps: ${miss[*]}" | tee -a "$LOG_FILE"
        log_command "sudo pacman -S --noconfirm ${miss[*]}" "Installing base deps"
    }
}
ensure_yay(){
    command -v yay &>/dev/null && return 0
    echo -e "${YELLOW}[INFO]${NC}  yay is required but not found." | tee -a "$LOG_FILE"
    echo -en "${YELLOW}Install yay now? [Y/n]: ${NC}"; read -r ans
    [[ $ans =~ ^[Nn]$ ]] && return 1
    install_aur_helper
}
counter_init(){
    counter_list=("$@")
    counter_total=${#counter_list[@]}
    counter_found=0
    for p in "${counter_list[@]}"; do
        if pacman -Qi "$p" &>/dev/null || yay -Qi "$p" &>/dev/null 2>&1; then
            ((counter_found++))
        fi
    done
}
counter_show(){
    local desc="$1"
    echo -e "${GREEN}[${counter_found}/${counter_total}]${NC} ${desc}"
}
install_packages() {
    local category="$1"; shift; local packages=("$@")
    local to_install=()
    for p in "${packages[@]}"; do
        if ! pacman -Qi "$p" &>/dev/null 2>&1 && ! yay -Qi "$p" &>/dev/null 2>&1; then
            to_install+=("$p")
        fi
    done
    if ((${#to_install[@]})); then
        if ! log_command "sudo pacman -S --noconfirm ${to_install[*]}" "Installing $category packages"; then
            if ensure_yay; then
                log_command "yay -S --noconfirm ${to_install[*]}" "Installing $category packages from AUR"
            else
                echo -e "${RED}[ERROR]${NC} Failed to install $category packages" | tee -a "$LOG_FILE"
                return 1
            fi
        fi
    else
        echo -e "${GREEN}[INFO]${NC} All $category packages already installed." | tee -a "$LOG_FILE"
    fi
}
update_system(){
    echo -e "${YELLOW}Updating system…${NC}" | tee -a "$LOG_FILE"
    log_command "sudo pacman -Syy --noconfirm" "Refresh DB" || return 1
    log_command "sudo pacman -Syu --noconfirm" "Full system upgrade" || return 1
}
install_starter_tools(){
    local tools=(base-devel git wget curl nano htop neofetch inxi lsb-release)
    counter_init "${tools[@]}"; counter_show "Starter tools"
    install_packages "Starter tools" "${tools[@]}" || return 1
}
install_aur_helper(){
    command -v yay &>/dev/null && {
        echo -e "${GREEN}[INFO]${NC} yay already installed." | tee -a "$LOG_FILE"; return 0
    }
    echo -e "${YELLOW}Installing yay…${NC}" | tee -a "$LOG_FILE"
    mkdir -p "$TEMP_DIR" || return 1
    log_command "git clone https://aur.archlinux.org/yay.git $TEMP_DIR/yay" "Clone yay" || return 1
    log_command "cd $TEMP_DIR/yay && makepkg -si --noconfirm" "Build yay" || return 1
    rm -rf "$TEMP_DIR/yay"
}
install_python(){
    local tools=(python python-pip python-virtualenv python-pipx)
    counter_init "${tools[@]}"; counter_show "Python"
    install_packages "Python" "${tools[@]}" || return 1
}
setup_pyenv(){
    [ -d "$HOME/.pyenv" ] && {
        echo -e "${GREEN}[INFO]${NC} pyenv already installed." | tee -a "$LOG_FILE"; return 0
    }
    echo -e "${YELLOW}Setting up pyenv…${NC}" | tee -a "$LOG_FILE"
    install_packages "Pyenv deps" base-devel git curl wget openssl zlib xz tk libffi sqlite || return 1
    log_command "curl https://pyenv.run | bash" "Install pyenv" || return 1
    local rc="$HOME/.bashrc"; [ -n "$ZSH_VERSION" ] && rc="$HOME/.zshrc"
    grep -q pyenv "$rc" || {
        cat <<EOF >> "$rc"
export PYENV_ROOT="\$HOME/.pyenv"
export PATH="\$PYENV_ROOT/bin:\$PATH"
eval "\$(pyenv init --path)"
eval "\$(pyenv init -)"
EOF
    }
    local py="3.13.7"
    log_command "$HOME/.pyenv/bin/pyenv install $py" "Build Python $py" || return 1
    log_command "$HOME/.pyenv/bin/pyenv global $py" "Set global Python" || return 1
    log_command "python -m pip install --upgrade pip setuptools wheel" "Upgrade pip tools" || return 1
    log_command "pip install numpy pygame flask requests pillow matplotlib pandas scipy jupyter" "Common Python libs" || return 1
}
install_thonny(){
    command -v thonny &>/dev/null && {
        echo -e "${GREEN}[INFO]${NC} Thonny already installed." | tee -a "$LOG_FILE"; return 0
    }
    echo -e "${YELLOW}Installing Thonny…${NC}" | tee -a "$LOG_FILE"
    if ensure_yay; then
        log_command "yay -S --noconfirm thonny" "Thonny (AUR)" || return 1
    else
        log_command "pip install thonny" "Thonny (pip fallback)" || return 1
    fi
}
create_python_desktop_entry(){
    echo -e "${YELLOW}Creating Python desktop entry…${NC}" | tee -a "$LOG_FILE"
    mkdir -p ~/.local/share/applications || return 1
    local pybin; pybin="$(pyenv root 2>/dev/null)/versions/3.13.7/bin/python" || pybin=$(command -v python)
    cat > ~/.local/share/applications/pyenv-python.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Pyenv Python
Exec=$pybin %f
Icon=utilities-terminal
Comment=Python interpreter managed by pyenv
Categories=Development;IDE;
Terminal=true
MimeType=text/x-python;
EOF
    log_command "update-desktop-database ~/.local/share/applications/" "Update desktop DB" || return 1
}
install_compilers(){
    local tools=(gcc make cmake gdb clang lldb)
    counter_init "${tools[@]}"; counter_show "Compilers"
    install_packages "Compilers" "${tools[@]}" || return 1
}
install_java(){
    local tools=(jdk-openjdk maven gradle)
    counter_init "${tools[@]}"; counter_show "Java"
    install_packages "Java" "${tools[@]}" || return 1
}
install_nodejs(){
    local tools=(nodejs npm yarn)
    counter_init "${tools[@]}"; counter_show "Node.js"
    install_packages "Node.js" "${tools[@]}" || return 1
    if [ -d "$HOME/.nvm" ]; then
        echo -e "${GREEN}[INFO]${NC} nvm already installed." | tee -a "$LOG_FILE"
        return 0
    fi
    echo -e "${YELLOW}Installing nvm…${NC}" | tee -a "$LOG_FILE"
    log_command "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash" "Install nvm" || return 1
    local rc="$HOME/.bashrc"; [ -n "$ZSH_VERSION" ] && rc="$HOME/.zshrc"
    grep -q NVM_DIR "$rc" || echo 'export NVM_DIR="$HOME/.nvm"' >> "$rc"
}
install_vscode(){
    command -v code &>/dev/null && {
        echo -e "${GREEN}[INFO]${NC} VS Code already installed." | tee -a "$LOG_FILE"; return 0
    }
    echo -e "${YELLOW}Installing VS Code…${NC}" | tee -a "$LOG_FILE"
    if ensure_yay; then
        log_command "yay -S --noconfirm visual-studio-code-bin" "VS Code (AUR)" || return 1
    else
        log_command "sudo pacman -S --noconfirm code" "VS Code (repo)" || return 1
    fi
}
install_archive_tools(){
    local tools=(p7zip unzip unrar zip tar)
    counter_init "${tools[@]}"; counter_show "Archive tools"
    install_packages "Archive tools" "${tools[@]}" || return 1
}
install_btop(){
    local tools=(btop)
    counter_init "${tools[@]}"; counter_show "System monitor"
    install_packages "System monitor" "${tools[@]}" || return 1
}
install_brave(){
    command -v brave-browser &>/dev/null && {
        echo -e "${GREEN}[INFO]${NC} Brave already installed." | tee -a "$LOG_FILE"; return 0
    }
    echo -e "${YELLOW}Installing Brave…${NC}" | tee -a "$LOG_FILE"
    if ensure_yay; then
        log_command "yay -S --noconfirm brave-bin" "Brave (AUR)" || return 1
    else
        log_command "sudo pacman -S --noconfirm brave" "Brave (repo)" || return 1
    fi
}
install_edge(){
    command -v microsoft-edge-stable &>/dev/null && {
        echo -e "${GREEN}[INFO]${NC} Edge already installed." | tee -a "$LOG_FILE"; return 0
    }
    echo -e "${YELLOW}Installing Edge…${NC}" | tee -a "$LOG_FILE"
    if ensure_yay; then
        log_command "yay -S --noconfirm microsoft-edge-stable-bin" "Edge (AUR)" || return 1
    else
        echo -e "${RED}[ERROR]${NC} Edge needs yay (not in repo)." | tee -a "$LOG_FILE"; return 1
    fi
}
install_multimedia(){
    local tools=(gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav ffmpegthumbs)
    counter_init "${tools[@]}"; counter_show "Multimedia codecs"
    install_packages "Multimedia codecs" "${tools[@]}" || return 1
}
install_productivity(){
    local tools=(libreoffice-fresh onlyoffice-desktopeditors okular evince)
    counter_init "${tools[@]}"; counter_show "Productivity"
    install_packages "Productivity" "${tools[@]}" || return 1
}
install_graphics_tools(){
    local tools=(gimp inkscape krita blender darktable)
    counter_init "${tools[@]}"; counter_show "Graphics"
    install_packages "Graphics" "${tools[@]}" || return 1
}
install_system_utils(){
    local tools=(gparted gnome-disk-utility timeshift grub-customizer baobab stacer)
    counter_init "${tools[@]}"; counter_show "System utils"
    install_packages "System utils" "${tools[@]}" || return 1
}
install_networking_tools(){
    local tools=(networkmanager-openvpn openconnect networkmanager-strongswan wireshark-qt nmap)
    counter_init "${tools[@]}"; counter_show "Networking"
    install_packages "Networking" "${tools[@]}" || return 1
}
install_virtualization_tools(){
    local tools=(virtualbox virtualbox-host-dkms qemu virt-manager docker docker-compose)
    counter_init "${tools[@]}"; counter_show "Virtualisation"
    install_packages "Virtualisation" "${tools[@]}" || return 1
    log_command "sudo usermod -aG vboxusers $USER" "Add user to vboxusers" || return 1
    log_command "sudo usermod -aG docker $USER"     "Add user to docker" || return 1
    log_command "sudo systemctl enable --now docker" "Enable Docker" || return 1
}
install_security_tools(){
    local tools=(ufw gufw clamav clamtk rkhunter chkrootkit)
    counter_init "${tools[@]}"; counter_show "Security"
    install_packages "Security" "${tools[@]}" || return 1
    log_command "sudo ufw enable" "Enable UFW" || return 1
}
install_rustdesk(){
    command -v rustdesk &>/dev/null && {
        echo -e "${GREEN}[INFO]${NC} RustDesk already installed." | tee -a "$LOG_FILE"; return 0
    }
    if install_packages "RustDesk" rustdesk; then
        return 0
    fi
    echo -e "${YELLOW}[INFO]${NC} RustDesk — falling back to AppImage." | tee -a "$LOG_FILE"
    local url="https://github.com/rustdesk/rustdesk/releases/download/1.4.2/rustdesk-1.4.2-x86_64.AppImage"
    local dir="$HOME/Applications"; mkdir -p "$dir" || return 1
    local bin="$dir/rustdesk.AppImage"
    log_command "wget -O \"$bin\" \"$url\"" "Download RustDesk" || return 1
    chmod +x "$bin"
    cat > ~/.local/share/applications/rustdesk.desktop <<EOF
[Desktop Entry]
Type=Application
Name=RustDesk
Exec=$bin
Icon=preferences-system-remote-desktop
Comment=Remote desktop
Categories=Network;RemoteAccess;
Terminal=false
EOF
    log_command "update-desktop-database ~/.local/share/applications/" "Update desktop DB" || return 1
}
install_wine_appimage(){
    echo -e "${YELLOW}Installing Wine AppImage…${NC}" | tee -a "$LOG_FILE"
    local url="https://github.com/ferion11/Wine_Appimage/releases/download/v5.11/wine-staging-linux-x86-v5.11-PlayOnLinux-x86_64.AppImage"
    local dir="$HOME/Applications"; mkdir -p "$dir" || return 1
    local bin="$dir/wine.AppImage"
    log_command "wget -O \"$bin\" \"$url\"" "Download Wine AppImage" || return 1
    chmod +x "$bin"
    cat > ~/.local/share/applications/wine-appimage.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Wine (AppImage)
Exec=$bin
Icon=wine
Comment=Windows compatibility layer
Categories=Utility;Emulator;
Terminal=false
EOF
    log_command "update-desktop-database ~/.local/share/applications/" "Update desktop DB" || return 1
}
install_gaming_tools(){
    local tools=(steam lutris wine-staging proton-ge-custom gamemode mangohud)
    counter_init "${tools[@]}"; counter_show "Gaming"
    install_packages "Gaming" "${tools[@]}" || return 1
    install_wine_appimage || return 1
}
install_communication_apps(){
    local tools=(discord telegram-desktop zoom slack-desktop teams)
    counter_init "${tools[@]}"; counter_show "Communication"
    install_packages "Communication" "${tools[@]}" || return 1
    install_rustdesk || return 1
}
install_browsers(){
    local tools=(firefox chromium opera vivaldi falkon)
    counter_init "${tools[@]}"; counter_show "Browsers"
    install_packages "Browsers" "${tools[@]}" || return 1
}
install_drivers(){
    echo -e "${YELLOW}Detecting GPU…${NC}" | tee -a "$LOG_FILE"
    if lspci | grep -E "VGA|3D" | grep -qi nvidia; then
        local tools=(nvidia nvidia-utils nvidia-settings nvidia-prime lib32-nvidia-utils)
        counter_init "${tools[@]}"; counter_show "NVIDIA"
        install_packages "NVIDIA" "${tools[@]}" || return 1
    elif lspci | grep -E "VGA|3D" | grep -qi amd; then
        local tools=(xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon libva-mesa-driver mesa-vdpau)
        counter_init "${tools[@]}"; counter_show "AMD"
        install_packages "AMD" "${tools[@]}" || return 1
    elif lspci | grep -E "VGA|3D" | grep -qi intel; then
        local tools=(xf86-video-intel vulkan-intel lib32-vulkan-intel mesa lib32-mesa)
        counter_init "${tools[@]}"; counter_show "Intel"
        install_packages "Intel" "${tools[@]}" || return 1
    else
        local tools=(mesa lib32-mesa vulkan-icd-loader lib32-vulkan-icd-loader)
        counter_init "${tools[@]}"; counter_show "Generic"
        install_packages "Generic" "${tools[@]}" || return 1
    fi
    local fw=(sof-firmware alsa-firmware alsa-utils pulseaudio pulseaudio-alsa pavucontrol)
    counter_init "${fw[@]}"; counter_show "Firmware"
    install_packages "Firmware" "${fw[@]}" || return 1
}
install_printing_support(){
    local tools=(cups cups-pdf system-config-printer hplip print-manager)
    counter_init "${tools[@]}"; counter_show "Printing"
    install_packages "Printing" "${tools[@]}" || return 1
    log_command "sudo systemctl enable --now cups" "Enable CUPS" || return 1
}
install_firmware(){
    local tools=(linux-firmware sof-firmware fwupd)
    counter_init "${tools[@]}"; counter_show "Firmware"
    install_packages "Firmware" "${tools[@]}" || return 1
    log_command "sudo systemctl enable --now fwupd" "Enable fwupd" || return 1
}
install_performance_tools(){
    local tools=(preload smem zram-generator)
    counter_init "${tools[@]}"; counter_show "Performance"
    install_packages "Performance" "${tools[@]}" || return 1
}
configure_zram(){
    echo -e "${YELLOW}Configuring zram…${NC}" | tee -a "$LOG_FILE"
    install_packages "ZRAM" zram-generator || return 1
    cat <<'EOF' | sudo tee /etc/systemd/zram-generator.conf >/dev/null
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
swap-priority = 100
fs-type = swap
EOF
    log_command "sudo systemctl daemon-reload" "Reload systemd" || return 1
    log_command "sudo systemctl start /dev/zram0" "Start zram0" || return 1
}
detect_display_info(){
    echo -e "${YELLOW}Detecting displays…${NC}" | tee -a "$LOG_FILE"
    command -v xrandr &>/dev/null || {
        echo -e "${YELLOW}[WARN]${NC} xrandr not found — cannot probe displays." | tee -a "$LOG_FILE"; return 1
    }
    xrandr | grep " connected" | tee -a "$LOG_FILE"
}
configure_screen_resolution(){
    detect_display_info
    echo -e "${RED}[WARNING]${NC} Wrong settings can break your session. Note them down!" | tee -a "$LOG_FILE"
    echo -en "${YELLOW}Proceed? [y/N]: ${NC}"; read -r ans
    [[ $ans =~ ^[Yy]$ ]] || { echo "Aborted." | tee -a "$LOG_FILE"; return 1; }
    if ! command -v cvt &>/dev/null; then
        log_command "sudo pacman -S --noconfirm xorg-server" "Install xorg-server for cvt" || return 1
    fi
    echo -e "${CYAN}Available resolutions:${NC}"
    select res in 640x480 800x600 1024x768 1280x720 1280x800 1280x1024 1360x768 1366x768 1440x900 1600x900 1680x1050 1920x1080 2560x1440 3840x2160; do
        [[ -n $res ]] && break
    done
    echo -e "${CYAN}Refresh:${NC}"; select hz in 60 75; do [[ -n $hz ]] && break; done
    echo -e "${CYAN}Depth:${NC}";   select d in 24 32; do [[ -n $d ]] && break; done
    local modeline; modeline=$(cvt ${res/x/ } $hz | grep Modeline | cut -d' ' -f2-)
    log_command "sudo mkdir -p /etc/X11/xorg.conf.d/" "Create xorg.conf.d" || return 1
    [ -f /etc/X11/xorg.conf.d/10-monitor.conf ] && \
        log_command "sudo cp /etc/X11/xorg.conf.d/10-monitor.conf /etc/X11/xorg.conf.d/10-monitor.conf.$(date +%Y%m%d)" "Backup old config" || return 1
    cat <<EOF | sudo tee /etc/X11/xorg.conf.d/10-monitor.conf >/dev/null
Section "Monitor"
    Identifier "HDMI-1"
    Modeline $modeline
    Option "PreferredMode" "${res}_${hz}.00"
EndSection
Section "Screen"
    Identifier "Screen0"
    Device "Card0"
    Monitor "HDMI-1"
    DefaultDepth $d
    SubSection "Display"
        Depth $d
        Modes "${res}_${hz}.00"
    EndSubSection
EndSection
EOF
    echo -e "${GREEN}[OK]${NC} Resolution set to ${res}@${hz} Hz ${d}-bit — reboot or re-login." | tee -a "$LOG_FILE"
}
optimize_system_performance(){
    echo -e "${RED}[WARNING]${NC} This will disable services and change kernel parameters. Continue? [y/N]"
    read -r ans
    [[ $ans =~ ^[Yy]$ ]] || { echo "Aborted." | tee -a "$LOG_FILE"; return 1; }
    echo -e "${YELLOW}Optimising system…${NC}" | tee -a "$LOG_FILE"
    log_command "sudo cp /etc/default/grub /etc/default/grub.bak.$(date +%Y%m%d)" "Backup grub" || return 1
    log_command "sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash processor.max_cstate=1 intel_idle.max_cstate=0 intel_pstate=disable acpi_osi=Linux pcie_aspm=off\"/' /etc/default/grub" "Grub kernel args" || return 1
    log_command "sudo sed -i 's/GRUB_TIMOUT=.*/GRUB_TIMEOUT=1/' /etc/default/grub" "Grub timeout" || return 1
    log_command "sudo update-grub" "Update grub" || return 1
    cat <<'EOF' | sudo tee -a /etc/sysctl.conf >/dev/null
kernel.sched_child_runs_first=0
kernel.sched_autogroup_enabled=1
vm.swappiness=1
vm.vfs_cache_pressure=10
vm.dirty_ratio=3
vm.dirty_background_ratio=1
vm.dirty_expire_centisecs=500
vm.dirty_writeback_centisecs=100
vm.overcommit_memory=1
vm.overcommit_ratio=80
vm.min_free_kbytes=65536
vm.zone_reclaim_mode=1
vm.page_lock_unfairness=1
kernel.shmmax=268435456
kernel.shmall=65536
vm.dirty_bytes=67108864
vm.dirty_background_bytes=33554432
kernel.panic=10
kernel.hung_task_timeout_secs=30
vm.laptop_mode=0
vm.stat_interval=60
fs.file-max=2097152
net.core.somaxconn=65535
EOF
    cat <<'EOF' | sudo tee /etc/udev/rules.d/60-ioschedulers.conf >/dev/null
ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{bdi/read_ahead_kb}="2048"
ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/nr_requests}="64"
EOF
    cat <<'EOF' | sudo tee -a /etc/fstab >/dev/null
tmpfs /tmp tmpfs defaults,noatime,mode=1777,size=512M 0 0
tmpfs /var/tmp tmpfs defaults,noatime,mode=1777,size=256M 0 0
tmpfs /var/cache/pacman/pkg tmpfs defaults,noatime,mode=755,size=512M 0 0
EOF
    log_command "sudo systemctl disable ModemManager bluetooth cups avahi-daemon" "Disable unused" || return 1
    log_command "sudo systemctl mask systemd-networkd-wait-online" "Mask wait-online" || return 1
    echo 'DefaultTimeoutStartSec=15s' | sudo tee -a /etc/systemd/system.conf >/dev/null
    echo 'DefaultTimeoutStopSec=5s'   | sudo tee -a /etc/systemd/system.conf >/dev/null
    log_command "sudo sysctl -p" "Load sysctl" || return 1
}
configure_system(){
    echo -e "${RED}[WARNING]${NC} This will enable UFW, disable services, and change system settings. Continue? [y/N]"
    read -r ans
    [[ $ans =~ ^[Yy]$ ]] || { echo "Aborted." | tee -a "$LOG_FILE"; return 1; }
    echo -e "${YELLOW}Tweaking system settings…${NC}" | tee -a "$LOG_FILE"
    log_command "sudo ufw enable" "Enable UFW" || return 1
    log_command "sudo systemctl enable --now fstrim.timer" "Enable fstrim" || return 1
    [ -d /etc/fonts/conf.avail ] && {
        sudo ln -sf /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
        sudo ln -sf /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/
    }
    echo 'vm.swappiness=10' | sudo tee /etc/sysctl.d/99-manjaro.conf >/dev/null
    install_packages "TLP" tlp tlp-rdw || return 1
    log_command "sudo systemctl enable --now tlp" "Enable TLP" || return 1
    log_command "sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket" "Mask rfkill" || return 1
}
setup_mirrors(){
    echo -e "${YELLOW}Picking fastest mirrors…${NC}" | tee -a "$LOG_FILE"
    log_command "sudo pacman-mirrors --fasttrack 5" "Fast mirrors" || return 1
    log_command "sudo pacman -Syy" "Refresh DB" || return 1
}
cleanup_system(){
    echo -e "${YELLOW}Cleaning up…${NC}" | tee -a "$LOG_FILE"
    log_command "sudo pacman -Sc --noconfirm" "Clean package cache" || return 1
    log_command "sudo pacman -Rns \$(pacman -Qtdq) --noconfirm 2>/dev/null || true" "Remove orphans" || return 1
    log_command "sudo rm -rf /tmp/* /var/tmp/*" "Clear temp" || return 1
    log_command "rm -rf ~/.cache/*" "Clear user cache" || return 1
}
create_backup(){
    echo -e "${YELLOW}Creating Timeshift backup…${NC}" | tee -a "$LOG_FILE"
    if command -v timeshift &>/dev/null; then
        log_command "sudo timeshift --create --comments \"Manjaro Wizard Backup\"" "Timeshift backup" || return 1
    else
        echo -e "${YELLOW}[INFO]${NC} Timeshift not installed — skipping backup." | tee -a "$LOG_FILE"
    fi
}
show_system_info(){
    echo -e "${CYAN}=================================${NC}"
    echo -e "${MAGENTA}        System Information        ${NC}"
    echo -e "${CYAN}=================================${NC}"
    echo -e "${YELLOW}OS:${NC} $(lsb_release -d | cut -f2)"
    echo -e "${YELLOW}Kernel:${NC} $(uname -r)"
    echo -e "${YELLOW}Uptime:${NC} $(uptime -p)"
    echo -e "${YELLOW}CPU:${NC} $(lscpu | grep 'Model name' | cut -d: -f2 | sed 's/^ *//')"
    echo -e "${YELLOW}Memory:${NC} $(free -h | awk '/Mem:/ {print $3 "/" $2}')"
    echo -e "${YELLOW}Disk:${NC} $(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 " used)"}')"
    echo -e "${CYAN}=================================${NC}"
}
custom_package_install(){
    echo -e "${YELLOW}Custom package install — choose manager first${NC}" | tee -a "$LOG_FILE"
    local mgr; mgr=$(choose_manager install) || return 1
    local search
    echo -en "${CYAN}Enter package name (or part) to search : ${NC}"; read -r search
    [ -z "$search" ] && { echo "Empty search — abort." | tee -a "$LOG_FILE"; return 1; }
    local -a hits=()
    case "$mgr" in
        pacman)  mapfile -t hits < <(pacman -Ss "$search" | awk -F'/' '{print $2}' | awk '{print $1}' | sort -u) ;;
        yay)     ensure_yay || return 1;  mapfile -t hits < <(yay -Ss "$search" | awk -F'/' '{print $2}' | awk '{print $1}' | sort -u) ;;
        flatpak) command -v flatpak &>/dev/null || { echo -e "${RED}[ERROR]${NC} flatpak not found." | tee -a "$LOG_FILE"; return 1; }
                 mapfile -t hits < <(flatpak search "$search" | awk '{print $1}' | sort -u) ;;
        snap)    command -v snap &>/dev/null    || { echo -e "${RED}[ERROR]${NC} snap not found."    | tee -a "$LOG_FILE"; return 1; }
                 mapfile -t hits < <(snap find "$search" | awk '{print $1}' | sort -u) ;;
    esac
    ((${#hits[@]})) || { echo -e "${YELLOW}No packages found for '$search'.${NC}" | tee -a "$LOG_FILE"; return 1; }
    local pick; pick=$(printf '%s\n' "${hits[@]}" | fzf --prompt="Select package to install > " --height=40% --reverse) || { echo "Cancelled."; return 1; }
    [ -z "$pick" ] && return 1
    case "$mgr" in
        pacman)  log_command "sudo pacman -S --noconfirm $pick" "Install $pick (pacman)" ;;
        yay)     log_command "yay -S --noconfirm $pick"        "Install $pick (AUR)" ;;
        flatpak) log_command "flatpak install -y flathub $pick" "Install $pick (flatpak)" ;;
        snap)    log_command "sudo snap install $pick"          "Install $pick (snap)" ;;
    esac
}
choose_manager(){
    local mode="$1"; shift
    echo -e "${CYAN}Select package manager:${NC}"
    select m in pacman yay flatpak snap BACK; do
        case "$m" in
            pacman|yay|flatpak|snap) echo "$m"; return 0 ;;
            BACK) return 1 ;;
        esac
    done
}
remove_packages(){
    local mgr; mgr=$(choose_manager remove) || return 1
    local -a list=()
    case "$mgr" in
        pacman)  mapfile -t list < <(pacman -Qqe | sort) ;;
        yay)     ensure_yay || return 1;  mapfile -t list < <(yay -Qqe | sort) ;;
        flatpak) command -v flatpak &>/dev/null || { echo -e "${RED}[ERROR]${NC} flatpak not found." | tee -a "$LOG_FILE"; return 1; }
                 mapfile -t list < <(flatpak list --app --columns=application | sort) ;;
        snap)    command -v snap &>/dev/null    || { echo -e "${RED}[ERROR]${NC} snap not found."    | tee -a "$LOG_FILE"; return 1; }
                 mapfile -t list < <(snap list | awk 'NR>1 {print $1}' | sort) ;;
    esac
    ((${#list[@]})) || { echo -e "${YELLOW}No user packages found for $mgr.${NC}" | tee -a "$LOG_FILE"; return 1; }
    local picks; picks=$(printf '%s\n' "${list[@]}" \
        | fzf --multi --prompt="Select package(s) to REMOVE > " --height=50% --reverse) || { echo "Cancelled."; return 1; }
    [ -z "$picks" ] && return 1
    while IFS= read -r pkg; do
        [ -z "$pkg" ] && continue
        case "$mgr" in
            pacman)  log_command "sudo pacman -Rns --noconfirm $pkg" "Remove $pkg (pacman)" ;;
            yay)     log_command "yay -Rns --noconfirm $pkg"        "Remove $pkg (AUR)" ;;
            flatpak) log_command "flatpak uninstall -y $pkg"        "Remove $pkg (flatpak)" ;;
            snap)    log_command "sudo snap remove $pkg"            "Remove $pkg (snap)" ;;
        esac
    done <<< "$picks"
}
setup_gaming_pc(){
    echo -e "${MAGENTA}Setting up Gaming PC configuration...${NC}" | tee -a "$LOG_FILE"
    update_system || return 1
    install_starter_tools || return 1
    install_aur_helper || return 1
    install_drivers || return 1
    install_gaming_tools || return 1
    install_multimedia || return 1
    install_communication_apps || return 1
    install_brave || return 1
    install_performance_tools || return 1
    configure_zram || return 1
    optimize_system_performance || return 1

    echo -e "${YELLOW}Creating gaming desktop entries...${NC}" | tee -a "$LOG_FILE"
    mkdir -p ~/.local/share/applications || return 1

    cat > ~/.local/share/applications/manjaro-wizard-gaming.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Manjaro Wizard Gaming
Exec=echo "Gaming configuration applied"
Icon=applications-games
Comment=Manjaro Wizard Gaming Configuration
Categories=Game;
Terminal=false
EOF

    log_command "update-desktop-database ~/.local/share/applications/" "Update desktop DB" || return 1
    echo -e "${GREEN}Gaming PC setup completed!${NC}" | tee -a "$LOG_FILE"
}
setup_development_pc(){
    echo -e "${MAGENTA}Setting up Development PC configuration...${NC}" | tee -a "$LOG_FILE"
    update_system || return 1
    install_starter_tools || return 1
    install_aur_helper || return 1
    install_python || return 1
    setup_pyenv || return 1
    install_compilers || return 1
    install_java || return 1
    install_nodejs || return 1
    install_vscode || return 1
    install_archive_tools || return 1
    install_btop || return 1
    install_virtualization_tools || return 1
    install_browsers || return 1
    install_drivers || return 1

    echo -e "${YELLOW}Creating development desktop entries...${NC}" | tee -a "$LOG_FILE"
    mkdir -p ~/.local/share/applications || return 1

    cat > ~/.local/share/applications/manjaro-wizard-development.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Manjaro Wizard Development
Exec=echo "Development configuration applied"
Icon=applications-development
Comment=Manjaro Wizard Development Configuration
Categories=Development;
Terminal=false
EOF

    log_command "update-desktop-database ~/.local/share/applications/" "Update desktop DB" || return 1
    echo -e "${GREEN}Development PC setup completed!${NC}" | tee -a "$LOG_FILE"
}
setup_office_pc(){
    echo -e "${MAGENTA}Setting up Office PC configuration...${NC}" | tee -a "$LOG_FILE"
    update_system || return 1
    install_starter_tools || return 1
    install_aur_helper || return 1
    install_productivity || return 1
    install_communication_apps || return 1
    install_browsers || return 1
    install_multimedia || return 1
    install_printing_support || return 1
    install_drivers || return 1

    echo -e "${YELLOW}Creating office desktop entries...${NC}" | tee -a "$LOG_FILE"
    mkdir -p ~/.local/share/applications || return 1

    cat > ~/.local/share/applications/manjaro-wizard-office.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Manjaro Wizard Office
Exec=echo "Office configuration applied"
Icon=applications-office
Comment=Manjaro Wizard Office Configuration
Categories=Office;
Terminal=false
EOF

    log_command "update-desktop-database ~/.local/share/applications/" "Update desktop DB" || return 1
    echo -e "${GREEN}Office PC setup completed!${NC}" | tee -a "$LOG_FILE"
}
main_menu(){
    while true; do
        clear
        echo -e "${CYAN}=================================${NC}"
        echo -e "${MAGENTA}        Manjaro Wizard Setup        ${NC}"
        echo -e "${CYAN}=================================${NC}"
        echo -e "${GREEN}333${NC} - Setup Gaming PC"
        echo -e "${GREEN}666${NC} - Setup Development PC"
        echo -e "${GREEN}999${NC} - Setup Office PC"
        echo -e "${CYAN}=================================${NC}"
        show_system_info
        echo -e "${CYAN}Installation / Management Options:${NC}"
        echo -e "1.  Update system"
        echo -e "2.  Install starter tools"
        echo -e "3.  Install AUR helper (yay)"
        echo -e "4.  Install Python"
        echo -e "5.  Setup pyenv + Python 3.13.7"
        echo -e "6.  Install Thonny IDE"
        echo -e "7.  Create Python desktop entry"
        echo -e "8.  Install compilers (GCC, CMake)"
        echo -e "9.  Install Java JDK"
        echo -e "10. Install Node.js"
        echo -e "11. Install VS Code"
        echo -e "12. Install archive tools"
        echo -e "13. Install btop"
        echo -e "14. Install Brave"
        echo -e "15. Install Edge"
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
        echo -e "28. Install firmware"
        echo -e "29. Install performance tools + zram"
        echo -e "30. Configure system settings"
        echo -e "31. Configure screen resolution"
        echo -e "32. Optimise system performance"
        echo -e "33. Set up mirrors"
        echo -e "34. Clean up system"
        echo -e "35. Create system backup"
        echo -e "36. Run ALL operations"
        echo -e "37. Custom package installer (search/pick)"
        echo -e "38. Remove / uninstall packages"
        echo -e "0.  Exit"
        echo -e ""
        echo -en "${YELLOW}Select [0-38, 333, 666, 999]: ${NC}"; read -r choice
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
            29) install_performance_tools && configure_zram;;
            30) configure_system;;
            31) configure_screen_resolution;;
            32) optimize_system_performance;;
            33) setup_mirrors;;
            34) cleanup_system;;
            35) create_backup;;
            36) run_all_operations;;
            37) custom_package_install;;
            38) remove_packages;;
            333) setup_gaming_pc;;
            666) setup_development_pc;;
            999) setup_office_pc;;
            0) exit 0;;
            *) echo -e "${RED}Invalid option!${NC}"; sleep 2;;
        esac
        [ "$choice" != "0" ] && { echo -e "${YELLOW}Press any key to continue…${NC}"; read -n 1 -r; }
    done
}
run_all_operations(){
    echo -e "${RED}Warning: this runs everything and takes ages.${NC}"
    echo -en "${YELLOW}Continue? [y/N]: ${NC}"; read -r ans
    [[ $ans =~ ^[Yy]$ ]] || return
    create_backup
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
    install_performance_tools
    configure_zram
    configure_system
    configure_screen_resolution
    optimize_system_performance
    setup_mirrors
    cleanup_system
    create_backup
    echo -e "${GREEN}All operations completed!${NC}"
}
echo -e "${GREEN}Starting Manjaro Wizard…${NC}"
check_manjaro
check_internet
install_dependencies
mkdir -p "$TEMP_DIR"
trap 'rm -rf "$TEMP_DIR"' EXIT
main_menu
