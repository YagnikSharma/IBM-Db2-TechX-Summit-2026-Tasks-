# IBM Db2 TechX Summit 2026 — Operations + Inventory Checklists

One static Vercel site with two matching pages:

- `index.html` — Operations checklist
- `inventory.html` — Event items inventory checklist
- `event-items-checklist.pdf` — Print-ready inventory checklist PDF
- `config.js` — Shared Supabase project URL and publishable/anon key
- `supabase-setup.sql` — Creates and enables Realtime for both checklist tables

## Visual identity

Both tabs use the same Inter typography, navy/blue palette, rounded cards, navigation style, spacing system, status indicator, and responsive behaviour. The Operations page retains quick checklist + task detail views. The Inventory page keeps its category/item/quantity/notes layout.

## Shared live progress for BOTH pages

Both pages use the **same Supabase project**, with separate tables so that task IDs and inventory item IDs cannot collide:

- `public.event_tasks` — Operations Checklist
- `public.event_inventory` — Event Inventory

1. Create a Supabase project.
2. Run all contents of `supabase-setup.sql` in Supabase Dashboard → SQL Editor.
3. Open `config.js` and fill in the same project URL and browser-safe publishable/anon key:

   ```js
   window.EVENT_CHECKLIST_CONFIG = {
     supabaseUrl: "https://YOUR_PROJECT.supabase.co",
     supabaseAnonKey: "YOUR_PUBLIC_PUBLISHABLE_OR_ANON_KEY"
   };
   ```

4. Commit/push the updated files to the production branch connected to Vercel.
5. Open both `/` (or `/index.html`) and `/inventory` (or `/inventory.html`). Each should display **Live sync connected**.
6. Test by ticking one task and one inventory item on one browser, then verify both appear in another browser/device.

On first connection to an empty table, the page seeds it with this browser's current checkmarks so current local progress is preserved. Once shared data exists, Supabase becomes the source of truth and missing new IDs are added unchecked.

## Security note — important

The included policies intentionally allow anonymous read/write so the shared checklist works without coordinator accounts. Anyone who has the website URL could change checkbox state. Do **not** place personal, confidential, or sensitive information in these tables. If only coordinators should edit, add Supabase Auth and restrict write policies to authenticated coordinator accounts before using this for critical inventory control.

## Local fallback

If `config.js` is blank or Supabase cannot connect, both pages remain usable but only save progress in the current browser/device. The status badge will explain that shared sync is unavailable. No Reset buttons are included.

## Deploy to existing Vercel site

Replace the matching root files in your existing repository, commit, and push to the branch linked with Vercel. No second Vercel project is required.
