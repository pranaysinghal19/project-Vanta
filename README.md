# Vanta

**Private accountability. Real progress.**

Vanta is a private monthly accountability membership for men who want more control over habits they may not want to discuss with people they know. The first programme is focused on pornography / PMO boundaries and paid adult-content spending, but the product is intentionally broader: members choose what they want to reduce, what they want to build instead, and how strongly Vanta should intervene.

Vanta combines:

- a cross-platform personal Goal Engine;
- user-selected `Track`, `Nudge`, and `Protect` enforcement levels;
- device-specific protection rules and delayed overrides;
- replacement habits such as sleep, fitness, reading, focus, savings, and social routines;
- a moderated anonymous men's improvement community;
- fortnightly private human accountability calls from trained Vanta Guides / tele-support partners;
- challenges with small partner rewards that reinforce positive habits;
- spending boundaries and “money kept / redirected” progress;
- privacy-by-design separation between account, behaviour, community, and guide-facing data.

## Brand decision locked

**Logo Concept 01 — Core Flow is LOCKED as Vanta's primary app mark.**

The canonical mark is the flowing ribbon symbol in `assets/brand/vanta-flow-primary.svg`: a warm coral-to-lilac-to-violet transition on a near-black rounded-square app icon. It represents movement from one state into another — not a flame, shield, mountain, arrow, or gym/alpha symbol.

See [`BRAND.md`](./BRAND.md) and [`DECISIONS.md`](./DECISIONS.md).

## Product doctrine

> **Choose what goes. Choose what replaces it.**

Vanta is not a shame product, a surveillance product, a therapy substitute, or a generic streak counter. Members define their own boundaries. A slip is information, not a moral failure. The product is designed to make honest behaviour change easier and to help members build a fuller life around the change.

## Repository status

This repository is the clean v0 foundation for the product. It contains the locked brand system, product architecture, privacy model, moderation rules, human check-in protocol, a web prototype shell, shared domain contracts, and the initial Supabase data model.

Production-grade platform enforcement (Android, iOS, desktop and browser) is intentionally represented as adapters / implementation tracks rather than falsely marked complete. OS-level enforcement must be validated against current platform policy before launch.

## Structure

```text
apps/
  web/        responsive product prototype / member dashboard
  mobile/     React Native / Expo implementation track
  desktop/    Tauri implementation track
  extension/  browser protection implementation track
packages/
  domain/     shared product types and rules
  brand/      locked design tokens
assets/brand/ locked logo assets and design references
supabase/     backend migrations and security model
docs/         product, privacy, operations and roadmap documentation
```

## Working principles

1. User agency first — the member chooses the goal.
2. Privacy first — do not expose why someone joined Vanta to community members, partners or unnecessary staff.
3. Human accountability without surveillance.
4. Remove + replace — every reduction goal should be able to pair with a positive habit.
5. Cross-platform account, platform-specific enforcement.
6. No explicit sexual content in the community.
7. No call recording, transcription or AI listening for ordinary Guide calls.
8. No medical claims unless substantiated and reviewed.
9. Honest progress > perfect streaks.
10. The app should feel alive and forward-moving, not gym-bro, corporate-wellness or meditation-themed.

## Local web prototype

```bash
npm install
npm run dev:web
```

The prototype is intentionally backed by mock data until the Supabase project is connected and migrations are reviewed.

## Ownership

Private proprietary project. All rights reserved.
