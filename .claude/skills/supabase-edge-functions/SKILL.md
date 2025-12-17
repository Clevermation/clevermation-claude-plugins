---
name: supabase-edge-functions
description: Supabase Edge Functions. Spezialisiert auf Serverless Functions, Deno/TypeScript, API-Endpunkte und MCP-basierte Edge Function-Operationen. Nutze diesen Skill wenn du Edge Functions erstellst oder verwaltest.
---

# Supabase Edge Functions Skill

Spezialisierter Skill fuer Supabase Edge Functions. Fokussiert auf Serverless TypeScript/Deno Functions.

## Edge Function erstellen

### Mit Supabase CLI
```bash
supabase functions new my-function
```

### Funktion-Struktur
```typescript
// supabase/functions/my-function/index.ts
import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from 'jsr:@supabase/supabase-js@2';

Deno.serve(async (req: Request) => {
  const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  };

  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_ANON_KEY')!,
      {
        global: {
          headers: { Authorization: req.headers.get('Authorization')! },
        },
      }
    );

    const { data: { user } } = await supabase.auth.getUser();
    if (!user) {
      return new Response(JSON.stringify({ error: 'Unauthorized' }), {
        status: 401,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const { name } = await req.json();

    const { data, error } = await supabase
      .from('items')
      .insert({ name, user_id: user.id })
      .select()
      .single();

    if (error) throw error;

    return new Response(JSON.stringify(data), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
```

## Deployment

### Mit Supabase CLI
```bash
supabase functions deploy my-function
```

### Mit MCP Server
```
Nutze deploy_edge_function Tool falls verfuegbar
```

## Best Practices

1. **CORS Headers** immer setzen
2. **Auth-Checks** durchfuehren
3. **Error Handling** implementieren
4. **TypeScript** verwenden

## Verwendung im Supabase Agent

Wenn der Supabase Agent Edge Functions erstellen soll:
1. Definiere die Function-Logik
2. Implementiere Auth-Checks
3. Setze CORS Headers
4. Deploye die Function
5. Nutze MCP Tools falls verfuegbar

**Wichtig:** Nutze diesen Skill NUR fuer Edge Functions. Fuer andere Supabase-Bereiche verwende die entsprechenden Skills (migration, auth, rls, etc.).

