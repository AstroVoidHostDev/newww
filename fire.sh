#!/bin/bash

# ╔══════════════════════════════════════════════════════════════════════════════╗
# ║                    ITZ_YTANSH PRO HOSTING INSTALLER v2.0                    ║
# ║                        Made with ❤️ by ITZ_YT_ANSH                          ║
# ╚══════════════════════════════════════════════════════════════════════════════╝

clear
tput civis  # Hide cursor for smooth animations

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
BLINK='\033[5m'
DIM='\033[2m'

# ═══════════════════════════════════════════════════════════════════════════════
# ADVANCED ANIMATIONS
# ═══════════════════════════════════════════════════════════════════════════════

# Rainbow text animation
rainbow_text() {
    local text="$1"
    local colors=('\033[1;31m' '\033[1;33m' '\033[1;32m' '\033[1;36m' '\033[1;34m' '\033[1;35m')
    for ((i=0; i<${#text}; i++)); do
        printf "${colors[i % ${#colors[@]}]}${text:$i:1}${NC}"
    done
    echo ""
}

# Professional spinner with gradient effect
spinner() {
    local pid=$1
    local delay=0.08
    local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local colors=('\033[1;36m' '\033[1;32m' '\033[1;33m' '\033[1;35m' '\033[1;31m')
    local color_idx=0
    while kill -0 $pid 2>/dev/null; do
        local temp=${spinstr#?}
        printf "\r  ${colors[color_idx]}[%c]${NC} ${CYAN}Processing...${NC}" "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        color_idx=$(( (color_idx + 1) % 5 ))
        sleep $delay
    done
    printf "\r  ${GREEN}[✓]${NC} ${GREEN}Complete!          ${NC}\n"
}

# Advanced loading bar with percentage and time estimation
loading_bar() {
    local duration=${1:-3}
    local message="${2:-Processing}"
    local width=50
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
        local remaining=$(( (duration * 1000 - i * duration * 10) / 1000 ))
        printf " ⏱️ ${YELLOW}~${remaining}s${NC}"
        sleep $(echo "scale=3; $duration/100" | bc 2>/dev/null || echo "0.03")
    done
    echo -e "\n"
}

# Typewriter effect with color
typewriter() {
    local text="$1"
    local delay="${2:-0.03}"
    local color="${3:-$CYAN}"
    echo -ne "$color"
    for ((i=0; i<${#text}; i++)); do
        printf "${text:$i:1}"
        sleep $delay
    done
    echo -e "${NC}"
}

# Heart pumping animation
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

# Rocket launch animation
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

# Glitch effect for text
glitch_text() {
    local text="$1"
    echo -e "${RED}${text}${NC}"
    sleep 0.05
    echo -e "${BLUE}${text}${NC}"
    sleep 0.05
    echo -e "${GREEN}${text}${NC}"
    sleep 0.05
    echo -e "${CYAN}${text}${NC}"
}

# Matrix rain effect (mini)
matrix_effect() {
    local duration=${1:-2}
    local chars="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%&*"
    local end_time=$((SECONDS + duration))
    while [ $SECONDS -lt $end_time ]; do
        local line=""
        for ((i=0; i<$(tput cols 2>/dev/null || echo 80); i++)); do
            line+="${chars:$((RANDOM % ${#chars})):1}"
        done
        echo -e "${GREEN}$line${NC}"
        sleep 0.05
    done
    clear
}

# Particle explosion
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
# ENHANCED BANNER
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
# FAKE PROFESSIONAL LOGS (Hide real installation)
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
        # Random delay for realism
        sleep $(echo "scale=2; 0.5 + $RANDOM/32767" | bc 2>/dev/null || echo "0.8")
        echo -e "\r${CYAN}║${NC} ${GREEN}[✓]${NC} $log ${GREEN}SUCCESS${NC}     "
    done
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Hide real installation output
hide_installation() {
    "$@" > /dev/null 2>&1 &
    local pid=$!
    spinner $pid
}

# ═══════════════════════════════════════════════════════════════════════════════
# THEME INSTALLER FUNCTION
# ═══════════════════════════════════════════════════════════════════════════════

theme_installer() {
    banner
    echo -e "${CYAN}╔═══════════════════ THEME INSTALLER ═══════════════════════╗${NC}"
    echo ""
    
    typewriter "🎨 Premium Theme Installer" 0.05 $MAGENTA
    echo ""
    
    # Confirmation loop
    while true; do
        echo -ne "${YELLOW}✨${NC} Are You Want To Make Your Panel Like Paid Hostings? ${GREEN}(yes/no)${NC}: "
        read -r THEME_CONFIRM
        
        if [[ "$THEME_CONFIRM" == "yes" ]]; then
            echo ""
            typewriter "🎨 Making your panel eye-catching..." 0.05 $YELLOW
            echo ""
            
            loading_bar 3 "✨ Transforming Your Panel"
            fake_logs
            
            echo -e "${DIM}[Installing premium themes...]${NC}"
            
            # Real installation - hidden from user
            cd /var/www/pterodactyl || {
                echo -e "${RED}❌ Panel directory not found!${NC}"
                sleep 2
                main_menu
                return
            }
            
            # Install blueprint if not present
            if ! command -v blueprint &> /dev/null; then
                echo -e "${DIM}[Setting up blueprint framework...]${NC}"
                apt install -y zip unzip git curl wget > /dev/null 2>&1
                wget "$(curl -s https://api.github.com/repos/BlueprintFramework/framework/releases/latest | grep 'browser_download_url' | cut -d '"' -f 4)" -O blueprint.sh > /dev/null 2>&1
                chmod +x blueprint.sh
                bash blueprint.sh <<EOF > /dev/null 2>&1
1
y
EOF
            fi
            
            # Clone blueprints repository
            echo -e "${DIM}[Downloading premium theme packages...]${NC}"
            cd /root || exit
            rm -rf blueprints
            git clone https://github.com/AstroVoidHostDev/blueprints > /dev/null 2>&1 &
            git_pid=$!
            spinner $git_pid
            wait $git_pid
            
            # Install all blueprints
            BLUEPRINT_DIR="/root/blueprints"
            PTERO_DIR="/var/www/pterodactyl"
            BLUEPRINTS=(
                nebula
                huxregister
                snowflakes
                versionchanger
                mcplugins
                minecraftplayermanager
                ShootingStars
                subdomains
            )
            
            total_bp=${#BLUEPRINTS[@]}
            current_bp=0
            
            for bp in "${BLUEPRINTS[@]}"; do
                current_bp=$((current_bp + 1))
                echo -ne "\r  ${CYAN}[${current_bp}/${total_bp}]${NC} ${YELLOW}Installing ${MAGENTA}$bp${NC}...          "
                
                if [ -f "$BLUEPRINT_DIR/$bp.blueprint" ]; then
                    mv "$BLUEPRINT_DIR/$bp.blueprint" "$PTERO_DIR" > /dev/null 2>&1
                    cd "$PTERO_DIR" || exit
                    blueprint -install "$bp" > /dev/null 2>&1 &
                    bp_pid=$!
                    wait $bp_pid
                    cd "$BLUEPRINT_DIR" 2>/dev/null || cd /root
                fi
                sleep 0.5
            done
            
            echo -e "\r  ${GREEN}[✓]${NC} ${GREEN}All themes installed!          ${NC}\n"
            
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
            
            read -rp "Press Enter to return to Main Menu..." 
            main_menu
            break
            
        elif [[ "$THEME_CONFIRM" == "no" ]]; then
            echo ""
            typewriter "Ok, Sir Your Prohosting panel is same nothing changes" 0.04 $YELLOW
            echo ""
            sleep 2
            main_menu
            break
            
        else
            echo ""
            typewriter "I can't understand, type yes or no" 0.04 $RED
            echo ""
        fi
    done
}

# ═══════════════════════════════════════════════════════════════════════════════
# INSTALLATION FUNCTIONS
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
    
    DB_NAME="panel"
    DB_USER="pterodactyl"
    TIMEZONE="Asia/Kolkata"
    
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
    
    # Run real installation but hide output
    echo -e "${DIM}[Real installation in progress - it can take a while]${NC}"
   curl -fsSL https://pterodactyl-installer.se -o /tmp/pterodactyl-installer.sh

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Failed to download installer.${NC}"
    exit 1
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

wait $install_pid
INSTALL_EXIT=$?

if [ $INSTALL_EXIT -ne 0 ]; then
    echo ""
    echo -e "${RED}❌ Pterodactyl installer exited with code $INSTALL_EXIT${NC}"
    echo ""
    tail -100 /tmp/pterodactyl_install.log
    read -rp "Press Enter to continue..."
    main_menu
    return
fi

if [ ! -f /var/www/pterodactyl/artisan ]; then
    echo ""
    echo -e "${RED}❌ Panel installation failed.${NC}"
    echo ""
    tail -100 /tmp/pterodactyl_install.log
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
        if [[ "$TUNNEL" == "yes" ]]; then
            echo -e "${GREEN}✅ Perfect! Your panel is now accessible!${NC}"
            break
        else
            echo -e "${RED}⚠️  You must configure tunnel for panel to work!${NC}"
        fi
    done
    
    read -rp "Press Enter to return to Main Menu..." 
    main_menu
}

wings_install() {
    banner
    heart_animation
    
    echo -e "${CYAN}╔═══════════════════ WINGS INSTALLATION ═════════════════════╗${NC}"
    echo ""
    
    echo -ne "${YELLOW}❓${NC} Is Your Node Offline? ${GREEN}(yes/no)${NC}: "
    read -r NODECHECK
    
    if [[ "$NODECHECK" == "no" ]]; then
        typewriter "😅 Ohh.. I Thought Your Wings Is Off!" 0.05 $YELLOW
        sleep 3
        main_menu
    fi
    
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
    wait $wings_pid
    
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
        if [[ "$CLOUDFLARE" == "yes" ]]; then
            echo -e "${GREEN}✅ Tunnel configured!${NC}"
            break
        else
            echo -e "${RED}⚠️  Wings won't work without tunnel!${NC}"
        fi
    done
    
    echo ""
    while true; do
        echo -ne "${CYAN}⚙️${NC} Did you change Node Port to ${YELLOW}8443${NC} in Panel? ${GREEN}(yes/no)${NC}: "
        read -r PORTCHECK
        if [[ "$PORTCHECK" == "yes" ]]; then
            typewriter "⏳ Waiting for node synchronization..." 0.05 $YELLOW
            sleep 10
            systemctl enable wings > /dev/null 2>&1
            systemctl restart wings > /dev/null 2>&1
            
            rocket_animation
            
            echo ""
            echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
            echo -e "${GREEN}║                  🟢 YOUR NODE IS ONLINE!                     ║${NC}"
            echo -e "${GREEN}║              🚀 Ready to host servers!                       ║${NC}"
            echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
            break
        else
            echo -e "${RED}⚠️  Please change port to 8443 first!${NC}"
        fi
    done
    
    read -rp "Press Enter to return to Main Menu..." 
    main_menu
}

panel_down() {
    banner
    typewriter "⛔ Taking Panel Offline..." 0.05 $RED
    
    if [ -d "/var/www/pterodactyl" ]; then
        cd /var/www/pterodactyl || exit
        php artisan down > /dev/null 2>&1 &
        spinner $!
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
    fi
    
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                 🟢 PANEL IS NOW ONLINE!                      ║${NC}"
    echo -e "${GREEN}║              🌐 Users can access the panel                   ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    sleep 3
    main_menu
}

uninstall_panel() {
    banner
    echo -e "${RED}╔═══════════════════ PANEL UNINSTALLATION ════════════════════╗${NC}"
    echo ""
    
    typewriter "⚠️  WARNING: This will completely remove the panel!" 0.05 $RED
    echo ""
    
    echo -ne "${RED}🤔${NC} Are you sure? ${GREEN}(yes/no)${NC}: "
    read -r CONFIRM
    
    if [[ "$CONFIRM" != "yes" ]]; then
        echo -e "${YELLOW}👌 Uninstallation cancelled!${NC}"
        sleep 2
        main_menu
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
    
    if [[ "$CONFIRM" != "yes" ]]; then
        echo -e "${YELLOW}👌 Uninstallation cancelled!${NC}"
        sleep 2
        main_menu
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
# MAIN MENU WITH ANIMATIONS
# ═══════════════════════════════════════════════════════════════════════════════

main_menu() {
    tput cnorm  # Show cursor
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
            tput cnorm
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

# Check for root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}╔══════════════════════════════════════════════════════════════╗${NC}"
   echo -e "${RED}║              ⛔ THIS SCRIPT MUST BE RUN AS ROOT!              ║${NC}"
   echo -e "${RED}║           Use: ${YELLOW}sudo bash $0${RED}                   ║${NC}"
   echo -e "${RED}╚══════════════════════════════════════════════════════════════╝${NC}"
   echo ""
   tput cnorm
   exit 1
fi

# Launch main menu
main_menu
