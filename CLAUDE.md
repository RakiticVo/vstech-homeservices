# vstech_home_services — Agent Rules

> **For AI Agents:** Read this file fully before writing any code. It is the single source of truth
> for this repository. If something here conflicts with a file in `docs/reference/` (copied from the
> sibling `home_services` project for business context only), **this file wins** for anything
> technical; `docs/reference/` wins for business/API contract facts.

## Project Identity

| Key | Value |
| :--- | :--- |
| **Project Name** | VSTech Home Services |
| **Platform** | Flutter (Dart) — iOS & Android only. No web, no desktop. |
| **Phase** | Phase 1 MVP — see `docs/reference/PHASE1_SCOPE.md` |
| **Scope** | B2C Customer App + Worker App (one codebase, role-aware routing) |
| **Architecture** | Feature-first clean architecture (BLoC/Cubit) |
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
| **Typography** | google_fonts (Plus Jakarta Sans + Inter — see Design System below) |
| **Responsive scaling** | flutter_screenutil |
| **Location & Maps** | google_maps_flutter + geolocator (GPS tracking 2s/broadcast) |
| **Permissions** | permission_handler (Camera, Location, Mic, Notifications) |
| **Realtime** | STOMP over WebSocket (`stomp_dart_client` or equivalent) for chat/tracking — see `docs/reference/api/00-foundation.md` |
| **Network State** | connectivity_plus (Auto reconnect trigger & offline banner) |
| **Push** | firebase_messaging |
| **Crash reporting** | firebase_crashlytics |
| **Image/file pick** | image_picker |
| **Formatting / L10n** | intl (NumberFormat currency, DateFormat, Pluralization) |
| **System Utilities** | url_launcher (dialer tel:, navigation geo:, deep link), uuid |
| **Logging** | logger (`appLogger` via PrettyPrinter) + pretty_dio_logger (debug only) |
| **Linter** | very_good_analysis |
| **Testing** | bloc_test, mocktail, golden_toolkit |

---

## Design System — Eco-Clean Sanctuary

**Source of truth: `docs/design/MASTER_SPEC_V9.md`.** This is the authoritative, actively-used
design spec (confirmed against the user's real Stitch project) and **supersedes**
`docs/design/DESIGN.md`, which is now reference-only history. Earlier work in this repo used
`DESIGN.md`'s Material-3 YAML front-matter (`primary #00685f`) — that was wrong; the correct locked
palette is the one below, which matches `DESIGN.md`'s own "LOCKED" section.

**Core tokens** (full rationale in `MASTER_SPEC_V9.md` Part 1):

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

Implemented in `lib/core/constants/app_colors.dart` (light scheme only — the spec has no dark-mode
tokens yet).

**Hard rules (non-negotiable, checked against the 8-point checklist in `MASTER_SPEC_V9.md` Part 6
before any screen ships):**
1. **Zero Shadows** — no `box-shadow`/`elevation` anywhere. Use the `border` hairline instead.
2. **No pure black** (`#000000`) anywhere in the UI, ever.
3. **60-30-10 color ratio** — `background`/`surface` dominant (60%), `textPrimary`/`border` structural (30%), `primary` as the sole accent (10%).
4. **Selected chip/card state** = `secondarySurface` background + `primary` border + check icon — never a solid dark/black fill.
5. **Fixed floating bottom nav dock** (`rounded-full`, white, hairline border) pins to the screen bottom; scrollable page bodies need `AppSpacing.dockClearanceMin`–`dockClearanceMax` (112–128px) of bottom padding so content is never hidden under it.
6. **Photo-first** — service categories/cards use real photo thumbnails (squircle, soft-rounded), not abstract icons. Placeholder images are fine until real photography exists.
7. **Icons** are neutral slate grey (`textMuted`/`textSecondary`), hairline stroke (1.25–1.5px), 20–24px, never wrapped in a circle/square chip, never all turned `primary` teal.
9. **Zero Hardcoded Text (100% Localization)**: All user-visible strings MUST come from `context.l10n` with 1:1 parity between `app_vi.arb` and `app_en.arb`.
10. **SOLID Principles & Clean Architecture**: Presentation widgets must stay decoupled from data sources; business logic lives in BLoC/Cubit only.
11. **CHANGELOG Maintenance**: Keep `CHANGELOG.md` updated whenever implementing or updating plans.

**Typography** — `GoogleFonts.sourceSans3` for the entire app.
See `lib/core/constants/app_text_styles.dart` for the full scale.

**Radius hierarchy** (`lib/core/constants/app_spacing.dart` → `AppRadius`): `chip=8px` (badges/tags),
`control=12px` (inputs, selection chips, the primary CTA), `card=16px` (content cards/sheets),
`full=9999px` (**only** the floating bottom nav dock and special round buttons — never a big card).

**Spacing grid:** `xs=4 sm=8 md=16 lg=24 xl=32` (also used as `gutter`/`margin` = 16).

**Ergonomics (non-negotiable, from the product design brief):**
- One screen = one primary goal, one primary CTA (height 48–52px).
- Minimum touch target `44×44`, preferred `48×48`.
- No critical action hidden behind a gesture or an icon-only button — always `Icon + Label`.
- Status must always be communicated as `Icon + Label + Color` together, never color alone.
- WCAG AAA contrast (7:1) for text on any colored background.
- Design target audience skews up to ~50 y/o — favor clarity and familiar patterns over novelty.

**Full 16-screen matrix** (Customer + Worker, both flows in one app) is documented in
`MASTER_SPEC_V9.md` Part 4 — check it before scaffolding a new screen so naming/scope matches.

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

Each feature follows `data/{datasources,models,repositories}`, `domain/{entities,repositories,usecases}`,
`presentation/{bloc,pages,widgets}`. Use the `flutter-feature-scaffold` skill to generate this shape.

---

## Naming Conventions

| Artifact | Convention | Example |
| :--- | :--- | :--- |
| Files | `snake_case.dart` | `booking_bloc.dart` |
| Classes | `PascalCase` | `BookingBloc`, `BookingState` |
| Variables/fields | `camelCase` | `bookingId` |
| API endpoints | `snake_case` path segments | `/api/v1/service_requests` |
| BLoC events | `PascalCase` + `Event` suffix | `FetchServicesEvent` |
| BLoC states | `PascalCase` + `State` suffix | `ServicesLoadedState` |
| Routes | `kebab-case` | `/booking/confirm` |

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
- Endpoints are declared as string constants in `core/network/api_endpoints.dart`. Base path
  `/api/v1/...` — verify the exact path per module doc (e.g. profiles is `/api/v1/profiles`, not `/users`).
- Every response is wrapped as `ApiResponse<T>` = `{status, message, data, errorCode, timestamp}`.
  Success = `errorCode == null` and `status` in 200–299. Always parse through a typed model — never
  read `json['field']` directly in a datasource.
- Paginated endpoints use `PagedResponse<T>` = `{content, page, size, totalItems, totalPages}` —
  **except** chat and notifications, which return bare `{messages:[...]}` / `{notifications:[...]}`
  with no pagination metadata; implement manual "load more" for those two only.
- Every state-changing `POST` (bookings, payments, withdrawals, etc.) MUST send a client-generated
  `X-Idempotency-Key: <uuid-v4>` header. Missing header → `HS-400-0011`.
- Auth: Bearer JWT, access token TTL 15 min / refresh TTL 7 days. Token refresh handled transparently
  by a dio interceptor. On 401: one refresh attempt → on failure, clear secure storage and redirect to
  `/auth/login` via a GoRouter redirect callback (never a widget-level check).
- Money values arrive as unformatted numeric strings (e.g. `"200000"`) — format for display, never
  assume a pre-formatted string. Timestamps are UTC ISO-8601.
- Error codes follow the `HS-XXX-XXXX` catalog in `docs/reference/api/11-appendices.md` — map to
  localized user-facing messages, never show a raw error code or raw dio exception to the user.
- **Zero DTO reuse:** never share a model between a Request and a Response, even if fields are
  identical — always define separate, dedicated DTOs.
- Tokens live ONLY in `flutter_secure_storage` — never `SharedPreferences`.

---

## Realtime (Chat / Tracking / Dispatch)

- Transport is **STOMP over WebSocket**, not a generic socket — booking-scoped topics such as
  `/topic/booking/{id}` emit named events (`WORKER_ASSIGNED`, `WORKER_ARRIVED`, ...). See
  `docs/reference/api/07-chat.md` and `09-location-tracking.md` for the full event catalog.
- Connections are scoped to the feature BLoC that needs them — open on bloc creation, close on bloc close.
- Worker GPS updates broadcast every ~2 seconds while online.

---

## Error Handling & Logging

- All errors are caught and surfaced through BLoC/Cubit state — never `try/catch` directly in UI code.
- Transient errors → `SnackBar`; fatal errors → dedicated `ErrorPage`.
- `pretty_dio_logger` for HTTP inspection, debug builds only.
- Report only server-side/system failures (5xx, `SocketException`, unhandled crashes) to Crashlytics.
  Do not report client-side validation errors (400/422).

---

## UI Component Rules

- Never hardcode a color or text style in a widget — always `AppColors.x` / `AppTextStyles.x`.
- Spacing values always come from `AppSpacing` constants.
- Buttons use the shared `AppButton` widget, never raw `ElevatedButton`/`TextButton` in feature pages.
- Every interactive widget respects the 44/48dp minimum touch target from the Design System section above.
- Lists use `ListView.builder`/`SliverList`, never `Column` + `.map()`. Images use `CachedNetworkImage`.

---

## Testing

- Unit tests (`test/unit/`) for all UseCases/Repositories/DataSources.
- BLoC tests (`test/bloc/`) with `bloc_test` for every state transition.
- Widget tests (`test/widget/`) for interactive widgets.
- Golden tests (`test/goldens/`) for shared `core/widgets/` components and critical screens, using
  `golden_toolkit`, baseline device size to confirm with user before first golden run.
- Mocking via `mocktail` only — no `mockito`, no hand-rolled mocks.
- Fixtures centralized under `test/fixtures/`.

---

## Out of Scope for This Codebase

B2B portal, bidding, e-contracts; Admin backoffice; backend services/database/WebSocket server
implementation; AI pricing/pre-booking scoping; RTB ad engine; loyalty/CMS/marketing; customer
assets & warranty tracking (`04-assets-warranty` API exists but is post-MVP — do not build against it
yet). Full list and Phase-1 feature breakdown: `docs/reference/PHASE1_SCOPE.md`.
