---
name: mermaid-gantt
description: Mermaid Gantt Diagramme. Spezialisiert auf Projektplanung, Zeitplaene, Meilensteine und Projekt-Timelines. Nutze diesen Skill wenn Gantt-Charts, Projektplaene oder Zeitplan-Visualisierungen erstellt werden sollen.
---

# Mermaid Gantt Chart Skill

Spezialisierter Skill fuer Mermaid Gantt-Diagramme. Gantt Charts visualisieren Projekt-Timelines, Aufgaben und Meilensteine.

## Grundlagen

### Basis-Syntax
```mermaid
gantt
    title Projekt Timeline
    dateFormat YYYY-MM-DD
    
    section Phase 1
    Research           :a1, 2024-01-01, 7d
    Design             :a2, after a1, 5d
    
    section Phase 2
    Development        :b1, after a2, 14d
    Testing            :b2, after b1, 7d
```

## Datum-Format

### Standard-Formate
```mermaid
gantt
    dateFormat YYYY-MM-DD
    title Beispiel
```

### Verfuegbare Formate
- `YYYY-MM-DD` - 2024-01-15 (Standard)
- `MM/DD/YYYY` - 01/15/2024
- `DD-MM-YYYY` - 15-01-2024
- `YYYY-MM-DD HH:mm` - Mit Zeit

## Aufgaben definieren

### Einfache Aufgabe
```mermaid
gantt
    dateFormat YYYY-MM-DD
    title Beispiel
    
    section Tasks
    Task 1 :a1, 2024-01-01, 5d
```

### Aufgabe mit ID und Label
```mermaid
gantt
    dateFormat YYYY-MM-DD
    title Beispiel
    
    section Development
    Research :research, 2024-01-01, 7d
    Design :design, after research, 5d
```

### Relative Daten
```mermaid
gantt
    dateFormat YYYY-MM-DD
    title Beispiel
    
    section Phase 1
    Start :a1, 2024-01-01, 1d
    Task A :a2, after a1, 3d
    Task B :a3, after a2, 2d
    Task C :a4, after a3, 4d
```

## Task-Marker

### Status-Marker
```mermaid
gantt
    dateFormat YYYY-MM-DD
    title Projekt Status
    
    section Completed
    Task 1 :done, t1, 2024-01-01, 5d
    
    section Active
    Task 2 :active, t2, 2024-01-06, 7d
    
    section Critical
    Task 3 :crit, t3, 2024-01-13, 5d
    
    section Milestone
    Release :milestone, m1, 2024-01-18, 0d
```

### Marker-Typen
- `done` - Aufgabe abgeschlossen (gruen)
- `active` - Aufgabe in Bearbeitung (blau)
- `crit` - Kritischer Pfad (rot)
- `milestone` - Meilenstein (Diamant)

## Sections (Phasen)

### Mehrere Sections
```mermaid
gantt
    dateFormat YYYY-MM-DD
    title Projekt Roadmap
    
    section Analyse
    Anforderungen :a1, 2024-01-01, 5d
    Spezifikation :a2, after a1, 3d
    
    section Entwicklung
    Backend :b1, after a2, 10d
    Frontend :b2, after a2, 12d
    Integration :b3, after b1, 5d
    
    section Testing
    Unit Tests :t1, after b1, 5d
    E2E Tests :t2, after b3, 5d
    
    section Deployment
    Staging :d1, after t2, 2d
    Production :milestone, d2, after d1, 0d
```

## Excludes (Ausnahmen)

### Wochenenden ausschliessen
```mermaid
gantt
    dateFormat YYYY-MM-DD
    excludes weekends
    title Beispiel
```

### Spezifische Tage ausschliessen
```mermaid
gantt
    dateFormat YYYY-MM-DD
    excludes 2024-01-01,2024-12-25
    title Beispiel
```

### Wochentage ausschliessen
```mermaid
gantt
    dateFormat YYYY-MM-DD
    excludes weekends
    excludes 2024-01-01
    title Beispiel
```

## Clevermation Templates

### Projekt-Roadmap
```mermaid
gantt
    title Clevermation Projekt Roadmap
    dateFormat YYYY-MM-DD
    excludes weekends
    
    section Phase 1: Planning
    Requirements Analysis    :done,    req, 2024-01-01, 5d
    Technical Specification  :active,  spec, after req, 3d
    Architecture Design      :         arch, after spec, 5d
    
    section Phase 2: Development
    Backend API              :         backend, after arch, 14d
    Frontend UI              :         frontend, after arch, 16d
    N8N Integration          :crit,    n8n, after backend, 7d
    Supabase Setup           :crit,    supabase, after arch, 5d
    
    section Phase 3: Testing
    Unit Tests               :         unit, after backend, 5d
    Integration Tests        :         integration, after n8n, 5d
    E2E Tests                :crit,    e2e, after frontend, 7d
    
    section Phase 4: Deployment
    Staging Deployment       :         staging, after e2e, 3d
    Production Release      :milestone, prod, after staging, 0d
    Documentation            :         docs, after prod, 5d
```

### Sprint-Planung
```mermaid
gantt
    title Sprint 1 - 2 Wochen
    dateFormat YYYY-MM-DD
    excludes weekends
    
    section Week 1
    Task 1 :t1, 2024-01-08, 3d
    Task 2 :t2, 2024-01-09, 2d
    Task 3 :t3, after t1, 2d
    
    section Week 2
    Task 4 :t4, 2024-01-15, 3d
    Task 5 :crit, t5, 2024-01-16, 2d
    Sprint Review :milestone, review, 2024-01-19, 0d
```

## Best Practices

### 1. Klare Struktur
- Sections fuer logische Gruppierung
- Aufgaben mit aussagekraeftigen Namen
- IDs fuer Referenzen verwenden

### 2. Realistische Zeitplaene
- Pufferzeiten einplanen
- Abhaengigkeiten beachten
- Kritische Pfade markieren

### 3. Status-Tracking
- `done` fuer abgeschlossene Aufgaben
- `active` fuer laufende Aufgaben
- `crit` fuer kritische Aufgaben

### 4. Meilensteine
- Wichtige Events als Milestones
- Release-Daten markieren
- Review-Termine hervorheben

## Verwendung im Plan Agent

Wenn der Plan Agent ein Gantt-Diagramm erstellen soll:
1. Definiere Projekt-Phasen (Sections)
2. Liste alle Aufgaben auf
3. Setze Startdaten und Dauer
4. Definiere Abhaengigkeiten (`after`)
5. Markiere Status und kritische Aufgaben
6. Erstelle das Diagramm mit diesem Skill

**Wichtig:** Nutze diesen Skill NUR fuer Gantt-Diagramme. Fuer andere Diagrammtypen verwende die entsprechenden Skills (flowchart, sequence, er, etc.).

