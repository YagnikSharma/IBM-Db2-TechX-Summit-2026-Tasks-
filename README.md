# IBM Db2 TechX Summit 2026 — Operations + Inventory Checklists

This is one static website with two pages:

- `index.html` — Operations checklist
- `inventory.html` — Event items inventory checklist
- `event-items-checklist.pdf` — Print-ready inventory checklist PDF
- `config.js` and `supabase-setup.sql` — optional setup for shared live inventory progress

## Important changes

- The inventory checklist is part of the same deployment. Use **Operations Checklist** and **Event Inventory** navigation tabs to switch pages.
- All **Reset** buttons and reset handlers have been removed intentionally. There is no one-click bulk reset.
- The certificate total is corrected to **33** (2 + 3 + 8 + 10 + 4 + 1 + 5).
- The 36 individual inventory items are checkable; the checkbox should be ticked only after physically checking quantity and availability.
- Both HTML pages are mobile-friendly. The inventory PDF can be downloaded from the inventory page.

## Deploy the update to your existing Vercel site

1. Download/extract this project ZIP.
2. Replace the matching files at the root of your existing GitHub repository with the files from this folder. Keep the same repository connected to Vercel.
3. Commit and push the changes to the production branch. Vercel should automatically build and deploy the update.
4. After deployment, open the existing Vercel URL. The inventory page will be at `/inventory` (Vercel clean URLs) or `/inventory.html`.

## Configure shared live inventory progress (Supabase)

The inventory page supports realtime shared checkmarks but **this is not active until configured**.

1. Create a Supabase project.
2. In the Supabase SQL Editor, run the contents of `supabase-setup.sql`.
3. Open `config.js` and set the Project URL and publishable/anon key:

   ```js
   window.EVENT_CHECKLIST_CONFIG = {
     supabaseUrl: "https://YOUR_PROJECT.supabase.co",
     supabaseAnonKey: "YOUR_PUBLIC_PUBLISHABLE_OR_ANON_KEY"
   };
   ```

4. Never put a service-role or secret key in browser code. Commit the updated `config.js` and let Vercel redeploy. Confirm the page displays **Live sync connected** on every coordinator's device.

### Access note

The included SQL policy allows anyone with the deployed URL to read and update the inventory checkmarks while shared-sync is enabled. The checklist contains no personal or secret information, but if you need to restrict write access to coordinators, configure Supabase Auth and tighter row-level security policies before sharing.

## Local-only fallback

If `config.js` is left blank, inventory checkmarks are stored in the browser/device only and do not sync to other coordinators.
