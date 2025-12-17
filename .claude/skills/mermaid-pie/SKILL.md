---
name: mermaid-pie
description: Mermaid Pie Chart Diagramme. Spezialisiert auf Datenverteilungen, Prozentangaben, Statistiken und Anteils-Visualisierungen. Nutze diesen Skill wenn Pie Charts, Kreisdiagramme oder Anteils-Visualisierungen erstellt werden sollen.
---

# Mermaid Pie Chart Skill

Spezialisierter Skill fuer Mermaid Pie-Diagramme. Pie Charts visualisieren Datenverteilungen und Anteile.

## Grundlagen

### Basis-Syntax
```mermaid
pie title Projektzeit-Verteilung
    "Entwicklung" : 45
    "Testing" : 25
    "Design" : 15
    "Meetings" : 15
```

## Einfaches Pie Chart

### Standard-Format
```mermaid
pie title Verteilung
    "Kategorie A" : 30
    "Kategorie B" : 50
    "Kategorie C" : 20
```

### Mit showData
```mermaid
pie showData title Verteilung
    "Kategorie A" : 30
    "Kategorie B" : 50
    "Kategorie C" : 20
```

## Clevermation Templates

### Projektzeit-Verteilung
```mermaid
pie showData title Projektzeit-Verteilung
    "Entwicklung" : 45
    "Testing" : 25
    "Design" : 15
    "Meetings" : 10
    "Dokumentation" : 5
```

### Workflow-Status Verteilung
```mermaid
pie title N8N Workflow Status
    "Active" : 60
    "Paused" : 20
    "Error" : 15
    "Draft" : 5
```

### Datenbank-Tabellen Groesse
```mermaid
pie title Supabase Tabellen-Groesse
    "Users" : 35
    "Orders" : 25
    "Products" : 20
    "Logs" : 15
    "Other" : 5
```

### Feature-Verteilung
```mermaid
pie showData title Feature-Status
    "Completed" : 50
    "In Progress" : 30
    "Planned" : 15
    "Blocked" : 5
```

## Best Practices

### 1. Sinnvolle Kategorien
- Maximal 5-7 Kategorien
- Klare, aussagekraeftige Namen
- Logische Gruppierung

### 2. Daten-Konsistenz
- Werte sollten sinnvoll sein
- Prozentangaben sollten 100% ergeben (optional)
- Absolute Zahlen sind auch moeglich

### 3. Lesbarkeit
- `showData` fuer genaue Werte
- Titel immer angeben
- Kategorien kurz halten

### 4. Verwendung
- Fuer Anteils-Visualisierungen
- Nicht fuer Zeitreihen
- Nicht fuer Vergleiche zwischen Kategorien

## Verwendung im Plan Agent

Wenn der Plan Agent ein Pie Chart erstellen soll:
1. Identifiziere die Kategorien
2. Sammle die Daten/Werte
3. Definiere einen aussagekraeftigen Titel
4. Entscheide ob `showData` benoetigt wird
5. Erstelle das Diagramm mit diesem Skill

**Wichtig:** Nutze diesen Skill NUR fuer Pie Charts. Fuer andere Diagrammtypen verwende die entsprechenden Skills (flowchart, sequence, er, etc.).

