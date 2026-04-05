# Design System: List Keep & Cosmic UI

This document outlines the visual language, design tokens, and component patterns for the List Keep application, encompassing both the **Terra Archival** (Warm/Editorial) and **Aether Glass** (Cosmic/Glassmorphic) themes.

---

## 1. Color Tokens

### Terra Archival (Light Theme)
- **Primary:** `#2D4B43` (Deep Forest) - Used for brand identity and primary actions.
- **Secondary:** `#16342d` (Night Forest) - High contrast accents.
- **Background:** `#fcf9f4` (Bone White) - Main screen surface.
- **Surface:** `#f6f3ee` (Off-white) - Secondary containers and backgrounds.
- **Accent/Warning:** `#e48a6e` (Terracotta) - Badges and destructive actions.
- **Text Primary:** `#1a1a1a` - High legibility.
- **Text Secondary:** `#666666` - Captions and metadata.

### Aether Glass (Dark/Cosmic Theme)
- **Background:** `linear-gradient(180deg, #0D1117 0%, #000000 100%)` with subtle purple accents.
- **Glass Surface:** `rgba(255, 255, 255, 0.08)` background with `20px - 40px` backdrop-blur.
- **Glass Border:** `rgba(255, 255, 255, 0.15)` 1px solid stroke.
- **Accent:** `#cfbef5` (Soft Lavender) - High contrast active states.
- **Text Primary:** `#ffffff`
- **Text Secondary:** `#c6c6cb`

---

## 2. Typography Scale (Manrope)

- **Display:** 32px / 1.2 / Bold / -0.02em tracking
- **Headline:** 24px / 1.3 / Bold / -0.01em tracking
- **Title:** 20px / 1.4 / SemiBold
- **Body Large:** 16px / 1.5 / Regular
- **Body Medium:** 14px / 1.5 / Regular
- **Label/Small:** 12px / 1.4 / SemiBold / 0.05em tracking (Uppercase)

---

## 3. Spacing & Grid (Mobile-First)

- **Base Unit:** 4px
- **Gutter:** 16px or 20px (Standard side margins)
- **Section Gap:** 24px or 32px
- **Component Padding:** 12px (Small), 16px (Medium), 24px (Large)
- **Touch Targets:** Minimum 44x44px for all interactive elements.

---

## 4. Components & Patterns

### Button Styles
- **Primary:** Solid `#2D4B43` (Terra) or Lavender `#cfbef5` (Cosmic). Rounded 12px or Full.
- **Secondary/Outline:** 1.5px border matching text color.
- **States:**
  - *Default:* Full opacity.
  - *Pressed:* Scale 0.96, opacity 0.9.
  - *Disabled:* Opacity 0.4, grayscale.

### Form Fields
- **Container:** Height 56px, background `#f6f3ee` (Terra) or Glass (Cosmic).
- **Labels:** Floating or top-aligned labels in 12px Semibold.
- **Active State:** 2px border in primary brand color.

### Card Patterns
- **Standard Card:** White or Off-white background, 12px radius, subtle 4px blur shadow.
- **Template Card:** Featured icons, larger titles, secondary accent backgrounds (e.g., light green/orange).
- **Glass Card:** Backdrop-blur (40px), 1px white border (15% opacity), inner glow.

### Status Badges
- **Shape:** Pill-shaped, 12px horizontal padding.
- **Visuals:** Low-opacity background of the status color with high-contrast text.
  - *Essential/New:* Terracotta/Lavender.
  - *Offline:* Light gray.

### Empty States
- **Hierarchy:** Centered illustration (40% opacity) > Headline > Subtext > Primary CTA.
- **Placement:** Vertical center of the viewport or container.

---

## 5. Mobile Ergonomics & Behavior

- **The Thumb Zone:** Primary actions (Save, Add, Navigation) are pinned to the bottom 1/3 of the screen.
- **One-Handed Navigation:** Bottom Tab Bar with clear icons and labels.
- **Dynamic Panels:** Expanding bottom sheets for complex inputs/components to keep interactions low on the screen.
- **Responsive Rules:** 
  - Max-width for cards: 600px.
  - Stacked grids on narrow viewports (320px).
  - Transition from 2-column to 1-column grid below 360px if content is text-heavy.

---

## 6. Theme Guidance

- **Switching Logic:** Maintain semantic color names (e.g., `surface-primary`) so values can swap between Light (Terra) and Dark (Aether) modes.
- **Shadows:** Use soft, natural shadows in light mode; rely on border-glows and backdrop-blur in dark cosmic mode.
