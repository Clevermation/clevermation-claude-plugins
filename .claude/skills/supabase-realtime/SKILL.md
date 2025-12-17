---
name: supabase-realtime
description: Supabase Realtime. Spezialisiert auf Subscriptions, Broadcasts, Echtzeit-Updates und MCP-basierte Realtime-Operationen. Nutze diesen Skill wenn du mit Supabase Realtime arbeitest.
---

# Supabase Realtime Skill

Spezialisierter Skill fuer Supabase Realtime. Fokussiert auf Echtzeit-Updates und Subscriptions.

## Subscriptions

### Tabellen-Aenderungen
```typescript
const channel = supabase
  .channel('table-changes')
  .on(
    'postgres_changes',
    { event: '*', schema: 'public', table: 'messages' },
    (payload) => {
      console.log('Change:', payload);
    }
  )
  .subscribe();
```

### Spezifische Events
```typescript
const channel = supabase
  .channel('inserts')
  .on(
    'postgres_changes',
    { event: 'INSERT', schema: 'public', table: 'messages' },
    (payload) => console.log('New message:', payload.new)
  )
  .on(
    'postgres_changes',
    { event: 'UPDATE', schema: 'public', table: 'messages' },
    (payload) => console.log('Updated:', payload.new)
  )
  .subscribe();
```

### Mit Filter
```typescript
const channel = supabase
  .channel('user-messages')
  .on(
    'postgres_changes',
    {
      event: '*',
      schema: 'public',
      table: 'messages',
      filter: `user_id=eq.${userId}`,
    },
    (payload) => console.log('My message:', payload)
  )
  .subscribe();
```

## Broadcast

### Senden
```typescript
await supabase
  .channel('room1')
  .send({
    type: 'broadcast',
    event: 'cursor-pos',
    payload: { x: 100, y: 200 },
  });
```

### Empfangen
```typescript
const channel = supabase
  .channel('room1')
  .on('broadcast', { event: 'cursor-pos' }, (payload) => {
    console.log('Cursor:', payload);
  })
  .subscribe();
```

## Unsubscribe
```typescript
await supabase.removeChannel(channel);
```

## Best Practices

1. **Channels** sinnvoll benennen
2. **Cleanup** - Channels entfernen wenn nicht mehr benoetigt
3. **Filter** verwenden um Datenmenge zu reduzieren
4. **Error Handling** implementieren

## Verwendung im Supabase Agent

Wenn der Supabase Agent Realtime implementieren soll:
1. Definiere welche Events abonniert werden sollen
2. Erstelle Channels
3. Implementiere Event-Handler
4. Cleanup bei Unmount
5. Nutze MCP Tools falls verfuegbar

**Wichtig:** Nutze diesen Skill NUR fuer Realtime. Fuer andere Supabase-Bereiche verwende die entsprechenden Skills (migration, auth, rls, etc.).

