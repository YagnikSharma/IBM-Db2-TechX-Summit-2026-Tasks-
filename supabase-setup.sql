-- IBM Db2 TechX Summit 2026 — shared live checklist database
-- Run this script ONCE in Supabase Dashboard > SQL Editor.
-- Both Operations Checklist and Event Inventory use the same Supabase project.

create table if not exists public.event_inventory (
  item_id text primary key,
  checked boolean not null default false,
  updated_at timestamptz not null default now()
);

create table if not exists public.event_tasks (
  task_id text primary key,
  checked boolean not null default false,
  updated_at timestamptz not null default now()
);

alter table public.event_inventory enable row level security;
alter table public.event_tasks enable row level security;

grant select, insert, update on public.event_inventory to anon;
grant select, insert, update on public.event_tasks to anon;

drop policy if exists "Public can read event inventory" on public.event_inventory;
create policy "Public can read event inventory"
  on public.event_inventory for select to anon using (true);
drop policy if exists "Public can seed event inventory" on public.event_inventory;
create policy "Public can seed event inventory"
  on public.event_inventory for insert to anon with check (true);
drop policy if exists "Public can update event inventory" on public.event_inventory;
create policy "Public can update event inventory"
  on public.event_inventory for update to anon using (true) with check (true);

drop policy if exists "Public can read event tasks" on public.event_tasks;
create policy "Public can read event tasks"
  on public.event_tasks for select to anon using (true);
drop policy if exists "Public can seed event tasks" on public.event_tasks;
create policy "Public can seed event tasks"
  on public.event_tasks for insert to anon with check (true);
drop policy if exists "Public can update event tasks" on public.event_tasks;
create policy "Public can update event tasks"
  on public.event_tasks for update to anon using (true) with check (true);

-- Add both tables to Supabase Realtime only if not already published.
do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'event_inventory'
  ) then
    execute 'alter publication supabase_realtime add table public.event_inventory';
  end if;
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'event_tasks'
  ) then
    execute 'alter publication supabase_realtime add table public.event_tasks';
  end if;
end $$;
