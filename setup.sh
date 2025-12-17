#!/bin/bash
# Clevermation Setup Script - Interaktiv mit Pfeiltasten-Navigation
# curl -fsSL https://raw.githubusercontent.com/Clevermation/clevermation-claude-plugins/main/setup.sh | bash

set -e
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

# Arrow key navigation function
arrow_menu() {
    local prompt="$1"
    shift
    local options=("$@")
    local selected=0
    local count=${#options[@]}
    
    while true; do
        clear
        echo -e "${BLUE}╔═══════════════════════════════════════════════════════════════╗${NC}"
        echo -e "${BLUE}║${NC}     ${GREEN}Clevermation Claude Code Plugins - Setup${NC}              ${BLUE}║${NC}"
        echo -e "${BLUE}╚═══════════════════════════════════════════════════════════════╝${NC}\n"
        echo -e "${CYAN}${prompt}${NC}"
        echo ""
        
        for i in "${!options[@]}"; do
            if [ $i -eq $selected ]; then
                echo -e "${GREEN}▶ ${options[i]}${NC}"
            else
                echo -e "  ${options[i]}"
            fi
        done
        
        echo ""
        echo -e "${YELLOW}Verwende ↑/↓ zum Navigieren, Enter zum Auswählen${NC}"
        
        read -rsn1 key
        case "$key" in
            $'\x1b')
                read -rsn1 -t 0.1 tmp
                if [[ "$tmp" == "[" ]]; then
                    read -rsn1 -t 0.1 tmp
                    case "$tmp" in
                        "A") # Up arrow
                            selected=$((selected - 1))
                            [ $selected -lt 0 ] && selected=$((count - 1))
                            ;;
                        "B") # Down arrow
                            selected=$((selected + 1))
                            [ $selected -ge $count ] && selected=0
                            ;;
                    esac
                fi
                ;;
            "")
                echo $selected
                return
                ;;
        esac
    done
}

# Simple yes/no menu
yes_no_menu() {
    local prompt="$1"
    local options=("Ja" "Nein")
    local result=$(arrow_menu "$prompt" "${options[@]}")
    [ "$result" = "0" ] && echo "j" || echo "n"
}

clear
echo -e "${BLUE}╔═══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${NC}     ${GREEN}Clevermation Claude Code Plugins - Setup${NC}              ${BLUE}║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════════════════════════════╝${NC}\n"

# Schritt 1: Claude Code Installation prüfen
echo -e "${YELLOW}🔍 Schritt 1: Claude Code Installation prüfen${NC}\n"

if ! command -v claude &> /dev/null; then
    echo -e "${RED}❌ Claude Code ist nicht installiert.${NC}"
    echo -e "${YELLOW}→ Bitte installiere Claude Code zuerst:${NC} https://code.claude.com"
    exit 1
fi

echo -e "${GREEN}✅ Claude Code ist installiert${NC}"

# Claude Code Version prüfen und automatisch updaten
echo -e "\n${YELLOW}📦 Claude Code Version prüfen...${NC}"
CURRENT_VERSION=$(claude --version 2>/dev/null || echo "unknown")
echo -e "Aktuelle Version: ${CURRENT_VERSION}"

echo -e "${GREEN}→ Claude Code wird automatisch auf neueste Version aktualisiert...${NC}"
claude update 2>/dev/null || echo -e "${YELLOW}⚠️ Update fehlgeschlagen oder bereits aktuell${NC}"

# Schritt 2: Projekt-Verzeichnis prüfen
echo -e "\n${YELLOW}📁 Schritt 2: Projekt-Verzeichnis prüfen${NC}\n"
echo -e "Aktuelles Verzeichnis: ${BLUE}$(pwd)${NC}"

RESULT=$(yes_no_menu "Bist du im richtigen Projekt-Verzeichnis?")

if [ "$RESULT" != "j" ]; then
    clear
    echo -e "${BLUE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC}     ${GREEN}Clevermation Claude Code Plugins - Setup${NC}              ${BLUE}║${NC}"
    echo -e "${BLUE}╚═══════════════════════════════════════════════════════════════╝${NC}\n"
    echo -e "${YELLOW}Du bist nicht im richtigen Projekt-Verzeichnis.${NC}\n"
    
    DIR_OPTIONS=("Projekt-Verzeichnis-Pfad eingeben" "Script abbrechen")
    DIR_CHOICE=$(arrow_menu "Was möchtest du tun?" "${DIR_OPTIONS[@]}")
    
    if [ "$DIR_CHOICE" = "0" ]; then
        echo -ne "${YELLOW}→ Gib den vollständigen Pfad zum Projekt-Verzeichnis ein: ${NC}"
        read -r PROJECT_PATH
        
        if [ -d "$PROJECT_PATH" ]; then
            echo -e "${GREEN}Wechsle zu: ${PROJECT_PATH}${NC}"
            cd "$PROJECT_PATH" || exit 1
            echo -e "${GREEN}✅ Jetzt im Projekt-Verzeichnis: $(pwd)${NC}"
        else
            echo -e "${RED}❌ Verzeichnis nicht gefunden: ${PROJECT_PATH}${NC}"
            exit 1
        fi
    else
        echo -e "\n${YELLOW}Script abgebrochen.${NC}"
        echo -e "${BLUE}Bitte führe das Script im richtigen Projekt-Verzeichnis erneut aus.${NC}"
        exit 0
    fi
else
    echo -e "${GREEN}✅ Im richtigen Projekt-Verzeichnis${NC}"
fi

# Schritt 3: Marketplace hinzufügen
echo -e "\n${YELLOW}📦 Schritt 3: Marketplace hinzufügen${NC}\n"

if claude plugin marketplace add https://github.com/Clevermation/clevermation-claude-plugins 2>&1 | grep -q "already installed"; then
    echo -e "${GREEN}✅ Marketplace bereits vorhanden${NC}"
else
    echo -e "${GREEN}✅ Marketplace hinzugefügt${NC}"
fi

# Schritt 4: Setup-Plugin installieren
echo -e "\n${YELLOW}🔧 Schritt 4: Setup-Plugin installieren${NC}\n"
claude plugin install clevermation-setup@clevermation-plugins || echo -e "${YELLOW}⚠️ Setup-Plugin bereits installiert${NC}"

# Schritt 5: Standard-Plugins automatisch installieren
echo -e "\n${YELLOW}📋 Schritt 5: Standard-Plugins installieren${NC}\n"
echo -e "${GREEN}Installiere automatisch:${NC}"
echo -e "  • Researcher Agent (Web-Recherche)"
echo -e "  • Plan Agent (Mermaid Diagramme)"
echo -e "  • Frontend-Test Agent (Playwright)"

claude plugin install researcher@clevermation-plugins || echo -e "${RED}❌ Researcher fehlgeschlagen${NC}"
claude plugin install plan-agent@clevermation-plugins || echo -e "${RED}❌ Plan-Agent fehlgeschlagen${NC}"
claude plugin install frontend-test@clevermation-plugins || echo -e "${RED}❌ Frontend-Test fehlgeschlagen${NC}"

# Schritt 6: Optionale Plugins
echo -e "\n${YELLOW}📋 Schritt 6: Optionale Plugins${NC}\n"

OPTIONAL_PLUGINS=(
    "Supabase (Datenbank, Auth, Storage)"
    "N8N (Workflow-Automation)"
    "Airtable (Tabellen, Formulas)"
    "Frontend (shadcn/ui, Tailwind)"
    "Alle installieren"
    "Keine installieren"
)

SELECTED_PLUGINS=$(arrow_menu "Welche optionalen Plugins installieren?" "${OPTIONAL_PLUGINS[@]}")

case "$SELECTED_PLUGINS" in
    0)
        echo -e "${GREEN}Installing Supabase...${NC}"
        claude plugin install supabase@clevermation-plugins || echo -e "${RED}❌ Supabase fehlgeschlagen${NC}"
        ;;
    1)
        echo -e "${GREEN}Installing N8N...${NC}"
        claude plugin install n8n@clevermation-plugins || echo -e "${RED}❌ N8N fehlgeschlagen${NC}"
        ;;
    2)
        echo -e "${GREEN}Installing Airtable...${NC}"
        claude plugin install airtable@clevermation-plugins || echo -e "${RED}❌ Airtable fehlgeschlagen${NC}"
        ;;
    3)
        echo -e "${GREEN}Installing Frontend...${NC}"
        claude plugin install frontend@clevermation-plugins || echo -e "${RED}❌ Frontend fehlgeschlagen${NC}"
        ;;
    4)
        echo -e "${GREEN}Installing alle optionalen Plugins...${NC}"
        claude plugin install supabase@clevermation-plugins || echo -e "${RED}❌ Supabase fehlgeschlagen${NC}"
        claude plugin install n8n@clevermation-plugins || echo -e "${RED}❌ N8N fehlgeschlagen${NC}"
        claude plugin install airtable@clevermation-plugins || echo -e "${RED}❌ Airtable fehlgeschlagen${NC}"
        claude plugin install frontend@clevermation-plugins || echo -e "${RED}❌ Frontend fehlgeschlagen${NC}"
        ;;
    5)
        echo -e "${YELLOW}Keine optionalen Plugins installiert${NC}"
        ;;
esac

# Zusammenfassung
clear
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║${NC}                    ${BLUE}✅ Setup abgeschlossen!${NC}                    ${GREEN}║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════╝${NC}\n"

echo -e "${BLUE}Nächste Schritte:${NC}"
echo -e "  1. Öffne Claude Code in diesem Projekt"
echo -e "  2. Führe '/setup-clevermation' aus für die vollständige Konfiguration:"
echo -e "     • Credentials einrichten"
echo -e "     • Model-Auswahl (Opus/Sonnet/Haiku)"
echo -e "     • Projekt-Konfiguration (PROJECT_RULES.md, PROJECT_CONTEXT.md)"
echo -e "\n${GREEN}Viel Erfolg mit Clevermation!${NC}\n"
