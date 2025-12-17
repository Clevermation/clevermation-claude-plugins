---
name: mermaid-flowchart
description: Mermaid Flowchart Diagramme. Spezialisiert auf Prozessablaeufe, Workflows, Entscheidungslogik und Geschaeftsprozesse. Nutze diesen Skill wenn Flowcharts, Prozessdiagramme oder Workflow-Visualisierungen erstellt werden sollen.
---

# Mermaid Flowchart Skill

Spezialisierter Skill fuer Mermaid Flowchart-Diagramme. Flowcharts visualisieren Prozessablaeufe, Entscheidungslogik und Workflows.

## Grundlagen

### Basis-Syntax
```mermaid
flowchart TD
    A[Start] --> B{Entscheidung}
    B -->|Ja| C[Aktion 1]
    B -->|Nein| D[Aktion 2]
    C --> E[Ende]
    D --> E
```

### Richtungen
- `TD` - Top Down (oben nach unten) - Standard
- `LR` - Left Right (links nach rechts)
- `BT` - Bottom Top (unten nach oben)
- `RL` - Right Left (rechts nach links)

## Knoten-Formen

### Standard-Formen
```mermaid
flowchart LR
    A[Rechteck]
    B(Rundes Rechteck)
    C([Stadium/Stadiumform])
    D[[Subroutine/Doppelrand]]
    E[(Datenbank/Zylinder)]
    F((Kreis))
    G>Asymmetrisch]
    H{Raute/Entscheidung}
    I{{Hexagon}}
    J[/Parallelogramm/]
    K[\Parallelogramm\]
    L[/Trapez/]
    M[\Trapez\]
```

### Formen-Referenz
- `[Text]` - Rechteck (Standard)
- `(Text)` - Abgerundetes Rechteck
- `([Text])` - Stadium-Form
- `[[Text]]` - Subroutine (Doppelrand)
- `[(Text)]` - Datenbank/Zylinder
- `((Text))` - Kreis
- `>Text]` - Asymmetrisch
- `{Text}` - Raute/Entscheidung
- `{{Text}}` - Hexagon
- `/Text/` - Parallelogramm rechts
- `\Text\` - Parallelogramm links
- `/Text/` - Trapez rechts
- `\Text\` - Trapez links

## Verbindungen

### Pfeil-Typen
```mermaid
flowchart LR
    A --> B
    C --- D
    E -.-> F
    G ==> H
    I --Text--> J
    K -->|Label| L
    M -.->|Dotted Label| N
    O ==>|Thick Label| P
```

- `-->` - Solid mit Pfeil
- `---` - Solid ohne Pfeil
- `-.->` - Dotted mit Pfeil
- `==>` - Thick mit Pfeil
- `--Text-->` - Mit Text-Label
- `-->|Label|` - Mit Label auf Pfeil

### Mehrfach-Verbindungen
```mermaid
flowchart TD
    A --> B
    A --> C
    A --> D
    B --> E
    C --> E
    D --> E
```

## Subgraphs (Gruppierung)

```mermaid
flowchart TD
    subgraph Frontend
        A[React]
        B[Next.js]
    end
    
    subgraph Backend
        C[API]
        D[Database]
    end
    
    Frontend --> Backend
```

### Subgraph mit Richtung
```mermaid
flowchart LR
    subgraph "Phase 1" [LR]
        A1[Start]
        A2[Analyse]
    end
    
    subgraph "Phase 2" [LR]
        B1[Entwicklung]
        B2[Testing]
    end
    
    A2 --> B1
```

## Styling

### Klassen-basiertes Styling
```mermaid
flowchart TD
    A:::start --> B:::process
    B --> C:::decision
    C -->|Ja| D:::success
    C -->|Nein| E:::error
    
    classDef start fill:#90EE90,stroke:#333,stroke-width:2px
    classDef process fill:#87CEEB,stroke:#333,stroke-width:2px
    classDef decision fill:#FFD700,stroke:#333,stroke-width:2px
    classDef success fill:#98FB98,stroke:#333,stroke-width:2px
    classDef error fill:#FF6B6B,stroke:#333,stroke-width:2px
```

### Inline-Styling
```mermaid
flowchart LR
    A[Start]:::fillGreen
    B[Ende]:::fillRed
    
    classDef fillGreen fill:#90EE90
    classDef fillRed fill:#FF6B6B
```

### Individuelle Knoten-Styles
```mermaid
flowchart TD
    A[Standard]
    B[Gruen]:::green
    C[Rot]:::red
    
    classDef green fill:#90EE90,stroke:#2E7D32,stroke-width:3px
    classDef red fill:#FF6B6B,stroke:#C62828,stroke-width:3px
```

## Clevermation Templates

### N8N Workflow Visualisierung
```mermaid
flowchart LR
    subgraph Trigger
        T1[Webhook]
        T2[Schedule]
    end
    
    subgraph Process
        P1[Transform Data]
        P2{Condition}
        P3[API Call]
    end
    
    subgraph Output
        O1[Supabase Insert]
        O2[Email Notification]
        O3[Slack Message]
    end
    
    T1 --> P1
    T2 --> P1
    P1 --> P2
    P2 -->|True| P3
    P2 -->|False| O2
    P3 --> O1
    O1 --> O3
```

### Power Automate Integration Flow
```mermaid
flowchart TD
    subgraph "Power Automate"
        PA1[Trigger: New Item]
        PA2[Transform]
        PA3[HTTP Request]
    end
    
    subgraph "N8N"
        N1[Webhook Receive]
        N2[Process]
        N3[Supabase Insert]
    end
    
    subgraph "Supabase"
        S1[(Database)]
        S2[Edge Function]
        S3[Realtime]
    end
    
    PA1 --> PA2 --> PA3
    PA3 -->|POST| N1
    N1 --> N2 --> N3
    N3 --> S1
    S1 --> S3
    S3 -->|Subscription| PA1
```

### Login Flow
```mermaid
flowchart TD
    Start([User Login]) --> Input{Email & Password}
    Input --> Validate{Valid?}
    Validate -->|Nein| Error[Show Error]
    Validate -->|Ja| Check{User Exists?}
    Check -->|Nein| Create[Create Account]
    Check -->|Ja| Auth[Authenticate]
    Create --> Auth
    Auth --> Success{Success?}
    Success -->|Nein| Error
    Success -->|Ja| Dashboard[Dashboard]
    Error --> Input
```

## Best Practices

### 1. Klare Struktur
- Maximal 15-20 Knoten pro Diagramm
- Logische Gruppierung mit Subgraphs
- Konsistente Richtung (TD oder LR)

### 2. Lesbarkeit
- Kurze, klare Labels
- Entscheidungsknoten immer als Raute `{}`
- Start/Ende als Stadium `([ ])`

### 3. Farben sinnvoll einsetzen
- Gruen: Start/Erfolg
- Rot: Fehler/Ende
- Blau: Prozess-Schritte
- Gelb: Entscheidungen

### 4. Komplexitaet reduzieren
- Bei zu vielen Knoten: Aufteilen in mehrere Diagramme
- Wichtige Details hervorheben
- Unwichtige Schritte weglassen

## Verwendung im Plan Agent

Wenn der Plan Agent ein Flowchart erstellen soll:
1. Analysiere den Prozess/Workflow
2. Identifiziere Start- und Endpunkte
3. Markiere Entscheidungspunkte
4. Definiere Hauptschritte
5. Erstelle das Diagramm mit diesem Skill

**Wichtig:** Nutze diesen Skill NUR fuer Flowcharts. Fuer andere Diagrammtypen verwende die entsprechenden Skills (sequence, er, gantt, etc.).

