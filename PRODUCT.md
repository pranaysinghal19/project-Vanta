# Vanta Product Definition

## One sentence

Vanta is a private monthly accountability membership that helps men reduce habits they want less of, build better habits in their place, and stay honest through cross-platform tools, community, challenges and recurring human check-ins.

## The member problem

Some habits are difficult to discuss with friends, partners or family. Pornography / PMO and paid adult content are an especially strong initial wedge because a member may want change without public disclosure, shame or surveillance.

Vanta is designed around the gap between:

> “I know what I want to do.”

and

> “I actually did it when the difficult moment arrived.”

## Core product loop

```text
Choose what goes
    ↓
Choose what replaces it
    ↓
Set enforcement strength
    ↓
Apply account goals + device rules
    ↓
Track honestly
    ↓
Use interventions when needed
    ↓
Community / challenge support
    ↓
Fortnightly human check-in
    ↓
Monthly review
    ↓
Reward progress
    ↓
Commit again
```

## Goal Engine

A goal has:
- category;
- direction: `reduce` or `build`;
- member-defined target;
- timeframe;
- enforcement mode;
- optional replacement linkage;
- privacy classification;
- progress method.

### Enforcement modes

**Track** — observe and understand behaviour.

**Nudge** — warnings, cooldowns, reminders and replacement actions.

**Protect** — stronger blocking / protection where the operating system allows it, plus delayed override through Decision Lock.

## Initial goal categories

### Reduce / control
- pornography;
- PMO;
- masturbation frequency;
- paid adult content;
- late-night browsing;
- social-media use;
- custom.

### Build
- sleep;
- exercise;
- walking / outdoors;
- reading;
- study / deep work;
- savings;
- social routines;
- custom.

The architecture supports additional categories later, but V1 should not become a bloated “fix every habit” application.

## Decision Lock

The member can voluntarily make important protection changes subject to a cooling period.

Example:

```text
Adult-content protection: ON
Decision Lock: 24 hours

01:17 — member requests protection off
01:17 next day — request becomes confirmable
member can cancel the request at any time before activation
```

The member remains in control. Vanta creates time between impulse and action rather than permanently trapping the user.

## Paid-content spending

Vanta supports voluntary spending boundaries such as:
- ₹0 paid adult content;
- monthly ceiling;
- category/site blocking;
- delayed limit increases;
- manual spending logs in V1;
- optional financial-data integration later, only with explicit permission.

Positive metric:

> **Money kept / redirected**

The product should show what the member retained and optionally where they chose to redirect it (savings, gym, travel, learning, debt, hobby, etc.).

Vanta must not claim it can veto every bank/card transaction unless it has an actual payment/banking integration capable of doing so.

## Replacement habits

A reduction goal should be able to link to one or more positive replacements.

Example:

```text
Reduce: pornography after 11pm
Build: phone outside bedroom + sleep before midnight + read 20 minutes
```

The app and Guide should discuss both sides.

## Community

The community exists for men to improve — not to keep pornography at the centre of their identity.

Suggested spaces:
- Discipline & Accountability
- Fitness & Health
- Focus / Study / Career
- Money & Spending
- Sleep & Digital Habits
- Social Confidence
- Mental Wellbeing
- PMO Recovery
- Wins
- Challenges

Core moderation rule:

> **Discuss the problem, not the pornography.**

## Human accountability

Each Guided member receives two check-ins each month from a trained human Guide / tele-support partner.

The Guide is not another community member and is not automatically a therapist.

The Guide should gently reality-check the data:

> “Do you feel what you logged reflects how the last two weeks actually went?”

If not:

> “That’s alright. You’re not being graded. We’d rather have an honest picture than a perfect one.”

The Guide should also ask about positive habits, not only PMO.

## Challenges & rewards

Challenges reinforce replacement habits. Examples:
- Move 12 — 12 workouts in 30 days;
- Sleep Reset — target met 20 nights;
- Read 300 — 300 minutes reading;
- Focus 20 — 20 focus sessions;
- Outside 20 — 20 walks/outdoor sessions;
- Honest 14 — 14 daily check-ins;
- No-Spend Reset — remain within a member-selected spending boundary.

Partner rewards should be modest and aligned to the positive behaviour: fitness, books, learning, wellbeing, sport, activities, etc.

Partners must never learn why a member joined Vanta. They receive only eligibility/redemption information required for the reward.

## Progress model

Avoid reducing the product to a single sobriety streak.

Possible indicators:
- adherence to self-selected boundaries;
- logging consistency;
- urges/interventions completed;
- recovery after slips;
- replacement-habit consistency;
- money kept / redirected;
- Guide check-ins completed;
- challenges completed.

A slip does not erase all progress.

## Monthly review

A member's monthly review may include:

```text
Boundary adherence          82%
Honest logs                 25 / 30 days
Paid-content spending       ₹900
Money kept                  ₹3,700
Gym                         10 sessions
Sleep target                18 nights
Difficult moments           9
Interrupted successfully    6
Human check-ins             2 / 2
Challenges                  Move 12 ✓
Reward                      partner offer unlocked
```

The month ends by asking what the member wants the next month to look like.
