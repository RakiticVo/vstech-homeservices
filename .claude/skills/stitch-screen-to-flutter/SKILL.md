---
name: stitch-screen-to-flutter
description: Convert a Stitch-generated screen design into Flutter widgets that strictly follow the Eco-Clean Sanctuary design tokens in CLAUDE.md. Use whenever implementing a page/widget from a Stitch mockup (mcp__stitch__get_screen output).
---

# Stitch Screen → Flutter

Stitch screens are the visual source of truth for layout and content; `CLAUDE.md`'s Design System
section is the source of truth for the actual values used to build it. When they conflict on a
specific pixel value, tokens in `CLAUDE.md`/`docs/design/DESIGN.md` win — flag the discrepancy to the
user rather than silently picking one.

## Steps

1. Fetch the screen with `mcp__stitch__get_screen` (or `list_screens` to find it first). Note the
   screen name/purpose and which feature module it belongs to (see `PHASE1_SCOPE.md`).

2. **Never hardcode a value that has a token equivalent.** Translate every color, font, radius, and
   spacing value in the mockup to its nearest `AppColors` / `AppTextStyles` / `AppSpacing` constant —
   do not paste raw hex codes or literal `EdgeInsets` numbers into feature widgets. If a mockup uses a
   color/size with no matching token, stop and flag it — don't invent a new ad hoc token silently.

3. Map typography: headings/buttons → `AppTextStyles` built on `GoogleFonts.plusJakartaSans`; body/
   numeric text → built on `GoogleFonts.inter`. Never introduce a third font family.

4. Respect ergonomics rules regardless of how the mockup renders on a design canvas: minimum 44×44
   (preferred 48×48) touch targets, one primary CTA per screen at 48–52px height, status always shown
   as icon + label + color together.

5. Build with reusable primitives first: check `core/widgets/` before writing a new button/input/card
   — reuse or extend `AppButton`/`AppTextField` rather than duplicating markup from the mockup.

6. Wire the resulting widget into the correct `features/<name>/presentation/pages/` file (create the
   feature skeleton first via `flutter-feature-scaffold` if it doesn't exist yet). Static layout only
   in this pass — data wiring to a Cubit/BLoC is a separate step unless the user asked for both.

7. After building, do a side-by-side sanity check against the Stitch screenshot for spacing rhythm and
   information hierarchy, not pixel-identical matching — Flutter layout adapts to real device sizes via
   `flutter_screenutil`, the Stitch mockup is a reference, not a fixed canvas.
