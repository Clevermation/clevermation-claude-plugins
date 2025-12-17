---
description: Clevermation Setup - Konfiguriere deine Entwicklungsumgebung mit Agents, Tools und Model-Auswahl
allowed-tools: Read, Write, AskUser, Bash
---

# Clevermation Setup

Willkommen beim Clevermation Setup! Ich führe dich jetzt automatisch durch die Einrichtung deiner Entwicklungsumgebung.

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

**WICHTIG:** Nutze `Bash` Tool um die Plugin-Installationen auszuführen:

```bash
claude plugin install researcher@clevermation-plugins
claude plugin install plan-agent@clevermation-plugins
claude plugin install frontend-test@clevermation-plugins
```

Führe diese Befehle **automatisch** aus und zeige dem User den Fortschritt.

### Schritt 3: Model-Auswahl

**WICHTIG:** Frage den User nach seinem bevorzugten Claude-Modell:

Nutze `AskUser` um zu fragen:

"Welches Claude-Modell möchtest du primär verwenden?

Verfügbare Modelle:
1. **Opus** - Beste Qualität, ideal für komplexe Aufgaben (DB-Design, komplexe Recherche, Workflow-Design)
2. **Sonnet** - Ausgewogen, gute Balance aus Qualität und Geschwindigkeit (Standard)
3. **Haiku** - Schnell und kostengünstig, für einfache Aufgaben

**Empfehlung:** Opus für komplexe Projekte, Sonnet für Standard-Nutzung

Bitte wähle (Opus/Sonnet/Haiku):"

**Speichere die Auswahl** für spätere Agent-Konfiguration.

**Hinweis:** Einige Agents werden automatisch mit empfohlenen Modellen konfiguriert:
- **Opus empfohlen:** Supabase Agent (komplexe DB-Designs), N8N Agent (komplexe Workflows), Researcher Agent (tiefe Recherche)
- **Inherit (nutzt aktuelles Model):** Plan Agent, Frontend Agent
- **Sonnet Standard:** Frontend-Test Agent, Airtable Agent

### Schritt 4: Optionale Plugins auswählen

**Frage den User interaktiv:**

Nutze `AskUser` um zu fragen:

"Welche zusätzlichen Plugins brauchst du für dieses Projekt?

Verfügbare optionale Plugins:

1. **Supabase** - Datenbank, Auth, Storage (benötigt: SUPABASE_URL, SUPABASE_SECRET_KEY, SUPABASE_PUBLISHABLE_KEY)
2. **N8N** - Workflow-Automation (benötigt: N8N_URL, N8N_API_KEY)
3. **Airtable** - Tabellen, Formulas (benötigt: AIRTABLE_API_KEY, AIRTABLE_BASE_ID)
4. **Frontend** - shadcn/ui, Tailwind CSS (keine Credentials)

Bitte wähle aus (z.B. 'Supabase und N8N', 'alle', 'keine'):"

**WICHTIG:** Parse die Antwort und identifiziere welche Plugins gewählt wurden (Supabase, N8N, Airtable, Frontend).

**Basierend auf der Antwort:**

- Installiere die gewählten Plugins mit `Bash` Tool: `claude plugin install <plugin-name>@clevermation-plugins`
- Frage nach Credentials für **JEDES** gewählte Plugin (auch wenn mehrere gewählt wurden!)

**Beispiel für Plugin-Installation:**
- Wenn Supabase gewählt: `claude plugin install supabase@clevermation-plugins`
- Wenn N8N gewählt: `claude plugin install n8n@clevermation-plugins`
- Wenn Frontend gewählt: `claude plugin install frontend@clevermation-plugins`
- Wenn Airtable gewählt: `claude plugin install airtable@clevermation-plugins`

### Schritt 5: Credentials einrichten

**WICHTIG:** Frage für **JEDES** gewählte Plugin nach den entsprechenden Credentials!

**1. Wenn Supabase gewählt wurde:**

Frage nacheinander:

- "Bitte gib deine SUPABASE_URL ein:"
- "Bitte gib deine SUPABASE_SECRET_KEY ein:"
- "Bitte gib deine SUPABASE_PUBLISHABLE_KEY ein:"

**2. Wenn N8N gewählt wurde:**

Frage nacheinander:

- "Bitte gib deine N8N_URL ein:"
- "Bitte gib deine N8N_API_KEY ein:"

**3. Wenn Airtable gewählt wurde:**

Frage nacheinander:

- "Bitte gib deine AIRTABLE_API_KEY ein:"
- "Bitte gib deine AIRTABLE_BASE_ID ein:"

**4. Standard-MCP Credentials:**

Frage auch nach:

- "Bitte gib deine FIRECRAWL_API_KEY ein (für Researcher Agent):"

**Erstelle `.claude/settings.local.json`:**

Nutze `Write` Tool um die Datei zu erstellen mit **allen** gesammelten Credentials:

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

**Wichtig:**

- Nur die Credentials eintragen, die tatsächlich benötigt werden!
- Wenn Plugin gewählt wurde, MUSS es auch Credentials haben (außer Frontend)

### Schritt 6: MCP-Verifikation

**Nach Credentials-Einrichtung:**

Prüfe ob die MCP Server funktionieren:

**1. Firecrawl MCP (für Researcher Agent):**

- Prüfe ob `FIRECRAWL_API_KEY` gesetzt ist
- Versuche ein einfaches Tool zu nutzen (z.B. `firecrawl_search` mit einer einfachen Query)
- Falls erfolgreich: ✅ Firecrawl MCP funktioniert
- Falls Fehler: ⚠️ Firecrawl MCP hat Probleme - prüfe API Key

**2. Playwright MCP (für Frontend-Test Agent):**

- Prüfe ob Playwright MCP verfügbar ist
- Versuche `browser_navigate` Tool zu nutzen (z.B. zu "https://example.com")
- Falls erfolgreich: ✅ Playwright MCP funktioniert
- Falls Fehler: ⚠️ Playwright MCP hat Probleme - möglicherweise muss npx installiert werden

**3. Supabase MCP (falls Supabase gewählt wurde):**

- Prüfe ob `SUPABASE_URL` und `SUPABASE_SECRET_KEY` gesetzt sind
- Versuche ein einfaches Tool zu nutzen (z.B. `list_tables`)
- Falls erfolgreich: ✅ Supabase MCP funktioniert
- Falls Fehler: ⚠️ Supabase MCP hat Probleme - prüfe Credentials

**4. N8N MCP (falls N8N gewählt wurde):**

- Prüfe ob `N8N_URL` und `N8N_API_KEY` gesetzt sind
- Versuche ein einfaches Tool zu nutzen (z.B. `list_workflows`)
- Falls erfolgreich: ✅ N8N MCP funktioniert
- Falls Fehler: ⚠️ N8N MCP hat Probleme - prüfe Credentials und URL

**Zeige Verifikations-Ergebnisse:**

Erstelle eine Zusammenfassung:

```
MCP-Verifikation:
✅ Firecrawl MCP - Funktioniert
✅ Playwright MCP - Funktioniert
✅ Supabase MCP - Funktioniert
⚠️ N8N MCP - Probleme (prüfe Credentials)
```

### Schritt 7: Agent-Model-Konfiguration

**Nach Model-Auswahl:**

Konfiguriere die Agents basierend auf der gewählten Model-Präferenz:

**Erstelle/aktualisiere `.claude/settings.json` mit Model-Konfiguration:**

```json
{
  "agents": {
    "defaultModel": "sonnet",
    "modelPreferences": {
      "supabase-agent": "opus",
      "n8n-agent": "opus",
      "researcher-agent": "opus",
      "plan-agent": "inherit",
      "frontend-test-agent": "sonnet",
      "frontend-agent": "inherit",
      "airtable-agent": "sonnet"
    }
  }
}
```

**WICHTIG:** 
- Wenn User Opus gewählt hat: Setze `defaultModel` auf `opus` und aktualisiere die Preferences entsprechend
- Wenn User Sonnet gewählt hat: Behalte Standard-Konfiguration
- Wenn User Haiku gewählt hat: Setze `defaultModel` auf `haiku` für alle Agents

**Speichere die Konfiguration** für spätere Nutzung.

### Schritt 8: Projekt-Konfiguration automatisch starten

**Nach erfolgreicher Plugin-Installation und MCP-Verifikation:**

**WICHTIG:** Führe die Projekt-Konfiguration **direkt hier durch**, nicht als separates Command!

Frage den User interaktiv nach:

1. **Projektname** - "Wie lautet der Projektname?"
2. **Kunde** - "Wer ist der Kunde für dieses Projekt?"
3. **Technologie-Stack** - "Welcher Technologie-Stack wird verwendet?"
4. **Projekt-Typ** - "Um welchen Projekt-Typ handelt es sich? (Web-App, API, Internes Tool, etc.)"
5. **Besondere Anforderungen** - "Gibt es besondere Anforderungen oder Constraints?"

**Dann erstelle:**

1. **`.claude/PROJECT_RULES.md`** mit:
   - Projekt-Info (Name, Kunde, Typ, Tech Stack)
   - Entwicklungs-Konventionen
   - Code-Stil-Richtlinien
   - Git-Workflow
   - Testing-Anforderungen
   - Agent-Nutzung (wann welcher Agent)

2. **`.claude/PROJECT_CONTEXT.md`** mit:
   - Projekt-Übersicht
   - Technologie-Stack Details
   - Projekt-Struktur (automatisch erkennen mit `Read` und `Glob`)
   - Wichtige Kontexte
   - Zielgruppe
   - Hauptfunktionen
   - Agent-Kontext

**WICHTIG:** 
- Nutze `Read` und `Glob` um die Projekt-Struktur zu analysieren
- Erstelle sinnvolle, projekt-spezifische Rules basierend auf dem Tech Stack
- Füge keine generischen/leeren Inhalte hinzu

## Zusammenfassung nach Abschluss

Zeige dem User eine Zusammenfassung:

"✅ Onboarding abgeschlossen!

**Installiert:**

- Marketplace: clevermation-plugins
- Standard-Plugins: researcher, plan-agent, frontend-test
- Optionale Plugins: [Liste der installierten]
- Credentials: [Anzahl] eingerichtet

**MCP-Verifikation:**
[MCP-Verifikations-Ergebnisse]

**Projekt-Setup:**

- Abgeschlossen

**Model-Konfiguration:**
- Standard-Model: [Gewähltes Model]
- Agent-Models: [Liste der konfigurierten Agent-Models]

**Nächste Schritte:**

- Teste die Agents: 'Recherchiere Best Practices für Supabase RLS'
- Bei jedem Session-Start prüft ein Hook automatisch deine Credentials
- Model-Einstellungen können in `.claude/settings.json` angepasst werden
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

**Falls MCP-Verifikation fehlschlägt:**

- Zeige welche MCPs Probleme haben
- Gib Hinweise zur Fehlerbehebung
- Fahre trotzdem mit Projekt-Setup fort (MCPs können später konfiguriert werden)
