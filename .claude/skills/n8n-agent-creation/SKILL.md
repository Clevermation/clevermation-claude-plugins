---
name: n8n-agent-creation
description: N8N AI Agent Node Erstellung. Spezialisiert auf Prompt-Erstellung, Model-Auswahl, Thinking-Einstellungen, System/Message Prompts und Structured Output Parser. Nutze diesen Skill wenn du AI Agent Nodes in N8N erstellst.
---

# N8N AI Agent Node Skill

Spezialisierter Skill fuer die komplette Erstellung von AI Agent Nodes in N8N Workflows.

## Model-Auswahl

### WICHTIG: Immer neuestes OpenAI Modell verwenden

**Workflow:**
1. **Recherchiere zuerst** welche OpenAI Modelle aktuell verfuegbar sind
2. **Nutze immer das neueste Chat-Modell** wenn moeglich
3. **Tendenz:** OpenAI Modelle bevorzugen fuer AI Agent Nodes

### Aktuelle OpenAI Chat-Modelle (Stand: Recherchiere immer!)

**Empfohlene Modelle (in dieser Reihenfolge):**
- `gpt-4o` - Neuestes und bestes Modell (Standard-Wahl)
- `gpt-4o-mini` - Schneller und kostenguenstiger
- `gpt-4-turbo` - Sehr gut fuer komplexe Aufgaben
- `gpt-3.5-turbo` - Kostenguenstig fuer einfache Aufgaben

**Wichtig:** Recherchiere immer die neuesten Modelle! OpenAI fuehrt regelmaessig neue Modelle ein.

### Andere Provider (nur wenn noetig)

- **Anthropic Claude** - Gute Alternative zu OpenAI
- **Google Gemini** - Fuer spezifische Use Cases
- **Local Models** - Fuer Datenschutz-kritische Anwendungen

## Thinking-Einstellungen

### Was ist Thinking?

Thinking bestimmt wie viel "Denkzeit" das Modell hat bevor es antwortet. Mehr Thinking = bessere Ergebnisse, aber laengere Ausfuehrungszeit.

### Thinking-Konfiguration

**Empfohlene Einstellungen:**

```json
{
  "node": "AI Agent",
  "parameters": {
    "model": "gpt-4o",
    "thinking": {
      "enabled": true,
      "budget": "medium" // "low", "medium", "high"
    }
  }
}
```

**Thinking-Budget:**
- `low` - Schnell, einfache Aufgaben
- `medium` - Standard, die meisten Use Cases (Empfohlen)
- `high` - Komplexe Aufgaben, maximale Qualitaet

**Wann Thinking aktivieren:**
- ✅ Komplexe Analysen
- ✅ Mehrstufige Entscheidungen
- ✅ Daten-Transformationen
- ❌ Einfache Kategorisierungen (kann ausgeschaltet werden)

## Prompt-Struktur: System Prompt + Message Prompt

### WICHTIG: Beide sind Pflicht!

Jeder AI Agent Node **MUSS** beide Prompts haben:
1. **System Prompt** - Definiert die Rolle und den Kontext
2. **Message Prompt** - Die eigentliche Aufgabe/Anfrage

### System Prompt Best Practices

**Struktur:**
```
Du bist [ROLLE] fuer [KONTEXT].

Deine Aufgaben:
- [Aufgabe 1]
- [Aufgabe 2]
- [Aufgabe 3]

Wichtige Regeln:
- [Regel 1]
- [Regel 2]

Output-Format:
[Erwartetes Format beschreiben]
```

**Beispiel:**
```
Du bist ein Datenanalyst fuer Clevermation.

Deine Aufgaben:
- Analysiere Daten und identifiziere Trends
- Erstelle Zusammenfassungen
- Gib Handlungsempfehlungen

Wichtige Regeln:
- Antworte immer auf Deutsch
- Nutze klare, praezise Sprache
- Gib konkrete Beispiele

Output-Format:
JSON mit insights (Array), summary (String), recommendations (Array)
```

### Message Prompt Best Practices

**Struktur:**
```
Aufgabe: [Was soll gemacht werden]

Kontext:
- [Kontext-Information 1]
- [Kontext-Information 2]

Daten:
{{ $json.data }}

Erwartetes Ergebnis:
[Was erwartest du als Output]
```

**Beispiel:**
```
Aufgabe: Analysiere die folgenden Kundendaten und identifiziere Trends.

Kontext:
- Zeitraum: Letzte 30 Tage
- Fokus: Support-Anfragen
- Ziel: Verbesserungsmoeglichkeiten finden

Daten:
{{ $json.customerData }}

Erwartetes Ergebnis:
JSON mit insights, summary und recommendations
```

### Kombination: System + Message

```json
{
  "node": "AI Agent",
  "parameters": {
    "model": "gpt-4o",
    "systemMessage": "Du bist ein Experte fuer Kundenservice. Analysiere Anfragen und kategorisiere sie. Antworte immer im JSON-Format.",
    "prompt": "Kategorisiere diese Kundenanfrage:\n\n{{ $json.message }}\n\nAntworte mit: category, priority, summary"
  }
}
```

## Structured Output Parser

### WICHTIG: Immer Structured Output nutzen!

Structured Output Parsers sorgen fuer konsistente, strukturierte JSON-Antworten. **ESSENTIELL** fuer zuverlaessige Workflows.

### Parser erstellen

#### Schritt 1: Schema definieren

Definiere das erwartete Output-Schema basierend auf deinem System/Message Prompt:

```json
{
  "type": "object",
  "properties": {
    "category": {
      "type": "string",
      "enum": ["support", "billing", "technical"]
    },
    "priority": {
      "type": "string",
      "enum": ["low", "medium", "high"]
    },
    "summary": {
      "type": "string"
    },
    "tags": {
      "type": "array",
      "items": {
        "type": "string"
      }
    }
  },
  "required": ["category", "priority", "summary"]
}
```

#### Schritt 2: Parser in N8N erstellen

1. Gehe zu N8N Settings → Structured Output Parsers
2. Klicke "Create Parser"
3. Gib einen Namen ein (z.B. "Customer Message Parser")
4. Fuege das Schema ein
5. Speichere den Parser

#### Schritt 3: Parser im AI Node verwenden

```json
{
  "node": "AI Agent",
  "parameters": {
    "model": "gpt-4o",
    "systemMessage": "Du bist ein Kundenservice-Experte.",
    "prompt": "Analysiere: {{ $json.message }}",
    "structuredOutput": {
      "parser": "customer-message-parser-id"
    }
  }
}
```

### Schema-Typen

#### Einfaches Objekt
```json
{
  "type": "object",
  "properties": {
    "name": { "type": "string" },
    "age": { "type": "number" }
  }
}
```

#### Mit Enum (Auswahl)
```json
{
  "type": "object",
  "properties": {
    "status": {
      "type": "string",
      "enum": ["pending", "approved", "rejected"]
    }
  }
}
```

#### Mit Array
```json
{
  "type": "object",
  "properties": {
    "items": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "id": { "type": "string" },
          "value": { "type": "number" }
        }
      }
    }
  }
}
```

## Komplette AI Agent Node Konfiguration

### Vollstaendiges Beispiel

```json
{
  "node": "AI Agent",
  "parameters": {
    "model": "gpt-4o",
    "thinking": {
      "enabled": true,
      "budget": "medium"
    },
    "temperature": 0.7,
    "maxTokens": 1000,
    "systemMessage": "Du bist ein Datenanalyst fuer Clevermation. Analysiere Daten und identifiziere Trends. Antworte immer im JSON-Format.",
    "prompt": "Aufgabe: Analysiere die folgenden Daten und identifiziere Trends.\n\nDaten:\n{{ $json.data }}\n\nErwartetes Ergebnis: JSON mit insights, summary, recommendations",
    "structuredOutput": {
      "parser": "data-analysis-parser-id"
    }
  }
}
```

## Clevermation Patterns

### Pattern 1: Daten-Analyse
```
System Message: Du bist ein Datenanalyst fuer Clevermation. Analysiere Daten und identifiziere Trends. Antworte im JSON-Format.

Message Prompt: Analysiere die folgenden Daten:
{{ $json.data }}

Output Schema: {
  "insights": [{"title": string, "description": string, "impact": "low|medium|high"}],
  "summary": string,
  "recommendations": [string]
}
```

### Pattern 2: Text-Kategorisierung
```
System Message: Du kategorisierst Kundennachrichten. Antworte im JSON-Format.

Message Prompt: Kategorisiere diese Nachricht:
{{ $json.message }}

Output Schema: {
  "category": "support|billing|technical|sales",
  "priority": "low|medium|high|urgent",
  "confidence": number (0-1),
  "tags": [string]
}
```

### Pattern 3: Content-Generierung
```
System Message: Du erstellst professionelle E-Mails. Antworte im JSON-Format.

Message Prompt: Erstelle eine E-Mail:
- Anlass: {{ $json.occasion }}
- Empfaenger: {{ $json.recipient }}
- Kontext: {{ $json.context }}

Output Schema: {
  "subject": string,
  "body": string,
  "tone": "formal|casual|professional",
  "keyPoints": [string]
}
```

## Best Practices Checkliste

### ✅ Model-Auswahl
- [ ] Neuestes OpenAI Modell recherchiert
- [ ] `gpt-4o` oder neuer verwendet
- [ ] Thinking aktiviert wenn noetig

### ✅ Prompts
- [ ] System Prompt vorhanden (Pflicht!)
- [ ] Message Prompt vorhanden (Pflicht!)
- [ ] Klare Struktur und Kontext
- [ ] Output-Format spezifiziert

### ✅ Structured Output
- [ ] Parser erstellt
- [ ] Schema definiert
- [ ] Parser im AI Node verwendet

### ✅ Konfiguration
- [ ] Temperature angepasst (0.7 Standard)
- [ ] Max Tokens limitiert
- [ ] Error Handling implementiert

## Verwendung im N8N Agent

Wenn der N8N Agent AI Nodes erstellen soll:
1. Lade diesen Skill
2. Recherchiere neuestes OpenAI Modell
3. Erstelle System Prompt (Pflicht!)
4. Erstelle Message Prompt (Pflicht!)
5. Erstelle Structured Output Parser
6. Konfiguriere Thinking falls noetig
7. Konfiguriere AI Node mit MCP Tools

**Wichtig:** Nutze diesen Skill NUR fuer AI Agent Nodes. Fuer andere N8N-Nodes verwende die entsprechenden Skills.
