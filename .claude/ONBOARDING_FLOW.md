# `/setup-clevermation` Command - Ablauf und Funktionsweise

## Ablauf wenn `/setup-clevermation` ausgeführt wird

### Schritt 1: Command wird erkannt
- Claude Code erkennt das `/setup-clevermation` Command
- Lädt die Command-Datei: `.claude/commands/setup-clevermation.md`
- Command hat `allowed-tools: Read, Write, AskUser` - kann Dateien lesen/schreiben und User fragen

### Schritt 2: Interaktiver Onboarding-Prozess
Der Command führt den User durch einen interaktiven Prozess:

1. **Willkommensnachricht** - Erklärt was das Plugin ist
2. **Marketplace hinzufügen** - Falls noch nicht geschehen:
   ```bash
   /plugin marketplace add clevermation/clevermation-claude-plugins
   ```
3. **Plugins installieren** - User wählt welche Plugins installiert werden sollen:
   - Standard-Plugins (keine Credentials nötig)
   - Optionale Plugins (benötigen Credentials)
4. **Credentials einrichten** - Command hilft beim Erstellen von `.claude/settings.local.json`
5. **Plugins aktivieren/deaktivieren** - User kann Plugins verwalten
6. **Test-Beispiele** - Command zeigt Beispiele wie Agents genutzt werden

### Schritt 3: Hook wird ausgeführt (bei Session-Start)
Nach dem Onboarding wird bei jedem Session-Start automatisch der Hook ausgeführt:

**Hook-Ablauf:**
1. Claude Code lädt `hooks/hooks.json` beim Plugin-Start
2. Bei `SessionStart` Event wird der Hook getriggert
3. Hook führt `onboarding-check.sh` aus
4. Script prüft:
   - Existiert `.claude/settings.local.json`?
   - Sind wichtige Credentials gesetzt?
5. Zeigt entsprechende Hinweise/Notifications

### Schritt 4: Agents sind verfügbar
Nach erfolgreichem Onboarding:
- Agents können direkt genutzt werden
- Skills werden automatisch geladen wenn benötigt
- MCP Server starten automatisch (falls konfiguriert)

## Wann macht `reference.md` Sinn?

### ✅ Sinnvoll für:

1. **Umfangreiche Referenz-Daten**
   - SQL-Referenz (alle PostgreSQL Funktionen)
   - API-Referenz (alle Endpoints mit Parametern)
   - Kommando-Referenz (alle CLI-Befehle)

2. **Lookup-Informationen**
   - Daten die nicht täglich gebraucht werden
   - Referenz die man nachschlagen kann wenn nötig
   - Tabellen, Listen, Übersichten

3. **Wenn SKILL.md zu lang wird**
   - SKILL.md sollte fokussiert bleiben (Best Practices, Workflows)
   - Reference.md für detaillierte Referenz-Daten

### ❌ Nicht sinnvoll für:

- Informationen die täglich gebraucht werden (gehören in SKILL.md)
- Best Practices (gehören in SKILL.md)
- Workflows und Anleitungen (gehören in SKILL.md)

### Beispiel: `supabase-migration` Skill

**SKILL.md** (Haupt-Skill):
- Best Practices für Migrationen
- Workflows und Anleitungen
- Clevermation-spezifische Patterns
- Wie man Migrationen erstellt/anwendet

**reference.md** (Optional, könnte hinzugefügt werden):
- Komplette PostgreSQL SQL-Referenz
- Alle verfügbaren Datentypen
- Alle Constraint-Typen
- Alle Index-Optionen
- Trigger-Syntax-Referenz

## Wann macht `scripts/` Sinn?

### ✅ Sinnvoll für:

1. **Wiederkehrende Aufgaben**
   - Migration-Validierung
   - Schema-Testing
   - Code-Generierung

2. **Helper-Scripts**
   - Scripts die vom Skill verwendet werden
   - Automatisierung von repetitiven Tasks
   - Validierung und Checks

3. **Testing-Scripts**
   - Unit-Tests für Skills
   - Integration-Tests
   - Validierung von Outputs

### ❌ Nicht sinnvoll für:

- Einmalige Scripts (gehören nicht ins Plugin)
- Projekt-spezifische Scripts (gehören ins Projekt, nicht ins Plugin)
- Scripts die nicht vom Skill verwendet werden

### Beispiel: `supabase-migration` Skill

**scripts/** (Optional, könnte hinzugefügt werden):
```
scripts/
├── validate-migration.sh    # Validiert Migration-Syntax
├── test-migration.sh        # Testet Migration lokal
└── generate-template.sh      # Generiert Migration-Template
```

**Verwendung:**
- Skill kann diese Scripts referenzieren
- Scripts werden mit `${CLAUDE_PLUGIN_ROOT}/.claude/skills/supabase-migration/scripts/validate-migration.sh` aufgerufen
- Scripts helfen bei wiederkehrenden Aufgaben

## Empfehlungen für Clevermation Skills

### Skills die `reference.md` profitieren könnten:

1. **supabase-migration**
   - `reference.md`: PostgreSQL SQL-Referenz, Datentypen, Constraints

2. **n8n**
   - `reference.md`: Alle Node-Typen, Expression-Funktionen, Error-Codes

3. **airtable**
   - `reference.md`: Alle Formula-Funktionen, API-Endpoints, Rate-Limits

4. **playwright**
   - `reference.md`: Alle MCP Tools mit vollständigen Parametern

### Skills die `scripts/` profitieren könnten:

1. **supabase-migration**
   - `scripts/validate-migration.sh`: Validiert SQL-Syntax
   - `scripts/test-migration.sh`: Testet Migration lokal

2. **n8n-agent-creation**
   - `scripts/validate-prompt.sh`: Validiert Prompt-Struktur
   - `scripts/generate-schema.sh`: Generiert Structured Output Schema

3. **researcher**
   - `scripts/validate-source.sh`: Validiert Quellen-Qualität
   - `scripts/extract-summary.sh`: Extrahiert Zusammenfassung

## Aktuelle Struktur

**Momentan haben wir:**
- ✅ Alle Skills haben `SKILL.md` mit Frontmatter
- ❌ Keine Skills haben `reference.md` (könnte hinzugefügt werden)
- ❌ Keine Skills haben `scripts/` (könnte hinzugefügt werden)

**Empfehlung:**
- Starte ohne `reference.md` und `scripts/`
- Füge sie hinzu wenn:
  - SKILL.md zu lang wird (>500 Zeilen)
  - Wiederkehrende Aufgaben automatisiert werden sollen
  - Umfangreiche Referenz-Daten benötigt werden

