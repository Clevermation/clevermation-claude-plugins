#!/bin/bash
# Clevermation Setup Script - Interaktiv
# curl -fsSL https://raw.githubusercontent.com/Clevermation/clevermation-claude-plugins/main/setup.sh | bash

set -e
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

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

# Claude Code Version prüfen und updaten
echo -e "\n${YELLOW}📦 Claude Code Version prüfen...${NC}"
CURRENT_VERSION=$(claude --version 2>/dev/null || echo "unknown")
echo -e "Aktuelle Version: ${CURRENT_VERSION}"

echo -ne "${YELLOW}→ Claude Code auf neueste Version updaten? (j/n): ${NC}"
read -r UPDATE_CLAUDE

if [ "$UPDATE_CLAUDE" = "j" ] || [ "$UPDATE_CLAUDE" = "J" ]; then
    echo -e "${GREEN}Updating Claude Code...${NC}"
    claude update || echo -e "${YELLOW}⚠️ Update fehlgeschlagen oder bereits aktuell${NC}"
fi

# Schritt 2: Projekt-Verzeichnis prüfen
echo -e "\n${YELLOW}📁 Schritt 2: Projekt-Verzeichnis prüfen${NC}\n"
echo -e "Aktuelles Verzeichnis: ${BLUE}$(pwd)${NC}"
echo -ne "${YELLOW}→ Bist du im richtigen Projekt-Verzeichnis? (j/n): ${NC}"
read -r CONFIRM_DIR

if [ "$CONFIRM_DIR" != "j" ] && [ "$CONFIRM_DIR" != "J" ]; then
    echo -e "\n${YELLOW}Du bist nicht im richtigen Projekt-Verzeichnis.${NC}"
    echo -e "${YELLOW}Optionen:${NC}"
    echo -e "  1. Projekt-Verzeichnis-Pfad eingeben"
    echo -e "  2. Script abbrechen und später im richtigen Verzeichnis erneut ausführen"
    echo -ne "${YELLOW}→ Wähle Option (1/2): ${NC}"
    read -r DIR_OPTION
    
    if [ "$DIR_OPTION" = "1" ]; then
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
echo -e "${BLUE}Verfügbare optionale Plugins:${NC}"
echo -e "  1. Supabase (Datenbank, Auth, Storage)"
echo -e "  2. N8N (Workflow-Automation)"
echo -e "  3. Airtable (Tabellen, Formulas)"
echo -e "  4. Frontend (shadcn/ui, Tailwind)"
echo -ne "${YELLOW}→ Welche optionalen Plugins installieren? (z.B. '1,2' oder 'alle' oder 'keine'): ${NC}"
read -r OPTIONAL_CHOICE

if [ "$OPTIONAL_CHOICE" != "keine" ] && [ "$OPTIONAL_CHOICE" != "" ]; then
    if [[ "$OPTIONAL_CHOICE" == *"1"* ]] || [ "$OPTIONAL_CHOICE" = "alle" ]; then
        echo -e "${GREEN}Installing Supabase...${NC}"
        claude plugin install supabase@clevermation-plugins || echo -e "${RED}❌ Supabase fehlgeschlagen${NC}"
    fi
    if [[ "$OPTIONAL_CHOICE" == *"2"* ]] || [ "$OPTIONAL_CHOICE" = "alle" ]; then
        echo -e "${GREEN}Installing N8N...${NC}"
        claude plugin install n8n@clevermation-plugins || echo -e "${RED}❌ N8N fehlgeschlagen${NC}"
    fi
    if [[ "$OPTIONAL_CHOICE" == *"3"* ]] || [ "$OPTIONAL_CHOICE" = "alle" ]; then
        echo -e "${GREEN}Installing Airtable...${NC}"
        claude plugin install airtable@clevermation-plugins || echo -e "${RED}❌ Airtable fehlgeschlagen${NC}"
    fi
    if [[ "$OPTIONAL_CHOICE" == *"4"* ]] || [ "$OPTIONAL_CHOICE" = "alle" ]; then
        echo -e "${GREEN}Installing Frontend...${NC}"
        claude plugin install frontend@clevermation-plugins || echo -e "${RED}❌ Frontend fehlgeschlagen${NC}"
    fi
else
    echo -e "${YELLOW}Keine optionalen Plugins installiert${NC}"
fi

# Zusammenfassung
echo -e "\n${GREEN}╔═══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║${NC}                    ${BLUE}✅ Setup abgeschlossen!${NC}                    ${GREEN}║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════╝${NC}\n"

echo -e "${BLUE}Nächste Schritte:${NC}"
echo -e "  1. Öffne Claude Code in diesem Projekt"
echo -e "  2. Führe '/setup-clevermation' aus für die vollständige Konfiguration:"
echo -e "     • Credentials einrichten"
echo -e "     • Model-Auswahl (Opus/Sonnet/Haiku)"
echo -e "     • Projekt-Konfiguration (PROJECT_RULES.md, PROJECT_CONTEXT.md)"
echo -e "\n${GREEN}Viel Erfolg mit Clevermation!${NC}\n"
