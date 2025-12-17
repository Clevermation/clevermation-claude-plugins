---
name: mermaid-er
description: Mermaid Entity Relationship Diagramme. Spezialisiert auf Datenbank-Schemas, Tabellen-Beziehungen, Kardinalitaeten und Datenmodellierung. Nutze diesen Skill wenn ER-Diagramme, Datenbankschemas oder Datenmodell-Visualisierungen erstellt werden sollen.
---

# Mermaid ER Diagram Skill

Spezialisierter Skill fuer Mermaid Entity Relationship (ER) Diagramme. ER-Diagramme visualisieren Datenbank-Schemas und Beziehungen zwischen Entitaeten.

## Grundlagen

### Basis-Syntax
```mermaid
erDiagram
    CUSTOMER ||--o{ ORDER : places
    ORDER ||--|{ ORDER_ITEM : contains
    PRODUCT ||--o{ ORDER_ITEM : "ordered in"
```

## Entitaeten definieren

### Einfache Entitaet
```mermaid
erDiagram
    USER {
        uuid id PK
        string email
        string name
    }
```

### Vollstaendige Entitaet mit allen Details
```mermaid
erDiagram
    USER {
        uuid id PK "Primary Key"
        string email UK "Unique Email"
        string name "Full Name"
        timestamp created_at "Created Date"
        boolean is_active "Active Status"
    }
```

## Beziehungen (Relationships)

### Kardinalitaeten
```mermaid
erDiagram
    USER ||--o{ ORDER : places
    ORDER ||--|{ ORDER_ITEM : contains
```

### Kardinalitaets-Notation
- `||` - Exactly one (1)
- `|o` - Zero or one (0..1)
- `}o` - Zero or more (0..*)
- `}|` - One or more (1..*)

### Beziehungs-Typen
```mermaid
erDiagram
    A ||--|| B : "One to One"
    C ||--o{ D : "One to Many"
    E }o--o{ F : "Many to Many"
    G }|--|| H : "Many to One"
```

## Vollstaendiges Beispiel

### E-Commerce Schema
```mermaid
erDiagram
    CUSTOMER ||--o{ ORDER : places
    ORDER ||--|{ ORDER_ITEM : contains
    PRODUCT ||--o{ ORDER_ITEM : "ordered in"
    CATEGORY ||--o{ PRODUCT : contains
    
    CUSTOMER {
        uuid id PK
        string email UK
        string name
        timestamp created_at
    }
    
    ORDER {
        uuid id PK
        uuid customer_id FK
        decimal total
        enum status "pending, completed, cancelled"
        timestamp created_at
    }
    
    ORDER_ITEM {
        uuid id PK
        uuid order_id FK
        uuid product_id FK
        int quantity
        decimal price
    }
    
    PRODUCT {
        uuid id PK
        uuid category_id FK
        string name
        decimal price
        boolean active
    }
    
    CATEGORY {
        uuid id PK
        string name
        string slug UK
    }
```

## Clevermation Templates

### Supabase Multi-Tenant Schema
```mermaid
erDiagram
    ORGANIZATION ||--o{ ORGANIZATION_MEMBER : has
    ORGANIZATION ||--o{ PROJECT : owns
    USER ||--o{ ORGANIZATION_MEMBER : belongs_to
    PROJECT ||--o{ TASK : contains
    
    ORGANIZATION {
        uuid id PK
        string name
        string slug UK
        timestamp created_at
    }
    
    ORGANIZATION_MEMBER {
        uuid id PK
        uuid organization_id FK
        uuid user_id FK
        enum role "owner, admin, member"
        timestamp created_at
    }
    
    USER {
        uuid id PK
        string email UK
        string name
        timestamp created_at
    }
    
    PROJECT {
        uuid id PK
        uuid organization_id FK
        string name
        enum status "active, archived"
        timestamp created_at
    }
    
    TASK {
        uuid id PK
        uuid project_id FK
        string title
        enum status "todo, in_progress, done"
        timestamp created_at
    }
```

### User Profile Extension
```mermaid
erDiagram
    AUTH_USER ||--|| PROFILE : has
    PROFILE }o--o{ TEAM : belongs_to
    
    AUTH_USER {
        uuid id PK
        string email UK
        timestamp created_at
    }
    
    PROFILE {
        uuid id PK "References auth.users"
        string username UK
        string full_name
        text avatar_url
        timestamp created_at
        timestamp updated_at
    }
    
    TEAM {
        uuid id PK
        string name
        string slug UK
        timestamp created_at
    }
```

## Best Practices

### 1. Klare Namenskonventionen
- Tabellen: Plural, snake_case (`users`, `order_items`)
- Spalten: snake_case (`user_id`, `created_at`)
- Primary Keys: immer `id`
- Foreign Keys: `tabelle_id`

### 2. Vollstaendige Definitionen
- Alle wichtigen Spalten definieren
- Datentypen angeben (uuid, string, timestamp, etc.)
- Constraints markieren (PK, UK, FK)

### 3. Beziehungen klar darstellen
- Kardinalitaeten korrekt setzen
- Beziehungsnamen aussagekraeftig
- Richtung der Beziehung beachten

### 4. Komplexitaet managen
- Bei vielen Tabellen: Aufteilen in mehrere Diagramme
- Wichtige Beziehungen hervorheben
- Unwichtige Details weglassen

## Verwendung im Plan Agent

Wenn der Plan Agent ein ER-Diagramm erstellen soll:
1. Analysiere das Datenmodell/Schema
2. Identifiziere alle Entitaeten (Tabellen)
3. Definiere Attribute (Spalten) pro Entitaet
4. Bestimme Beziehungen und Kardinalitaeten
5. Erstelle das Diagramm mit diesem Skill

**Wichtig:** Nutze diesen Skill NUR fuer ER-Diagramme. Fuer andere Diagrammtypen verwende die entsprechenden Skills (flowchart, sequence, gantt, etc.).

