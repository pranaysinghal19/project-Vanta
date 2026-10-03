# Vanta Brand System

## Locked logo direction

**Concept 01 — Core Flow** is the canonical app icon / symbol direction.

Files:
- `assets/brand/vanta-flow-primary.svg` — primary app icon
- `assets/brand/vanta-flow-symbol.svg` — transparent symbol only
- `assets/brand/vanta-flow-mono.svg` — monochrome symbol
- `assets/brand/favicon.svg` — simplified small-size icon
- `assets/brand/tokens.json` — machine-readable brand tokens

Reference boards are retained in `assets/brand/references/` only as visual history. The SVG assets above are authoritative.

## Meaning

The symbol is an abstract ribbon moving through a turn. It represents:
- change from one state into another;
- momentum rather than aggression;
- progress that can bend without stopping;
- a “better next”, not an idealised perfect self.

It is **not** a flame, despite the warmth in the gradient.

## Colour

### Foundation
- Coal — `#151516`
- Paper — `#F4F1EA`

### Brand accents
- Coral — `#FF5B4D`
- Lilac — `#8B78FF`
- Violet — `#5B43D6`
- Lime — `#C7EB5A` (progress/completion only; use sparingly)

### UI neutrals
- Ink — `#222228`
- Slate — `#6C6C78`
- Line — `#DEDDD8`
- Surface — `#FBFAF7`

## Gradient

Primary Flow gradient:

```css
linear-gradient(145deg,
  #FF6A57 0%,
  #EF7EC7 38%,
  #A36CF4 62%,
  #5B43D6 100%
)
```

Do not turn the entire product into a gradient UI. The gradient belongs to moments of movement, identity, challenge completion and emotional emphasis.

## Typography

Preferred application stack:

```css
font-family: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
```

The brand should feel modern and direct. Avoid ornate luxury serifs, “masculine” condensed sports fonts, and wellness-script typography.

## Copy tone

Vanta is direct, human and non-judgmental.

Good:
- `Something needs to change. Start here.`
- `Choose what goes. Choose what replaces it.`
- `Yesterday happened. Today isn't cancelled.`
- `₹5,000 stayed yours.`
- `You said this mattered.`
- `Do your logs reflect how the fortnight really went?`
- `Not perfect. Still moving.`

Avoid:
- `Become an alpha.`
- `Conquer your urges.`
- `Rewire your masculine energy.`
- `Unlock superhuman testosterone.`
- `A calmer, stronger you.`
- `Forge the warrior within.`

## Visual direction

Use:
- high-contrast typography;
- controlled bursts of brand gradient;
- visible momentum and before/after state transitions;
- honest, everyday progress metrics;
- clean white/light product surfaces with strong dark moments;
- dark mode as a first-class theme;
- motion that suggests continuation / transition.

Avoid:
- mountains;
- men staring into sunsets;
- leaves / spa imagery;
- dumbbells as brand symbols;
- literal fire everywhere;
- metallic 3D logos;
- shields / warriors / animals;
- corporate cybersecurity iconography.

## App icon rules

- Use the Core Flow mark centred in a rounded-square field.
- Primary field: Coal `#151516`.
- Maintain breathing room of at least ~18% around the mark.
- No wordmark inside launcher icon.
- No glow stronger than the shape itself.
- At favicon size, use the simplified symbol.
