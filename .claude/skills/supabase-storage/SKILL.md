---
name: supabase-storage
description: Supabase Storage. Spezialisiert auf File-Uploads, Buckets, Storage-Policies und MCP-basierte Storage-Operationen. Nutze diesen Skill wenn du mit Supabase Storage arbeitest.
---

# Supabase Storage Skill

Spezialisierter Skill fuer Supabase Storage. Fokussiert auf File-Management und Buckets.

## Buckets erstellen

### Mit SQL
```sql
INSERT INTO storage.buckets (id, name, public)
VALUES ('avatars', 'avatars', true);
```

### Storage Policies
```sql
-- Oeffentlicher Zugriff
CREATE POLICY "Avatar images are publicly accessible"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'avatars');

-- User kann eigenes Avatar hochladen
CREATE POLICY "Users can upload own avatar"
  ON storage.objects FOR INSERT
  WITH CHECK (
    bucket_id = 'avatars' AND
    auth.uid()::text = (storage.foldername(name))[1]
  );
```

## File-Operationen

### Upload
```typescript
const { data, error } = await supabase.storage
  .from('avatars')
  .upload(`${userId}/avatar.png`, file, {
    cacheControl: '3600',
    upsert: true,
  });
```

### Download
```typescript
const { data, error } = await supabase.storage
  .from('avatars')
  .download(`${userId}/avatar.png`);
```

### Public URL
```typescript
const { data } = supabase.storage
  .from('avatars')
  .getPublicUrl(`${userId}/avatar.png`);
```

### Signed URL
```typescript
const { data, error } = await supabase.storage
  .from('private-files')
  .createSignedUrl('path/to/file.pdf', 3600);
```

### Delete
```typescript
const { error } = await supabase.storage
  .from('avatars')
  .remove([`${userId}/avatar.png`]);
```

### List
```typescript
const { data, error } = await supabase.storage
  .from('avatars')
  .list(userId);
```

## Best Practices

1. **Bucket-Namen** klar und konsistent
2. **Storage Policies** immer setzen
3. **Signed URLs** fuer private Dateien
4. **File-Groesse** limitieren

## Verwendung im Supabase Agent

Wenn der Supabase Agent Storage-Operationen durchfuehren soll:
1. Erstelle Buckets falls noetig
2. Setze Storage Policies
3. Implementiere Upload/Download-Logik
4. Nutze MCP Tools falls verfuegbar

**Wichtig:** Nutze diesen Skill NUR fuer Storage. Fuer andere Supabase-Bereiche verwende die entsprechenden Skills (migration, auth, rls, etc.).

