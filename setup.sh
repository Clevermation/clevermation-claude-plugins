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

# Prüfe Claude Code
if ! command -v claude &> /dev/null; then
    echo -e "${RED}❌ Claude Code nicht gefunden.${NC}"
    echo "Bitte installiere Claude Code zuerst: https://code.claude.com"
    exit 1
fi

echo -e "${GREEN}✅ Claude Code gefunden${NC}\n"

# Prüfe ob im richtigen Projekt-Verzeichnis
echo -e "${YELLOW}📁 Aktuelles Verzeichnis:${NC} $(pwd)"
echo -ne "${YELLOW}→ Bist du im richtigen Projekt-Verzeichnis? (j/n): ${NC}"
read -r CONFIRM_DIR
if [ "$CONFIRM_DIR" != "j" ] && [ "$CONFIRM_DIR" != "J" ]; then
    echo -e "${RED}❌ Bitte wechsle ins richtige Projekt-Verzeichnis und führe das Script erneut aus.${NC}"
    exit 1
fi

# Marketplace hinzufügen
echo -e "\n${YELLOW}📦 Marketplace hinzufügen...${NC}"
if claude plugin marketplace add https://github.com/Clevermation/clevermation-claude-plugins 2>&1 | grep -q "already installed"; then
    echo -e "${GREEN}✅ Marketplace bereits vorhanden${NC}"
else
    echo -e "${GREEN}✅ Marketplace hinzugefügt${NC}"
fi

# Setup-Plugin installieren
echo -e "\n${YELLOW}🔧 Setup-Plugin installieren...${NC}"
claude plugin install clevermation-setup@clevermation-plugins || true

# Standard-Plugins
echo -e "\n${YELLOW}📋 Standard-Plugins installieren:${NC}"
echo -e "  1. Researcher Agent (Web-Recherche)"
echo -e "  2. Plan Agent (Mermaid Diagramme)"
echo -e "  3. Frontend-Test Agent (Playwright)"
echo -ne "${YELLOW}→ Standard-Plugins installieren? (j/n): ${NC}"
read -r INSTALL_STANDARD

if [ "$INSTALL_STANDARD" = "j" ] || [ "$INSTALL_STANDARD" = "J" ]; then
    echo -e "\n${GREEN}Installing...${NC}"
    claude plugin install researcher@clevermation-plugins || echo -e "${RED}❌ Researcher fehlgeschlagen${NC}"
    claude plugin install plan-agent@clevermation-plugins || echo -e "${RED}❌ Plan-Agent fehlgeschlagen${NC}"
    claude plugin install frontend-test@clevermation-plugins || echo -e "${RED}❌ Frontend-Test fehlgeschlagen${NC}"
fi

# Optionale Plugins
echo -e "\n${YELLOW}📋 Optionale Plugins:${NC}"
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
fi

echo -e "\n${GREEN}✅ Setup abgeschlossen!${NC}\n"
echo -e "${BLUE}Nächste Schritte:${NC}"
echo -e "  1. Öffne Claude Code in diesem Projekt"
echo -e "  2. Führe '/setup-clevermation' aus für die vollständige Konfiguration"
echo -e "  3. Das Command führt dich durch Credentials, Model-Auswahl und Projekt-Konfiguration\n"
