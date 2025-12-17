---
name: shadcn-ui
description: shadcn/ui Komponenten-Library und Tailwind CSS. Referenz fuer Installation, Komponenten, Theming und Best Practices.
---

# shadcn/ui Skill

Referenz fuer shadcn/ui und Tailwind CSS in Clevermation-Projekten.

## Quick Setup

### Neues Projekt
```bash
# Next.js mit TypeScript und Tailwind
npx create-next-app@latest my-app --typescript --tailwind --eslint --app

cd my-app

# shadcn/ui initialisieren
npx shadcn@latest init

# Optionen:
# - Style: Default oder New York
# - Base color: Slate, Gray, Zinc, etc.
# - CSS variables: Yes
# - Tailwind config: tailwind.config.ts
# - Components: @/components
# - Utils: @/lib/utils
```

### Komponenten hinzufuegen
```bash
# Einzeln
npx shadcn@latest add button
npx shadcn@latest add card
npx shadcn@latest add form

# Mehrere auf einmal
npx shadcn@latest add button card form input

# Alle verfuegbaren
npx shadcn@latest add --all
```

## Komponenten-Referenz

### Button
```tsx
import { Button } from "@/components/ui/button";

// Varianten
<Button variant="default">Default</Button>
<Button variant="destructive">Destructive</Button>
<Button variant="outline">Outline</Button>
<Button variant="secondary">Secondary</Button>
<Button variant="ghost">Ghost</Button>
<Button variant="link">Link</Button>

// Groessen
<Button size="default">Default</Button>
<Button size="sm">Small</Button>
<Button size="lg">Large</Button>
<Button size="icon"><Icon /></Button>

// Als Link
<Button asChild>
  <Link href="/page">Link Button</Link>
</Button>
```

### Input
```tsx
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";

<div className="grid w-full max-w-sm items-center gap-1.5">
  <Label htmlFor="email">E-Mail</Label>
  <Input type="email" id="email" placeholder="email@example.com" />
</div>

// Mit Icon
<div className="relative">
  <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
  <Input type="search" placeholder="Suchen..." className="pl-8" />
</div>
```

### Select
```tsx
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

<Select>
  <SelectTrigger className="w-[180px]">
    <SelectValue placeholder="Waehlen..." />
  </SelectTrigger>
  <SelectContent>
    <SelectItem value="option1">Option 1</SelectItem>
    <SelectItem value="option2">Option 2</SelectItem>
    <SelectItem value="option3">Option 3</SelectItem>
  </SelectContent>
</Select>
```

### Dialog
```tsx
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";

<Dialog>
  <DialogTrigger asChild>
    <Button>Dialog oeffnen</Button>
  </DialogTrigger>
  <DialogContent className="sm:max-w-[425px]">
    <DialogHeader>
      <DialogTitle>Titel</DialogTitle>
      <DialogDescription>
        Beschreibung des Dialogs.
      </DialogDescription>
    </DialogHeader>
    <div className="py-4">
      {/* Inhalt */}
    </div>
    <DialogFooter>
      <Button type="submit">Speichern</Button>
    </DialogFooter>
  </DialogContent>
</Dialog>
```

### Toast
```tsx
// 1. Toaster in Layout hinzufuegen
import { Toaster } from "@/components/ui/toaster";

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        {children}
        <Toaster />
      </body>
    </html>
  );
}

// 2. Toast verwenden
import { useToast } from "@/hooks/use-toast";

export function MyComponent() {
  const { toast } = useToast();

  return (
    <Button
      onClick={() => {
        toast({
          title: "Erfolg!",
          description: "Aktion wurde ausgefuehrt.",
        });
      }}
    >
      Toast anzeigen
    </Button>
  );
}

// Varianten
toast({ title: "Info" });
toast({ title: "Erfolg", variant: "default" });
toast({ title: "Fehler", variant: "destructive" });
```

### Data Table
```tsx
import {
  Table,
  TableBody,
  TableCaption,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";

<Table>
  <TableCaption>Liste der Benutzer</TableCaption>
  <TableHeader>
    <TableRow>
      <TableHead className="w-[100px]">ID</TableHead>
      <TableHead>Name</TableHead>
      <TableHead>E-Mail</TableHead>
      <TableHead className="text-right">Aktionen</TableHead>
    </TableRow>
  </TableHeader>
  <TableBody>
    {users.map((user) => (
      <TableRow key={user.id}>
        <TableCell className="font-medium">{user.id}</TableCell>
        <TableCell>{user.name}</TableCell>
        <TableCell>{user.email}</TableCell>
        <TableCell className="text-right">
          <Button variant="ghost" size="sm">Bearbeiten</Button>
        </TableCell>
      </TableRow>
    ))}
  </TableBody>
</Table>
```

### Form (mit react-hook-form + zod)
```tsx
"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import * as z from "zod";

import { Button } from "@/components/ui/button";
import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";

const formSchema = z.object({
  username: z.string().min(2).max(50),
  email: z.string().email(),
});

export function ProfileForm() {
  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      username: "",
      email: "",
    },
  });

  function onSubmit(values: z.infer<typeof formSchema>) {
    console.log(values);
  }

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
        <FormField
          control={form.control}
          name="username"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Benutzername</FormLabel>
              <FormControl>
                <Input placeholder="username" {...field} />
              </FormControl>
              <FormDescription>
                Dein oeffentlicher Anzeigename.
              </FormDescription>
              <FormMessage />
            </FormItem>
          )}
        />
        <Button type="submit">Speichern</Button>
      </form>
    </Form>
  );
}
```

## Theming

### CSS Variables
```css
/* globals.css */
@layer base {
  :root {
    --background: 0 0% 100%;
    --foreground: 222.2 84% 4.9%;
    --card: 0 0% 100%;
    --card-foreground: 222.2 84% 4.9%;
    --popover: 0 0% 100%;
    --popover-foreground: 222.2 84% 4.9%;
    --primary: 222.2 47.4% 11.2%;
    --primary-foreground: 210 40% 98%;
    --secondary: 210 40% 96.1%;
    --secondary-foreground: 222.2 47.4% 11.2%;
    --muted: 210 40% 96.1%;
    --muted-foreground: 215.4 16.3% 46.9%;
    --accent: 210 40% 96.1%;
    --accent-foreground: 222.2 47.4% 11.2%;
    --destructive: 0 84.2% 60.2%;
    --destructive-foreground: 210 40% 98%;
    --border: 214.3 31.8% 91.4%;
    --input: 214.3 31.8% 91.4%;
    --ring: 222.2 84% 4.9%;
    --radius: 0.5rem;
  }

  .dark {
    --background: 222.2 84% 4.9%;
    --foreground: 210 40% 98%;
    /* ... */
  }
}
```

### Theme Toggle
```tsx
"use client";

import { Moon, Sun } from "lucide-react";
import { useTheme } from "next-themes";
import { Button } from "@/components/ui/button";

export function ThemeToggle() {
  const { theme, setTheme } = useTheme();

  return (
    <Button
      variant="ghost"
      size="icon"
      onClick={() => setTheme(theme === "light" ? "dark" : "light")}
    >
      <Sun className="h-5 w-5 rotate-0 scale-100 transition-all dark:-rotate-90 dark:scale-0" />
      <Moon className="absolute h-5 w-5 rotate-90 scale-0 transition-all dark:rotate-0 dark:scale-100" />
      <span className="sr-only">Theme wechseln</span>
    </Button>
  );
}
```

## Tailwind Utilities

### Layout
```tsx
// Container
<div className="container mx-auto px-4">

// Grid
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">

// Flex
<div className="flex items-center justify-between gap-4">

// Stack
<div className="flex flex-col gap-4">
```

### Spacing
```tsx
// Padding
<div className="p-4 px-6 py-2 pt-4 pb-8">

// Margin
<div className="m-4 mx-auto my-8 mt-2 mb-4">

// Gap
<div className="gap-4 gap-x-2 gap-y-8">
```

### Typography
```tsx
// Text Size
<p className="text-sm text-base text-lg text-xl text-2xl">

// Font Weight
<p className="font-normal font-medium font-semibold font-bold">

// Colors
<p className="text-foreground text-muted-foreground text-primary">

// Utilities
<p className="truncate">          // Abschneiden
<p className="line-clamp-2">      // Max 2 Zeilen
<p className="capitalize">        // Erste Buchstaben gross
<p className="uppercase">         // Alles gross
```

### Animation
```tsx
// Transitions
<button className="transition-colors hover:bg-muted">

// Transform
<div className="hover:scale-105 transition-transform">

// Spin (Loading)
<Loader2 className="h-4 w-4 animate-spin" />

// Pulse (Skeleton)
<div className="animate-pulse bg-muted h-4 w-full rounded">
```

## Best Practices

### 1. cn() Helper nutzen
```tsx
import { cn } from "@/lib/utils";

<div className={cn(
  "base-classes",
  condition && "conditional-classes",
  className // von Props
)}>
```

### 2. Komponenten erweitern
```tsx
// Nicht shadcn direkt aendern, sondern wrappen
import { Button, ButtonProps } from "@/components/ui/button";

interface LoadingButtonProps extends ButtonProps {
  isLoading?: boolean;
}

export function LoadingButton({ isLoading, children, ...props }: LoadingButtonProps) {
  return (
    <Button disabled={isLoading} {...props}>
      {isLoading && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
      {children}
    </Button>
  );
}
```

### 3. Compound Components
```tsx
// Card mit eigenen Subkomponents
function DashboardCard({ children }) {
  return <Card className="p-6">{children}</Card>;
}

DashboardCard.Title = function({ children }) {
  return <CardTitle className="text-lg">{children}</CardTitle>;
};

DashboardCard.Content = function({ children }) {
  return <CardContent className="pt-4">{children}</CardContent>;
};

// Verwendung
<DashboardCard>
  <DashboardCard.Title>Titel</DashboardCard.Title>
  <DashboardCard.Content>Inhalt</DashboardCard.Content>
</DashboardCard>
```

### 4. Responsive Patterns
```tsx
// Mobile-first
<div className="
  flex flex-col          // Mobile: Stack
  md:flex-row            // Desktop: Row
  gap-4
">

// Hidden/Visible
<div className="hidden md:block">     // Nur Desktop
<div className="md:hidden">           // Nur Mobile
```

## Haeufige Patterns

### Page Layout
```tsx
export default function Layout({ children }) {
  return (
    <div className="min-h-screen flex flex-col">
      <Header />
      <main className="flex-1 container py-6">
        {children}
      </main>
      <Footer />
    </div>
  );
}
```

### Dashboard Grid
```tsx
<div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
  <Card>Metric 1</Card>
  <Card>Metric 2</Card>
  <Card>Metric 3</Card>
  <Card>Metric 4</Card>
</div>
<div className="grid gap-4 md:grid-cols-2 lg:grid-cols-7 mt-4">
  <Card className="col-span-4">Chart</Card>
  <Card className="col-span-3">Recent Activity</Card>
</div>
```

### Empty State
```tsx
<div className="flex flex-col items-center justify-center py-12 text-center">
  <FileQuestion className="h-12 w-12 text-muted-foreground mb-4" />
  <h3 className="text-lg font-semibold">Keine Daten</h3>
  <p className="text-muted-foreground mb-4">
    Es wurden noch keine Eintraege erstellt.
  </p>
  <Button>Ersten Eintrag erstellen</Button>
</div>
```

### Loading Skeleton
```tsx
import { Skeleton } from "@/components/ui/skeleton";

<div className="space-y-4">
  <Skeleton className="h-12 w-full" />
  <Skeleton className="h-4 w-3/4" />
  <Skeleton className="h-4 w-1/2" />
</div>
```
