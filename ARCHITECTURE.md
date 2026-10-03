# Vanta Technical Architecture

## Principle

One Vanta account, one Goal Engine, multiple client surfaces.

```text
                    VANTA ACCOUNT
                         │
                 Shared Goal Engine
                         │
        ┌────────────────┼────────────────┐
        │                │                │
      Mobile           Desktop          Browser
   Android / iOS      Windows/macOS      Extension
        │                │                │
        └──────── device-specific rules ─┘
                         │
                    Supabase backend
                Postgres + Auth + Storage
                         │
      ┌──────────────────┼────────────────────┐
      │                  │                    │
  Community         Guide Operations      Challenges/
                                          Rewards
```

## Stack

### Shared backend
- Supabase Postgres
- Supabase Auth
- Storage only where necessary
- RLS for member isolation
- server-authoritative RPC / Edge Functions for consequential transitions
- no call audio stored in Supabase

### Web
- React + TypeScript + Vite
- responsive PWA/member dashboard

### Mobile
- React Native / Expo for shared UI and member workflows
- platform-native protection modules where required

### Desktop
- Tauri shell + shared web UI where practical
- native protection adapters where required

### Browser
- Manifest V3 extension architecture
- site/category blocking and intervention layer

## Cross-platform model

Two layers:

1. **Account goals** — what the member is trying to change.
2. **Device rules** — how each connected device participates.

Example:

```text
Account Goal: No adult content after 23:00

Phone: Protect
Laptop: Protect
Tablet: Nudge
Work browser: Track only
```

Do not promise identical enforcement on every OS. Capability must be explicit per platform.

## Domain modules

- identity
- memberships
- goals
- replacement-habits
- devices
- protection
- decision-lock
- behavioural-logs
- spending-boundaries
- community
- moderation
- guide-checkins
- challenges
- rewards
- notifications
- analytics
- safety

## Privacy domains

### Account identity
Billing/contact identity. Private.

### Behaviour identity
Goals, logs, interventions, spending boundaries. Highly sensitive.

### Community identity
Pseudonymous profile used in the men's community.

### Guide-facing identity
Minimum information necessary to conduct a useful check-in.

These domains must not be casually joined in front-end queries.

## Server authority

The server owns:
- membership entitlements;
- challenge completion eligibility;
- reward unlocks;
- Decision Lock timestamps and release rules;
- Guide call scheduling state;
- community moderation state;
- cross-device goal versioning.

Clients can request changes but should not be trusted to mint rewards, shorten lock periods or alter completed call metadata.

## Decision Lock state machine

```text
ACTIVE
  │ request change
  ▼
COOLING_OFF ── cancel ──► ACTIVE
  │ time elapsed
  ▼
CONFIRMABLE
  │ confirm
  ▼
CHANGED
```

No irreversible “you can never leave” design.

## Realtime

Use selectively:
- community thread updates;
- check-in scheduling changes;
- cross-device goal/rule sync.

Do not stream high-frequency behavioural data when polling/sync is sufficient.

## Security baseline

- RLS on all member-owned rows;
- explicit service-role-only operations for Guide / moderation workflows;
- no raw browsing history exposed to Guides;
- no community access to behavioural private tables;
- no reward partner access to PMO data;
- idempotency for reward redemption and Guide booking operations;
- audit privileged operations without storing call content.
