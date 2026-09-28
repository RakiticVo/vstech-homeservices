---
name: start-session
description: Initializes and orients a working session on the vstech_home_services Flutter project. Use when the user types /start-session, says 'bắt đầu session', 'start session', or begins a new conversation turn. Performs project status checks, validates environment health (git status, flutter analyze, flutter test), verifies architectural & Eco-Clean Sanctuary v9.0 design compliance, tracks progress against the 16-screen matrix, and outputs a concise session kickoff report with clear next steps.
---

# Session Starter (start-session)

Use this skill whenever beginning a new session, when the user requests `/start-session`, or when re-orienting on the `vstech_home_services` codebase.

## Workflow

### Step 1: Context & Source of Truth Review
Before writing or proposing any code, review the single sources of truth:
1. **Agent Rules & Architecture**: Read [`CLAUDE.md`](../../../CLAUDE.md).
   - Platform: Flutter (iOS & Android only).
   - Architecture: Feature-first clean architecture (`data/`, `domain/`, `presentation/`) with BLoC/Cubit.
   - Router: `go_router` with role-aware redirection (Customer vs Worker).
   - DI: `get_it` + `injectable`.
2. **Design System & Tokens**: Read [`docs/design/MASTER_SPEC_V9.md`](../../../docs/design/MASTER_SPEC_V9.md).
   - Hard Rule: **Zero Shadows** (no `BoxShadow` or `elevation`, use 1px hairline border `#E2E8F0`).
   - Hard Rule: **No pure black** (`#000000`) anywhere. Always use Slate text `#0F172A`.
   - Hard Rule: **60-30-10 color ratio** (Ivory `#FAF9F6` & White `#FFFFFF` 60%, Slate `#0F172A` 30%, Teal accent `#0D9488` 10%).
   - Hard Rule: **Fixed Floating Bottom Nav Dock** (`rounded-full`, white, hairline border) + `pb-28` to `pb-32` scroll clearance.
   - Hard Rule: **Photo-First** squircle thumbnails for service categories, not abstract icons.
   - Typography: Google Fonts `Plus Jakarta Sans` (headings/buttons) and `Inter` (body/prices).
3. **Phase & Scope**: Read [`docs/reference/PHASE1_SCOPE.md`](../../../docs/reference/PHASE1_SCOPE.md).
   - Only implement Phase 1 MVP features. Do NOT build post-MVP modules (assets/warranty, B2B bidding, AI scoping engine, etc.).

### Step 2: Environment & Repository Health Verification
Run the following commands to check codebase health:
1. `git status` — Check active branch and uncommitted/untracked changes.
2. `git log -n 5 --oneline` — Check recent commits to understand latest milestone.
3. `flutter analyze` — Verify that there are 0 errors and 0 warnings.
4. `flutter test` — Ensure the current test suite passes 100%.

### Step 3: Map Implementation Progress (16-Screen Matrix)
Inspect `lib/features/` and `lib/core/` against the 16 screens specified in `MASTER_SPEC_V9.md` Part 4:
- **01 Splash Screen** (`core/router`, `features/auth` or splash)
- **02 Role Gateway** (Customer vs Worker selection)
- **03 Phone OTP Auth (3A-3B)** (`features/auth`)
- **04 Customer Info (3C)** (`features/auth`)
- **05 Worker Onboarding** (`features/worker_kyc`)
- **06 Customer Home (SCREEN_2 Master)** (`features/home` — 4 tabs, squircle photo cards, floating dock)
- **07 Service Detail** (`features/home` / `features/booking`)
- **08 Add-ons Matrix** (`features/booking`)
- **09 Schedule & Time Slot** (`features/booking`)
- **10 Booking Confirmation & Checkout** (`features/booking`, `features/checkout`)
- **11 Order Tracking (7A-7D)** (`features/tracking`)
- **12 Change Order & Estimate Approval** (`features/booking`)
- **13 Completion & Payment** (`features/checkout`)
- **14 Worker Job Lobby** (`features/worker_dashboard`, `features/worker_dispatch`)
- **15 Worker Task Execution & Check-in** (`features/worker_task`)
- **16 Worker Wallet & Earnings** (`features/wallet`)

### Step 4: Deliver Session Kickoff Report
Present a clean, high-signal kickoff summary to the user in their preferred language (Vietnamese by default for this project):
1. **Bảng định danh & Quy chuẩn kỹ thuật** (Tech stack, Eco-Clean Sanctuary v9.0 tokens).
2. **Trạng thái sức khỏe mã nguồn** (Git branch, analyze result, test suite status).
3. **Bản đồ tiến độ 16 màn hình** (Đã xong, Đang làm, Chưa làm).
4. **Hành động đề xuất kế tiếp** (Gợi ý màn hình hoặc module cụ thể cần thực hiện tiếp theo).
