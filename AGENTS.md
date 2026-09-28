# vstech_home_services — Universal Agent Rules

> **For All AI Agents (Antigravity, Gemini, Claude, Cursor, Copilot, Codex, etc.):**
> Read this file fully before writing any code. It is the single source of truth
> for this repository. If something here conflicts with a file in `docs/reference/` (copied from the
> sibling `home_services` project for business context only), **this file wins** for anything
> technical; `docs/reference/` wins for business/API contract facts.

## Project Identity

| Key | Value |
| :--- | :--- |
| **Project Name** | VSTech Home Services |
| **Platform** | Flutter (Dart) — iOS & Android only. No web, no desktop. |
| **Phase** | Phase 1 MVP — see `docs/reference/PHASE1_SCOPE.md` |
| **Scope** | B2C Customer App + Worker App (one codebase, role-aware routing via GoRouter) |
| **Architecture** | Feature-first clean architecture (BLoC/Cubit: `data/`, `domain/`, `presentation/`) |
| **Backend** | External dependency. This repo only consumes the REST/WebSocket contracts in `docs/reference/api/`. Never implement backend logic, admin/B2B workflows, ledger/payout engines, matching algorithms, or database schemas here. |

This is a **fresh codebase**. Do not port code, patterns, or the BMAD agent system from
`D:\StudioProjects\home_services` — only its documentation is reused, and only through the curated
copies in `docs/reference/`.

---

## Tech Stack (Locked — do not change without discussing with the user first)

| Layer | Technology |
| :--- | :--- |
| **Language** | Dart, SDK ≥ 3.0 |
| **Framework** | Flutter ≥ 3.22 |
| **State Management** | flutter_bloc / Cubit |
| **Navigation** | go_router |
| **HTTP Client** | dio (+ pretty_dio_logger in debug builds only) |
| **Dependency Injection** | get_it + injectable |
| **JSON Serialization** | freezed + json_serializable + json_annotation |
| **Local DB / Cache** | hive_flutter |
| **Secure Storage** | flutter_secure_storage |
| **Typography** | google_fonts (`Source Sans 3` via `GoogleFonts.sourceSans3`) |
| **Responsive scaling** | flutter_screenutil |
| **Location & Maps** | google_maps_flutter + geolocator (GPS tracking 2s/broadcast) |
| **Permissions** | permission_handler (Camera, Location, Mic, Notifications) |
| **Realtime** | STOMP over WebSocket (`stomp_dart_client` or equivalent) for chat/tracking — see `docs/reference/api/00-foundation.md` |
| **Network State** | connectivity_plus (Auto reconnect trigger & offline banner) |
| **Push** | firebase_messaging |
| **Crash reporting** | firebase_crashlytics |
| **Image/file pick** | image_picker |
| **Formatting / L10n** | intl + flutter_localizations (100% Zero Hardcoding, VI & EN) |
| **System Utilities** | url_launcher (dialer tel:, navigation geo:, deep link), uuid |
| **Logging** | logger (`appLogger` via PrettyPrinter) + pretty_dio_logger (debug only) |
| **Linter** | very_good_analysis |
| **Testing** | bloc_test, mocktail, golden_toolkit |

---

## Design System — Eco-Clean Sanctuary v9.0

**Source of truth: `docs/design/MASTER_SPEC_V9.md`.** This is the authoritative, actively-used
design spec (confirmed against the user's real Stitch project) and **supersedes**
`docs/design/DESIGN.md`, which is now reference-only history.

**Core tokens** (`lib/core/constants/app_colors.dart`):

| Token | Value | Usage |
| :--- | :--- | :--- |
| `primary` | `#0D9488` | The single dominant accent — exactly **one** primary CTA per screen, or the active tab. Never scattered across icons/badges/borders. |
| `primaryPressed` | `#0F766E` | Pressed/active state of primary. |
| `onPrimary` | `#ffffff` | Text/icons on primary. |
| `secondary` | `#CCFBF1` | Light mint tint — badges, subtle highlights (not an action color). |
| `secondarySurface` | `#F0FDFA` | Selected chip/card background, always paired with a `primary` border. |
| `background` | `#FAF9F6` | Warm ivory app background — never stark white. |
| `surface` | `#FFFFFF` | Card/sheet surface. |
| `textPrimary` | `#0F172A` | Headlines, field labels, prices, phone numbers. **Never** pure black `#000000` — that is explicitly forbidden anywhere in the UI. |
| `textSecondary` | `#475569` | Descriptions, secondary addresses. |
| `textMuted` | `#94A3B8` | Placeholders, timestamps, fine print. |
| `border` | `#E2E8F0` | Hairline 1px border — **replaces box-shadow everywhere**. |
| `success` / `successDark` | `#10B981` / `#059669` | Verified/approved states. |
| `warning` | `#F59E0B` | Urgent/warning states. |
| `error` / `errorAlt` | `#EF4444` / `#F43F5E` | Required-field marks, cancellations, high-risk warnings. |

**Hard rules (non-negotiable, checked against the 8-point checklist in `MASTER_SPEC_V9.md` Part 6 before any screen ships):**
1. **Zero Shadows** — no `box-shadow`/`elevation` anywhere. Use the `border` hairline instead.
2. **No pure black** (`#000000`) anywhere in the UI, ever.
3. **60-30-10 color ratio** — `background`/`surface` dominant (60%), `textPrimary`/`border` structural (30%), `primary` as the sole accent (10%).
4. **Selected chip/card state** = `secondarySurface` background + `primary` border + check icon — never a solid dark/black fill.
5. **Fixed floating bottom nav dock** (`rounded-full`, white, hairline border) pins to the screen bottom; scrollable page bodies need `AppSpacing.dockClearanceMin`–`dockClearanceMax` (112–128px) of bottom padding so content is never hidden under it.
6. **Photo-first** — service categories/cards use real photo thumbnails (squircle, soft-rounded), not abstract icons. Placeholder images are fine until real photography exists.
7. **Icons** are neutral slate grey (`textMuted`/`textSecondary`), hairline stroke (1.25–1.5px), 20–24px, never wrapped in a circle/square chip, never all turned `primary` teal.
8. **Typography minimums**: field labels ≥14px, input/body text ≥16px (prevents iOS auto-zoom), card titles ≥18px, button text 16–17px bold/semibold.
9. **Zero Hardcoded Text (100% Localization)**: All user-visible strings MUST come from `context.l10n` with 1:1 parity between `app_vi.arb` and `app_en.arb`.
10. **SOLID Principles & Clean Architecture**: Presentation widgets must stay decoupled from data sources; business logic lives in BLoC/Cubit only.
11. **CHANGELOG Maintenance**: Keep `CHANGELOG.md` updated whenever implementing or updating plans.

**Typography Scale:**
- Entire App Typography → `GoogleFonts.sourceSans3`
- Constants defined in `lib/core/constants/app_text_styles.dart`.


**Radius Hierarchy (`lib/core/constants/app_spacing.dart` → `AppRadius`):**
- `chip=8px` (badges/tags)
- `control=12px` (inputs, selection chips, the primary CTA)
- `card=16px` (content cards/sheets)
- `full=9999px` (**only** the floating bottom nav dock and special round buttons — never a big card).

---

## Workspace Skills (`.agents/skills/`)

Every agent has access to the following workspace skills:
- **`start-session`**: Initializes a development turn, runs health checks (`flutter analyze`, `flutter test`), maps progress against the 16-screen matrix, and provides a kickoff report.
- **`flutter-feature-scaffold`**: Scaffolds a new `lib/features/<name>` Clean Architecture module (`data/`, `domain/`, `presentation/`).
- **`stitch-screen-to-flutter`**: Converts Stitch mockups into Eco-Clean Sanctuary v9.0 compliant Flutter widgets.
- **`api-module-integration`**: Wires network endpoints from `docs/reference/api/` with typed DTOs, datasource, and repository.

---

## Project Directory Structure

```
lib/
├── main.dart
├── app.dart                      # MaterialApp + GoRouter + theme setup
├── core/
│   ├── constants/                # AppColors, AppTextStyles, AppSpacing — ONLY source of truth
│   ├── di/                       # get_it + injectable setup
│   ├── network/                  # ApiClient (dio), api_endpoints.dart, NetworkException, WS/STOMP client
│   ├── router/                   # GoRouter config + route name constants
│   ├── theme/                    # ThemeData light/dark built from AppColors/AppTextStyles
│   ├── utils/                    # idempotency_key.dart, logger.dart
│   └── widgets/                  # Shared AppButton, AppTextField, LoadingOverlay, etc.
├── features/
│   ├── auth/                     # Phone/password login, OTP registration, role-aware routing
│   ├── home/                     # B2C: category browse, search, favorites
│   ├── booking/                  # B2C: booking form + matching/dispatch state
│   ├── tracking/                 # Shared: live GPS tracking map
│   ├── checkout/                 # B2C: payment (VNPay/ZaloPay)
│   ├── messaging/                # Shared: chat + VoIP call UI
│   ├── worker_dashboard/         # Worker: online toggle + earnings summary
│   ├── worker_dispatch/          # Worker: job accept/decline overlay
│   ├── worker_task/              # Worker: task execution + status updates
│   ├── worker_kyc/               # Worker: eKYC onboarding wizard
│   └── wallet/                   # Worker: wallet + withdrawal request
└── l10n/                         # vi, en
```

---

## BLoC / Cubit Patterns

- Use **Cubit** for simple screen state, **BLoC** for event-driven multi-step flows.
- Wrap route-level blocs in `BlocProvider` inside the `GoRoute` builder, not at app root.
- Never call API/business logic directly from widgets — always through a Cubit/BLoC.
- Never pass full model objects via GoRouter `extra` — pass IDs and refetch/read from state.
- State classes are `sealed class` hierarchies (Dart 3+): `Initial`, `Loading`, `Loaded`, `Error`.

---

## API Contract Rules

Full details: `docs/reference/api/00-foundation.md` + per-module files. Key rules:
- All calls go through a single `ApiClient` (dio). Never use the `http` package directly.
- Endpoints are declared as string constants in `core/network/api_endpoints.dart`. Base path `/api/v1/...`.
- Every response is wrapped as `ApiResponse<T>` = `{status, message, data, errorCode, timestamp}`.
- Every state-changing `POST` MUST send a client-generated `X-Idempotency-Key: <uuid-v4>` header.
- Tokens live ONLY in `flutter_secure_storage` — never `SharedPreferences`.
- Zero DTO reuse: never share a model between Request and Response.

---

## Out of Scope for Phase 1 MVP

B2B portal, bidding, e-contracts; Admin backoffice; backend services/database/WebSocket server implementation; AI pricing/pre-booking scoping engine; RTB ad engine; loyalty/CMS/marketing; customer assets & warranty tracking (`04-assets-warranty` API exists but is post-MVP — do not build against it yet). Full list: `docs/reference/PHASE1_SCOPE.md`.
