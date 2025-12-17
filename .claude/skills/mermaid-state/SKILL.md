---
name: mermaid-state
description: Mermaid State Diagramme. Spezialisiert auf State Machines, Zustandsuebergaenge, Workflow-States und Zustands-Modelle. Nutze diesen Skill wenn State Diagrams, Zustandsmaschinen oder State-Transition-Visualisierungen erstellt werden sollen.
---

# Mermaid State Diagram Skill

Spezialisierter Skill fuer Mermaid State-Diagramme. State Diagrams visualisieren Zustandsmaschinen und Zustandsuebergaenge.

## Grundlagen

### Basis-Syntax
```mermaid
stateDiagram-v2
    [*] --> Draft
    Draft --> Review : submit
    Review --> Draft : reject
    Review --> Approved : approve
    Approved --> Published : publish
    Published --> [*]
```

## States (Zustaende)

### Einfache States
```mermaid
stateDiagram-v2
    [*] --> State1
    State1 --> State2
    State2 --> [*]
```

### States mit Beschreibung
```mermaid
stateDiagram-v2
    [*] --> Draft : Create
    Draft : Document in Draft
    Draft --> Review : Submit
    Review --> [*] : Approve
```

## Transitions (Uebergaenge)

### Transition mit Label
```mermaid
stateDiagram-v2
    [*] --> Idle
    Idle --> Running : start
    Running --> Idle : stop
    Running --> Error : fail
    Error --> Idle : reset
```

### Transition mit Bedingung
```mermaid
stateDiagram-v2
    [*] --> Checking
    Checking --> Valid : valid
    Checking --> Invalid : invalid
    Valid --> [*]
    Invalid --> [*]
```

## Nested States (Verschachtelte States)

### Composite States
```mermaid
stateDiagram-v2
    [*] --> Active
    
    state Active {
        [*] --> Pending
        Pending --> InProgress : start
        InProgress --> Pending : pause
        InProgress --> Completed : finish
        Completed --> [*]
    }
    
    Active --> Inactive : deactivate
    Inactive --> [*]
```

### Parallel States
```mermaid
stateDiagram-v2
    [*] --> Active
    
    state Active {
        [*] --> State1
        State1 --> State2
    }
    
    state Active {
        [*] --> StateA
        StateA --> StateB
    }
    
    Active --> [*]
```

## Clevermation Templates

### Order Status Flow
```mermaid
stateDiagram-v2
    [*] --> Pending : Create Order
    
    state Pending {
        [*] --> PaymentPending
        PaymentPending --> PaymentReceived : payment
        PaymentReceived --> PaymentFailed : fail
        PaymentFailed --> PaymentPending : retry
    }
    
    Pending --> Processing : payment received
    Processing --> Shipped : ship
    Shipped --> Delivered : deliver
    Delivered --> [*]
    
    Pending --> Cancelled : cancel
    Processing --> Cancelled : cancel
    Cancelled --> [*]
```

### User Authentication Flow
```mermaid
stateDiagram-v2
    [*] --> LoggedOut
    
    state LoggedOut {
        [*] --> EnteringCredentials
        EnteringCredentials --> Validating : submit
        Validating --> CredentialsInvalid : invalid
        Validating --> CredentialsValid : valid
        CredentialsInvalid --> EnteringCredentials : retry
        CredentialsValid --> [*]
    }
    
    LoggedOut --> LoggedIn : login success
    
    state LoggedIn {
        [*] --> Active
        Active --> Idle : inactive
        Idle --> Active : activity
        Active --> SessionExpired : timeout
        SessionExpired --> [*]
    }
    
    LoggedIn --> LoggedOut : logout
```

### Workflow Approval Process
```mermaid
stateDiagram-v2
    [*] --> Draft
    
    Draft --> Submitted : submit
    Submitted --> UnderReview : assign reviewer
    
    state UnderReview {
        [*] --> Reviewing
        Reviewing --> NeedsChanges : request changes
        Reviewing --> Approved : approve
        NeedsChanges --> Reviewing : resubmit
    }
    
    UnderReview --> Approved : approve
    UnderReview --> Rejected : reject
    
    Approved --> Published : publish
    Published --> [*]
    
    Rejected --> Draft : revise
```

## Best Practices

### 1. Klare State-Namen
- Aussagekraeftige Namen verwenden
- States als Substantive (Draft, Review, Approved)
- Transitions als Verben (submit, approve, reject)

### 2. Logische Struktur
- Start-State: `[*]`
- End-State: `[*]`
- Verschachtelte States fuer komplexe Logik

### 3. Transition-Labels
- Immer Labels bei Transitions
- Klare Bedingungen/Events
- Konsistente Namensgebung

### 4. Komplexitaet managen
- Bei vielen States: Verschachteln
- Wichtige States hervorheben
- Unwichtige Details weglassen

## Verwendung im Plan Agent

Wenn der Plan Agent ein State Diagram erstellen soll:
1. Identifiziere alle moeglichen Zustaende
2. Definiere Start- und End-Zustaende
3. Bestimme alle moeglichen Uebergaenge
4. Markiere Bedingungen/Events fuer Uebergaenge
5. Verwende verschachtelte States bei Komplexitaet
6. Erstelle das Diagramm mit diesem Skill

**Wichtig:** Nutze diesen Skill NUR fuer State Diagrams. Fuer andere Diagrammtypen verwende die entsprechenden Skills (flowchart, sequence, er, etc.).

