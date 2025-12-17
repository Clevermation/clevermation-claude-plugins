---
name: supabase-auth
description: Supabase Authentication. Spezialisiert auf User-Management, Login-Flows, OAuth, Session-Management und MCP-basierte Auth-Operationen. Nutze diesen Skill wenn du mit Supabase Authentication arbeitest.
---

# Supabase Auth Skill

Spezialisierter Skill fuer Supabase Authentication. Fokussiert auf User-Management und Authentifizierungs-Flows.

## WICHTIG: MCP Supabase Server

Falls der Supabase MCP Server aktiviert ist, kannst du Auth-Operationen direkt durchfuehren. Pruefe die verfuegbaren MCP Tools fuer Auth-Funktionen.

## Authentication-Methoden

### Email/Password

#### Signup
```typescript
const { data, error } = await supabase.auth.signUp({
  email: 'user@example.com',
  password: 'securepassword',
  options: {
    data: {
      full_name: 'John Doe',
    },
  },
});
```

#### Login
```typescript
const { data, error } = await supabase.auth.signInWithPassword({
  email: 'user@example.com',
  password: 'securepassword',
});
```

#### Logout
```typescript
await supabase.auth.signOut();
```

### OAuth Providers

#### Google OAuth
```typescript
const { data, error } = await supabase.auth.signInWithOAuth({
  provider: 'google',
  options: {
    redirectTo: 'http://localhost:3000/auth/callback',
  },
});
```

#### GitHub OAuth
```typescript
const { data, error } = await supabase.auth.signInWithOAuth({
  provider: 'github',
  options: {
    redirectTo: 'http://localhost:3000/auth/callback',
  },
});
```

### Magic Link
```typescript
const { data, error } = await supabase.auth.signInWithOtp({
  email: 'user@example.com',
  options: {
    emailRedirectTo: 'http://localhost:3000/welcome',
  },
});
```

## Session-Management

### Session abrufen
```typescript
const { data: { session } } = await supabase.auth.getSession();
```

### User abrufen
```typescript
const { data: { user } } = await supabase.auth.getUser();
```

### Session aktualisieren
```typescript
const { data: { session }, error } = await supabase.auth.refreshSession();
```

## User Profile Extension

### Profil-Tabelle erstellen
```sql
-- Migration: create_profiles_table
CREATE TABLE public.profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  username TEXT UNIQUE,
  full_name TEXT,
  avatar_url TEXT,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

-- Automatisch Profil erstellen bei Signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, avatar_url)
  VALUES (
    NEW.id,
    NEW.raw_user_meta_data->>'full_name',
    NEW.raw_user_meta_data->>'avatar_url'
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
```

### Profil abrufen
```typescript
const { data: profile } = await supabase
  .from('profiles')
  .select('*')
  .eq('id', user.id)
  .single();
```

## Auth Callback (Next.js)

### Route Handler
```typescript
// app/auth/callback/route.ts
import { createRouteHandlerClient } from '@supabase/auth-helpers-nextjs';
import { cookies } from 'next/headers';
import { NextResponse } from 'next/server';

export async function GET(request: Request) {
  const requestUrl = new URL(request.url);
  const code = requestUrl.searchParams.get('code');

  if (code) {
    const supabase = createRouteHandlerClient({ cookies });
    await supabase.auth.exchangeCodeForSession(code);
  }

  return NextResponse.redirect(requestUrl.origin);
}
```

## Password Reset

### Reset-Link senden
```typescript
const { data, error } = await supabase.auth.resetPasswordForEmail(
  'user@example.com',
  {
    redirectTo: 'http://localhost:3000/reset-password',
  }
);
```

### Password aendern
```typescript
const { data, error } = await supabase.auth.updateUser({
  password: 'newpassword',
});
```

## Best Practices

### 1. Session-Handling
- Pruefe Session bei jeder geschuetzten Route
- Nutze Server-Side Session-Checks
- Refresh Session bei Bedarf

### 2. Security
- Nutze Service Role Key NUR Server-Side
- Nutze Anon Key im Frontend
- Validiere User-Input immer

### 3. Error Handling
- Behandle Auth-Fehler angemessen
- Zeige benutzerfreundliche Fehlermeldungen
- Logge Auth-Fehler Server-Side

## Verwendung im Supabase Agent

Wenn der Supabase Agent Auth-Funktionen implementieren soll:
1. Bestimme die Auth-Methode (Email/Password, OAuth, etc.)
2. Implementiere Signup/Login-Flows
3. Erstelle Profil-Tabellen falls noetig
4. Implementiere Session-Management
5. Nutze MCP Tools falls verfuegbar

**Wichtig:** Nutze diesen Skill NUR fuer Authentication. Fuer andere Supabase-Bereiche verwende die entsprechenden Skills (migration, rls, storage, etc.).

