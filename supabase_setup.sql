-- Sebei Scientists Forum membership application storage
-- Run this in Supabase Dashboard -> SQL Editor.
-- The public website can submit applications, but anonymous visitors cannot read the register.

create table if not exists public.membership_applications (
  id uuid primary key default gen_random_uuid(),
  full_name text not null check (char_length(full_name) between 2 and 120),
  email text not null check (char_length(email) <= 254),
  phone text not null check (char_length(phone) between 3 and 40),
  membership_type text not null check (membership_type in ('Ordinary', 'Student')),
  district text not null check (char_length(district) between 2 and 120),
  institution text check (institution is null or char_length(institution) <= 180),
  profession text not null check (char_length(profession) between 2 and 160),
  education_level text check (education_level is null or char_length(education_level) <= 80),
  interests text not null check (char_length(interests) between 2 and 1500),
  motivation text check (motivation is null or char_length(motivation) <= 1500),
  status text not null default 'pending' check (status in ('pending', 'approved', 'declined', 'contacted')),
  created_at timestamptz not null default now()
);

alter table public.membership_applications enable row level security;

-- Allow public application submissions only. The status is constrained to 'pending' on insert.
drop policy if exists "Public can submit membership applications" on public.membership_applications;
create policy "Public can submit membership applications"
on public.membership_applications
for insert
to anon, authenticated
with check (status = 'pending');

-- No SELECT, UPDATE, or DELETE policy is granted to anonymous visitors.
-- Review applications in the Supabase Dashboard after signing in as an authorized administrator.
revoke all on table public.membership_applications from anon, authenticated;
grant insert (full_name, email, phone, membership_type, district, institution, profession, education_level, interests, motivation)
on table public.membership_applications to anon, authenticated;
