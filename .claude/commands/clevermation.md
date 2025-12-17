---
description: Clevermation Onboarding - Konfiguriere deine Entwicklungsumgebung mit den verfuegbaren Agents und Tools
allowed-tools: Read, Write, AskUser
---

# Willkommen bei Clevermation!

Ich helfe dir, deine Claude Code Umgebung fuer die Arbeit mit Clevermation einzurichten.

## Was ist dieses Plugin?

Das Clevermation Claude Code Plugin bietet spezialisierte Agents, Skills und MCP Server Integrationen fuer effiziente Entwicklung und Automatisierung.

## Wie funktioniert dieser Command?

Dieser Command führt dich interaktiv durch das Onboarding:

1. **Marketplace hinzufügen** - Fügt das Clevermation Marketplace hinzu
2. **Plugins installieren** - Installiert die gewünschten Plugins
3. **Credentials einrichten** - Hilft beim Erstellen von `settings.local.json`
4. **Plugins aktivieren** - Aktiviert die installierten Plugins
5. **Test-Beispiele** - Zeigt wie Agents genutzt werden

**Nach dem Onboarding:**

- Bei jedem Session-Start wird automatisch ein Hook ausgeführt
- Der Hook prüft ob Credentials gesetzt sind
- Zeigt entsprechende Hinweise falls etwas fehlt

## Onboarding: Schritt-fuer-Schritt

### Schritt 1: Marketplace hinzufuegen

Falls noch nicht geschehen, fuege das Clevermation Marketplace hinzu:

```bash
/plugin marketplace add clevermation/clevermation-claude-plugins
```

### Schritt 2: Plugins installieren

#### Standard-Plugins (sofort einsatzbereit)

Diese Plugins benoetigen keine zusaetzliche Konfiguration:

```bash
/plugin install researcher@clevermation-plugins
/plugin install plan-agent@clevermation-plugins
/plugin install frontend-test@clevermation-plugins
```

**Verfuegbare Standard-Agents:**

- **Researcher Agent** - Web-Recherche mit Firecrawl
- **Plan Agent** - Architektur-Visualisierung mit Mermaid
- **Frontend-Test Agent** - E2E-Testing mit Playwright

#### Optionale Plugins (benoetigen Credentials)

Diese Plugins benoetigen zusaetzliche Konfiguration:

```bash
/plugin install supabase@clevermation-plugins
/plugin install n8n@clevermation-plugins
/plugin install airtable@clevermation-plugins
/plugin install frontend@clevermation-plugins
```

### Schritt 3: Credentials einrichten (fuer optionale Plugins)

Erstelle eine Datei `.claude/settings.local.json` im Projekt-Root:

```json
{
  "env": {
    "FIRECRAWL_API_KEY": "fc-xxx",
    "SUPABASE_URL": "https://xxx.supabase.co",
    "SUPABASE_SECRET_KEY": "sb_xxx",
    "SUPABASE_PUBLISHABLE_KEY": "sb_publishable_xxx",
    "N8N_URL": "https://n8n.example.com",
    "N8N_API_KEY": "xxx",
    "AIRTABLE_API_KEY": "patXXX",
    "AIRTABLE_BASE_ID": "appXXX"
  }
}
```

**Wichtig:**

- Diese Datei ist in `.gitignore` und wird NICHT committed!
- Nur die Credentials eintragen, die du benoetigst

### Schritt 4: Plugins aktivieren/deaktivieren

#### Plugin aktivieren

```bash
/plugin enable plugin-name@clevermation-plugins
```

#### Plugin deaktivieren (ohne zu deinstallieren)

```bash
/plugin disable plugin-name@clevermation-plugins
```

#### Plugin komplett entfernen

```bash
/plugin uninstall plugin-name@clevermation-plugins
```

#### Alle installierten Plugins anzeigen

```bash
/plugin
```

### Schritt 5: Agents nutzen

Nach der Installation kannst du die Agents direkt nutzen:

**Researcher Agent:**

```
"Recherchiere Best Practices fuer Supabase Row Level Security"
```

**Plan Agent:**

```
"Erstelle ein Flowchart fuer den Bestellprozess"
```

**Frontend-Test Agent:**

```
"Schreibe einen Playwright Test fuer das Login-Formular"
```

## Verfuegbare Agents

### Standard-Agents (keine Konfiguration noetig)

| Agent             | Beschreibung                                 | MCP Server |
| ----------------- | -------------------------------------------- | ---------- |
| **Researcher**    | Web-Recherche, Quellen-Validierung           | Firecrawl  |
| **Plan Agent**    | Mermaid Diagramme (Flow, Sequence, ER, etc.) | -          |
| **Frontend-Test** | E2E-Testing mit Playwright                   | Playwright |

### Optionale Agents (Credentials erforderlich)

| Agent        | Beschreibung                             | Benoetigte Credentials                                            |
| ------------ | ---------------------------------------- | ----------------------------------------------------------------- |
| **Supabase** | Datenbank, Auth, Storage, Edge Functions | `SUPABASE_URL`, `SUPABASE_SECRET_KEY`, `SUPABASE_PUBLISHABLE_KEY` |
| **N8N**      | Workflow-Automatisierung                 | `N8N_URL`, `N8N_API_KEY`                                          |
| **Airtable** | Tabellen, Formulas, Automations          | `AIRTABLE_API_KEY`, `AIRTABLE_BASE_ID`                            |
| **Frontend** | shadcn/ui, Tailwind CSS                  | -                                                                 |

## Skills erkunden

Jeder Agent hat spezialisierte Skills mit detaillierter Dokumentation:

### Mermaid Skills (pro Diagrammtyp)

- `mermaid-flowchart`, `mermaid-sequence`, `mermaid-er`, `mermaid-gantt`, `mermaid-class`, `mermaid-state`, `mermaid-pie`

### Supabase Skills (pro Bereich)

- `supabase-migration`, `supabase-auth`, `supabase-rls`, `supabase-storage`, `supabase-edge-functions`, `supabase-realtime`

### N8N Skills

- `n8n-agent-creation` - Komplette AI Agent Node Erstellung

### Weitere Skills

- `researcher`, `playwright`, `airtable`, `shadcn`

## Neues Projekt einrichten

### Bei einem neuen Projekt:

1. **Repository klonen** oder Projekt erstellen
2. **Claude Code oeffnen** im Projekt-Verzeichnis
3. **Marketplace hinzufuegen:**
   ```bash
   /plugin marketplace add clevermation/clevermation-claude-plugins
   ```
4. **Plugins installieren** die du benoetigst:
   ```bash
   /plugin install researcher@clevermation-plugins
   /plugin install plan-agent@clevermation-plugins
   # ... weitere Plugins
   ```
5. **Credentials einrichten** (falls noetig):
   - Erstelle `.claude/settings.local.json`
   - Trage benoetigte Credentials ein
6. **Testen:** Probiere einen Agent aus

## Hilfe & Support

- **Agent-Uebersicht:** `/agents` zeigt alle verfuegbaren Agents
- **Plugin-Management:** `/plugin` zeigt installierte Plugins
- **Skill-Dokumentation:** Lies die SKILL.md Dateien fuer Details
- **Team-Kanal:** #engineering auf Slack

## Projekt-spezifisches Setup (fuer Kundenprojekte)

Nach dem Onboarding kannst du projekt-spezifische Rules erstellen:

```bash
/setup-project
```

Dies erstellt:

- `.claude/PROJECT_RULES.md` - Projekt-spezifische Rules
- `.claude/PROJECT_CONTEXT.md` - Projekt-Kontext
- Passt Agents an das Projekt an

**Wichtig:** Projekt-spezifische Rules werden automatisch von allen Agents geladen!

## Naechste Schritte

1. **Standard-Agents testen:**

   - "Recherchiere Best Practices fuer Supabase RLS"
   - "Erstelle ein Flowchart fuer einen Bestellprozess"
   - "Schreibe einen Playwright Test fuer das Login-Formular"

2. **Optionale Agents aktivieren:**

   - Erstelle `.claude/settings.local.json` mit Credentials
   - Installiere benoetigte Plugins

3. **Projekt-spezifisches Setup (fuer Kundenprojekte):**

   - Fuehre `/setup-project` aus
   - Definiere projekt-spezifische Rules
   - Agents werden automatisch angepasst

4. **Skills erkunden:**
   - Jeder Agent hat spezialisierte Skills
   - Skills enthalten detaillierte Best Practices

Viel Erfolg mit Clevermation!
