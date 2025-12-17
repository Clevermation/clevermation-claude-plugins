---
name: web-research
description: Systematische Web-Recherche Methodik. Nutze diesen Skill fuer umfassende Informationssuche mit Quellenvalidierung und strukturierter Aufbereitung.
---

# Web-Recherche Skill

Dieser Skill definiert Best Practices fuer systematische Web-Recherche.

## Wann diesen Skill nutzen

- Informationen zu neuen Technologien/APIs recherchieren
- Best Practices fuer Implementierungen finden
- Dokumentation und Tutorials sammeln
- Marktanalysen und Wettbewerbsrecherche
- Fehlerbehebung durch Community-Wissen

## Recherche-Methodik

### 1. Suchstrategie

**Primaere Quellen (hoechste Prioritaet):**
- Offizielle Dokumentationen
- GitHub Repositories (README, Issues, Discussions)
- Peer-reviewed Artikel

**Sekundaere Quellen:**
- Tech-Blogs von etablierten Unternehmen
- StackOverflow (akzeptierte Antworten)
- Medium/Dev.to (verifizierte Autoren)

**Tertiaere Quellen (mit Vorsicht):**
- Forum-Diskussionen
- Social Media
- Nicht-verifizierte Blogs

### 2. Suchoperatoren

```
site:docs.microsoft.com "power automate"
"supabase" tutorial 2024
filetype:pdf "api integration" best practices
inurl:github "n8n" workflow example
```

### 3. Quellen-Bewertung

| Kriterium | Frage |
|-----------|-------|
| Aktualitaet | Wann wurde es veroeffentlicht/aktualisiert? |
| Autoritaet | Wer ist der Autor? Welche Expertise? |
| Genauigkeit | Sind Fakten ueberpruefbar? |
| Zweck | Was ist die Intention des Inhalts? |
| Konsistenz | Stimmt es mit anderen Quellen ueberein? |

### 4. Informations-Extraktion

**Strukturierte Notizen:**
```markdown
## Quelle: [URL]
- **Datum:** [Veroeffentlichung/Aktualisierung]
- **Autor:** [Name/Organisation]
- **Kernaussagen:**
  1. ...
  2. ...
- **Code-Beispiele:** [Falls vorhanden]
- **Einschraenkungen:** [Bekannte Limitierungen]
```

### 5. Synthese-Template

```markdown
# [Thema] - Recherche-Ergebnis

## Executive Summary
[1 Absatz: Was wurde gefunden, was ist die Empfehlung?]

## Hintergrund
[Kontext und Problemstellung]

## Analyse
### Option A: [Name]
- Vorteile: ...
- Nachteile: ...
- Beispiel: ...

### Option B: [Name]
- Vorteile: ...
- Nachteile: ...
- Beispiel: ...

## Empfehlung
[Klare Handlungsempfehlung mit Begruendung]

## Quellen
1. [Titel](URL) - [Kurzbeschreibung]
2. ...

## Naechste Schritte
1. ...
2. ...
```

## Clevermation-spezifische Recherche

### Haeufige Recherche-Themen

**Microsoft Power Platform:**
- Power Automate Flows
- Power Apps Komponenten
- Dataverse Schemas
- Premium Connectors

**N8N:**
- Workflow Templates
- Custom Node Development
- Credential Management
- Error Handling Patterns

**Supabase:**
- Database Design
- Row Level Security
- Edge Functions
- Realtime Subscriptions

**Airtable:**
- Formula Fields
- Automations
- API Rate Limits
- Sync-Strategien

### Nuetzliche Ressourcen

- Microsoft Learn: https://learn.microsoft.com
- N8N Docs: https://docs.n8n.io
- Supabase Docs: https://supabase.com/docs
- Airtable API: https://airtable.com/developers/web/api

## Tool-Nutzung

### WebSearch
Fuer breite Suche nach Themen:
```
WebSearch("supabase edge functions typescript tutorial 2024")
```

### WebFetch
Fuer spezifische Seiten:
```
WebFetch("https://supabase.com/docs/guides/functions", "Extract tutorial steps")
```

### Firecrawl MCP (falls aktiviert)
Fuer strukturierte Extraktion:
```
firecrawl_scrape(url, formats=["markdown"])
firecrawl_crawl(url, max_depth=2)
```
