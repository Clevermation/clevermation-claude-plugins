#!/bin/bash
# Clevermation Setup Script
# curl -fsSL https://raw.githubusercontent.com/Clevermation/clevermation-claude-plugins/main/setup.sh | bash

set -e
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}Clevermation Setup${NC}\n"

# Prüfe Claude Code
if ! command -v claude &> /dev/null; then
    echo "❌ Claude Code nicht gefunden. Bitte installiere Claude Code zuerst."
    exit 1
fi

echo "✅ Claude Code gefunden"

# Marketplace hinzufügen
echo -e "\n${YELLOW}Marketplace hinzufügen...${NC}"
claude plugin marketplace add https://github.com/Clevermation/clevermation-claude-plugins || true

# Setup-Plugin installieren
echo -e "\n${YELLOW}Setup-Plugin installieren...${NC}"
claude plugin install clevermation-setup@clevermation-plugins

# Standard-Plugins installieren
echo -e "\n${YELLOW}Standard-Plugins installieren...${NC}"
claude plugin install researcher@clevermation-plugins
claude plugin install plan-agent@clevermation-plugins
claude plugin install frontend-test@clevermation-plugins

echo -e "\n${GREEN}✅ Setup abgeschlossen!${NC}"
echo "Führe jetzt '/setup-clevermation' in Claude Code aus für die vollständige Konfiguration."
