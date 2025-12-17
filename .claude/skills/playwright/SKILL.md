---
name: playwright-mcp
description: MCP Playwright Browser-Automatisierung. Spezialisiert auf die Nutzung des Playwright MCP Servers fuer E2E-Testing, UI-Verifikation und Browser-Interaktionen. Nutze diesen Skill wenn du mit dem Playwright MCP Server arbeitest.
---

# Playwright MCP Skill

Spezialisierter Skill fuer die Nutzung des Playwright MCP Servers. Dieser Skill fokussiert sich auf die MCP Tools, nicht auf JavaScript Playwright Code.

## WICHTIG: MCP Playwright vs. JavaScript Playwright

Dieser Skill ist speziell fuer den **Playwright MCP Server** entwickelt. Du nutzt die MCP Tools direkt, nicht JavaScript Code.

**MCP Playwright:** Browser-Automatisierung durch MCP Tools
**JavaScript Playwright:** Code-basierte Tests (nicht Teil dieses Skills)

## Verfuegbare MCP Tools

### Navigation

#### `browser_navigate`
Navigiere zu einer URL.

**Parameter:**
- `url` (string, required) - Die URL zum Navigieren

**Beispiel:**
```
Navigiere zu https://example.com
```

#### `browser_navigate_back`
Gehe zurueck zur vorherigen Seite.

**Parameter:** Keine

**Beispiel:**
```
Gehe zurueck zur vorherigen Seite
```

### Seiten-Interaktion

#### `browser_snapshot`
Erstelle einen Accessibility-Snapshot der aktuellen Seite. **Besser als Screenshot** - zeigt strukturierte Informationen.

**Parameter:** Keine

**Beispiel:**
```
Erstelle einen Snapshot der aktuellen Seite
```

**Wichtig:** Nutze `browser_snapshot` um die Seite zu verstehen, bevor du interagierst!

#### `browser_click`
Klicke auf ein Element.

**Parameter:**
- `element` (string) - Beschreibung des Elements (fuer Permission)
- `ref` (string, required) - Element-Referenz aus dem Snapshot
- `button` (string, optional) - "left", "right", "middle" (default: "left")
- `doubleClick` (boolean, optional) - Doppelklick
- `modifiers` (array, optional) - ["Shift", "Control", "Alt", "Meta"]

**Beispiel:**
```
Klicke auf den Submit-Button (ref aus Snapshot)
```

#### `browser_type`
Tippe Text in ein Eingabefeld.

**Parameter:**
- `element` (string) - Beschreibung des Elements
- `ref` (string, required) - Element-Referenz aus dem Snapshot
- `text` (string, required) - Text zum Tippen
- `submit` (boolean, optional) - Enter nach dem Tippen
- `slowly` (boolean, optional) - Zeichen fuer Zeichen tippen

**Beispiel:**
```
Tippe "user@example.com" in das Email-Feld (ref aus Snapshot)
```

#### `browser_hover`
Hoovere ueber ein Element.

**Parameter:**
- `element` (string) - Beschreibung des Elements
- `ref` (string, required) - Element-Referenz aus dem Snapshot

**Beispiel:**
```
Hoovere ueber das Menue-Element (ref aus Snapshot)
```

#### `browser_select_option`
Waehle eine Option in einem Dropdown.

**Parameter:**
- `element` (string) - Beschreibung des Elements
- `ref` (string, required) - Element-Referenz aus dem Snapshot
- `values` (array, required) - Array von Werten zum Auswaehlen

**Beispiel:**
```
Waehle "Deutschland" im Laender-Dropdown (ref aus Snapshot)
```

#### `browser_press_key`
Drucke eine Taste auf der Tastatur.

**Parameter:**
- `key` (string, required) - Tastenname (z.B. "Enter", "ArrowLeft", "a")

**Beispiel:**
```
Drucke Enter
```

### Warten und Timing

#### `browser_wait_for`
Warte auf Text oder Zeit.

**Parameter:**
- `text` (string, optional) - Text auf den gewartet wird
- `textGone` (string, optional) - Text der verschwinden soll
- `time` (number, optional) - Zeit in Sekunden zum Warten

**Beispiel:**
```
Warte bis "Erfolgreich gespeichert" erscheint
```

### Browser-Konfiguration

#### `browser_resize`
Aendere die Browser-Fenstergroesse.

**Parameter:**
- `width` (number, required) - Breite in Pixeln
- `height` (number, required) - Hoehe in Pixeln

**Beispiel:**
```
Setze Browser-Groesse auf 1920x1080
```

### Debugging und Analyse

#### `browser_console_messages`
Hole alle Console-Messages der Seite.

**Parameter:** Keine

**Beispiel:**
```
Zeige alle Console-Messages
```

#### `browser_network_requests`
Hole alle Network-Requests seit dem Laden der Seite.

**Parameter:** Keine

**Beispiel:**
```
Zeige alle Network-Requests
```

## Workflow fuer E2E-Testing mit MCP Playwright

### Phase 1: Seite verstehen
1. Navigiere zur Seite mit `browser_navigate`
2. Erstelle einen Snapshot mit `browser_snapshot`
3. Analysiere die Struktur und finde relevante Elemente
4. Notiere die `ref` Werte der Elemente

### Phase 2: Interaktionen durchfuehren
1. Nutze `browser_type` fuer Eingaben
2. Nutze `browser_click` fuer Klicks
3. Nutze `browser_select_option` fuer Dropdowns
4. Nutze `browser_hover` fuer Hover-Effekte

### Phase 3: Verifikation
1. Erstelle erneut einen Snapshot nach Aktionen
2. Vergleiche den Snapshot mit dem erwarteten Zustand
3. Pruefe Console-Messages mit `browser_console_messages`
4. Pruefe Network-Requests mit `browser_network_requests`

### Phase 4: Fehlerbehandlung
1. Bei Fehlern: Pruefe Console-Messages
2. Pruefe Network-Requests auf Fehler
3. Erstelle einen Snapshot zur Analyse
4. Wiederhole Aktionen falls noetig

## Clevermation Testing Patterns

### Login-Flow Test
```
1. Navigiere zu /login
2. Snapshot erstellen
3. Email-Feld finden (ref aus Snapshot)
4. Email eingeben mit browser_type
5. Password-Feld finden (ref aus Snapshot)
6. Password eingeben mit browser_type
7. Submit-Button finden (ref aus Snapshot)
8. Submit-Button klicken mit browser_click
9. Warten auf Redirect mit browser_wait_for
10. Snapshot erstellen und verifizieren
```

### Formular-Test
```
1. Navigiere zur Formular-Seite
2. Snapshot erstellen
3. Alle Pflichtfelder ausfuellen mit browser_type
4. Dropdown auswaehlen mit browser_select_option
5. Checkbox aktivieren mit browser_click
6. Submit-Button klicken
7. Warten auf Erfolgs-Message
8. Snapshot erstellen und verifizieren
```

### UI-Verifikation
```
1. Navigiere zur Seite
2. Snapshot erstellen
3. Pruefe ob alle erwarteten Elemente vorhanden sind
4. Pruefe Console-Messages auf Fehler
5. Pruefe Network-Requests auf Fehler
6. Verifiziere dass keine JavaScript-Fehler auftreten
```

## Best Practices

### 1. Immer Snapshot vor Interaktion
- Erstelle IMMER einen Snapshot bevor du interagierst
- Nutze den Snapshot um Element-Refs zu finden
- Verstehe die Seiten-Struktur vor Aktionen

### 2. Element-Refs korrekt verwenden
- Nutze die `ref` aus dem Snapshot
- Beschreibe das Element in `element` Parameter
- Stelle sicher dass die Ref noch gueltig ist

### 3. Warten auf Aenderungen
- Nutze `browser_wait_for` nach Aktionen
- Warte auf erwartete Texte oder Aenderungen
- Pruefe nicht zu frueh den Zustand

### 4. Fehlerbehandlung
- Pruefe Console-Messages bei Problemen
- Pruefe Network-Requests bei API-Fehlern
- Erstelle Snapshots zur Debugging-Unterstuetzung

### 5. Strukturierte Tests
- Folge dem Workflow: Navigate → Snapshot → Interact → Verify
- Dokumentiere jeden Schritt
- Verifiziere nach jeder wichtigen Aktion

## Unterschiede zu JavaScript Playwright

| Aspekt | MCP Playwright | JavaScript Playwright |
|--------|----------------|----------------------|
| **Ausfuehrung** | Direkt durch MCP Tools | Code-basiert |
| **Snapshots** | Accessibility-Snapshots | Screenshots |
| **Element-Findung** | Via Snapshot refs | Via Selektoren |
| **Verifikation** | Snapshot-Vergleich | Assertions im Code |
| **Debugging** | Console/Network Tools | Code-Debugging |

## Verwendung im Frontend-Test Agent

Wenn der Frontend-Test Agent Tests durchfuehren soll:
1. Nutze die MCP Playwright Tools direkt
2. Folge dem Workflow: Navigate → Snapshot → Interact → Verify
3. Nutze Snapshots zur Verifikation
4. Pruefe Console und Network bei Problemen
5. Dokumentiere alle Schritte

**Wichtig:** Dieser Skill ist speziell fuer MCP Playwright. Fuer JavaScript Playwright Code siehe andere Ressourcen.
