#!/bin/bash

# ╔══════════════════════════════════════════════════════════════════════════════╗
# ║                    ITZ_YTANSH PRO HOSTING INSTALLER v2.0                    ║
# ║                        Made with ❤️ by ITZ_YT_ANSH                          ║
# ╚══════════════════════════════════════════════════════════════════════════════╝

set -o pipefail

clear
tput civis 2>/dev/null

# ═══════════════════════════════════════════════════════════════════════════════
# COLOR DEFINITIONS
# ═══════════════════════════════════════════════════════════════════════════════
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
MAGENTA='\033[1;35m'
ORANGE='\033[1;38;5;208m'
PINK='\033[1;38;5;205m'
NC='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'

# ═══════════════════════════════════════════════════════════════════════════════
# LOG FILE
# ═══════════════════════════════════════════════════════════════════════════════
LOG_FILE="/tmp/itz_ytansh_installer.log"
exec 3>>"$LOG_FILE"

log_msg() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >&3 2>/dev/null
}

# ═══════════════════════════════════════════════════════════════════════════════
# ADVANCED ANIMATIONS
# ═══════════════════════════════════════════════════════════════════════════════

rainbow_text() {
    local text="$1"
    local colors=('\033[1;31m' '\033[1;33m' '\033[1;32m' '\033[1;36m' '\033[1;34m' '\033[1;35m')
    for ((i=0; i<${#text}; i++)); do
        printf "${colors[i % ${#colors[@]}]}${text:$i:1}${NC}"
    done
    echo ""
}

spinner() {
    local pid=$1
    local delay=0.08
    local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local colors=('\033[1;36m' '\033[1;32m' '\033[1;33m' '\033[1;35m' '\033[1;31m')
    local color_idx=0
    while kill -0 "$pid" 2>/dev/null; do
        local temp=${spinstr#?}
        printf "\r  ${colors[color_idx]}[%c]${NC} ${CYAN}Processing...${NC}" "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        color_idx=$(( (color_idx + 1) % 5 ))
        sleep "$delay"
    done
    printf "\r  ${GREEN}[✓]${NC} ${GREEN}Complete!          ${NC}\n"
}

loading_bar() {
    local duration=${1:-3}
    local message="${2:-Processing}"
    local width=50
    local step
    step=$(awk "BEGIN{print $duration/100}")
    echo ""
    for ((i=0; i<=100; i++)); do
        local filled=$(( i * width / 100 ))
        printf "\r  ${CYAN}${message}:${NC} ["
        for ((j=0; j<filled; j++)); do
            if [ $j -lt $((width/3)) ]; then
                printf "${RED}█${NC}"
            elif [ $j -lt $((2*width/3)) ]; then
                printf "${YELLOW}█${NC}"
            else
                printf "${GREEN}█${NC}"
            fi
        done
        for ((j=filled; j<width; j++)); do
            printf "${DIM}░${NC}"
        done
        printf "] ${BOLD}%3d%%${NC}" "$i"
        local remaining=$(( 100 - i ))
        printf " ⏱️ ${YELLOW}~${remaining}s${NC}"
        sleep "$step"
    done
    echo -e "\n"
}

typewriter() {
    local text="$1"
    local delay="${2:-0.03}"
    local color="${3:-$CYAN}"
    echo -ne "$color"
    for ((i=0; i<${#text}; i++)); do
        printf "%s" "${text:$i:1}"
        sleep "$delay"
    done
    echo -e "${NC}"
}

heart_animation() {
    local frames=(
        "  ❤️  "
        " 💗💗 "
        "💖💖💖"
        " 💗💗 "
        "  ❤️  "
    )
    clear
    for ((i=0; i<3; i++)); do
        for frame in "${frames[@]}"; do
            echo -e "${RED}${frame}${NC}"
            sleep 0.1
            clear
        done
    done
    echo -e "${MAGENTA}  💜  ${NC}"
    echo -e "${PINK} 💗💗💗 ${NC}"
    echo -e "${RED}💖💖💖💖💖${NC}"
    echo -e "${PINK} 💗💗💗 ${NC}"
    echo -e "${MAGENTA}  💜  ${NC}"
    sleep 1
}

rocket_animation() {
    clear
    echo -e "\n\n\n\n\n"
    echo -e "          ${YELLOW}🚀${NC}"
    sleep 0.3
    clear
    echo -e "\n\n\n\n"
    echo -e "          ${YELLOW}  🚀${NC}"
    echo -e "          ${RED}💥💥💥${NC}"
    sleep 0.3
    clear
    echo -e "\n\n\n"
    echo -e "          ${YELLOW}    🚀${NC}"
    echo -e "          ${ORANGE}  💥💥💥${NC}"
    echo -e "          ${RED}💥💥💥💥💥${NC}"
    sleep 0.3
    clear
    echo -e "\n\n"
    echo -e "          ${YELLOW}      🚀${NC}"
    echo -e "          ${ORANGE}    💥💥💥${NC}"
    echo -e "          ${RED}  💥💥💥💥💥${NC}"
    echo -e "          ${YELLOW}💥💥💥💥💥💥💥${NC}"
    sleep 0.3
    clear
}

matrix_effect() {
    local duration=${1:-2}
    local chars="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%&*"
    local end_time=$((SECONDS + duration))
    local cols
    cols=$(tput cols 2>/dev/null || echo 80)
    while [ $SECONDS -lt $end_time ]; do
        local line=""
        for ((i=0; i<cols; i++)); do
            line+="${chars:$((RANDOM % ${#chars})):1}"
        done
        echo -e "${GREEN}$line${NC}"
        sleep 0.05
    done
    clear
}

explosion_effect() {
    local particles=("💫" "✨" "⭐" "🌟" "💥" "🔥" "⚡" "💢")
    for ((i=0; i<5; i++)); do
        clear
        echo -e "\n\n"
        for ((j=0; j<10; j++)); do
            local rand_y=$((RANDOM % 5))
            local rand_x=$((RANDOM % 60))
            local particle=${particles[$((RANDOM % ${#particles[@]}))]}
            printf "\033[%d;%dH%s" $((rand_y + 5)) $((rand_x + 10)) "$particle"
        done
        sleep 0.2
    done
    clear
}

# ═══════════════════════════════════════════════════════════════════════════════
# BANNER
# ═══════════════════════════════════════════════════════════════════════════════

banner() {
    clear
    echo ""
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}                                                                              ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${BOLD}${RED}██╗████████╗███████╗${NC}     ${BOLD}${GREEN}██╗   ██╗████████╗ █████╗ ███╗   ██╗███████╗██╗  ██╗${NC}  ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${BOLD}${ORANGE}██║╚══██╔══╝╚══███╔╝${NC}     ${BOLD}${GREEN}╚██╗ ██╔╝╚══██╔══╝██╔══██╗████╗  ██║██╔════╝██║  ██║${NC}  ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${BOLD}${YELLOW}██║   ██║     ███╔╝${NC}       ${BOLD}${GREEN}╚████╔╝    ██║   ███████║██╔██╗ ██║███████╗███████║${NC}  ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${BOLD}${GREEN}██║   ██║    ███╔╝${NC}         ${BOLD}${GREEN}╚██╔╝     ██║   ██╔══██║██║╚██╗██║╚════██║██╔══██║${NC}  ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${BOLD}${BLUE}██║   ██║   ███████╗${NC}        ${BOLD}${GREEN}██║      ██║   ██║  ██║██║ ╚████║███████║██║  ██║${NC}  ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${BOLD}${MAGENTA}╚═╝   ╚═╝   ╚══════╝${NC}        ${BOLD}${GREEN}╚═╝      ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝${NC}  ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}                                                                              ${CYAN}║${NC}"
    echo -e "${CYAN}╠══════════════════════════════════════════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║${NC}                  ${YELLOW}🚀 ITZ_YTANSH PRO HOSTING INSTALLER v2.0 🚀${NC}                   ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}                        ${PINK}Made with ❤️  by ITZ_YT_ANSH${NC}                        ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# ═══════════════════════════════════════════════════════════════════════════════
# FAKE LOGS
# ═══════════════════════════════════════════════════════════════════════════════

fake_logs() {
    local logs=(
        "🔍 Scanning system architecture..."
        "📦 Loading secure module dependencies..."
        "🔄 Initializing cryptographic protocols..."
        "⚙️  Compiling kernel optimizations..."
        "🛡️  Configuring firewall rulesets..."
        "📡 Establishing secure connection..."
        "💾 Allocating memory buffers..."
        "🔐 Generating SSL certificates..."
        "🗄️  Setting up database clusters..."
        "🐳 Initializing Docker runtime..."
        "📊 Optimizing performance metrics..."
        "🔧 Building hosting environment..."
        "🧩 Assembling Pterodactyl components..."
        "🎛️  Calibrating system parameters..."
        "✅ Verifying installation integrity..."
    )
    
    echo ""
    echo -e "${CYAN}╔════════════════════ INSTALLATION LOG ════════════════════╗${NC}"
    for log in "${logs[@]}"; do
        echo -ne "${CYAN}║${NC} ${YELLOW}[⏳]${NC} $log "
        sleep 0.8
        echo -e "\r${CYAN}║${NC} ${GREEN}[✓]${NC} $log ${GREEN}SUCCESS${NC}     "
    done
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# ═══════════════════════════════════════════════════════════════════════════════
# THEME INSTALLER - MAIN FUNCTION
# ═══════════════════════════════════════════════════════════════════════════════

theme_installer() {
    banner
    echo -e "${CYAN}╔═══════════════════ THEME INSTALLER ═══════════════════════╗${NC}"
    echo ""
    
    typewriter "🎨 Premium Theme Installer" 0.05 $MAGENTA
    echo ""
    
    while true; do
        echo -ne "${YELLOW}✨${NC} Are You Want To Make Your Panel Like Paid Hostings? ${GREEN}(yes/no)${NC}: "
        read -r THEME_CONFIRM
        
        case "$THEME_CONFIRM" in
            yes|YES|Yes|y|Y)
                theme_menu
                return
                ;;
            no|NO|No|n|N)
                echo ""
                typewriter "Ok, Sir Your Prohosting panel is same nothing changes" 0.04 $YELLOW
                echo ""
                sleep 2
                main_menu
                return
                ;;
            *)
                echo ""
                typewriter "I can't understand, type yes or no" 0.04 $RED
                echo ""
                ;;
        esac
    done
}

# ═══════════════════════════════════════════════════════════════════════════════
# THEME SUB-MENU
# ═══════════════════════════════════════════════════════════════════════════════

theme_menu() {
    banner
    echo -e "${CYAN}╔═══════════════════ THEME MANAGER ═══════════════════════╗${NC}"
    echo ""
    echo -e "  ${GREEN}[${BOLD}1${NC}${GREEN}]${NC}  🎨  ${BOLD}Install Theme${NC}           ${DIM}• Premium Panel Themes${NC}"
    echo -e "  ${GREEN}[${BOLD}2${NC}${GREEN}]${NC}  🗑️   ${BOLD}Uninstall Theme${NC}         ${DIM}• Remove Themes & Blueprint${NC}"
    echo -e "  ${GREEN}[${BOLD}0${NC}${GREEN}]${NC}  🔙  ${BOLD}Back${NC}                    ${DIM}• Return to Main Menu${NC}"
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -ne "  ${YELLOW}👉${NC} ${BOLD}Select an option${NC} ${CYAN}[0-2]${NC}: ${GREEN}"
    read -r THEME_OPTION
    echo -ne "${NC}"
    
    case "$THEME_OPTION" in
        1) theme_install_run ;;
        2) theme_uninstall_run ;;
        0) main_menu ;;
        *) 
            echo -e "${RED}❌ Invalid Option! Please choose between 0-2${NC}"
            sleep 2
            theme_menu 
            ;;
    esac
}

# ═══════════════════════════════════════════════════════════════════════════════
# THEME INSTALL FUNCTION
# ═══════════════════════════════════════════════════════════════════════════════

theme_install_run() {
    banner
    echo -e "${CYAN}╔═══════════════════ THEME INSTALLATION ═══════════════════════╗${NC}"
    echo ""
    
    typewriter "🎨 Making your panel eye-catching..." 0.05 $YELLOW
    echo ""
    
    # Check panel directory
    if [ ! -d "/var/www/pterodactyl" ]; then
        echo -e "${RED}❌ Pterodactyl panel not found at /var/www/pterodactyl${NC}"
        echo -e "${YELLOW}⚠️  Please install the panel first!${NC}"
        sleep 3
        main_menu
        return
    fi
    
    loading_bar 3 "✨ Preparing Theme Environment"
    fake_logs
    
    export PTERODACTYL_DIRECTORY="/var/www/pterodactyl"
    
    # ═══════════════════════════════════════════════════════════════════════════
    # STEP 1: Install Blueprint Framework
    # ═══════════════════════════════════════════════════════════════════════════
    echo -e "${DIM}[Step 1/3] Installing Blueprint Framework...${NC}"
    
    (
        # Install dependencies
        apt install -y curl wget unzip ca-certificates git gnupg zip >>"$LOG_FILE" 2>&1 || true
        
        # Navigate to Pterodactyl directory
        cd "$PTERODACTYL_DIRECTORY" || exit 1
        
        # Download Blueprint's latest release
        wget "https://github.com/BlueprintFramework/framework/releases/latest/download/release.zip" -O "$PTERODACTYL_DIRECTORY/release.zip" >>"$LOG_FILE" 2>&1
        unzip -o release.zip >>"$LOG_FILE" 2>&1
        rm -f release.zip
        
        # Add Node.js apt repository
        mkdir -p /etc/apt/keyrings
        curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg >>"$LOG_FILE" 2>&1
        echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list >>"$LOG_FILE" 2>&1
        apt update >>"$LOG_FILE" 2>&1
        apt install -y nodejs >>"$LOG_FILE" 2>&1 || true
        
        # Install yarn and node dependencies
        cd /var/www/pterodactyl || exit 1
        npm i -g yarn >>"$LOG_FILE" 2>&1 || true
        yarn install >>"$LOG_FILE" 2>&1 || true
        
        # Create .blueprintrc file
        touch "$PTERODACTYL_DIRECTORY/.blueprintrc"
        printf 'WEBUSER="www-data";\nOWNERSHIP="www-data:www-data";\nUSERSHELL="/bin/bash";\n' > "$PTERODACTYL_DIRECTORY/.blueprintrc"
        
        # Give blueprint.sh execute permissions and run it
        chmod +x "$PTERODACTYL_DIRECTORY/blueprint.sh"
        yes | bash "$PTERODACTYL_DIRECTORY/blueprint.sh" >>"$LOG_FILE" 2>&1 || true
    ) &
    
    bp_install_pid=$!
    spinner $bp_install_pid
    wait $bp_install_pid 2>/dev/null
    
    if ! command -v blueprint &>/dev/null; then
        echo -e "  ${YELLOW}[!]${NC} ${YELLOW}Blueprint command not found in PATH, checking local...${NC}"
    fi
    
    echo -e "  ${GREEN}[✓]${NC} ${GREEN}Blueprint Framework ready!${NC}\n"
    
    # ═══════════════════════════════════════════════════════════════════════════
    # STEP 2: Clone blueprints repository
    # ═══════════════════════════════════════════════════════════════════════════
    echo -e "${DIM}[Step 2/3] Downloading premium theme packages...${NC}"
    
    (
        cd /root || exit 1
        rm -rf blueprints
        git clone https://github.com/AstroVoidHostDev/blueprints >>"$LOG_FILE" 2>&1
    ) &
    
    git_clone_pid=$!
    spinner $git_clone_pid
    wait $git_clone_pid 2>/dev/null
    
    if [ ! -d "/root/blueprints" ]; then
        echo -e "  ${RED}[✗]${NC} ${RED}Failed to download theme packages!${NC}"
        echo -e "  ${YELLOW}[i]${NC} ${YELLOW}Check log: $LOG_FILE${NC}"
        read -rp "Press Enter to return..."
        theme_menu
        return
    fi
    
    echo -e "  ${GREEN}[✓]${NC} ${GREEN}Theme packages downloaded!${NC}\n"
    
    # ═══════════════════════════════════════════════════════════════════════════
    # STEP 3: Install all blueprints
    # ═══════════════════════════════════════════════════════════════════════════
    echo -e "${DIM}[Step 3/3] Applying premium themes...${NC}"
    echo ""
    
    local BLUEPRINT_DIR="/root/blueprints"
    local PTERO_DIR="/var/www/pterodactyl"
    local BLUEPRINTS=(
        nebula
        huxregister
        snowflakes
        versionchanger
        mcplugins
        minecraftplayermanager
        ShootingStars
        subdomains
    )
    
    local total_bp=${#BLUEPRINTS[@]}
    local current_bp=0
    local installed_count=0
    local failed_count=0
    
    for bp in "${BLUEPRINTS[@]}"; do
        current_bp=$((current_bp + 1))
        printf "\r  ${CYAN}[${current_bp}/${total_bp}]${NC} ${YELLOW}Installing ${MAGENTA}$bp${NC}...                    "
        
        if [ -f "$BLUEPRINT_DIR/$bp.blueprint" ]; then
            mv "$BLUEPRINT_DIR/$bp.blueprint" "$PTERO_DIR" >>"$LOG_FILE" 2>&1
            cd "$PTERO_DIR" || continue
            if blueprint -install "$bp" >>"$LOG_FILE" 2>&1; then
                installed_count=$((installed_count + 1))
            else
                failed_count=$((failed_count + 1))
            fi
            cd "$BLUEPRINT_DIR" 2>/dev/null || cd /root
        fi
        sleep 0.3
    done
    
    echo -e "\r  ${GREEN}[✓]${NC} ${GREEN}Themes installed: ${installed_count}/${total_bp}${NC}"
    if [ "$failed_count" -gt 0 ]; then
        echo -e "  ${YELLOW}[!]${NC} ${YELLOW}Failed: ${failed_count} (check log: $LOG_FILE)${NC}"
    fi
    echo ""
    
    echo ""
    typewriter "✨ Almost done... Your Nebula experience is loading..." 0.05 $MAGENTA
    sleep 2
    
    explosion_effect
    
    # Final Nebula display
    clear
    echo ""
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                                                              ║${NC}"
    echo -e "${CYAN}║                                                              ║${NC}"
    echo -e "${CYAN}║          ${MAGENTA}✦ ✦ ✦  NEBULA EXPERIENCE ACTIVATED  ✦ ✦ ✦${NC}          ${CYAN}║${NC}"
    echo -e "${CYAN}║                                                              ║${NC}"
    echo -e "${CYAN}║              ${PINK}🌟  PREMIUM THEME INSTALLED  🌟${NC}              ${CYAN}║${NC}"
    echo -e "${CYAN}║                                                              ║${NC}"
    echo -e "${CYAN}║         ${YELLOW}╔══════════════════════════════════════════╗${NC}         ${CYAN}║${NC}"
    echo -e "${CYAN}║         ${YELLOW}║${NC}                                          ${YELLOW}║${NC}         ${CYAN}║${NC}"
    echo -e "${CYAN}║         ${YELLOW}║${NC}     ${BOLD}${WHITE}✦ NEBULA - Premium Theme ✦${NC}${YELLOW}     ║${NC}         ${CYAN}║${NC}"
    echo -e "${CYAN}║         ${YELLOW}║${NC}                                          ${YELLOW}║${NC}         ${CYAN}║${NC}"
    echo -e "${CYAN}║         ${YELLOW}║${NC}   ${DIM}Made with ❤️ by ITZ_YT_ANSH${NC}${YELLOW}           ║${NC}         ${CYAN}║${NC}"
    echo -e "${CYAN}║         ${YELLOW}║${NC}                                          ${YELLOW}║${NC}         ${CYAN}║${NC}"
    echo -e "${CYAN}║         ${YELLOW}╚══════════════════════════════════════════╝${NC}         ${CYAN}║${NC}"
    echo -e "${CYAN}║                                                              ║${NC}"
    echo -e "${CYAN}║         ${GREEN}✅ Panel is now looking like Paid Hosting!${NC}         ${CYAN}║${NC}"
    echo -e "${CYAN}║                                                              ║${NC}"
    echo -e "${CYAN}║      ${ORANGE}🚀 Your Pterodactyl Panel is Premium Ready!${NC}          ${CYAN}║${NC}"
    echo -e "${CYAN}║                                                              ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    read -rp "Press Enter to return to Theme Menu..." 
    theme_menu
}

# ═══════════════════════════════════════════════════════════════════════════════
# THEME UNINSTALL FUNCTION
# ═══════════════════════════════════════════════════════════════════════════════

theme_uninstall_run() {
    banner
    echo -e "${RED}╔═══════════════════ THEME UNINSTALLATION ═══════════════════════╗${NC}"
    echo ""
    
    typewriter "⚠️  WARNING: This will remove all installed themes!" 0.05 $RED
    echo ""
    
    echo -ne "${RED}🤔${NC} Are you sure you want to uninstall themes? ${GREEN}(yes/no)${NC}: "
    read -r UNINSTALL_CONFIRM
    
    while true; do
        case "$UNINSTALL_CONFIRM" in
            yes|YES|Yes|y|Y)
                break
                ;;
            no|NO|No|n|N)
                echo ""
                typewriter "👌 Theme uninstallation cancelled!" 0.04 $YELLOW
                sleep 2
                theme_menu
                return
                ;;
            *)
                echo ""
                typewriter "I can't understand, type yes or no" 0.04 $RED
                echo -ne "${RED}🤔${NC} Are you sure? ${GREEN}(yes/no)${NC}: "
                read -r UNINSTALL_CONFIRM
                ;;
        esac
    done
    
    echo ""
    typewriter "🗑️  Removing all themes..." 0.05 $RED
    echo ""
    
    loading_bar 2 "🧹 Cleaning Theme Files"
    
    local PTERO_DIR="/var/www/pterodactyl"
    local BLUEPRINTS=(
        nebula
        huxregister
        snowflakes
        versionchanger
        mcplugins
        minecraftplayermanager
        ShootingStars
        subdomains
    )
    
    local total_bp=${#BLUEPRINTS[@]}
    local current_bp=0
    
    echo -e "${DIM}[Removing premium themes...]${NC}"
    echo ""
    
    for bp in "${BLUEPRINTS[@]}"; do
        current_bp=$((current_bp + 1))
        printf "\r  ${CYAN}[${current_bp}/${total_bp}]${NC} ${YELLOW}Removing ${MAGENTA}$bp${NC}...                    "
        
        cd "$PTERO_DIR" 2>/dev/null || continue
        if command -v blueprint &>/dev/null; then
            blueprint -uninstall "$bp" >>"$LOG_FILE" 2>&1 || true
        fi
        sleep 0.3
    done
    
    echo -e "\r  ${GREEN}[✓]${NC} ${GREEN}All themes removed!          ${NC}\n"
    
    echo -e "${DIM}[Cleaning up blueprint files...]${NC}"
    rm -rf /root/blueprints >>"$LOG_FILE" 2>&1
    rm -f "$PTERO_DIR"/*.blueprint >>"$LOG_FILE" 2>&1
    
    explosion_effect
    
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                                                              ║${NC}"
    echo -e "${GREEN}║            ✅ ALL THEMES UNINSTALLED SUCCESSFULLY!           ║${NC}"
    echo -e "${GREEN}║                                                              ║${NC}"
    echo -e "${GREEN}║         🔄 Your panel is back to default appearance          ║${NC}"
    echo -e "${GREEN}║                                                              ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    read -rp "Press Enter to return to Theme Menu..." 
    theme_menu
}

# ═══════════════════════════════════════════════════════════════════════════════
# PANEL INSTALL
# ═══════════════════════════════════════════════════════════════════════════════

panel_install() {
    banner
    echo -e "${CYAN}╔═══════════════════ PANEL INSTALLATION ═══════════════════════╗${NC}"
    echo ""
    
    loading_bar 3 "🔥 Preparing Installation Environment"
    fake_logs
    
    echo -e "${CYAN}╔═══════════════════ CONFIGURATION ════════════════════════╗${NC}"
    echo ""
    
    echo -ne "${YELLOW}🌐${NC} Enter Panel Domain: ${GREEN}"
    read -r PANEL_DOMAIN
    echo -ne "${NC}"
    
    local DB_NAME="panel"
    local DB_USER="pterodactyl"
    local TIMEZONE="Asia/Kolkata"
    
    echo -ne "${YELLOW}📧${NC} Enter Admin Email: ${GREEN}"
    read -r EMAIL
    echo -ne "${NC}"
    
    echo -ne "${YELLOW}👤${NC} Enter Username: ${GREEN}"
    read -r USERNAME
    echo -ne "${NC}"
    
    echo -ne "${YELLOW}📝${NC} Enter First Name: ${GREEN}"
    read -r FIRSTNAME
    echo -ne "${NC}"
    
    echo -ne "${YELLOW}📝${NC} Enter Last Name: ${GREEN}"
    read -r LASTNAME
    echo -ne "${NC}"
    
    echo -ne "${YELLOW}🔒${NC} Enter Password: ${GREEN}"
    read -rs PASSWORD
    echo -e "${NC}"
    
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    typewriter "🚀 Initiating Panel Deployment..." 0.05 $YELLOW
    echo ""
    echo -e "${DIM}[Real installation in progress - it can take a while]${NC}"
    
    if ! curl -fsSL https://pterodactyl-installer.se -o /tmp/pterodactyl-installer.sh; then
        echo -e "${RED}❌ Failed to download installer.${NC}"
        read -rp "Press Enter to return..."
        main_menu
        return
    fi
    
    bash /tmp/pterodactyl-installer.sh <<EOF > /tmp/pterodactyl_install.log 2>&1 &
0

$DB_NAME
$DB_USER

$TIMEZONE
$EMAIL
$EMAIL
$USERNAME
$FIRSTNAME
$LASTNAME
$PASSWORD
$PANEL_DOMAIN
n
n
n
no
yes
EOF
    
    local install_pid=$!
    spinner $install_pid
    wait $install_pid 2>/dev/null
    local INSTALL_EXIT=$?
    
    if [ $INSTALL_EXIT -ne 0 ] || [ ! -f /var/www/pterodactyl/artisan ]; then
        echo ""
        echo -e "${RED}❌ Panel installation failed (exit: $INSTALL_EXIT)${NC}"
        echo -e "${YELLOW}[i] Check log: /tmp/pterodactyl_install.log${NC}"
        echo ""
        tail -30 /tmp/pterodactyl_install.log
        read -rp "Press Enter to continue..."
        main_menu
        return
    fi
    
    explosion_effect
    
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                    ✅ PANEL INSTALLED!                       ║${NC}"
    echo -e "${GREEN}║              🎉 Your server is ready to fly!                 ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    while true; do
        echo -ne "${CYAN}🔗${NC} Add ${YELLOW}http://localhost:80${NC} in Cloudflare Tunnel ${GREEN}(yes/no)${NC}: "
        read -r TUNNEL
        case "$TUNNEL" in
            yes|YES|Yes|y|Y)
                echo -e "${GREEN}✅ Perfect! Your panel is now accessible!${NC}"
                break
                ;;
            *)
                echo -e "${RED}⚠️  You must configure tunnel for panel to work!${NC}"
                ;;
        esac
    done
    
    read -rp "Press Enter to return to Main Menu..." 
    main_menu
}

# ═══════════════════════════════════════════════════════════════════════════════
# WINGS INSTALL
# ═══════════════════════════════════════════════════════════════════════════════

wings_install() {
    banner
    heart_animation
    
    echo -e "${CYAN}╔═══════════════════ WINGS INSTALLATION ═════════════════════╗${NC}"
    echo ""
    
    echo -ne "${YELLOW}❓${NC} Is Your Node Offline? ${GREEN}(yes/no)${NC}: "
    read -r NODECHECK
    
    case "$NODECHECK" in
        yes|YES|Yes|y|Y) ;;
        no|NO|No|n|N)
            typewriter "😅 Ohh.. I Thought Your Wings Is Off!" 0.05 $YELLOW
            sleep 3
            main_menu
            return
            ;;
        *)
            echo -e "${RED}❌ Invalid input!${NC}"
            sleep 2
            wings_install
            return
            ;;
    esac
    
    loading_bar 3 "🛠️  Preparing Wings Environment"
    fake_logs
    
    echo -e "${YELLOW}🚀 Starting Wings Installation...${NC}"
    echo -e "${DIM}[Real installation in progress - it can take a while..]${NC}"
    
    bash <(curl -s https://pterodactyl-installer.se) <<EOF > /tmp/wings_install.log 2>&1 &
1
n
n
n
y
EOF
    
    local wings_pid=$!
    spinner $wings_pid
    wait $wings_pid 2>/dev/null
    
    echo ""
    echo -e "${CYAN}╔═══════════════════ NODE CONFIGURATION ═════════════════════╗${NC}"
    echo ""
    
    echo -ne "${YELLOW}🆔${NC} Enter Node UUID: ${GREEN}"
    read -r NODE_UUID
    echo -ne "${NC}"
    
    echo -ne "${YELLOW}🔑${NC} Enter Token ID: ${GREEN}"
    read -r TOKEN_ID
    echo -ne "${NC}"
    
    echo -ne "${YELLOW}🔐${NC} Enter Token: ${GREEN}"
    read -r TOKEN
    echo -ne "${NC}"
    
    echo -ne "${YELLOW}🌐${NC} Enter Node Domain: ${GREEN}"
    read -r NODE_DOMAIN
    echo -ne "${NC}"
    
    echo -ne "${YELLOW}🌐${NC} Enter Panel Domain: ${GREEN}"
    read -r PANEL_REMOTE
    echo -ne "${NC}"
    
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    typewriter "⚙️  Generating configuration..." 0.03 $CYAN
    
    mkdir -p /etc/pterodactyl
    
    cat > /etc/pterodactyl/config.yml <<EOL
debug: false
uuid: $NODE_UUID
token_id: $TOKEN_ID
token: $TOKEN
api:
  host: 0.0.0.0
  port: 8080
  ssl:
    enabled: false
    cert: /etc/letsencrypt/live/$NODE_DOMAIN/fullchain.pem
    key: /etc/letsencrypt/live/$NODE_DOMAIN/privkey.pem
upload_limit: 100
system:
  data: /var/lib/pterodactyl/volumes
  sftp:
    bind_port: 2022
allowed_mounts: []
remote: 'https://$PANEL_REMOTE'
EOL
    
    echo -e "${GREEN}✅ Configuration file created successfully!${NC}"
    echo ""
    
    while true; do
        echo -ne "${CYAN}🔗${NC} Add ${YELLOW}http://localhost:8080${NC} in Cloudflare Tunnel ${GREEN}(yes/no)${NC}: "
        read -r CLOUDFLARE
        case "$CLOUDFLARE" in
            yes|YES|Yes|y|Y)
                echo -e "${GREEN}✅ Tunnel configured!${NC}"
                break
                ;;
            *)
                echo -e "${RED}⚠️  Wings won't work without tunnel!${NC}"
                ;;
        esac
    done
    
    echo ""
    while true; do
        echo -ne "${CYAN}⚙️${NC} Did you change Node Port to ${YELLOW}8443${NC} in Panel? ${GREEN}(yes/no)${NC}: "
        read -r PORTCHECK
        case "$PORTCHECK" in
            yes|YES|Yes|y|Y)
                typewriter "⏳ Waiting for node synchronization..." 0.05 $YELLOW
                sleep 10
                systemctl enable wings >>"$LOG_FILE" 2>&1
                systemctl restart wings >>"$LOG_FILE" 2>&1
                
                rocket_animation
                
                echo ""
                echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
                echo -e "${GREEN}║                  🟢 YOUR NODE IS ONLINE!                     ║${NC}"
                echo -e "${GREEN}║              🚀 Ready to host servers!                       ║${NC}"
                echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
                break
                ;;
            *)
                echo -e "${RED}⚠️  Please change port to 8443 first!${NC}"
                ;;
        esac
    done
    
    read -rp "Press Enter to return to Main Menu..." 
    main_menu
}

# ═══════════════════════════════════════════════════════════════════════════════
# PANEL DOWN / UP
# ═══════════════════════════════════════════════════════════════════════════════

panel_down() {
    banner
    typewriter "⛔ Taking Panel Offline..." 0.05 $RED
    
    if [ -d "/var/www/pterodactyl" ]; then
        cd /var/www/pterodactyl || exit
        php artisan down > /dev/null 2>&1 &
        spinner $!
    else
        echo -e "${RED}❌ Panel not installed!${NC}"
        sleep 2
        main_menu
        return
    fi
    
    echo ""
    echo -e "${RED}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║              ⛔ PANEL IS NOW IN MAINTENANCE MODE              ║${NC}"
    echo -e "${RED}║            🔒 Only admins can access the panel               ║${NC}"
    echo -e "${RED}╚══════════════════════════════════════════════════════════════╝${NC}"
    sleep 3
    main_menu
}

panel_up() {
    banner
    typewriter "🟢 Bringing Panel Online..." 0.05 $GREEN
    
    if [ -d "/var/www/pterodactyl" ]; then
        cd /var/www/pterodactyl || exit
        php artisan up > /dev/null 2>&1 &
        spinner $!
    else
        echo -e "${RED}❌ Panel not installed!${NC}"
        sleep 2
        main_menu
        return
    fi
    
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                 🟢 PANEL IS NOW ONLINE!                      ║${NC}"
    echo -e "${GREEN}║              🌐 Users can access the panel                   ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    sleep 3
    main_menu
}

# ═══════════════════════════════════════════════════════════════════════════════
# UNINSTALL PANEL / WINGS
# ═══════════════════════════════════════════════════════════════════════════════

uninstall_panel() {
    banner
    echo -e "${RED}╔═══════════════════ PANEL UNINSTALLATION ════════════════════╗${NC}"
    echo ""
    
    typewriter "⚠️  WARNING: This will completely remove the panel!" 0.05 $RED
    echo ""
    
    echo -ne "${RED}🤔${NC} Are you sure? ${GREEN}(yes/no)${NC}: "
    read -r CONFIRM
    
    if [[ ! "$CONFIRM" =~ ^(yes|YES|Yes|y|Y)$ ]]; then
        echo -e "${YELLOW}👌 Uninstallation cancelled!${NC}"
        sleep 2
        main_menu
        return
    fi
    
    loading_bar 2 "🗑️  Removing Panel Components"
    
    echo -e "${DIM}[Removing panel files...]${NC}"
    systemctl stop nginx mysql redis-server pteroq 2>/dev/null
    systemctl disable nginx mysql redis-server pteroq 2>/dev/null
    rm -rf /var/www/pterodactyl
    rm -rf /etc/nginx/sites-enabled/pterodactyl.conf
    rm -rf /etc/nginx/sites-available/pterodactyl.conf
    rm -rf /etc/systemd/system/pteroq.service
    mysql -e "DROP DATABASE IF EXISTS panel;" 2>/dev/null
    mysql -e "DROP USER IF EXISTS 'pterodactyl'@'127.0.0.1';" 2>/dev/null
    mysql -e "DROP USER IF EXISTS 'panel'@'127.0.0.1';" 2>/dev/null
    mysql -e "FLUSH PRIVILEGES;" 2>/dev/null
    apt purge -y nginx mysql-server redis-server php* 2>/dev/null
    apt autoremove -y 2>/dev/null
    
    explosion_effect
    
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║               ✅ PANEL COMPLETELY REMOVED!                   ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    read -rp "Press Enter to return to Main Menu..." 
    main_menu
}

uninstall_wings() {
    banner
    echo -e "${RED}╔═══════════════════ WINGS UNINSTALLATION ═══════════════════╗${NC}"
    echo ""
    
    typewriter "⚠️  WARNING: This will completely remove Wings!" 0.05 $RED
    echo ""
    
    echo -ne "${RED}🤔${NC} Are you sure? ${GREEN}(yes/no)${NC}: "
    read -r CONFIRM
    
    if [[ ! "$CONFIRM" =~ ^(yes|YES|Yes|y|Y)$ ]]; then
        echo -e "${YELLOW}👌 Uninstallation cancelled!${NC}"
        sleep 2
        main_menu
        return
    fi
    
    loading_bar 2 "🗑️  Removing Wings Components"
    
    echo -e "${DIM}[Removing wings files...]${NC}"
    systemctl stop wings docker 2>/dev/null
    systemctl disable wings docker 2>/dev/null
    rm -rf /etc/pterodactyl
    rm -rf /var/lib/pterodactyl
    rm -rf /etc/systemd/system/wings.service
    rm -rf /usr/local/bin/wings
    docker system prune -af > /dev/null 2>&1
    apt purge -y docker-ce docker-ce-cli containerd.io docker-compose-plugin > /dev/null 2>&1
    apt autoremove -y > /dev/null 2>&1
    
    explosion_effect
    
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║               ✅ WINGS COMPLETELY REMOVED!                   ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    read -rp "Press Enter to return to Main Menu..." 
    main_menu
}

# ═══════════════════════════════════════════════════════════════════════════════
# SUBSCRIBE
# ═══════════════════════════════════════════════════════════════════════════════

subscribe() {
    banner
    matrix_effect 2
    
    echo ""
    typewriter "🎥 Opening YouTube Channel..." 0.05 $RED
    sleep 1
    
    echo ""
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                                                              ║${NC}"
    echo -e "${CYAN}║          ${RED}📺  SUBSCRIBE TO OUR YOUTUBE CHANNEL  📺${CYAN}          ║${NC}"
    echo -e "${CYAN}║                                                              ║${NC}"
    echo -e "${CYAN}║     ${YELLOW}🔗 https://www.youtube.com/@ITZ_YT_ANSH_OFFICIAL${CYAN}      ║${NC}"
    echo -e "${CYAN}║                                                              ║${NC}"
    echo -e "${CYAN}║         ${PINK}❤️  Support us for more content!  ❤️${CYAN}              ║${NC}"
    echo -e "${CYAN}║                                                              ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    read -rp "Press Enter to return to Main Menu..." 
    main_menu
}

# ═══════════════════════════════════════════════════════════════════════════════
# MAIN MENU
# ═══════════════════════════════════════════════════════════════════════════════

main_menu() {
    tput cnorm 2>/dev/null
    banner
    
    echo -e "  ${GREEN}[${BOLD}1${NC}${GREEN}]${NC}  🚀  ${BOLD}Install Panel${NC}           ${DIM}• Deploy Pterodactyl Panel${NC}"
    echo -e "  ${GREEN}[${BOLD}2${NC}${GREEN}]${NC}  ⚡  ${BOLD}Install Wings${NC}           ${DIM}• Setup Node Daemon${NC}"
    echo -e "  ${GREEN}[${BOLD}3${NC}${GREEN}]${NC}  🎨  ${BOLD}Theme Installer${NC}         ${DIM}• Premium Panel Themes${NC}"
    echo -e "  ${GREEN}[${BOLD}4${NC}${GREEN}]${NC}  🔴  ${BOLD}Panel Down${NC}              ${DIM}• Enable Maintenance Mode${NC}"
    echo -e "  ${GREEN}[${BOLD}5${NC}${GREEN}]${NC}  🟢  ${BOLD}Panel Up${NC}                ${DIM}• Disable Maintenance Mode${NC}"
    echo -e "  ${GREEN}[${BOLD}6${NC}${GREEN}]${NC}  🗑️   ${BOLD}Uninstall Panel${NC}         ${DIM}• Remove Panel Completely${NC}"
    echo -e "  ${GREEN}[${BOLD}7${NC}${GREEN}]${NC}  🗑️   ${BOLD}Uninstall Wings${NC}         ${DIM}• Remove Wings Completely${NC}"
    echo -e "  ${GREEN}[${BOLD}8${NC}${GREEN}]${NC}  📺  ${BOLD}Subscribe${NC}               ${DIM}• Visit Our YouTube Channel${NC}"
    echo -e "  ${GREEN}[${BOLD}0${NC}${GREEN}]${NC}  🚪  ${BOLD}Exit${NC}                    ${DIM}• Close Installer${NC}"
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -ne "  ${YELLOW}👉${NC} ${BOLD}Select an option${NC} ${CYAN}[0-8]${NC}: ${GREEN}"
    read -r OPTION
    echo -ne "${NC}"
    
    case $OPTION in
        1) panel_install ;;
        2) wings_install ;;
        3) theme_installer ;;
        4) panel_down ;;
        5) panel_up ;;
        6) uninstall_panel ;;
        7) uninstall_wings ;;
        8) subscribe ;;
        0) 
            clear
            echo ""
            rainbow_text "Thanks for using ITZ_YTANSH PRO HOSTING INSTALLER!"
            echo ""
            echo -e "${PINK}❤️  Made with love by ITZ_YTANSH  ❤️${NC}"
            echo ""
            tput cnorm 2>/dev/null
            exit 0 
            ;;
        *) 
            echo ""
            echo -e "${RED}❌ Invalid Option! Please choose between 0-8${NC}"
            sleep 2
            main_menu 
            ;;
    esac
}

# ═══════════════════════════════════════════════════════════════════════════════
# STARTUP
# ═══════════════════════════════════════════════════════════════════════════════

# Root check first
if [[ $EUID -ne 0 ]]; then
    clear
    echo ""
    echo -e "${RED}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║              ⛔ THIS SCRIPT MUST BE RUN AS ROOT!              ║${NC}"
    echo -e "${RED}║           Use: ${YELLOW}sudo bash $0${RED}                   ║${NC}"
    echo -e "${RED}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    tput cnorm 2>/dev/null
    exit 1
fi

# Initial loading screen
clear
matrix_effect 1
clear

echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║                                                              ║${NC}"
echo -e "${CYAN}║           ${YELLOW}🚀 INITIALIZING SYSTEM...${NC}                           ${CYAN}║${NC}"
echo -e "${CYAN}║                                                              ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"

loading_bar 2 "⚡ Loading Core Modules"

# Launch main menu
main_menu
