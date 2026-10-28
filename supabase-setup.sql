-- Event Items Checklist: shared checkbox state for all coordinators.
-- Run once in Supabase Dashboard > SQL Editor.

create table if not exists public.event_inventory (
  item_id text primary key,
  checked boolean not null default false,
  updated_at timestamptz not null default now()
);

alter table public.event_inventory enable row level security;

grant select, insert, update on public.event_inventory to anon;

drop policy if exists "Public can read event inventory" on public.event_inventory;
create policy "Public can read event inventory"
  on public.event_inventory for select to anon using (true);

drop policy if exists "Public can seed event inventory" on public.event_inventory;
create policy "Public can seed event inventory"
  on public.event_inventory for insert to anon with check (true);

drop policy if exists "Public can update event inventory" on public.event_inventory;
create policy "Public can update event inventory"
  on public.event_inventory for update to anon using (true) with check (true);

-- Enable live updates for this table.
alter publication supabase_realtime add table public.event_inventory;
