# Phase 1 MVP Scope — vstech_home_services

> Curated from `home_services` Epic 1–8 (confirmed MVP scope). Epics 9–12 (AI pre-booking scoping,
> assets/warranty, disputes, contextual taxonomy) are **post-MVP** — do not build against them yet.
> This file exists so agents don't need to open the full 2,300-line epics doc from the sibling project.

## B2C Customer App

- **Onboarding / Auth** — phone + password login, OTP verification (registration only, not login),
  role-aware routing (a single app binary serves both Customer and Worker roles based on account role).
- **Home / Discovery** — profile & saved-address management, service category browsing, service search,
  backend-provided estimated pricing display, favorite taskers list.
- **Booking flow** — incident report form, booking creation form, media attachment upload, client-side
  validation + failure handling, "pending dispatch" matching-radar state.
- **Tracking / Realtime** — booking status & ETA tracking, live worker location map, realtime connection
  lifecycle + recovery. Channel is STOMP over `/topic/booking/{id}` with named events
  (`WORKER_ASSIGNED`, `WORKER_ARRIVED`, etc.) — not a generic WebSocket.
- **Chat / VoIP** — in-app chat tied to an active booking; masked VoIP call session UI.
- **Checkout / Payment** — invoice summary, VNPay/ZaloPay method selection, idempotent payment
  initiation, provider handoff/deep-link return, payment status/receipt/failure states, realtime
  invoice/payment updates. Ledger posting/reconciliation is backend-only — out of scope for mobile.

## Worker App

- **Onboarding** — eKYC wizard, skills/service-category management, certificate upload + verification
  status, availability calendar/operating hours, work-zone setup, online-status + GPS broadcast toggle.
- **Dispatch / Job execution** — dispatch request overlay, accept/decline, expiration/reassignment
  states, job status updates, location check-in, extra expense/material line items, no-show/cancellation
  reporting.
- **Tracking / Chat / VoIP** — active-job map + customer context, same chat/VoIP/realtime stack as the
  Customer app.
- **Wallet / Payout** — wallet balance & earnings history, withdrawal request status visibility.

## Shared foundation (both apps)

Eco-Clean Sanctuary design system (see `docs/design/DESIGN.md`), shared core widgets, feature-first
Flutter structure, Dio API client + interceptors, typed DTO/repository pattern with mockable
datasources, baseline test scaffolding.

## API modules in scope

`docs/reference/api/` — `01-auth-profiles`, `02-bookings`, `03-categories-dispatch`,
`05-wallet-payments`, `06-withdrawals`, `07-chat`, `08-notifications`, `09-location-tracking`,
`10-voip`, plus `00-foundation` (envelope/auth/pagination rules) and `11-appendices` (error codes).
`04-assets-warranty` is intentionally excluded — post-MVP.

## Explicitly out of scope for this codebase

B2B portal, bidding, e-contracts; Admin backoffice; backend services/database/WebSocket server
(external dependency — consume contracts only); AI pricing/pre-booking scoping engine; RTB ad engine;
loyalty/CMS/marketing; customer assets & warranty tracking.
