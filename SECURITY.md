# Security Baseline

## Sensitive product assumptions

Vanta may hold sexual-behaviour goals, behavioural logs and spending-boundary data. Treat this as high-sensitivity user data even when a specific jurisdiction does not label every field identically.

## Requirements

- Row Level Security on every member-owned table.
- Default deny; allow explicit owner/member access.
- Server-only operations for reward minting, Guide administration and moderation.
- Separate community identity from account identity.
- No direct partner access to sensitive goal data.
- No call audio storage.
- No transcript storage.
- Avoid storing raw URLs when category-level decisions are sufficient.
- Idempotency keys for booking/redemption mutations.
- Audit privileged staff actions.
- Rate-limit community writes and sensitive endpoints.
- Use least-privilege vendor access.

## Secrets

Never commit:
- Supabase service-role keys;
- telephony provider secrets;
- payment secrets;
- reward-partner secrets;
- signing keys.
