---
name: n8n-workflows
description: N8N Workflow-Automation. Referenz fuer Trigger, Nodes, Daten-Transformation, Integrationen und Best Practices.
---

# N8N Workflow Skill

Umfassende Referenz fuer N8N-Automatisierung in Clevermation-Projekten.

## Quick Reference

### API Endpoints
```
GET    /workflows                 - Liste aller Workflows
GET    /workflows/{id}            - Workflow Details
POST   /workflows                 - Workflow erstellen
PUT    /workflows/{id}            - Workflow aktualisieren
DELETE /workflows/{id}            - Workflow loeschen
POST   /workflows/{id}/activate   - Workflow aktivieren
POST   /workflows/{id}/deactivate - Workflow deaktivieren
GET    /executions                - Ausfuehrungen auflisten
```

### Authentication
```bash
# API Key in Header
curl -H "X-N8N-API-KEY: your-api-key" \
  https://n8n.example.com/api/v1/workflows
```

## Workflow Patterns

### Pattern 1: Webhook → Process → Store
```
Webhook (POST /order)
    ↓
Validate Data
    ↓
Transform (Set Node)
    ↓
Store (Supabase Insert)
    ↓
Response (Success/Error)
```

**Use Case:** API-Endpunkt fuer externe Systeme

### Pattern 2: Schedule → Fetch → Sync
```
Schedule (Daily 9:00)
    ↓
Fetch External API
    ↓
Compare with Database
    ↓
  ┌──┴──┐
New    Updated
  ↓      ↓
Insert  Update
  └──┬──┘
     ↓
Send Report
```

**Use Case:** Daten-Synchronisation

### Pattern 3: Event → Branch → Multi-Action
```
Webhook Trigger
    ↓
Switch (by event_type)
    ↓
┌───┼───┬───┐
│   │   │   │
v   v   v   v
Create Update Delete Archive
    └───┬───┘
        ↓
    Notify Team
```

**Use Case:** Event-basierte Verarbeitung

### Pattern 4: Batch Processing
```
Schedule Trigger
    ↓
Fetch Large Dataset
    ↓
Split In Batches (100 items)
    ↓
Loop: Process Batch
    ↓
Aggregate Results
    ↓
Generate Report
```

**Use Case:** Grosse Datenmengen verarbeiten

## Node Reference

### Trigger Nodes

#### Webhook
```json
{
  "parameters": {
    "path": "my-webhook",
    "httpMethod": "POST",
    "responseMode": "responseNode",
    "options": {
      "rawBody": true
    }
  }
}
```

#### Schedule
```json
{
  "parameters": {
    "rule": {
      "interval": [
        {
          "field": "cronExpression",
          "expression": "0 9 * * 1-5"
        }
      ]
    }
  }
}
```

### Transform Nodes

#### Code Node
```javascript
// Grundstruktur
for (const item of $input.all()) {
  item.json.processed = true;
  item.json.timestamp = new Date().toISOString();
}
return $input.all();

// Mit externen Modulen
const axios = require('axios');
const response = await axios.get('https://api.example.com');
return [{ json: response.data }];

// Error Handling
try {
  const result = JSON.parse($input.item.json.data);
  return { json: result };
} catch (error) {
  throw new Error(`Parse error: ${error.message}`);
}
```

#### Set Node
```json
{
  "parameters": {
    "mode": "manual",
    "duplicateItem": false,
    "assignments": {
      "assignments": [
        {
          "name": "fullName",
          "value": "={{ $json.firstName }} {{ $json.lastName }}",
          "type": "string"
        },
        {
          "name": "isActive",
          "value": true,
          "type": "boolean"
        }
      ]
    },
    "include": "all"
  }
}
```

#### Split In Batches
```json
{
  "parameters": {
    "batchSize": 100,
    "options": {}
  }
}
```

#### Merge
```json
{
  "parameters": {
    "mode": "combine",
    "mergeByFields": {
      "values": [
        { "field1": "id", "field2": "userId" }
      ]
    },
    "options": {}
  }
}
```

### Action Nodes

#### HTTP Request
```json
{
  "parameters": {
    "method": "POST",
    "url": "https://api.example.com/data",
    "authentication": "genericCredentialType",
    "genericAuthType": "httpHeaderAuth",
    "sendHeaders": true,
    "headerParameters": {
      "parameters": [
        { "name": "Content-Type", "value": "application/json" }
      ]
    },
    "sendBody": true,
    "specifyBody": "json",
    "jsonBody": "={{ JSON.stringify($json) }}",
    "options": {
      "timeout": 30000,
      "retry": {
        "maxTries": 3,
        "waitBetweenTries": 1000
      }
    }
  }
}
```

#### Send Email (SMTP)
```json
{
  "parameters": {
    "fromEmail": "noreply@example.com",
    "toEmail": "={{ $json.email }}",
    "subject": "Your Order #{{ $json.orderId }}",
    "text": "Thank you for your order!",
    "options": {}
  }
}
```

## Expressions

### Daten-Zugriff
```javascript
// Aktuelles Item
$json.fieldName
$input.item.json.fieldName

// Alle Items
$input.all()
$input.first()
$input.last()

// Von spezifischem Node
$('Node Name').item.json.fieldName
$('Node Name').all()

// Execution Context
$executionId
$workflow.name
$workflow.id
$now                    // Aktuelles Datum
$today                  // Heute 00:00
```

### String-Funktionen
```javascript
{{ $json.name.toUpperCase() }}
{{ $json.text.toLowerCase() }}
{{ $json.email.split('@')[0] }}
{{ $json.name.replace(/[^a-z]/gi, '') }}
{{ $json.title.substring(0, 50) }}
```

### Datum-Funktionen
```javascript
{{ $now.toISOString() }}
{{ $now.format('YYYY-MM-DD') }}
{{ $now.plus({ days: 7 }).toISO() }}
{{ DateTime.fromISO($json.date).toFormat('dd.MM.yyyy') }}
```

### Bedingte Logik
```javascript
{{ $json.status === 'active' ? 'Aktiv' : 'Inaktiv' }}
{{ $json.amount > 100 ? 'Premium' : 'Standard' }}
{{ $json.email || 'keine E-Mail' }}
```

## Clevermation Integrationen

### Microsoft Power Platform
```
Power Automate (HTTP Trigger)
    ↓
N8N Webhook empfaengt
    ↓
Process Data
    ↓
Supabase speichern
    ↓
Response an Power Automate
```

### Supabase Webhook
```javascript
// Supabase -> N8N
// In Supabase: Database Function mit http_post zu N8N Webhook

// N8N Webhook empfaengt:
{
  "type": "INSERT",
  "table": "orders",
  "record": {
    "id": "xxx",
    "customer_name": "John",
    "total": 99.99
  },
  "old_record": null
}
```

### Airtable Sync
```
Schedule (every 5 min)
    ↓
Airtable: List Records (modified since last run)
    ↓
Loop through records
    ↓
Supabase: Upsert
    ↓
Store last sync timestamp
```

## Error Handling

### Global Error Workflow
```
Error Trigger
    ↓
Extract Error Info
    ↓
Format Message
    ↓
┌──┴──┐
Slack  Email
 ↓      ↓
#alerts admin@
```

### Try/Catch Pattern
```javascript
// In Code Node
try {
  const result = await processData($json);
  return { json: { success: true, data: result } };
} catch (error) {
  return {
    json: {
      success: false,
      error: error.message,
      input: $json
    }
  };
}
```

### Retry Exponential Backoff
```json
{
  "parameters": {
    "options": {
      "retry": {
        "maxTries": 5,
        "waitBetweenTries": "={{ Math.pow(2, $runIndex) * 1000 }}"
      }
    }
  }
}
```

## Performance Tips

### 1. Batch Processing
```javascript
// Statt einzelner Requests
for (const item of items) {
  await supabase.insert(item); // SCHLECHT
}

// Batch Insert
await supabase.insert(items); // GUT
```

### 2. Parallel Execution
```
Split Workload
    ↓
┌──┬──┬──┐
│  │  │  │
v  v  v  v
Parallel Processing
    └──┬──┘
       ↓
    Merge Results
```

### 3. Caching
```javascript
// In Code Node - Simple Cache
const cacheKey = `data_${$json.id}`;
const cached = $workflow.staticData[cacheKey];

if (cached && Date.now() - cached.timestamp < 3600000) {
  return { json: cached.data };
}

// Fetch fresh data...
$workflow.staticData[cacheKey] = {
  data: result,
  timestamp: Date.now()
};
```

## Debugging

### Execution Logs
```bash
# Via API
curl -X GET "https://n8n.example.com/api/v1/executions" \
  -H "X-N8N-API-KEY: xxx"
```

### Test Workflow
```
Manual Trigger (fuer Tests)
    ↓
Set Test Data
    ↓
Actual Workflow Nodes
    ↓
Debug Output (Set Node mit allen Daten)
```

### Console Output
```javascript
// In Code Node
console.log('Debug:', JSON.stringify($json, null, 2));
// Sichtbar in Execution Details
```
