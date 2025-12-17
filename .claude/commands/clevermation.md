---
description: Clevermation Onboarding - Konfiguriere deine Entwicklungsumgebung mit den verfuegbaren Agents und Tools
allowed-tools: Read, Write, AskUser, Bash
---

# Clevermation Onboarding

Willkommen beim Clevermation Onboarding! Ich führe dich jetzt automatisch durch die Einrichtung.

## WICHTIG: Interaktiver Ablauf

Führe diese Schritte **automatisch** und **interaktiv** aus:

### Schritt 1: Marketplace hinzufügen

Füge automatisch das Clevermation Marketplace hinzu:

```bash
/plugin marketplace add clevermation/clevermation-claude-plugins
```

**Falls bereits vorhanden:** Überspringe diesen Schritt.

### Schritt 2: Standard-Plugins automatisch installieren

Installiere automatisch diese Standard-Plugins (keine Credentials nötig):

1. **Researcher Agent** - Web-Recherche mit Firecrawl
2. **Plan Agent** - Architektur-Visualisierung mit Mermaid  
3. **Frontend-Test Agent** - E2E-Testing mit Playwright

Führe aus:
```bash
/plugin install researcher@clevermation-plugins
/plugin install plan-agent@clevermation-plugins
/plugin install frontend-test@clevermation-plugins
```

### Schritt 3: Optionale Plugins auswählen

**Frage den User interaktiv:**

Nutze `AskUser` um zu fragen:

"Welche zusätzlichen Plugins brauchst du für dieses Projekt?

Verfügbare optionale Plugins:
1. **Supabase** - Datenbank, Auth, Storage (benötigt: SUPABASE_URL, SUPABASE_SECRET_KEY, SUPABASE_PUBLISHABLE_KEY)
2. **N8N** - Workflow-Automation (benötigt: N8N_URL, N8N_API_KEY)
3. **Airtable** - Tabellen, Formulas (benötigt: AIRTABLE_API_KEY, AIRTABLE_BASE_ID)
4. **Frontend** - shadcn/ui, Tailwind CSS (keine Credentials)

Bitte wähle aus (z.B. 'Supabase und N8N', 'alle', 'keine'):"

**Basierend auf der Antwort:**
- Installiere die gewählten Plugins mit `/plugin install`
- Frage nach Credentials für jedes gewählte Plugin

### Schritt 4: Credentials einrichten

**Für jedes gewählte Plugin:**

1. **Supabase:**
   - Frage: "SUPABASE_URL?"
   - Frage: "SUPABASE_SECRET_KEY?"
   - Frage: "SUPABASE_PUBLISHABLE_KEY?"

2. **N8N:**
   - Frage: "N8N_URL?"
   - Frage: "N8N_API_KEY?"

3. **Airtable:**
   - Frage: "AIRTABLE_API_KEY?"
   - Frage: "AIRTABLE_BASE_ID?"

**Erstelle `.claude/settings.local.json`:**

Nutze `Write` Tool um die Datei zu erstellen mit allen gesammelten Credentials:

```json
{
  "env": {
    "FIRECRAWL_API_KEY": "...",
    "SUPABASE_URL": "...",
    "SUPABASE_SECRET_KEY": "...",
    "SUPABASE_PUBLISHABLE_KEY": "...",
    "N8N_URL": "...",
    "N8N_API_KEY": "...",
    "AIRTABLE_API_KEY": "...",
    "AIRTABLE_BASE_ID": "..."
  }
}
```

**Wichtig:** Nur die Credentials eintragen, die tatsächlich benötigt werden!

### Schritt 5: Projekt-Setup automatisch starten

**Nach erfolgreicher Plugin-Installation:**

Führe automatisch aus:
```bash
/setup-project
```

Dies startet das interaktive Projekt-Setup, das:
- Projektname abfragt
- Kunde abfragt
- Technologie-Stack abfragt
- Projekt-Typ abfragt
- Besondere Anforderungen abfragt
- `.claude/PROJECT_RULES.md` erstellt
- `.claude/PROJECT_CONTEXT.md` erstellt
- Agents an das Projekt anpasst

## Zusammenfassung nach Abschluss

Zeige dem User eine Zusammenfassung:

"✅ Onboarding abgeschlossen!

**Installiert:**
- Marketplace: clevermation-plugins
- Standard-Plugins: researcher, plan-agent, frontend-test
- Optionale Plugins: [Liste der installierten]
- Credentials: [Anzahl] eingerichtet
- Projekt-Setup: Abgeschlossen

**Nächste Schritte:**
- Teste die Agents: 'Recherchiere Best Practices für Supabase RLS'
- Bei jedem Session-Start prüft ein Hook automatisch deine Credentials
- Viel Erfolg mit Clevermation!"

## Fehlerbehandlung

**Falls Plugin-Installation fehlschlägt:**
- Zeige Fehlermeldung
- Frage ob User manuell installieren möchte
- Fahre mit nächstem Schritt fort

**Falls Credentials fehlen:**
- Erstelle `settings.local.json` trotzdem
- Füge Kommentare hinzu welche Credentials noch fehlen
- Erinnere User diese später hinzuzufügen
