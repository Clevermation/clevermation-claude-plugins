#!/bin/bash
# Clevermation Onboarding Check Hook
# Wird bei Session-Start ausgefuehrt

# JSON Input lesen
read input

# Pruefe ob settings.local.json existiert
if [ ! -f ".claude/settings.local.json" ]; then
  echo '{"message": "Willkommen! Nutze /clevermation fuer das Onboarding und richte deine Credentials ein.", "level": "info"}'
  exit 0
fi

# Pruefe ob wichtige Credentials gesetzt sind
local_settings=$(cat .claude/settings.local.json 2>/dev/null)

# Pruefe Firecrawl (fuer Researcher Agent)
if ! echo "$local_settings" | grep -q "FIRECRAWL_API_KEY"; then
  echo '{"message": "Hinweis: FIRECRAWL_API_KEY nicht gesetzt. Researcher Agent hat eingeschraenkte Funktionalitaet.", "level": "warning"}'
fi

exit 0
