# GitHub Setup - Schritt für Schritt

## Vorbereitung abgeschlossen ✅

Die Plugin-Struktur ist bereit für GitHub!

## Nächste Schritte

### 1. Git Repository initialisieren

```bash
cd /Users/jonneschwegmann/Desktop/Jonne_Felix/Clevermation/Intern/setup-clevermation-claude-plugins

# Git Repository initialisieren
git init

# Alle Dateien hinzufügen (settings.local.json wird automatisch ignoriert)
git add .

# Ersten Commit erstellen
git commit -m "Initial commit: Clevermation Claude Code Plugins v1.0.0"
```

### 2. GitHub Repository erstellen

1. Gehe zu https://github.com/new
2. Repository-Name: `clevermation-claude-plugins`
3. Beschreibung: `Claude Code Plugins für das Clevermation Team - Agents, Skills und MCP Server`
4. **Wichtig:** Wähle **Public** (damit Team-Mitglieder es nutzen können)
   - ODER: **Private** wenn nur für Clevermation Team
5. **NICHT** "Initialize with README" ankreuzen (wir haben schon eins)
6. Klicke "Create repository"

### 3. Repository verbinden und hochladen

```bash
# Remote Repository hinzufügen (ersetze USERNAME mit deinem GitHub-Username)
git remote add origin https://github.com/setup-clevermation/setup-clevermation-claude-plugins.git

# Branch auf main setzen
git branch -M main

# Hochladen
git push -u origin main
```

**Falls Repository privat ist:**
- Team-Mitglieder müssen Zugriff haben
- Oder nutze: `git remote add origin git@github.com:clevermation/setup-clevermation-claude-plugins.git` (SSH)

### 4. Team-Mitglieder können jetzt nutzen

Jedes Team-Mitglied führt aus:

```bash
# In Claude Code (in einem beliebigen Projekt)
/plugin marketplace add clevermation/setup-clevermation-claude-plugins

# Oder mit vollständigem Pfad:
/plugin marketplace add https://github.com/setup-clevermation/setup-clevermation-claude-plugins

# Dann Onboarding:
/setup-clevermation
```

## Updates verteilen

Wenn du Änderungen machst:

```bash
# Änderungen hinzufügen
git add .

# Committen
git commit -m "Update: Beschreibung der Änderungen"

# Hochladen
git push

# Team-Mitglieder updaten dann:
/plugin marketplace update clevermation-plugins
/plugin update researcher@clevermation-plugins  # etc.
```

## Wichtige Hinweise

✅ **settings.local.json** wird automatisch ignoriert (ist in .gitignore)
✅ **PROJECT_RULES.md** und **PROJECT_CONTEXT.md** werden ignoriert (projekt-spezifisch)
✅ Alle anderen Dateien werden committed

## Repository-URL anpassen

Falls dein GitHub-Username nicht "clevermation" ist, passe die URLs an:
- In `.claude-plugin/plugin.json`: `repository` Feld
- In `README.md`: Alle GitHub-Links
- In diesem Dokument: Remote-URL

## Testen vor dem Push

Bevor du auf GitHub hochlädst, teste lokal:

```bash
# Claude Code im Plugin-Verzeichnis öffnen
claude .

# Command testen
/setup-clevermation
```

Wenn alles funktioniert → GitHub hochladen!

