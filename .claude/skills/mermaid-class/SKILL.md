---
name: mermaid-class
description: Mermaid Class Diagramme. Spezialisiert auf OOP-Strukturen, TypeScript Interfaces, Domain-Modelle und Klassen-Beziehungen. Nutze diesen Skill wenn Class Diagrams, Datenmodelle oder OOP-Strukturen visualisiert werden sollen.
---

# Mermaid Class Diagram Skill

Spezialisierter Skill fuer Mermaid Class-Diagramme. Class Diagrams visualisieren Klassen-Strukturen, Beziehungen und OOP-Modelle.

## Grundlagen

### Basis-Syntax
```mermaid
classDiagram
    class Animal {
        +String name
        +int age
        +makeSound() void
    }
    
    class Dog {
        +String breed
        +bark() void
    }
    
    Animal <|-- Dog
```

## Klassen definieren

### Einfache Klasse
```mermaid
classDiagram
    class User {
        +String id
        +String email
        +String name
    }
```

### Klasse mit Sichtbarkeit
```mermaid
classDiagram
    class User {
        +String id
        -String password
        #String internalId
        ~String tempData
    }
```

### Sichtbarkeits-Modifikatoren
- `+` - Public
- `-` - Private
- `#` - Protected
- `~` - Package/Internal

### Klasse mit Methoden
```mermaid
classDiagram
    class User {
        +String id
        +String email
        +login() boolean
        +logout() void
        +updateProfile() User
    }
```

### Interface/Abstract Class
```mermaid
classDiagram
    class Animal {
        <<interface>>
        +String name
        +makeSound() void
    }
    
    class Dog {
        +String breed
        +bark() void
    }
    
    Animal <|.. Dog
```

## Beziehungen

### Vererbung (Inheritance)
```mermaid
classDiagram
    class Animal
    class Dog
    class Cat
    
    Animal <|-- Dog
    Animal <|-- Cat
```

### Realisierung (Implementation)
```mermaid
classDiagram
    class Animal {
        <<interface>>
    }
    class Dog
    
    Animal <|.. Dog
```

### Komposition (Composition)
```mermaid
classDiagram
    class Car
    class Engine
    
    Car *-- Engine
```

### Aggregation (Aggregation)
```mermaid
classDiagram
    class Owner
    class Pet
    
    Owner o-- Pet
```

### Assoziation (Association)
```mermaid
classDiagram
    class User
    class Order
    
    User --> Order
```

### Dependency (Dependency)
```mermaid
classDiagram
    class UserService
    class Database
    
    UserService ..> Database
```

### Kardinalitaeten
```mermaid
classDiagram
    class User
    class Order
    
    User "1" --> "*" Order
    User "1" --> "0..1" Profile
```

## Vollstaendiges Beispiel

### E-Commerce Domain Model
```mermaid
classDiagram
    class User {
        +String id
        +String email
        +String name
        +login() boolean
        +logout() void
    }
    
    class Order {
        +String id
        +Date createdAt
        +Decimal total
        +calculateTotal() Decimal
        +addItem() void
    }
    
    class OrderItem {
        +String id
        +int quantity
        +Decimal price
        +getSubtotal() Decimal
    }
    
    class Product {
        +String id
        +String name
        +Decimal price
        +boolean active
        +isAvailable() boolean
    }
    
    class Category {
        +String id
        +String name
        +String slug
    }
    
    User "1" --> "*" Order : places
    Order "1" --> "*" OrderItem : contains
    Product "1" --> "*" OrderItem : "ordered in"
    Category "1" --> "*" Product : contains
```

## Clevermation Templates

### Supabase Client Structure
```mermaid
classDiagram
    class SupabaseClient {
        +auth AuthClient
        +from() QueryBuilder
        +storage StorageClient
        +rpc() RPCBuilder
    }
    
    class AuthClient {
        +signUp() AuthResponse
        +signIn() AuthResponse
        +signOut() void
        +getUser() UserResponse
    }
    
    class QueryBuilder {
        +select() QueryBuilder
        +insert() QueryBuilder
        +update() QueryBuilder
        +delete() QueryBuilder
    }
    
    SupabaseClient *-- AuthClient
    SupabaseClient *-- QueryBuilder
```

### N8N Workflow Structure
```mermaid
classDiagram
    class Workflow {
        +String id
        +String name
        +Node[] nodes
        +Connection[] connections
        +execute() Execution
    }
    
    class Node {
        <<abstract>>
        +String type
        +Object parameters
        +execute() Item[]
    }
    
    class TriggerNode {
        +trigger() void
    }
    
    class ActionNode {
        +execute() Item[]
    }
    
    class TransformNode {
        +transform() Item[]
    }
    
    Workflow "1" --> "*" Node
    Node <|-- TriggerNode
    Node <|-- ActionNode
    Node <|-- TransformNode
```

## Best Practices

### 1. Klare Struktur
- Klassen mit aussagekraeftigen Namen
- Sichtbarkeit korrekt setzen
- Methoden und Attribute vollstaendig

### 2. Beziehungen richtig darstellen
- Vererbung: `<|--`
- Komposition: `*--` (starke Beziehung)
- Aggregation: `o--` (schwache Beziehung)
- Dependency: `..>` (nutzt, aber besitzt nicht)

### 3. Kardinalitaeten angeben
- `"1"` - Genau eins
- `"*"` - Viele
- `"0..1"` - Null oder eins
- `"1..*"` - Eins oder mehr

### 4. Interfaces/Abstract Classes
- Mit `<<interface>>` oder `<<abstract>>` markieren
- Realisierung mit `<|..` zeigen

## Verwendung im Plan Agent

Wenn der Plan Agent ein Class Diagram erstellen soll:
1. Identifiziere alle Klassen/Interfaces
2. Definiere Attribute und Methoden
3. Bestimme Beziehungen zwischen Klassen
4. Setze Kardinalitaeten
5. Erstelle das Diagramm mit diesem Skill

**Wichtig:** Nutze diesen Skill NUR fuer Class Diagrams. Fuer andere Diagrammtypen verwende die entsprechenden Skills (flowchart, sequence, er, etc.).

