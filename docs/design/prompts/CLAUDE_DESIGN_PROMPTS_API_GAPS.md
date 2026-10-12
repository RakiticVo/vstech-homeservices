# Claude Design Prompts — UI for APIs that have no screen yet

> Source: `docs/api/openapi.yaml` checked against the 81 existing screens (2026-10-07).
> Numbering continues the Concept 02 matrix (last cell so far: Cell 131) → starts at **Cell 132**.
>
> **Updated 2026-10-12:** prompts rewritten in English. Batches 14–15 now match the real API after
> Phases 2–5 (numeric order codes like `#502`, the API returns no worker name/photo, no image-upload
> API yet, the wallet shows "available" + "on hold"). Batches 16–17 are already built in the app —
> skip them.
>
> **How to use:** in each Claude Design session, paste the **Shared context block** first, then the
> prompt of one batch. Use a separate session per batch to keep quality high.
>
> **UI language:** the app is in Vietnamese. Prompts are in English, but every on-screen string is
> given in Vietnamese inside quotes — Claude Design must render those strings **exactly as quoted**.

| Batch | Content | Cells | APIs served |
| :--- | :--- | :--- | :--- |
| 14 | Itemized extra-cost quote (worker sends, customer approves) | 132–135 | `POST /bookings/{id}/quote`, `/quote/approve`, `/quote/reject` |
| 15 | Top up the worker wallet | 136–138 | `POST /wallets/payments/deposit`, `GET /wallets/me` |
| ~~16~~ | ~~Notifications: mark all read + worker notification settings~~ — **built in Phase 5, do not paste** | 139–140 | `POST /notifications/read-all`, `GET/PUT /notifications/settings` |
| ~~17~~ | ~~Booking call history~~ — **built in Phase 5 (shown inside the chat), do not paste** | 141 | `GET /voip/calls?bookingId=` |

**No prompt for:**
- `POST /wallets/payments/withdraw`: duplicates `/wallets/withdrawals` (already has UI). Waiting for the backend to explain its purpose.
- `/assets` (5 APIs): the My Home Devices screen exists but is post-MVP per CLAUDE.md.
- Admin APIs: not part of the mobile app.

---

## Shared context block (paste at the start of every session)

```
You are continuing the design of the VSTech Home Services app (Concept 02) — an app for booking home repair / cleaning technicians in Vietnam. One app serves two roles: Customer and Worker (technician). All on-screen text is Vietnamese: render every quoted string exactly as written. Reference device: iPhone 390×844, plain viewport (no device frame).

Design system "Eco-Clean Sanctuary v9.0" — MANDATORY:
- Colors: primary #0D9488 (only for the single primary CTA per screen or the active tab), pressed #0F766E, text on primary #FFFFFF, secondary #CCFBF1 (soft badges), secondarySurface #F0FDFA (selected chip/card background, always paired with a primary border), app background #FAF9F6 (warm ivory, never pure white), card surface #FFFFFF, primary text #0F172A, secondary text #475569, muted text #94A3B8, hairline border #E2E8F0, success #10B981/#059669, warning #F59E0B, error #EF4444.
- NEVER use pure black #000000 and NEVER use shadows/elevation — use a 1px #E2E8F0 hairline border instead.
- 60-30-10 color ratio: background/surface 60%, text/borders 30%, teal is the only accent at 10%.
- Selected state = #F0FDFA background + #0D9488 border + check icon, never a solid dark fill.
- Font: Source Sans 3 everywhere. Field labels ≥14–15px, input text ≥16px, card titles ≥18px, primary buttons 16–17px, clearly bold.
- Corner radius: 8px chips/badges, 12px inputs & CTA buttons, 16px cards/sheets, fully round only for the bottom dock and special round buttons.
- Spacing grid 4/8/16/24/32, 16px page margins.
- Icons: thin 1.25–1.5px stroke, 20–24px, slate grey (#94A3B8/#475569), never wrapped in a circle/square chip, never all turned teal.
- Status is always Icon + Label + Color together, never color alone.
- Every important action is Icon + Label — never hidden behind a gesture or an icon-only button. Minimum touch target 44×44, preferred 48×48. Primary CTA height 48–52px.
- One goal and one primary CTA per screen. Users can be up to ~50 years old: clarity and familiar patterns over novelty. WCAG AAA text contrast.
- Money is shown as "4.860.000đ". Date-time as "14:30 · 12/10/2026".
- Real photos in soft squircles instead of abstract icons when illustrating services/receipts.
- Screens with the floating bottom dock (white pill, hairline border) need 112–128px bottom padding on scrolling content.

For every screen, draw all listed states, label each frame with its Cell number, and stay consistent with the existing Concept 02 screens (Cells 1–131).
```

---

## Batch 14 — Itemized extra-cost quote (Cells 132–135)

**API context (checked 2026-10-12):**
- The worker sends `POST /bookings/{id}/quote` with several lines (`itemName`, `amount`, optional `receiptUrl`) plus `evidencePhotoUrls`; the server returns `totalAmount`, `status`, `submittedAt`. The customer can only **Approve** / **Reject** (`/quote/approve`, `/quote/reject`) with no reason.
- **No image-upload API yet** → receipt and evidence photos must be designed so each screen still works **without photos** (the app hides the photo area until the backend adds uploads).
- **The customer has no API to read the quote yet** (`BookingResponse` carries no quote) — reported to the backend (NOTES L12). Design the customer screen anyway so it is ready.
- The API returns **no worker name / photo / rating** → use the role label "Thợ phụ trách" (assigned technician), no real avatar.
- Order codes are numeric: show `#502`. There is no push → the customer reaches the approval screen from **Order detail**.
- Today the app sends a quote through a dialog with one name + one price on the In-progress screen — this batch replaces that dialog.

```
Batch 14 — Extra-cost quote. Design 4 screens (Cells 132–135). Data notes: order codes look like "#502"; the app has NO worker name/photo/rating, only the role label "Thợ phụ trách"; photos may not exist in the first release, so every screen with a photo area must also be drawn in a variant WITHOUT the photo area that still looks balanced.

Cell 132 — [Worker] Create an extra-cost quote (full screen, opened from the "+ Báo giá phát sinh" button on the In-progress screen).
- Header: Back button (icon + label), title "Báo giá phát sinh", subtitle "Đơn #502 · Vệ sinh máy lạnh".
- Reference card: "Giá ước tính ban đầu 350.000đ" + small note "Tổng tiền đơn không được vượt 1,5 lần giá ước tính".
- Line items (min 1, max 10), each a card with: a field "Tên vật tư / hạng mục" (e.g. "Gas R32 bổ sung"), a field "Số tiền" with the đ suffix, an optional receipt photo slot (dashed squircle "+ Ảnh hoá đơn"; once filled, a thumbnail + a labeled "Xoá ảnh" button), and a "Xoá hạng mục" button (trash icon + label, error color) hidden when only one item remains.
- Secondary outlined button "+ Thêm hạng mục".
- Optional "Ảnh hiện trường" area: 3-column squircle grid, first tile "+ Chụp / Chọn ảnh", max 6 photos, hint "Ảnh giúp khách duyệt nhanh hơn".
- Sticky total bar right above the CTA: "Tổng phát sinh" + large bold amount; subline "Khách trả thêm khoản này sau khi duyệt".
- Primary full-width teal CTA: "Gửi báo giá cho khách".
- States: (a) empty — CTA disabled; (b) 2 valid items (one variant with photos, one without the photo area) — CTA enabled; (c) validation errors: an item with no name or a 0 amount → error border + icon + error text under the field; total above 1.5× the estimate → error banner above the total bar (icon + text); (d) sending — spinner inside the CTA, inputs locked.

Cell 133 — [Worker] Quote status (card inside the In-progress screen).
- (a) "Đang chờ khách duyệt": clock icon + label + warning color, extra-cost total, item count, sent time "14:30 · 12/10/2026", secondary button "Xem lại báo giá".
- (b) "Khách đã duyệt": check icon + label + success color, "Tổng mới của đơn" = original price + extra cost.
- (c) "Khách đã từ chối": X icon + label + error color, hint "Tiếp tục theo giá ban đầu hoặc nhắn tin với khách", two buttons: "Nhắn tin" (secondary, icon + label) and "Tiếp tục công việc" (primary).

Cell 134 — [Customer] Approve the extra-cost quote (full screen, opened from a banner "Thợ gửi báo giá phát sinh — Xem & duyệt" on the Order detail screen; also draw that banner at the top of Order detail).
- Header: Back + title "Báo giá phát sinh", subtitle "Đơn #502 · Thợ phụ trách".
- Compact item table: name, amount, receipt thumbnail if any (tap to zoom).
- Evidence photo grid if any (tap to view full screen).
- Totals table: "Giá ban đầu" / "Chi phí phát sinh" / "Tổng mới" (boldest). Note: "Bạn chỉ thanh toán sau khi nghiệm thu".
- Two buttons: "Từ chối" (outlined, error text) and "Duyệt báo giá" (the only teal CTA).
- Confirmation dialog on Reject: title "Từ chối báo giá?", body "Thợ sẽ tiếp tục theo giá ban đầu.", buttons "Quay lại" and "Từ chối báo giá" (error).
- States: (a) default with photos; (b) without the photo area; (c) processing — spinner inside the button; (d) network error — SnackBar "Không có kết nối mạng…" + "Thử lại"; (e) quote already handled — info banner (icon + label), both buttons hidden.

Cell 135 — [Customer] Result after approving / rejecting (short confirmation screen).
- (a) Approved: large check icon (success) + "Đã duyệt chi phí phát sinh" + the new total; CTA "Về chi tiết đơn".
- (b) Rejected: info icon (slate) + "Đã từ chối báo giá" + "Thợ tiếp tục theo giá ban đầu 350.000đ"; CTA "Về chi tiết đơn".
```

---

## Batch 15 — Top up the worker wallet (Cells 136–138)

**API context (checked 2026-10-12):**
- `POST /wallets/payments/deposit` takes `amount` (> 0), `gateway` and `gatewayTxId` (the transaction id **returned by the payment gateway** — the app sends it after the user has paid in VNPay/ZaloPay); it returns a transaction with `status` PENDING / COMPLETED / FAILED. The transaction appears in the wallet ledger with type `DEPOSIT`.
- The current worker Wallet screen (Cell 117, already wired to the API) has: a balance card with **"Có thể rút"** (available) + an **"Đang tạm giữ"** (on hold) line, a "Rút tiền" (withdraw) button and 4 ledger filter chips (Tất cả / Thu nhập / Rút tiền / Tạm giữ). The old "total earned / withdrawn" figures are gone.
- ⚠ **Which wallet is topped up is not confirmed yet** (assumed: the worker wallet, used to cover platform fees on cash-paid jobs) — waiting for the BA. The 50.000đ minimum is an app rule proposal (not in the API).

```
Batch 15 — Top up the Worker wallet. The balance card on the Wallet screen (Cell 117) currently shows "Có thể rút" (large amount) + a "Đang tạm giữ" line and the primary button "Rút tiền". Add a secondary outlined "Nạp tiền" button (icon + label) next to "Rút tiền" — "Rút tiền" stays the only primary CTA. Design 3 screens (Cells 136–138):

Cell 136 — [Worker] Top up the wallet.
- Header: Back + title "Nạp tiền vào ví".
- Balance card "Có thể rút 4.860.000đ" + subline "Sau khi nạp: 5.360.000đ" that updates with the entered amount.
- Large amount input (input text ≥16px, displayed as "500.000đ"), hint "Tối thiểu 50.000đ".
- 4 quick-pick chips: 100.000đ, 200.000đ, 500.000đ, 1.000.000đ (selected = #F0FDFA background + teal border + check).
- Payment gateway choice: 2 option cards, VNPay and ZaloPay (logo as a squircle image + name + short description "Thẻ ATM / QR ngân hàng", "Ví ZaloPay"); the selected card has a teal border + check.
- Transparency note (info icon + text): "Miễn phí nạp tiền. Tiền vào ví khi cổng thanh toán xác nhận."
- Primary CTA: "Nạp 500.000đ" (amount is dynamic).
- States: (a) empty — CTA disabled; (b) 500.000đ + VNPay selected; (c) amount below the minimum (icon + error text under the field).

Cell 137 — [Worker] Confirming the transaction (after returning from the payment gateway).
- Loader + title "Đang xác nhận giao dịch", amount, gateway, gateway transaction id (e.g. "VNP-14220931"), note "Thường mất dưới 1 phút. Bạn có thể rời màn hình này."
- Secondary button "Về ví".

Cell 138 — [Worker] Top-up result.
- (a) Success: success check icon, "Nạp tiền thành công", "+500.000đ" (success color), new balance, transaction id, time "14:30 · 12/10/2026"; CTA "Về ví".
- (b) Failure: error X icon, "Nạp tiền không thành công", short reason "Giao dịch bị huỷ hoặc hết hạn", reassurance "Bạn chưa bị trừ tiền"; CTA "Thử lại", secondary button "Đổi cổng thanh toán".
- (c) Still processing (PENDING after 5 minutes): warning icon, "Giao dịch đang được đối soát", button "Gọi hỗ trợ" (icon + label).
- Also: a "Nạp tiền" row in the wallet ledger (Cell 117) with an incoming-arrow icon, a + amount and a status "Hoàn tất" / "Đang xử lý" / "Thất bại" (icon + label + color).
```

---

## Batch 16 — Notifications (Cells 139–140) — ✅ built in Phase 5, do not paste

Already implemented in the app with the existing design system: one shared notifications screen for
customers and workers (type filter chips, Today / Earlier, "Đã đọc tất cả", manual "Xem thêm") and
a settings screen with the 3 API categories (booking / system / promo) for both roles. Re-design only
if you want to polish it.

---

## Batch 17 — Booking call history (Cell 141) — ✅ built in Phase 5, do not paste

Already implemented: the booking's call log (`GET /voip/calls?bookingId=`) appears inline in the
chat timeline as pills ("Cuộc gọi thoại · 00:48" / "Cuộc gọi nhỡ"). A separate call-history screen
is not needed for now.
