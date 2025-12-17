# Quick Start - Plugin in neuem Projekt aktivieren

## Schritt-für-Schritt Anleitung

### Voraussetzungen

- Claude Code installiert
- Zugriff auf GitHub (falls Plugin dort veröffentlicht ist)
- Oder: Lokales Plugin-Repository verfügbar

---

## Option 1: Plugin von GitHub nutzen (Team-Nutzung)

### Voraussetzung: Repository muss öffentlich sein

**WICHTIG:** Das Repository muss auf GitHub **öffentlich** sein, damit es ohne Authentifizierung genutzt werden kann.

Falls das Repository privat ist:
- **Option A:** Repository öffentlich machen (empfohlen für Plugins)
- **Option B:** Lokale Nutzung verwenden (siehe Option 2 unten)
- **Option C:** GitHub Personal Access Token konfigurieren

### Schritt 1: Marketplace hinzufügen

Öffne Claude Code in deinem neuen Projekt und führe aus:

**Für öffentliches Repository:**

```bash
/plugin marketplace add https://github.com/clevermation/clevermation-claude-plugins
```

**Für privates Repository (mit Token):**

1. Erstelle GitHub Personal Access Token (Settings > Developer settings > Personal access tokens)
2. Nutze Token in URL:
```bash
/plugin marketplace add https://TOKEN@github.com/clevermation/clevermation-claude-plugins
```

**⚠️ Empfehlung:** Mache das Repository öffentlich für einfachere Team-Nutzung!

### Schritt 2: Setup-Plugin installieren

**WICHTIG:** Das Setup-Plugin muss installiert werden, damit die Commands verfügbar sind:

```bash
/plugin install clevermation-setup@clevermation-plugins
```

### Schritt 3: Setup starten

```bash
/setup-clevermation
```

Das Command führt dich interaktiv durch:
1. ✅ Marketplace hinzufügen (automatisch)
2. ✅ Standard-Plugins installieren (automatisch)
3. ✅ Model-Auswahl (Opus/Sonnet/Haiku)
4. ✅ Optionale Plugins auswählen (Supabase, N8N, etc.)
5. ✅ Credentials einrichten
6. ✅ MCP-Verifikation
7. ✅ Agent-Model-Konfiguration
8. ✅ Projekt-Konfiguration starten (`/configure-project`)

### Schritt 3: Projekt-spezifische Konfiguration

Nach dem Setup wird automatisch `/configure-project` gestartet:

```bash
/configure-project
```

Dies fragt nach:
- Projektname
- Kunde
- Technologie-Stack
- Projekt-Typ
- Besondere Anforderungen
- Model-Präferenz für dieses Projekt

**Ergebnis:**
- `.claude/PROJECT_RULES.md` - Projekt-spezifische Rules
- `.claude/PROJECT_CONTEXT.md` - Projekt-Kontext
- `.claude/settings.json` - Aktualisiert mit Projekt-Infos

---

## Option 2: Lokales Plugin nutzen (Entwicklung/Privates Repository)

**Diese Option funktioniert ohne GitHub-Authentifizierung!**

### Schritt 1: Plugin-Verzeichnis klonen/öffnen

```bash
# Falls noch nicht vorhanden, klone das Repository lokal:
cd ~/Desktop/Jonne_Felix/Clevermation/Intern
git clone https://github.com/clevermation/clevermation-claude-plugins.git
# Oder falls bereits vorhanden:
cd clevermation-claude-plugins
```

### Schritt 2: In neuem Projekt Plugin referenzieren

**Methode 1: Symlink (empfohlen für Entwicklung)**

```bash
# Im neuen Projekt (z.B. Milkyway)
cd ~/Desktop/Jonne_Felix/Clevermation/Intern/Milkyway
ln -s ~/Desktop/Jonne_Felix/Clevermation/Intern/clevermation-claude-plugins/.claude .claude-plugin
```

**Methode 2: Plugin-Verzeichnis kopieren**

```bash
# Im neuen Projekt
cd ~/Desktop/Jonne_Felix/Clevermation/Intern/Milkyway
cp -r ~/Desktop/Jonne_Felix/Clevermation/Intern/clevermation-claude-plugins/.claude .claude-plugin
```

**Methode 3: Direkt im Plugin-Verzeichnis arbeiten**

```bash
# Öffne Claude Code direkt im Plugin-Verzeichnis
cd ~/Desktop/Jonne_Felix/Clevermation/Intern/clevermation-claude-plugins
claude .
```

### Schritt 3: Setup starten

```bash
/setup-clevermation
```

**Vorteil:** Funktioniert sofort ohne GitHub-Authentifizierung!

---

## Was passiert beim Setup?

### Automatisch installiert:

1. **Marketplace** - Clevermation Plugin Marketplace wird hinzugefügt
2. **Standard-Plugins:**
   - `researcher` - Web-Recherche mit Firecrawl
   - `plan-agent` - Mermaid Diagramme
   - `frontend-test` - E2E-Testing mit Playwright

### Interaktiv konfiguriert:

1. **Model-Auswahl** - Opus/Sonnet/Haiku
2. **Optionale Plugins** - Supabase, N8N, Airtable, Frontend
3. **Credentials** - API Keys für gewählte Plugins
4. **MCP-Verifikation** - Prüft ob MCPs funktionieren
5. **Agent-Models** - Konfiguriert Model-Präferenzen

### Erstellt:

- `.claude/settings.local.json` - Lokale Credentials (nicht committed)
- `.claude/settings.json` - Agent-Model-Konfiguration
- `.claude/PROJECT_RULES.md` - Projekt-spezifische Rules (nach `/configure-project`)
- `.claude/PROJECT_CONTEXT.md` - Projekt-Kontext (nach `/configure-project`)

---

## Nach dem Setup

### Agents nutzen

Die Agents sind jetzt verfügbar und können direkt genutzt werden:

```
"Recherchiere Best Practices für Supabase RLS"
"Erstelle ein ER-Diagramm für eine E-Commerce Datenbank"
"Teste den Login-Flow auf https://example.com"
```

### Commands verfügbar

- `/setup-clevermation` - Setup erneut ausführen
- `/configure-project` - Projekt-Konfiguration anpassen

### Hooks aktiv

Bei jedem Session-Start wird automatisch geprüft:
- Sind Credentials gesetzt?
- Funktionieren MCPs?
- Zeigt entsprechende Hinweise

---

## Troubleshooting

### Plugin wird nicht gefunden

**Problem:** `/setup-clevermation` funktioniert nicht

**Lösung:**
1. Prüfe ob Marketplace hinzugefügt wurde:
   ```bash
   /plugin marketplace list
   ```
2. Füge Marketplace manuell hinzu (nutze HTTPS-URL):
   ```bash
   /plugin marketplace add https://github.com/clevermation/clevermation-claude-plugins
   ```

### Authentifizierungsfehler (SSH oder HTTPS)

**Problem:** `Permission denied` oder `could not read Username` beim Hinzufügen des Marketplaces

**Ursache:** Das Repository ist privat oder benötigt Authentifizierung.

**Lösungen:**

1. **Repository öffentlich machen (empfohlen):**
   - Gehe zu GitHub Repository Settings
   - Scrolle nach unten zu "Danger Zone"
   - Klicke "Change visibility" → "Make public"
   - Dann funktioniert: `/plugin marketplace add https://github.com/clevermation/clevermation-claude-plugins`

2. **GitHub Personal Access Token verwenden:**
   ```bash
   # Token erstellen: GitHub Settings > Developer settings > Personal access tokens
   # Token mit 'repo' Berechtigung erstellen
   /plugin marketplace add https://TOKEN@github.com/clevermation/clevermation-claude-plugins
   ```

3. **SSH-Keys konfigurieren:**
   - Siehe: https://docs.github.com/en/authentication/connecting-to-github-with-ssh
   - Dann funktioniert: `/plugin marketplace add clevermation/clevermation-claude-plugins`

4. **Lokale Nutzung (siehe Option 2):**
   - Funktioniert ohne GitHub-Authentifizierung
   - Ideal für Entwicklung/Testing

### MCPs funktionieren nicht

**Problem:** MCP-Verifikation schlägt fehl

**Lösung:**
1. Prüfe Credentials in `.claude/settings.local.json`
2. Prüfe `.mcp.json` existiert im Projekt
3. Starte Claude Code neu

### Agents verwenden falsches Model

**Problem:** Agent nutzt nicht das gewünschte Model

**Lösung:**
1. Prüfe `.claude/settings.json` - `agents.modelPreferences`
2. Passe Model-Präferenzen an
3. Oder nutze `/setup-clevermation` erneut

---

## Nächste Schritte

Nach erfolgreichem Setup:

1. ✅ **Teste Agents** - Probiere verschiedene Agents aus
2. ✅ **Passe PROJECT_RULES.md an** - Projekt-spezifische Rules definieren
3. ✅ **Team teilen** - Andere Teammitglieder können dasselbe Setup durchführen

**Viel Erfolg mit Clevermation! 🚀**

