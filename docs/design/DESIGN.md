---
name: Eco-Clean Sanctuary 1
colors:
  surface: '#faf8ff'
  surface-dim: '#d2d9f4'
  surface-bright: '#faf8ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f3ff'
  surface-container: '#eaedff'
  surface-container-high: '#e2e7ff'
  surface-container-highest: '#dae2fd'
  on-surface: '#131b2e'
  on-surface-variant: '#3d4947'
  inverse-surface: '#283044'
  inverse-on-surface: '#eef0ff'
  outline: '#6d7a77'
  outline-variant: '#bcc9c6'
  surface-tint: '#006a61'
  primary: '#00685f'
  on-primary: '#ffffff'
  primary-container: '#008378'
  on-primary-container: '#f4fffc'
  inverse-primary: '#6bd8cb'
  secondary: '#3b665f'
  on-secondary: '#ffffff'
  secondary-container: '#bdece2'
  on-secondary-container: '#416c65'
  tertiary: '#924628'
  on-tertiary: '#ffffff'
  tertiary-container: '#b05e3d'
  on-tertiary-container: '#fffbff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#89f5e7'
  primary-fixed-dim: '#6bd8cb'
  on-primary-fixed: '#00201d'
  on-primary-fixed-variant: '#005049'
  secondary-fixed: '#bdece2'
  secondary-fixed-dim: '#a2d0c6'
  on-secondary-fixed: '#00201c'
  on-secondary-fixed-variant: '#224e47'
  tertiary-fixed: '#ffdbce'
  tertiary-fixed-dim: '#ffb59a'
  on-tertiary-fixed: '#370e00'
  on-tertiary-fixed-variant: '#773215'
  background: '#faf8ff'
  on-background: '#131b2e'
  surface-variant: '#dae2fd'
typography:
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
rounded:
  sm: 0.5rem
  DEFAULT: 1rem
  md: 1.5rem
  lg: 2rem
  xl: 3rem
  full: 9999px
spacing:
  gutter: 1rem
  margin: 1rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2rem
---

# Eco-Clean Sanctuary 1
UI/UX Design System — Google Stitch Generation Specification

**Product:** On-demand household services marketplace  
**Market:** Vietnam  
**Primary users:** Customers / Homeowners + Service Professionals  
**Design target:** Users up to U50  
**Design philosophy:** Simple, Clear, Familiar, Forgiving  

---

## 1. Product Design Direction
Eco-Clean Sanctuary is a household-services marketplace connecting customers with professional service providers.

### 1.1 Customer goals
- Find a service
- Understand the service
- Compare providers when applicable
- Select date and time
- Select or confirm location
- Confirm booking
- Track service status
- Contact the provider
- Complete payment
- Review the service

### 1.2 Professional goals
- Discover available jobs
- Understand job requirements
- Accept or reject jobs
- Navigate to the location
- Start the job
- Update job status
- Complete the job
- Submit required evidence
- Track earnings and payment status

---

## 2. Core Design Principles
1. **Simple:** Reduce unnecessary decisions and visual complexity.
2. **Clear:** Understand where they are, what they are doing, what matters, and what action to take.
3. **Familiar:** Prefer established mobile interaction patterns.
4. **Forgiving:** Back, Edit, Cancel when allowed, Retry failed actions, Correct mistakes.

---

## 3. Law of Simplicity & UX Constraints
- **One screen = one goal**
- **One primary action** (CTA height: 48–52px)
- **Progressive disclosure**
- **Touch targets:** Minimum 44 × 44px, Preferred 48 × 48px
- **Visible actions:** No critical actions hidden behind gestures or icon-only buttons
- **Status clarity:** Always use `Icon + Label + Color`

---

## 4. Brand & Color System — LOCKED
- **Primary Teal:** `#0D9488` | Pressed: `#0F766E`
- **Secondary Mint:** `#CCFBF1` | Surface: `#F0FDFA`
- **Background:** `#FAF9F6` | Card Surface: `#FFFFFF`
- **Text:** Primary `#0F172A` | Secondary `#475569` | Muted `#94A3B8`
- **Semantic:** Success `#10B981` | Warning `#F59E0B` | Error `#EF4444`

---

## 5. Typography & Ergonomics
- **Headings & Buttons:** Plus Jakarta Sans
- **Body & Numerical/Prices:** Inter (Body >= 16px, Functional >= 14px)
- **Border Radius:** 12px (controls), 16px (inputs), 24px (cards/sheets), 999px (pills)