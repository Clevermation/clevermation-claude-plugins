---
name: supabase-migration
description: Supabase Datenbank-Migrationen. Spezialisiert auf Migration-Management, Schema-Aenderungen, Versionierung und MCP-basierte Migration-Operationen. Nutze diesen Skill wenn du Migrationen erstellen, anwenden oder verwalten musst.
---

# Supabase Migration Skill

Spezialisierter Skill fuer Supabase Datenbank-Migrationen. Fokussiert auf MCP-basierte Migration-Operationen.

## WICHTIG: MCP Supabase Server

Falls der Supabase MCP Server aktiviert ist, kannst du Migration-Operationen direkt durchfuehren:
- `apply_migration` - Migration anwenden
- `list_migrations` - Alle Migrationen auflisten
- `execute_sql` - SQL direkt ausfuehren (nur fuer DML, nicht DDL!)

**Fuer DDL-Operationen:** Nutze IMMER `apply_migration`, nicht `execute_sql`!

## Migration-Erstellung

### Mit Supabase CLI
```bash
# Neue Migration erstellen
supabase migration new create_users_table

# Migration-Datei wird erstellt:
# supabase/migrations/YYYYMMDDHHMMSS_create_users_table.sql
```

### Migration-Datei-Struktur
```sql
-- Migration: create_users_table
-- Created: 2024-01-15

-- Tabellen erstellen
CREATE TABLE IF NOT EXISTS public.users (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

-- Indizes erstellen
CREATE INDEX idx_users_email ON public.users(email);

-- Kommentare hinzufuegen
COMMENT ON TABLE public.users IS 'User accounts table';
COMMENT ON COLUMN public.users.email IS 'Unique email address';
```

## Migration anwenden

### Mit Supabase CLI
```bash
# Lokale Migrationen anwenden
supabase db push

# Spezifische Migration anwenden
supabase migration up

# Migration zuruecknehmen
supabase migration down
```

### Mit MCP Server
```
Nutze apply_migration Tool:
- project_id: Deine Projekt-ID
- name: Migration-Name (snake_case)
- query: SQL-Query der Migration
```

## Best Practices

### 1. Migration-Namen
- Verwende aussagekraeftige Namen
- Format: `action_object` (z.B. `create_users_table`)
- Snake_case verwenden

### 2. Idempotenz
- Nutze `IF NOT EXISTS` bei CREATE
- Nutze `IF EXISTS` bei DROP
- Pruefe ob Spalten/Tabellen existieren

### 3. Rollback-Sicherheit
- Jede Migration sollte rueckgaengig gemacht werden koennen
- Dokumentiere Rollback-Schritte
- Teste Migrationen lokal vorher

### 4. Reihenfolge beachten
- Abhaengigkeiten beachten (Foreign Keys)
- Erst Tabellen, dann Indizes
- Erst CREATE, dann ALTER

## Clevermation Patterns

### Standard-Tabellen-Template
```sql
-- Migration: create_orders_table
CREATE TABLE IF NOT EXISTS public.orders (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    total DECIMAL(10,2) NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending',
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

-- Indizes
CREATE INDEX IF NOT EXISTS idx_orders_user_id ON public.orders(user_id);
CREATE INDEX IF NOT EXISTS idx_orders_status ON public.orders(status);

-- Updated_at Trigger
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_orders_updated_at
    BEFORE UPDATE ON public.orders
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at();
```

### Spalte hinzufuegen
```sql
-- Migration: add_phone_to_users
ALTER TABLE public.users
ADD COLUMN IF NOT EXISTS phone TEXT;

-- Mit Default-Wert
ALTER TABLE public.users
ADD COLUMN IF NOT EXISTS phone TEXT DEFAULT '';
```

### Spalte aendern
```sql
-- Migration: modify_users_email
ALTER TABLE public.users
ALTER COLUMN email TYPE VARCHAR(255);

-- Mit Constraint
ALTER TABLE public.users
ALTER COLUMN email SET NOT NULL;
```

### Tabelle loeschen
```sql
-- Migration: drop_old_table
DROP TABLE IF EXISTS public.old_table CASCADE;
```

## Verwendung im Supabase Agent

Wenn der Supabase Agent Migrationen erstellen soll:
1. Analysiere die gewuenschte Schema-Aenderung
2. Erstelle eine neue Migration-Datei
3. Nutze idempotente SQL-Befehle
4. Teste die Migration lokal falls moeglich
5. Wende die Migration mit MCP `apply_migration` an

**Wichtig:** Nutze diesen Skill NUR fuer Migrationen. Fuer andere Supabase-Bereiche verwende die entsprechenden Skills (auth, rls, storage, etc.).

