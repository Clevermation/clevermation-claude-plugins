# Clevermation Claude Code Plugins

Claude Code Plugin-System fuer das Clevermation-Team mit spezialisierten Agents, Skills und MCP Server Integrationen.

## 🚀 Schnellstart

**Für lokale Nutzung (Entwicklung/Testing):**

```bash
cd clevermation-claude-plugins
claude .
/clevermation
```

**Für Team-Distribution (GitHub):**

```bash
# 1. Repository auf GitHub hochladen
# 2. Team-Mitglieder fügen hinzu:
/plugin marketplace add clevermation/clevermation-claude-plugins
# 3. Onboarding:
/clevermation
```

📖 **Ausführliche Anleitung:** Siehe [DEPLOYMENT.md](./DEPLOYMENT.md)

## Quick Start

### 1. Marketplace hinzufuegen

```bash
/plugin marketplace add clevermation/clevermation-claude-plugins
```

### 2. Onboarding starten

```bash
/clevermation
```

### 3. Plugins installieren

```bash
# Standard-Plugins (empfohlen)
/plugin install researcher@clevermation-plugins
/plugin install plan-agent@clevermation-plugins
/plugin install frontend-test@clevermation-plugins

# Optionale Plugins
/plugin install supabase@clevermation-plugins
/plugin install n8n@clevermation-plugins
/plugin install airtable@clevermation-plugins
/plugin install frontend@clevermation-plugins
```

## Verfuegbare Agents

### Standard-Agents (keine Konfiguration noetig)

| Agent             | Beschreibung                                 | MCP Server |
| ----------------- | -------------------------------------------- | ---------- |
| **Researcher**    | Web-Recherche, Quellen-Validierung           | Firecrawl  |
| **Plan Agent**    | Mermaid Diagramme (Flow, Sequence, ER, etc.) | -          |
| **Frontend-Test** | E2E-Testing mit Playwright                   | Playwright |

### Optionale Agents (Credentials erforderlich)

| Agent        | Beschreibung                             | Credentials                                                       |
| ------------ | ---------------------------------------- | ----------------------------------------------------------------- |
| **Supabase** | Datenbank, Auth, Storage, Edge Functions | `SUPABASE_URL`, `SUPABASE_SECRET_KEY`, `SUPABASE_PUBLISHABLE_KEY` |
| **N8N**      | Workflow-Automatisierung                 | `N8N_URL`, `N8N_API_KEY`                                          |
| **Airtable** | Tabellen, Formulas, Automations          | `AIRTABLE_API_KEY`, `AIRTABLE_BASE_ID`                            |
| **Frontend** | shadcn/ui, Tailwind CSS                  | -                                                                 |

## Credentials einrichten

Erstelle `.claude/settings.local.json` (wird NICHT committed):

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

## Projektstruktur

Dieses Repository ist ein **Plugin Marketplace** mit mehreren Plugins. Die Struktur folgt der [Claude Code Plugin-Struktur](https://code.claude.com/docs/en/plugins-reference#standard-plugin-layout):

```
clevermation-claude-plugins/          # Marketplace Root
├── .claude-plugin/                   # Plugin Metadata
│   ├── plugin.json                   # Plugin Manifest (definiert Hooks, MCP)
│   └── marketplace.json              # Marketplace Definition (definiert Plugins)
├── .claude/                          # Plugin-Komponenten (Teil des Plugins)
│   ├── commands/                     # Plugin Commands
│   │   ├── clevermation.md          # /clevermation Onboarding
│   │   └── setup-project.md         # /setup-project Projekt-Setup
│   ├── agents/                       # Plugin Agents
│   │   ├── researcher-agent.md
│   │   ├── plan-agent.md
│   │   ├── frontend-test-agent.md
│   │   ├── supabase-agent.md
│   │   ├── n8n-agent.md
│   │   ├── airtable-agent.md
│   │   └── frontend-agent.md
│   ├── skills/                       # Agent Skills
│   │   ├── researcher/
│   │   │   └── SKILL.md             # Pflicht: SKILL.md mit Frontmatter
│   │   ├── mermaid-flowchart/
│   │   │   └── SKILL.md
│   │   ├── playwright/
│   │   │   └── SKILL.md
│   │   ├── supabase-migration/
│   │   │   └── SKILL.md
│   │   └── [weitere Skills...]
│   └── hooks/                        # Plugin Hooks
│       ├── hooks.json                # Hook-Konfiguration (JSON, Pflicht)
│       └── onboarding-check.sh       # Hook-Script
├── .mcp.json                         # MCP Server Konfiguration
├── .claude/                          # Projekt-Settings (nicht Teil des Plugins)
│   ├── settings.json                 # Team-Settings (git-tracked)
│   └── settings.local.json           # Credentials (git-ignored)
├── LICENSE                           # License File
└── README.md                         # Dokumentation
```

### Skill-Struktur Details

Gemäß der [Claude Code Dokumentation](https://code.claude.com/docs/en/plugins-reference#skills) kann jeder Skill folgende Struktur haben:

```
skills/
└── skill-name/
    ├── SKILL.md          # Pflicht: Haupt-Skill-Datei mit Frontmatter
    ├── reference.md      # Optional: Zusätzliche Referenz-Dokumentation
    └── scripts/          # Optional: Skill-spezifische Scripts
        └── helper.sh
```

**Wichtig:**

- `SKILL.md` ist **Pflicht** und muss Frontmatter mit `name` und `description` haben
- `reference.md` ist **optional** - für zusätzliche Referenz-Dokumentation neben SKILL.md
- `scripts/` Ordner ist **optional** - für Skill-spezifische Scripts die vom Skill verwendet werden

**Beispiel:** Ein komplexer Skill könnte so aussehen:

```
skills/
└── supabase-migration/
    ├── SKILL.md              # Haupt-Skill mit Best Practices
    ├── reference.md          # Zusätzliche SQL-Referenz
    └── scripts/
        ├── validate-migration.sh
        └── test-migration.sh
```

### Hook-Struktur Details

Hooks müssen in `hooks/hooks.json` definiert sein (nicht nur als Scripts), gemäß der [Claude Code Dokumentation](https://code.claude.com/docs/en/plugins-reference#hooks):

```
hooks/
├── hooks.json              # Pflicht: Hook-Konfiguration (JSON)
└── onboarding-check.sh     # Optional: Hook-Script
```

Die `hooks.json` Datei definiert welche Hooks ausgeführt werden:

```json
{
  "description": "Hook-Beschreibung",
  "hooks": {
    "SessionStart": [
      {
        "matcher": ".*",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/.claude/hooks/onboarding-check.sh"
          }
        ]
      }
    ]
  }
}
```

**Wichtig:**

- `hooks.json` ist **Pflicht** wenn Hooks verwendet werden
- Scripts sind **optional** - werden von `hooks.json` referenziert
- Nutze `${CLAUDE_PLUGIN_ROOT}` für Plugin-Pfade

## Agent-Nutzung

### Researcher Agent

```
"Recherchiere Best Practices fuer Supabase Row Level Security"
"Finde aktuelle Tutorials zu N8N Webhook-Integration"
"Sammle Informationen ueber Microsoft Power Automate Connectors"
```

### Plan Agent

```
"Erstelle ein Flowchart fuer den Bestellprozess"
"Zeichne ein ER-Diagramm fuer die User-Orders Beziehung"
"Visualisiere den Auth-Flow als Sequence Diagram"
"Erstelle ein Gantt-Diagramm fuer das Projekt"
```

### Frontend-Test Agent

```
"Schreibe einen Playwright Test fuer das Login-Formular"
"Erstelle E2E-Tests fuer den Checkout-Flow"
"Implementiere Visual Regression Tests fuer die Dashboard-Seite"
```

### Supabase Agent

```
"Erstelle das Schema fuer eine Multi-Tenant App"
"Schreibe RLS Policies fuer Team-basierte Zugriffe"
"Implementiere eine Edge Function fuer Webhook-Handling"
```

### N8N Agent

```
"Erstelle einen Workflow fuer E-Mail Benachrichtigungen"
"Baue eine Integration zwischen Airtable und Supabase"
"Automatisiere den Report-Versand jeden Montag"
```

## Skill-Dokumentation

Jeder Agent hat spezialisierte Skills mit detaillierter Referenz:

### Mermaid Skills (pro Diagrammtyp)

- **mermaid-flowchart:** Flowchart Diagramme
- **mermaid-sequence:** Sequence Diagramme
- **mermaid-er:** ER Diagramme
- **mermaid-gantt:** Gantt Charts
- **mermaid-class:** Class Diagramme
- **mermaid-state:** State Diagramme
- **mermaid-pie:** Pie Charts

### Playwright Skills

- **playwright:** MCP Playwright Browser-Automatisierung

### Supabase Skills (pro Bereich)

- **supabase-migration:** Datenbank-Migrationen
- **supabase-auth:** Authentication & User-Management
- **supabase-rls:** Row Level Security Policies
- **supabase-storage:** File-Uploads & Buckets
- **supabase-edge-functions:** Serverless Functions
- **supabase-realtime:** Realtime Subscriptions

### N8N Skills

- **n8n:** Nodes, Expressions, Error Handling
- **n8n-agent-creation:** Komplette AI Agent Node Erstellung (Prompts, Model, Thinking, Structured Output)

### Weitere Skills

- **researcher:** Recherche-Methodik, Quellen-Bewertung
- **airtable:** Formulas, API, Automations
- **shadcn:** Komponenten, Theming, Tailwind Utilities

## Projekt-spezifisches Setup

### Fuer neue Kundenprojekte:

Nutze `/setup-project` um projekt-spezifische Rules und Konfigurationen zu erstellen:

```bash
/setup-project
```

Dies erstellt:

- `.claude/PROJECT_RULES.md` - Projekt-spezifische Rules und Best Practices
- `.claude/PROJECT_CONTEXT.md` - Projekt-Kontext und Architektur-Info
- Aktualisiert `.claude/settings.json` mit projekt-spezifischen Settings
- Passt Agents an das Projekt an

**Workflow:**

1. Neues Projekt klonen/erstellen
2. `/clevermation` ausfuehren (Onboarding)
3. `/setup-project` ausfuehren (Projekt-spezifische Konfiguration)
4. Credentials in `settings.local.json` eintragen
5. Loslegen!

## Team-Distribution

### Fuer neue Team-Mitglieder:

1. Repository klonen
2. Claude Code oeffnen
3. `/clevermation` ausfuehren
4. Credentials in `settings.local.json` eintragen
5. Loslegen!

### Updates verteilen:

```bash
git pull origin main
# Plugins werden automatisch aktualisiert
```

## Best Practices

### Agents

- ✅ Alle Agents haben `capabilities` definiert
- ✅ Klare `description` fuer automatische Delegation
- ✅ Spezifische `tools` nur wenn noetig
- ✅ Projekt-Kontext wird automatisch geladen wenn vorhanden

### Skills

- ✅ Jeder Skill hat Frontmatter mit `name` und `description`
- ✅ Skills sind granular (ein Skill pro Funktionsbereich)
- ✅ Skills enthalten Best Practices und Code-Beispiele

### Commands

- ✅ Commands haben Frontmatter mit `description`
- ✅ Commands nutzen `allowed-tools` fuer Sicherheit
- ✅ Interaktive Commands nutzen `AskUser` Tool

### Hooks

- ✅ Hooks sind in `hooks/hooks.json` oder inline in `settings.json`
- ✅ Hooks nutzen `${CLAUDE_PROJECT_DIR}` fuer projekt-spezifische Scripts
- ✅ SessionStart Hooks fuer Environment-Setup

### Projekt-spezifische Rules

- ✅ `.claude/PROJECT_RULES.md` wird automatisch von Agents geladen
- ✅ `.claude/PROJECT_CONTEXT.md` enthaelt Projekt-Kontext
- ✅ Rules werden in Agent System Prompts integriert

## Support

- **Slack:** #engineering
- **Dokumentation:** Siehe SKILL.md Dateien
- **Issues:** GitHub Repository

---

Erstellt fuer Clevermation mit Claude Code.
