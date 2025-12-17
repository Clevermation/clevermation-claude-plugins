---
name: supabase-rls
description: Supabase Row Level Security (RLS). Spezialisiert auf RLS Policies, Zugriffskontrollen, Sicherheit und MCP-basierte RLS-Operationen. Nutze diesen Skill wenn du RLS Policies erstellen oder verwalten musst.
---

# Supabase RLS Skill

Spezialisierter Skill fuer Supabase Row Level Security (RLS). Fokussiert auf Zugriffskontrollen und Sicherheit.

## WICHTIG: RLS aktivieren

RLS muss explizit aktiviert werden:
```sql
ALTER TABLE table_name ENABLE ROW LEVEL SECURITY;
```

**Ohne RLS:** Alle Daten sind oeffentlich zugaenglich!

## Basis-Policies

### SELECT Policy (Lesen)
```sql
CREATE POLICY "Users can view own data"
  ON table_name FOR SELECT
  USING (auth.uid() = user_id);
```

### INSERT Policy (Einfuegen)
```sql
CREATE POLICY "Users can insert own data"
  ON table_name FOR INSERT
  WITH CHECK (auth.uid() = user_id);
```

### UPDATE Policy (Aktualisieren)
```sql
CREATE POLICY "Users can update own data"
  ON table_name FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);
```

### DELETE Policy (Loeschen)
```sql
CREATE POLICY "Users can delete own data"
  ON table_name FOR DELETE
  USING (auth.uid() = user_id);
```

## Erweiterte Patterns

### Rollen-basierte Policies
```sql
CREATE POLICY "Admins can do anything"
  ON table_name FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM user_roles
      WHERE user_id = auth.uid()
      AND role = 'admin'
    )
  );
```

### Team-basierte Policies
```sql
CREATE POLICY "Team members can view team data"
  ON projects FOR SELECT
  USING (
    team_id IN (
      SELECT team_id FROM team_members
      WHERE user_id = auth.uid()
    )
  );
```

### Oeffentliche Lesen, Authentifizierte Schreiben
```sql
-- Oeffentlich lesbar
CREATE POLICY "Public read access"
  ON products FOR SELECT
  USING (true);

-- Nur authentifizierte User koennen schreiben
CREATE POLICY "Authenticated users can insert"
  ON products FOR INSERT
  WITH CHECK (auth.role() = 'authenticated');
```

## Best Practices

1. **Immer RLS aktivieren** bei Tabellen mit sensiblen Daten
2. **Teste Policies** mit verschiedenen User-Rollen
3. **Nutze Helper-Functions** fuer komplexe Logik
4. **Dokumentiere Policies** klar

## Verwendung im Supabase Agent

Wenn der Supabase Agent RLS Policies erstellen soll:
1. Analysiere die Zugriffsanforderungen
2. Definiere Policies fuer SELECT, INSERT, UPDATE, DELETE
3. Teste die Policies mit verschiedenen Usern
4. Nutze MCP Tools falls verfuegbar

**Wichtig:** Nutze diesen Skill NUR fuer RLS. Fuer andere Supabase-Bereiche verwende die entsprechenden Skills (migration, auth, storage, etc.).

