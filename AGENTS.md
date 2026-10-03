# Instructions for Coding Agents

## Owner context

The owner is not a software engineer. Do not push framework, SQL or debugging decisions back to the owner unless a real business/product choice depends on them. Explain technical consequences in plain language.

## Do not undo locked decisions

Read `DECISIONS.md` first.

Most important:
- product name remains Vanta unless owner explicitly changes it;
- Concept 01 / Core Flow logo is locked;
- no surprise rebrand;
- no gym-bro, yoga, cyber-security or alpha-male visual drift;
- community stays non-explicit;
- ordinary Guide calls are not recorded/transcribed;
- human Guide accountability is part of the core membership;
- account goals sync across platforms, device rules remain device-specific.

## Engineering standards

- TypeScript strict mode.
- Server-authoritative consequential transitions.
- Privacy minimisation.
- RLS for every member-owned Supabase table.
- No user-controlled membership/reward/Guide authority fields.
- Idempotent mutations for bookings and rewards.
- Keep the monorepo modular; avoid premature microservices.
- Document platform limitations honestly.

## Product language

Use respectful, non-clinical language unless a clinical context genuinely applies. Do not imply masturbation itself is inherently unhealthy. Do not invent medical benefits.
