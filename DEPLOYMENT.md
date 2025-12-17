# Deployment & Nutzung - Clevermation Plugins

## Zwei Möglichkeiten der Nutzung

Du hast **zwei Optionen** wie du die Plugins nutzen kannst:

### Option 1: Lokale Nutzung (für Entwicklung/Testing)

**Wann:** Wenn du die Plugins nur lokal testen oder entwickeln willst

**Wie:**
1. Öffne Claude Code im Plugin-Verzeichnis
2. Nutze die Plugins direkt - sie sind bereits verfügbar!
3. Teste `/setup-clevermation` Command lokal

**Vorteile:**
- Schnelles Testen während der Entwicklung
- Keine GitHub-Veröffentlichung nötig
- Änderungen sofort verfügbar

**Nachteile:**
- Nur auf diesem Rechner verfügbar
- Team kann nicht darauf zugreifen

### Option 2: GitHub Distribution (für Team-Nutzung)

**Wann:** Wenn du die Plugins mit dem Team teilen willst

**Wie:**
1. Repository auf GitHub hochladen
2. Team-Mitglieder fügen das Marketplace hinzu
3. Plugins werden automatisch installiert

**Vorteile:**
- Team kann Plugins nutzen
- Zentrale Updates
- Versionierung möglich

**Nachteile:**
- GitHub-Repository nötig
- Änderungen müssen committed werden

---

## Option 1: Lokale Nutzung (Schnellstart)

### Schritt 1: Plugin lokal testen

```bash
# Im Plugin-Verzeichnis
cd /Users/jonneschwegmann/Desktop/Jonne_Felix/Clevermation/Intern/setup-clevermation-claude-plugins

# Claude Code öffnen (im Terminal)
claude .

# Oder: In Claude Code das Verzeichnis öffnen
```

### Schritt 2: Command testen

```bash
# Im Claude Code Chat
/setup-clevermation
```

Das Command sollte jetzt funktionieren!

### Schritt 3: Plugins lokal nutzen

Die Plugins sind bereits verfügbar, weil sie im `.claude/` Verzeichnis liegen. Claude Code lädt sie automatisch.

**Test:**
```
"Recherchiere Best Practices für Supabase RLS"
```

Der Researcher Agent sollte automatisch verwendet werden.

---

## Option 2: GitHub Distribution (Team-Nutzung)

### Schritt 1: Repository auf GitHub hochladen

```bash
# Falls noch kein Git-Repository
git init
git add .
git commit -m "Initial commit: Clevermation Claude Code Plugins"

# GitHub Repository erstellen (auf github.com)
# Dann:
git remote add origin https://github.com/setup-clevermation/setup-clevermation-claude-plugins.git
git branch -M main
git push -u origin main
```

**Wichtig:** 
- Repository muss **öffentlich** sein ODER
- Team-Mitglieder müssen **Zugriff** haben

### Schritt 2: Team-Mitglieder fügen Marketplace hinzu

Jedes Team-Mitglied führt aus:

```bash
# In Claude Code (in einem beliebigen Projekt)
/plugin marketplace add clevermation/setup-clevermation-claude-plugins
```

**Oder mit vollständigem GitHub-Pfad:**
```bash
/plugin marketplace add https://github.com/setup-clevermation/setup-clevermation-claude-plugins
```

### Schritt 3: Plugins installieren

```bash
# Onboarding starten
/setup-clevermation

# Oder manuell installieren
/plugin install researcher@clevermation-plugins
/plugin install plan-agent@clevermation-plugins
```

### Schritt 4: Updates verteilen

Wenn du Änderungen machst:

```bash
# Änderungen committen
git add .
git commit -m "Update: Neue Features"
git push

# Team-Mitglieder updaten
/plugin marketplace update clevermation-plugins
/plugin update researcher@clevermation-plugins
```

---

## Was brauchst du jetzt?

### Für lokale Entwicklung:
✅ **Nichts weiter!** - Du kannst direkt loslegen:
```bash
cd /Users/jonneschwegmann/Desktop/Jonne_Felix/Clevermation/Intern/setup-clevermation-claude-plugins
claude .
/setup-clevermation
```

### Für Team-Distribution:
1. ✅ Repository auf GitHub hochladen
2. ✅ Team-Mitglieder fügen Marketplace hinzu
3. ✅ Plugins installieren mit `/setup-clevermation`

---

## Empfehlung

**Starte mit lokaler Nutzung:**
- Teste alles lokal
- Stelle sicher dass alles funktioniert
- Dann auf GitHub hochladen für Team-Distribution

**Workflow:**
1. Lokal entwickeln und testen
2. Wenn alles funktioniert → GitHub
3. Team kann dann nutzen

---

## Troubleshooting

### Plugin wird nicht gefunden

**Lokale Nutzung:**
- Stelle sicher dass du im Plugin-Verzeichnis bist
- Claude Code muss das Verzeichnis geöffnet haben

**GitHub Distribution:**
- Prüfe Repository-URL
- Stelle sicher dass Repository öffentlich ist oder Zugriff vorhanden
- Prüfe `.claude-plugin/marketplace.json` existiert

### Command `/setup-clevermation` funktioniert nicht

- Prüfe dass `.claude/commands/setup-clevermation.md` existiert
- Prüfe Frontmatter ist korrekt
- Claude Code neu starten

### Plugins werden nicht geladen

- Prüfe `.claude-plugin/plugin.json` existiert
- Prüfe JSON-Syntax ist korrekt
- Prüfe Pfade in `marketplace.json` sind korrekt

