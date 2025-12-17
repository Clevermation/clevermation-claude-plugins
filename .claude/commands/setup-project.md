---
description: Projekt-Setup - Konfiguriere projekt-spezifische Rules, Agents und Plugins fuer dieses Kundenprojekt
allowed-tools: Read, Write, AskUser
---

# Projekt-Setup - Clevermation

Ich helfe dir, projekt-spezifische Rules und Konfigurationen fuer dieses Kundenprojekt einzurichten.

## Was macht dieses Command?

Dieses Command erstellt projekt-spezifische Konfigurationen, die:
- Projekt-spezifische Rules definieren
- Agents an das Projekt anpassen
- Projekt-Kontext hinzufuegen
- Team-spezifische Best Practices festlegen

## Schritt 1: Projekt-Informationen sammeln

Bevor wir starten, benoetige ich einige Informationen:

1. **Projektname** - Wie heisst dieses Projekt?
2. **Kunde** - Welcher Kunde ist das?
3. **Technologie-Stack** - Welche Technologien werden verwendet?
4. **Projekt-Typ** - Web-App, API, Automatisierung, etc.?
5. **Besondere Anforderungen** - Gibt es spezielle Rules oder Constraints?

## Schritt 2: Projekt-spezifische Rules erstellen

Basierend auf deinen Angaben erstelle ich:

### `.claude/PROJECT_RULES.md`
Projekt-spezifische Rules und Best Practices, die alle Agents beachten sollen:
- Coding Standards
- Architektur-Prinzipien
- Naming Conventions
- Testing Requirements
- Deployment Guidelines

### `.claude/settings.json` Updates
Projekt-spezifische Settings:
- Permissions
- Environment Variables
- Hooks
- Company Announcements

## Schritt 3: Agents anpassen

Ich passe die Clevermation Agents an das Projekt an:
- Projekt-Kontext zu Agent Prompts hinzufuegen
- Projekt-spezifische Skills aktivieren
- Projekt-Regeln in Agent System Prompts integrieren

## Schritt 4: Projekt-Kontext-Datei erstellen

Erstelle `.claude/PROJECT_CONTEXT.md` mit:
- Projekt-Uebersicht
- Architektur-Diagramme
- Wichtige Dateien und Verzeichnisse
- Integrationen und externe Services
- Team-Mitglieder und Rollen

## Verwendung

### Neues Projekt einrichten

```bash
/setup-project
```

Das Command fuehrt dich interaktiv durch:
1. Projekt-Informationen sammeln
2. Rules definieren
3. Agents konfigurieren
4. Kontext-Dateien erstellen

### Bestehendes Projekt aktualisieren

```bash
/setup-project --update
```

Aktualisiert bestehende Konfigurationen ohne alles zu ueberschreiben.

## Beispiel-Workflow

```
User: /setup-project

Claude: Willkommen beim Projekt-Setup! Lass uns beginnen...

1. Projektname: [User gibt ein]
2. Kunde: [User gibt ein]
3. Technologie-Stack: [User gibt ein]
...

Claude: Perfekt! Ich erstelle jetzt:
- .claude/PROJECT_RULES.md
- .claude/PROJECT_CONTEXT.md
- Aktualisiere .claude/settings.json
- Passe Agents an

[Erstellt Dateien]

Claude: Setup abgeschlossen! Dein Projekt ist jetzt konfiguriert.
```

## Projekt-spezifische Rules Format

Die erstellten Rules folgen diesem Format:

```markdown
# Projekt Rules: [Projektname]

## Coding Standards
- [Projekt-spezifische Standards]

## Architektur
- [Architektur-Prinzipien]

## Testing
- [Testing Requirements]

## Deployment
- [Deployment Guidelines]

## Integrationen
- [Externe Services und APIs]
```

## Agents anpassen

Die Agents werden automatisch mit Projekt-Kontext erweitert:

```markdown
## Projekt-Kontext: [Projektname]

[Projekt-spezifische Informationen werden hier hinzugefuegt]
```

## Naechste Schritte

Nach dem Setup:
1. Pruefe `.claude/PROJECT_RULES.md`
2. Pruefe `.claude/PROJECT_CONTEXT.md`
3. Teste die Agents mit projekt-spezifischen Aufgaben
4. Passe Rules bei Bedarf an

**Wichtig:** Projekt-spezifische Rules werden automatisch von allen Agents geladen!

