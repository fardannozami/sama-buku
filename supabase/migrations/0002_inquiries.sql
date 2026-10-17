create table if not exists public.inquiries (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  email text not null,
  subject text,
  message text not null,
  created_at timestamptz default now()
);

alter table public.inquiries enable row level security;

-- Public can insert (contact form)
create policy "inquiries_public_insert" on public.inquiries for insert
  with check (true);

-- Only authenticated admin can read
create policy "inquiries_auth_read" on public.inquiries for select
  using (auth.role() = 'authenticated');