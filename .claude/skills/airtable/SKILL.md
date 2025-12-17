---
name: airtable
description: Airtable Datenbank und Automation. Referenz fuer Formulas, API, Automations und Integration-Patterns.
---

# Airtable Skill

Referenz fuer Airtable in Clevermation-Projekten.

## Formula Quick Reference

### Text-Funktionen
```javascript
CONCATENATE(text1, text2, ...)     // Texte verbinden
UPPER(text)                         // Grossbuchstaben
LOWER(text)                         // Kleinbuchstaben
TRIM(text)                          // Leerzeichen entfernen
LEN(text)                           // Textlaenge
LEFT(text, count)                   // Links abschneiden
RIGHT(text, count)                  // Rechts abschneiden
MID(text, start, count)             // Mitte extrahieren
SUBSTITUTE(text, old, new)          // Ersetzen
SEARCH(find, text)                  // Position finden
REGEX_MATCH(text, regex)            // Regex pruefen
REGEX_EXTRACT(text, regex)          // Regex extrahieren
REGEX_REPLACE(text, regex, replace) // Regex ersetzen
```

### Zahlen-Funktionen
```javascript
SUM(num1, num2, ...)    // Summe
AVERAGE(num1, num2, ...)// Durchschnitt
MAX(num1, num2, ...)    // Maximum
MIN(num1, num2, ...)    // Minimum
ROUND(num, precision)   // Runden
ROUNDUP(num, precision) // Aufrunden
ROUNDDOWN(num, precision)// Abrunden
CEILING(num)            // Naechste ganze Zahl hoch
FLOOR(num)              // Naechste ganze Zahl runter
ABS(num)                // Absolutwert
POWER(base, exp)        // Potenz
SQRT(num)               // Wurzel
MOD(num, divisor)       // Modulo
VALUE(text)             // Text zu Zahl
```

### Logik-Funktionen
```javascript
IF(condition, true_val, false_val)
AND(cond1, cond2, ...)
OR(cond1, cond2, ...)
NOT(condition)
XOR(cond1, cond2)
SWITCH(expr, case1, val1, case2, val2, ..., default)
BLANK()                   // Leerer Wert
ERROR()                   // Fehler erzeugen
ISERROR(value)           // Ist Fehler?
ISBLANK(value)           // Ist leer?
```

### Datum-Funktionen
```javascript
TODAY()                              // Heutiges Datum
NOW()                                // Aktueller Zeitpunkt
DATEADD(date, count, "units")        // Datum addieren
DATETIME_DIFF(end, start, "units")   // Differenz
DATETIME_FORMAT(date, "format")      // Formatieren
DATETIME_PARSE(text, "format")       // Parsen
SET_TIMEZONE(date, "timezone")       // Zeitzone setzen
YEAR(date)                           // Jahr
MONTH(date)                          // Monat
DAY(date)                            // Tag
HOUR(date)                           // Stunde
MINUTE(date)                         // Minute
WEEKDAY(date)                        // Wochentag (0=So)
WEEKNUM(date)                        // Kalenderwoche
IS_BEFORE(date1, date2)              // Vorher?
IS_AFTER(date1, date2)               // Nachher?
IS_SAME(date1, date2, "unit")        // Gleich?
WORKDAY_DIFF(start, end)             // Arbeitstage
```

**Einheiten:** "milliseconds", "seconds", "minutes", "hours", "days", "weeks", "months", "years"

**Datumsformate:**
- `YYYY-MM-DD` → 2024-01-15
- `DD.MM.YYYY` → 15.01.2024
- `MMMM D, YYYY` → January 15, 2024
- `dddd` → Monday
- `HH:mm` → 14:30

### Array-Funktionen
```javascript
ARRAYCOMPACT(array)           // Leere entfernen
ARRAYFLATTEN(array)           // Verschachtelte Arrays
ARRAYJOIN(array, separator)   // Zu String
ARRAYSLICE(array, start, end) // Ausschnitt
ARRAYUNIQUE(array)            // Duplikate entfernen
ARRAYCONTAINS(array, value)   // Enthalten?
```

## Praktische Formeln

### Status-Anzeige
```javascript
// Status mit Emoji
SWITCH(
  {Status},
  "New", "🆕 Neu",
  "In Progress", "🔄 In Bearbeitung",
  "Review", "👀 Review",
  "Done", "✅ Fertig",
  "Blocked", "🚫 Blockiert",
  "❓ Unbekannt"
)
```

### Deadline-Management
```javascript
// Tage bis Deadline
IF(
  AND({Deadline}, {Status} != "Done"),
  DATETIME_DIFF({Deadline}, TODAY(), "days"),
  ""
)

// Deadline-Status
IF(
  NOT({Deadline}),
  "",
  IF(
    {Status} = "Done",
    "✅",
    IF(
      IS_BEFORE({Deadline}, TODAY()),
      "🔴 Ueberfaellig",
      IF(
        DATETIME_DIFF({Deadline}, TODAY(), "days") <= 3,
        "🟡 Bald faellig",
        "🟢 OK"
      )
    )
  )
)
```

### Fortschritt
```javascript
// Prozent abgeschlossen
IF(
  {Total Tasks} > 0,
  ROUND({Completed Tasks} / {Total Tasks} * 100, 0) & "%",
  "0%"
)

// Fortschrittsbalken
REPT("█", ROUND({Completed} / {Total} * 10, 0)) &
REPT("░", 10 - ROUND({Completed} / {Total} * 10, 0))
```

### Validierung
```javascript
// E-Mail validieren
IF(
  REGEX_MATCH({Email}, "^[^@]+@[^@]+\\.[^@]+$"),
  "✓",
  "✗ Ungueltig"
)

// Pflichtfelder pruefen
IF(
  AND({Name}, {Email}, {Phone}),
  "✅ Vollstaendig",
  "⚠️ Unvollstaendig"
)
```

## API Integration

### JavaScript Client
```javascript
const Airtable = require('airtable');

const base = new Airtable({
  apiKey: process.env.AIRTABLE_API_KEY
}).base(process.env.AIRTABLE_BASE_ID);

// Records lesen
const records = await base('Table Name')
  .select({
    maxRecords: 100,
    view: 'Grid view',
    filterByFormula: '{Status} = "Active"',
    sort: [{ field: 'Created', direction: 'desc' }]
  })
  .all();

// Record erstellen
const created = await base('Table Name').create([
  {
    fields: {
      'Name': 'New Item',
      'Status': 'New'
    }
  }
]);

// Record updaten
await base('Table Name').update([
  {
    id: 'recXXXXXX',
    fields: {
      'Status': 'Updated'
    }
  }
]);

// Record loeschen
await base('Table Name').destroy(['recXXXXXX']);
```

### TypeScript Types
```typescript
interface AirtableRecord {
  id: string;
  fields: {
    Name: string;
    Status: 'New' | 'Active' | 'Done';
    Amount: number;
    'Created Time': string;
    'Linked Records': string[];
  };
  createdTime: string;
}

interface AirtableResponse {
  records: AirtableRecord[];
  offset?: string;
}
```

### Pagination
```javascript
async function getAllRecords(tableName: string) {
  const allRecords: AirtableRecord[] = [];
  let offset: string | undefined;

  do {
    const response = await fetch(
      `https://api.airtable.com/v0/${baseId}/${tableName}` +
      (offset ? `?offset=${offset}` : ''),
      {
        headers: {
          'Authorization': `Bearer ${apiKey}`
        }
      }
    );

    const data: AirtableResponse = await response.json();
    allRecords.push(...data.records);
    offset = data.offset;
  } while (offset);

  return allRecords;
}
```

## Automation Scripts

### Basic Template
```javascript
// Input Config
let inputConfig = input.config();
let triggerRecord = inputConfig.record;

// Tabellen
let ordersTable = base.getTable("Orders");
let itemsTable = base.getTable("Order Items");

// Records abfragen
let ordersQuery = await ordersTable.selectRecordsAsync({
  fields: ["Name", "Status", "Total"],
  sorts: [{ field: "Created", direction: "desc" }]
});

// Filtern
let activeOrders = ordersQuery.records.filter(
  record => record.getCellValueAsString("Status") === "Active"
);

// Record erstellen
let newRecordId = await ordersTable.createRecordAsync({
  "Name": "New Order",
  "Status": { name: "New" },
  "Total": 0
});

// Record updaten
await ordersTable.updateRecordAsync(triggerRecord.id, {
  "Status": { name: "Processed" },
  "Processed At": new Date()
});

// Batch Update
let updates = activeOrders.map(record => ({
  id: record.id,
  fields: {
    "Status": { name: "Archived" }
  }
}));

// Max 50 pro Batch
while (updates.length > 0) {
  await ordersTable.updateRecordsAsync(updates.splice(0, 50));
}

// Output
output.set("processedCount", activeOrders.length);
output.set("newRecordId", newRecordId);
```

### Linked Records verarbeiten
```javascript
let inputConfig = input.config();
let order = inputConfig.record;

// Linked Records holen
let linkedItemIds = order.getCellValue("Order Items");
if (!linkedItemIds) {
  output.set("total", 0);
  return;
}

let itemsTable = base.getTable("Order Items");
let itemsQuery = await itemsTable.selectRecordsAsync({
  fields: ["Quantity", "Unit Price"]
});

// Total berechnen
let total = 0;
for (let linkedItem of linkedItemIds) {
  let item = itemsQuery.getRecord(linkedItem.id);
  if (item) {
    let qty = item.getCellValue("Quantity") || 0;
    let price = item.getCellValue("Unit Price") || 0;
    total += qty * price;
  }
}

// Order updaten
let ordersTable = base.getTable("Orders");
await ordersTable.updateRecordAsync(order.id, {
  "Total": total
});

output.set("total", total);
```

## N8N Integration

### Airtable Node in N8N
```json
{
  "node": "Airtable",
  "credentials": {
    "airtableApi": "airtable_credentials"
  },
  "parameters": {
    "operation": "list",
    "application": "appXXXXXX",
    "table": "Orders",
    "returnAll": false,
    "limit": 100,
    "options": {
      "view": "Active",
      "filterByFormula": "AND({Status}='Active', {Amount}>100)"
    }
  }
}
```

### Webhook Automation
```
Airtable Automation
  ↓
Trigger: Record matches conditions
  ↓
Action: Send Webhook
  ↓
N8N Webhook empfaengt
  ↓
Weiterverarbeitung
```

## Best Practices

### 1. Tabellen-Design
- Primary Field = Name/Titel
- Created/Modified Time Felder
- Status als Single Select
- Linked Records statt Duplikate

### 2. Performance
- Views filtern, nicht alles laden
- Formulas einfach halten
- Linked Records begrenzen
- Automations effizient gestalten

### 3. API-Nutzung
- Rate Limits beachten (5/s)
- Pagination implementieren
- Fehler behandeln
- Caching wo moeglich

### 4. Sync-Strategien
- Airtable ID als Foreign Key
- Last Modified tracken
- Konflikt-Handling definieren
- Incremental Sync bevorzugen
