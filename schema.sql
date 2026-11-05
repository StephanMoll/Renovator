-- Run once in Supabase SQL Editor. Tables are NOT exposed to anonymous database users.
create table if not exists public.renovator_tasks (id uuid primary key default gen_random_uuid(), date date not null, title text not null, start_time time not null, end_time time not null, need integer not null check(need between 1 and 30), description text not null default '', created_at timestamptz not null default now(), check(end_time>start_time));
create table if not exists public.renovator_signups (id uuid primary key default gen_random_uuid(), task_id uuid not null references public.renovator_tasks(id) on delete cascade, name text not null, start_time time not null, end_time time not null, edit_token_hash text not null, created_at timestamptz not null default now(), check(end_time>start_time));
create table if not exists public.renovator_offers (id uuid primary key default gen_random_uuid(), name text not null, kind text not null, title text not null, date date not null, time time, description text not null default '', edit_token_hash text not null, created_at timestamptz not null default now());
alter table public.renovator_tasks enable row level security;
alter table public.renovator_signups enable row level security;
alter table public.renovator_offers enable row level security;
revoke all on public.renovator_tasks, public.renovator_signups, public.renovator_offers from anon, authenticated;
