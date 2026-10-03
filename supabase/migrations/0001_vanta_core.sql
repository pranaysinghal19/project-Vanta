-- Vanta core schema — v0 foundation
-- Review before production use.

create extension if not exists pgcrypto;

create type public.goal_direction as enum ('reduce','build');
create type public.enforcement_mode as enum ('track','nudge','protect');
create type public.goal_status as enum ('draft','active','paused','completed','archived');
create type public.guide_call_status as enum ('scheduled','completed','missed','cancelled');
create type public.decision_lock_state as enum ('cooling_off','confirmable','changed','cancelled');
create type public.community_content_status as enum ('visible','under_review','removed');

create table public.member_profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  member_code text not null unique default ('V-' || upper(substr(encode(gen_random_bytes(6),'hex'),1,10))),
  preferred_language text,
  timezone text not null default 'UTC',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.community_profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  handle text not null unique,
  display_name text,
  avatar_key text,
  bio text,
  created_at timestamptz not null default now()
);

create table public.goals (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  category text not null,
  direction public.goal_direction not null,
  title text not null,
  status public.goal_status not null default 'active',
  enforcement public.enforcement_mode not null default 'track',
  target jsonb not null default '{}'::jsonb,
  starts_at timestamptz not null default now(),
  ends_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.goal_replacements (
  reduce_goal_id uuid not null references public.goals(id) on delete cascade,
  build_goal_id uuid not null references public.goals(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  primary key (reduce_goal_id, build_goal_id),
  constraint different_goals check (reduce_goal_id <> build_goal_id)
);

create table public.goal_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  goal_id uuid not null references public.goals(id) on delete cascade,
  logged_for date not null,
  value jsonb not null default '{}'::jsonb,
  honesty_confirmed boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (goal_id, logged_for)
);

create table public.devices (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  platform text not null,
  display_name text not null,
  capability_version text,
  last_seen_at timestamptz,
  created_at timestamptz not null default now()
);

create table public.device_rules (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  device_id uuid not null references public.devices(id) on delete cascade,
  goal_id uuid not null references public.goals(id) on delete cascade,
  enforcement public.enforcement_mode not null,
  schedule jsonb not null default '{}'::jsonb,
  enabled boolean not null default true,
  rule_version bigint not null default 1,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.decision_lock_requests (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  device_rule_id uuid not null references public.device_rules(id) on delete cascade,
  requested_change jsonb not null,
  requested_at timestamptz not null default now(),
  confirmable_at timestamptz not null,
  state public.decision_lock_state not null default 'cooling_off',
  resolved_at timestamptz,
  idempotency_key text not null,
  unique (user_id, idempotency_key),
  constraint confirmation_after_request check (confirmable_at > requested_at)
);

create table public.spending_boundaries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  currency char(3) not null default 'INR',
  monthly_limit_minor bigint not null check (monthly_limit_minor >= 0),
  baseline_monthly_minor bigint check (baseline_monthly_minor >= 0),
  decision_lock_hours integer not null default 24 check (decision_lock_hours between 0 and 168),
  active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.spending_entries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  boundary_id uuid not null references public.spending_boundaries(id) on delete cascade,
  occurred_at timestamptz not null,
  amount_minor bigint not null check (amount_minor >= 0),
  source text not null default 'manual',
  created_at timestamptz not null default now()
);

create table public.community_posts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  channel text not null,
  body text not null check (char_length(body) between 1 and 5000),
  status public.community_content_status not null default 'visible',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.community_comments (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  post_id uuid not null references public.community_posts(id) on delete cascade,
  body text not null check (char_length(body) between 1 and 3000),
  status public.community_content_status not null default 'visible',
  created_at timestamptz not null default now()
);

create table public.community_reports (
  id uuid primary key default gen_random_uuid(),
  reporter_user_id uuid not null references auth.users(id) on delete cascade,
  post_id uuid references public.community_posts(id) on delete cascade,
  comment_id uuid references public.community_comments(id) on delete cascade,
  reason text not null,
  created_at timestamptz not null default now(),
  constraint exactly_one_target check ((post_id is not null)::int + (comment_id is not null)::int = 1)
);

create table public.guide_calls (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  guide_external_ref text,
  scheduled_at timestamptz not null,
  status public.guide_call_status not null default 'scheduled',
  duration_seconds integer check (duration_seconds is null or duration_seconds >= 0),
  language text,
  next_call_preference jsonb not null default '{}'::jsonb,
  safety_flag boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

comment on table public.guide_calls is 'Operational metadata only. Do not add audio, transcript or free-form sexual disclosure fields.';

create table public.challenge_definitions (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  title text not null,
  description text not null,
  verification text not null check (verification in ('trust','system','device','partner')),
  target jsonb not null,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table public.challenge_enrolments (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  challenge_id uuid not null references public.challenge_definitions(id) on delete cascade,
  starts_at timestamptz not null default now(),
  ends_at timestamptz,
  progress jsonb not null default '{}'::jsonb,
  completed_at timestamptz,
  created_at timestamptz not null default now()
);

create table public.reward_catalog (
  id uuid primary key default gen_random_uuid(),
  partner_code text not null,
  reward_code text not null unique,
  title text not null,
  terms text,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table public.reward_unlocks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  challenge_enrolment_id uuid not null references public.challenge_enrolments(id) on delete cascade,
  reward_id uuid not null references public.reward_catalog(id) on delete restrict,
  redemption_token_hash text not null unique,
  unlocked_at timestamptz not null default now(),
  redeemed_at timestamptz,
  idempotency_key text not null,
  unique (user_id, idempotency_key)
);

-- RLS
alter table public.member_profiles enable row level security;
alter table public.community_profiles enable row level security;
alter table public.goals enable row level security;
alter table public.goal_replacements enable row level security;
alter table public.goal_logs enable row level security;
alter table public.devices enable row level security;
alter table public.device_rules enable row level security;
alter table public.decision_lock_requests enable row level security;
alter table public.spending_boundaries enable row level security;
alter table public.spending_entries enable row level security;
alter table public.community_posts enable row level security;
alter table public.community_comments enable row level security;
alter table public.community_reports enable row level security;
alter table public.guide_calls enable row level security;
alter table public.challenge_definitions enable row level security;
alter table public.challenge_enrolments enable row level security;
alter table public.reward_catalog enable row level security;
alter table public.reward_unlocks enable row level security;

-- Member-owned private tables.
create policy member_profiles_owner on public.member_profiles for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy goals_owner on public.goals for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy goal_replacements_owner on public.goal_replacements for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy goal_logs_owner on public.goal_logs for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy devices_owner on public.devices for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy device_rules_owner on public.device_rules for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy decision_lock_read_own on public.decision_lock_requests for select using (auth.uid() = user_id);
create policy spending_boundaries_owner on public.spending_boundaries for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy spending_entries_owner on public.spending_entries for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy guide_calls_read_own on public.guide_calls for select using (auth.uid() = user_id);
create policy challenge_enrolments_owner on public.challenge_enrolments for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy reward_unlocks_read_own on public.reward_unlocks for select using (auth.uid() = user_id);

-- Community profiles/posts are readable to signed-in members; writes remain self-owned.
create policy community_profiles_member_read on public.community_profiles for select using (auth.uid() is not null);
create policy community_profiles_owner_write on public.community_profiles for insert with check (auth.uid() = user_id);
create policy community_profiles_owner_update on public.community_profiles for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy community_posts_member_read on public.community_posts for select using (auth.uid() is not null and status = 'visible');
create policy community_posts_owner_insert on public.community_posts for insert with check (auth.uid() = user_id);
create policy community_posts_owner_update on public.community_posts for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy community_comments_member_read on public.community_comments for select using (auth.uid() is not null and status = 'visible');
create policy community_comments_owner_insert on public.community_comments for insert with check (auth.uid() = user_id);
create policy community_comments_owner_update on public.community_comments for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy community_reports_owner_insert on public.community_reports for insert with check (auth.uid() = reporter_user_id);
create policy community_reports_owner_read on public.community_reports for select using (auth.uid() = reporter_user_id);

-- Public catalogue data for signed-in members.
create policy challenge_definitions_read on public.challenge_definitions for select using (auth.uid() is not null and active = true);
create policy reward_catalog_read on public.reward_catalog for select using (auth.uid() is not null and active = true);

-- Important: creation/resolution of Decision Lock transitions, Guide call status updates,
-- challenge-completion verification and reward minting should be handled by privileged
-- server functions / service roles, not direct member writes.
