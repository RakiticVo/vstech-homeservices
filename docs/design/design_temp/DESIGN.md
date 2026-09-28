# HomeService — Concept 02: Contemporary Folk Utility

Design spec for the coded build of Concept 02. Every new screen must follow this document.

Language policy: technical documentation is written in English. On-screen UI copy is Vietnamese by default, with English provided through the `lang` switch.

---

## Phase 1 — final reference

Audited in batch 11. This section is the source of truth where it differs from older sections below.

### App structure & roles

One mobile app (390×844, Manrope, light/dark via `data-th`, VI/EN via `LSTR` / `T(vi, en)`) with two roles.

```
Splash → Onboarding (5) → Role selection ─┬─ Khách hàng → Login / Register (+OTP) → Customer Home
                                          └─ Thợ / đối tác → Login / Register (+OTP) → KYC (7 steps) → Worker "Hôm nay"
Logout (either role) → confirm dialog → Role selection.  Delete account (Customer) → OTP → Role selection.
```

| File | Role |
| --- | --- |
| `HomeServicePhone.dc.html` | App shell (splash, onboarding, role, auth, OTP) + every Customer screen. Mounts the Worker component when `role = worker` |
| `HomeServiceWorker.dc.html` | Every Worker screen incl. KYC; `onLogout` returns to the shell |
| `HomeServiceChat.dc.html` | Shared chat thread + VoIP call screens, mounted by both roles |
| `HomeServices Concept 02.dc.html` | Presentation page: live phone + control rows (theme, language, role, order status, simulations) + the numbered board |
| `HomeServices Concept 02-print.dc.html` | Print version, same `FLOW` groups and cell rows |

Docks — Customer: Trang chủ · Đơn hàng · AI hỗ trợ · Thông báo · Tài khoản (roots: `home`, `orders`, `chat`, `notif`, `profile`). Worker: Hôm nay · Công việc · Lịch · Ví · Hồ sơ (`whome`, `wjobs`, `wcal`, `wwallet`, `wprofile`). Every other screen has a back button; result screens (Done, Paid, Thanks, wait/status screens) have a single forward CTA instead.

### Status model (identical names in both roles)

| ost | Status | Customer | Worker |
| --- | --- | --- | --- |
| 0 | Đã nhận việc | Tracking | `wgo` |
| 1 | Thợ đang đến | Tracking + map, ETA 8 phút · 2,4 km | `wgo` (map, navigation, masked call/chat, "Huỷ việc") |
| 2 | Thợ đã đến | Tracking, check-in 13:58 | `warr` ("Bắt đầu làm", "Khách không có mặt?") |
| 3 | Đang thực hiện | Tracking timer + checklist | `wwork` |
| 4 | Chờ nghiệm thu | Nghiệm thu | `wwait` |
| 5 | Chờ thanh toán | Payment | `wwait` |
| 6 | Hoàn tất | Receipt, review, warranty | `wwait` → Wallet |
| 7 | Đang xem xét (complaint) | Dispute status, money held | `wwait` complaint card, wallet "Đang tạm giữ" |

Side outcomes: **Khách vắng mặt** (worker reports after 15 min; job ends in Hoàn thành), **Đang tìm thợ** (worker cancelled; customer re-matched). Warranty jobs: Đã gửi → Thợ đã nhận → Đang xử lý → Đã khắc phục.

### Money rules

| Case | Customer | Worker |
| --- | --- | --- |
| Standard order #…0012 | Công thợ 350.000 + Add-on 30.000 + Phụ phí mặt bằng 20.000 = **400.000đ**, paid **after sign-off** | 400.000 − 15% fee **60.000** = **340.000đ** |
| Approved extra cost (thay ron vòi sen) | 400.000 + 45.000 = **445.000đ** | 400.000 + 45.000 − 60.000 = **385.000đ** (fee on the service price only; extra cost 100% to the worker) |
| Declined extra cost | Line struck through, total stays 400.000đ | 340.000đ |
| Pricing | Not distance-based. Site surcharge: townhouse 0 · apartment with lift 20.000 · without lift 50.000 | — |
| Booking | Amber "Xác nhận đặt lịch" commits to the estimate; nothing is charged | — |
| Customer cancel | Free before a worker accepts; 50.000đ after; not allowed once the worker is on the way | — |
| Customer no-show | 50.000đ no-show fee; service price not charged | +50.000đ, no platform fee |
| Worker cancel | Re-matched, no charge | Acceptance 96→95%, completion 98→97% |
| Complaint (escrow) | Nothing charged while under review ("Tiền đang được giữ an toàn…") | 340.000đ shown as "Đang tạm giữ", excluded from the balance |
| Resolved complaint #KN-0228-014 | Partial refund **100.000đ** to ZaloPay, 3–5 working days | — |
| Warranty job | **0đ** | "Bảo hành – 0đ"; declining = **−120.000đ** rework penalty |
| Tip | Amber CTA; 100% to the worker | — |
| Withdrawal | — | Min 100.000đ, fee 0đ, manual approval ≤ 24 h. Balance = Σ credits − withdrawals − deductions (sample 4.860.000đ) |

Solid amber appears only on: Xác nhận đặt lịch · Thanh toán [amount] · Gửi đánh giá · Tip [amount] · approving an extra cost in chat.

### Screen table (board order, 128 cells)

The board is organised as **7 journeys**, each drawn as a two-lane swimlane: Customer on top, Worker below, with screens that belong to the same order status stacked in the same column ("stage"). Stages marked Shared are identical for both roles and appear once, in the top lane. Journeys: 1 Vào app · 2 Một đơn trọn vẹn · 3 Nhánh ngoại lệ · 4 Bảo hành · 5 Chat & gọi · 6 Tài khoản & cài đặt · 7 Ví & vận hành của Thợ. Data lives in `JOURNEYS` (`[title, subtitle, colour, [[stage, customerIds, workerIds, shared?], …]]`) in both the page and the print file; cells are numbered stage by stage, customer lane first. The print file keeps three phones per page and prefixes each caption with its stage and lane.

| # | Stage | Lane | Screen | Key |
| --- | --- | --- | --- | --- |
| | **1. Vào app** | | | |
| 1 | Mở đầu | Shared | Splash | `splash` |
| 2 | Mở đầu | Shared | Onboarding 1 — Lời mở | `onboarding` |
| 3 | Mở đầu | Shared | Onboarding 2 — Niềm tin | `onboarding` |
| 4 | Mở đầu | Shared | Onboarding 3 — Cách dùng | `onboarding` |
| 5 | Mở đầu | Shared | Onboarding 4 — AI | `onboarding` |
| 6 | Mở đầu | Shared | Onboarding 5 — Tổng kết | `intro` |
| 7 | Chọn vai trò | Shared | Chọn vai trò | `role` |
| 8 | Đăng nhập | Customer | Đăng nhập — Khách | `login` |
| 9 | Đăng nhập | Worker | Đăng nhập — Thợ | `login` |
| 10 | Đăng ký | Customer | Đăng ký — Khách | `register` |
| 11 | Đăng ký | Worker | Bước 1 — Số điện thoại | `register` |
| 12 | OTP & mật khẩu | Shared | Xác thực OTP | `otp` |
| 13 | OTP & mật khẩu | Shared | OTP — sai mã | `otp` |
| 14 | OTP & mật khẩu | Shared | Quên mật khẩu | `forgot` |
| 15 | OTP & mật khẩu | Shared | Mật khẩu mới | `newpass` |
| 16 | OTP & mật khẩu | Shared | Đổi mật khẩu thành công | `passok` |
| 17 | Hồ sơ đối tác (KYC) | Worker | Bước 2 — Thông tin cá nhân | `wkyc` |
| 18 | Hồ sơ đối tác (KYC) | Worker | Bước 3 — CCCD | `wkyc` |
| 19 | Hồ sơ đối tác (KYC) | Worker | Bước 4 — Xác thực khuôn mặt | `wkyc` |
| 20 | Hồ sơ đối tác (KYC) | Worker | Bước 5 — Tay nghề & chứng chỉ | `wkyc` |
| 21 | Hồ sơ đối tác (KYC) | Worker | Bước 6 — Tài khoản nhận tiền | `wkyc` |
| 22 | Hồ sơ đối tác (KYC) | Worker | Hồ sơ — Đang chờ duyệt | `wkyc` |
| 23 | Hồ sơ đối tác (KYC) | Worker | Hồ sơ — Cần bổ sung | `wkyc` |
| 24 | Hồ sơ đối tác (KYC) | Worker | Hồ sơ — Đã duyệt | `wkyc` |
| | **2. Một đơn trọn vẹn** | | | |
| 25 | Tìm & đặt lịch | Customer | Trang chủ | `home` |
| 26 | Tìm & đặt lịch | Customer | Danh mục dịch vụ | `categories` |
| 27 | Tìm & đặt lịch | Customer | Chi tiết dịch vụ | `service` |
| 28 | Tìm & đặt lịch | Customer | Bước 1 — Gói & dịch vụ thêm | `book1` |
| 29 | Tìm & đặt lịch | Customer | Bước 2 — Thời gian, địa chỉ, mặt bằng | `booking` |
| 30 | Tìm & đặt lịch | Customer | Bước 3 — Xác nhận | `book3` |
| 31 | Ghép thợ | Customer | Bước 4 — Hoàn tất | `done` |
| 32 | Ghép thợ | Customer | Đang tìm thợ | `matching` |
| 33 | Ghép thợ | Customer | Đã có thợ nhận | `matching` |
| 34 | Ghép thợ | Worker | Việc hôm nay | `whome` |
| 35 | Ghép thợ | Worker | Chi tiết yêu cầu | `wjob` |
| 36 | Danh sách đơn | Customer | Đơn của tôi — Đang làm | `orders` |
| 37 | Danh sách đơn | Customer | Đơn của tôi — Đang chờ | `orders` |
| 38 | Danh sách đơn | Customer | Đơn của tôi — Hoàn thành | `orders` |
| 39 | Danh sách đơn | Customer | Đơn của tôi — Tab trống | `orders` |
| 40 | Danh sách đơn | Worker | Thợ — Công việc · Mới phân công | `wjobs` |
| 41 | Danh sách đơn | Worker | Thợ — Công việc · Đang làm | `wjobs` |
| 42 | Danh sách đơn | Worker | Thợ — Công việc · Hoàn thành | `wjobs` |
| 43 | Thợ đang đến | Customer | Theo dõi — Thợ đang đến | `tracking` |
| 44 | Thợ đang đến | Worker | Thợ — Đang đến | `wgo` |
| 45 | Thợ đã đến | Customer | Theo dõi — Thợ đã đến | `tracking` |
| 46 | Thợ đã đến | Worker | Thợ — Đã đến | `warr` |
| 47 | Đang thực hiện | Customer | Theo dõi — Đang thực hiện | `tracking` |
| 48 | Đang thực hiện | Worker | Đang thực hiện | `wwork` |
| 49 | Chờ nghiệm thu | Customer | Theo dõi — Chờ nghiệm thu | `tracking` |
| 50 | Chờ nghiệm thu | Customer | Nghiệm thu | `accept` |
| 51 | Chờ nghiệm thu | Worker | Thợ — Chờ khách nghiệm thu | `wwait` |
| 52 | Chờ thanh toán | Customer | Thanh toán | `paysum` |
| 53 | Chờ thanh toán | Customer | Cổng thanh toán | `pay` |
| 54 | Chờ thanh toán | Worker | Thợ — Chờ khách thanh toán | `wwait` |
| 55 | Hoàn tất | Customer | Thanh toán thành công | `paid` |
| 56 | Hoàn tất | Customer | Hoá đơn điện tử | `receipt` |
| 57 | Hoàn tất | Customer | Đánh giá — chưa tip | `review` |
| 58 | Hoàn tất | Customer | Đánh giá — có tip | `review` |
| 59 | Hoàn tất | Customer | Cảm ơn | `thanks` |
| 60 | Hoàn tất | Worker | Thợ — Đã nhận tiền | `wwait` |
| 61 | Hoàn tất | Worker | Thợ — Ví sau khi nhận tiền | `wwallet` |
| 62 | Chi tiết đơn & thông báo | Customer | Chi tiết đơn — đang làm | `odetail` |
| 63 | Chi tiết đơn & thông báo | Customer | Chi tiết đơn — chờ thanh toán | `odetail` |
| 64 | Chi tiết đơn & thông báo | Customer | Thông báo — Khách | `notif` |
| 65 | Chi tiết đơn & thông báo | Customer | Cài đặt thông báo — Khách | `nset` |
| 66 | Chi tiết đơn & thông báo | Worker | Thông báo — Thợ | `wnotif` |
| | **3. Nhánh ngoại lệ** | | | |
| 67 | Khách huỷ lịch | Customer | Huỷ đặt lịch — miễn phí | `cancel` |
| 68 | Khách huỷ lịch | Customer | Huỷ đặt lịch — có phí | `cancel` |
| 69 | Không tìm được thợ | Customer | Chưa tìm được thợ | `matching` |
| 70 | Thợ huỷ việc | Customer | Khách — Thợ huỷ, tìm lại | `matching` |
| 71 | Thợ huỷ việc | Worker | Thợ — Huỷ việc | `wcxl` |
| 72 | Khách vắng mặt | Customer | Khách — Thông báo vắng mặt | `odetail` |
| 73 | Khách vắng mặt | Worker | Thợ — Chờ khách (vắng mặt) | `wns` |
| 74 | Khách vắng mặt | Worker | Thợ — Báo khách vắng mặt | `wnsrep` |
| 75 | Khách vắng mặt | Worker | Thợ — Đã ghi nhận vắng mặt | `wnsdone` |
| 76 | Chi phí phát sinh | Customer | Khách — Thanh toán có phát sinh | `paysum` |
| 77 | Chi phí phát sinh | Worker | Thợ — Nhận tiền có phát sinh | `wwait` |
| 78 | Thanh toán thất bại | Customer | Thanh toán thất bại | `pay` |
| 79 | Khiếu nại | Customer | Báo vấn đề | `dispute` |
| 80 | Khiếu nại | Customer | Đơn đang được xem xét | `disputed` |
| 81 | Khiếu nại | Customer | Chi tiết đơn — đang khiếu nại | `odetail` |
| 82 | Khiếu nại | Customer | Khiếu nại của tôi | `clist` |
| 83 | Khiếu nại | Customer | Khiếu nại đã giải quyết | `cdetail` |
| 84 | Khiếu nại | Customer | Khiếu nại cần bổ sung | `cdetail` |
| 85 | Khiếu nại | Worker | Thợ — Khách đã khiếu nại | `wwait` |
| 86 | Khiếu nại | Worker | Thợ — Tiền đang tạm giữ | `wwallet` |
| 87 | Khiếu nại | Worker | Thợ — Đơn đang được xem xét | `wwait` |
| | **4. Bảo hành** | | | |
| 88 | Phiếu & yêu cầu | Customer | Phiếu bảo hành | `bhcert` |
| 89 | Phiếu & yêu cầu | Customer | Yêu cầu bảo hành | `bhreq` |
| 90 | Phân công | Customer | Trạng thái bảo hành | `bhstat` |
| 91 | Phân công | Customer | Đơn của tôi — việc bảo hành | `orders` |
| 92 | Phân công | Worker | Thợ — Chi tiết việc bảo hành | `wbh` |
| 93 | Thợ từ chối | Worker | Thợ — Từ chối bảo hành | `wbhno` |
| 94 | Thợ từ chối | Worker | Thợ — Ví khi bị phạt | `wwallet` |
| 95 | Hoàn tất | Worker | Thợ — Hoàn tất bảo hành | `wwait` |
| | **5. Chat & gọi** | | | |
| 96 | Chat | Customer | Chat — Khách | `tracking` |
| 97 | Chat | Customer | Chat đã đóng | `tracking` |
| 98 | Chat | Worker | Chat — Thợ | `wwork` |
| 99 | Gọi ẩn số | Customer | Gọi đi — Khách | `tracking` |
| 100 | Gọi ẩn số | Worker | Cuộc gọi đến — Thợ | `wgo` |
| | **6. Tài khoản & cài đặt** | | | |
| 101 | Tiện ích | Customer | Ngôi nhà của bạn | `devices` |
| 102 | Tiện ích | Customer | AI Assistant | `chat` |
| 103 | Tiện ích | Customer | AI gợi ý dịch vụ | `suggestions` |
| 104 | Hồ sơ | Customer | Hồ sơ cá nhân | `profile` |
| 105 | Hồ sơ | Customer | Thông tin cá nhân | `eprof` |
| 106 | Hồ sơ | Worker | Hồ sơ tay nghề | `wprofile` |
| 107 | Địa chỉ & thanh toán | Customer | Địa chỉ của tôi | `addrs` |
| 108 | Địa chỉ & thanh toán | Customer | Thêm / sửa địa chỉ | `addredit` |
| 109 | Địa chỉ & thanh toán | Customer | Phương thức thanh toán | `pms` |
| 110 | Địa chỉ & thanh toán | Customer | Liên kết ví mới | `pmlink` |
| 111 | Thợ yêu thích | Customer | Thợ yêu thích | `favs` |
| 112 | Thợ yêu thích | Customer | Hồ sơ thợ | `wprev` |
| 113 | Cài đặt & bảo mật | Customer | Cài đặt | `settings` |
| 114 | Cài đặt & bảo mật | Customer | Đổi mật khẩu | `chpass` |
| 115 | Cài đặt & bảo mật | Customer | Xoá tài khoản | `delacc` |
| 116 | Cài đặt & bảo mật | Customer | Đăng xuất — Khách | `settings` |
| | **7. Ví & vận hành của Thợ** | | | |
| 117 | Ví | Worker | Ví thu nhập | `wwallet` |
| 118 | Ví | Worker | Thợ — Ví & số dư | `wwallet` |
| 119 | Ví | Worker | Thợ — Chi tiết giao dịch | `wtx` |
| 120 | Rút tiền | Worker | Thợ — Rút tiền | `wwd` |
| 121 | Rút tiền | Worker | Thợ — Nhập PIN | `wwdpin` |
| 122 | Rút tiền | Worker | Thợ — Trạng thái rút tiền | `wwdst` |
| 123 | Lịch | Worker | Thợ — Lịch tuần | `wcal` |
| 124 | Lịch | Worker | Thợ — Giờ nhận việc & nghỉ đột xuất | `wavail` |
| 125 | Khu vực & kỹ năng | Worker | Thợ — Khu vực nhận việc | `wzone` |
| 126 | Khu vực & kỹ năng | Worker | Thợ — Kỹ năng & chứng chỉ | `wskill` |
| 127 | Khu vực & kỹ năng | Worker | Thợ — Tải chứng chỉ mới | `wcert` |
| 128 | Hiệu suất | Worker | Thợ — Hiệu suất | `wperf` |

---

## 0. Overview

| | |
| --- | --- |
| Product | One home-services mobile app with two roles: Customer (Khách hàng) and Worker (Thợ) |
| Direction | **Contemporary Folk Utility** — modern, practical, warm, distinctly Vietnamese |
| Frame | 390 × 844 px |
| Screens | 128 cells on the presentation board (Customer 01–17, Worker 18–22, Role & Auth 23–30, Worker sign-up 31–39) |
| Language | Vietnamese and English via the `lang` prop (`vi` \| `en`) |
| Theme | Light and dark via the `theme` prop (`light` \| `dark`) |
| Taglines | Nhà tốt hơn mỗi ngày · Nhịp sống vội, nhà vẫn luôn là nơi chờ bạn. · Việc nhà nhẹ hơn — Cuộc sống tươi hơn |

### Files

| File | Role |
| --- | --- |
| `HomeServicePhone.dc.html` | App shell: brand, role selection, auth, Customer experience; mounts the Worker component when role = worker. Props: `screen`, `role`, `obSlide`, `theme`, `lang`, plus demo-state props (§6b) |
| `HomeServiceChat.dc.html` | Shared chat thread + VoIP call screens, mounted as an overlay by both roles |
| `HomeServiceWorker.dc.html` | Worker experience and worker sign-up (KYC). Props: `screen`, `theme`, `lang`, `kycStep`, `kycStatus`, `dlg`, `onLogout` |
| `HomeServices Concept 02.dc.html` | Presentation page: header with switches, full-size interactive phone, notes, grouped screen board |
| `HomeServices Concept 02-print.dc.html` | Print/PDF version on `doc-page`, driven by array `G` |
| `HomeServices Concept 02 - mo tren may.html` | Self-contained bundle for opening from disk. Regenerate after every design change |
| `doc-page.js` | Print document shell used by the print version |
| `assets/` | Source images (see §17 — the app does not load these at runtime) |
| `uploads/` | User-supplied source material |

---

## 1. Design principles

Warm beige ground instead of tech grey-blue. White cards with hairline borders and large radii, no heavy shadows. Every screen has **exactly one primary action**, always a solid block.

The cultural layer (Saigon skyline, Vietnamese family illustration, handwritten lines) appears only on brand screens and one accent on Customer Home. In functional flows it steps back entirely.

Three non-negotiables: **readable in 3 seconds · one CTA per screen · reachable with one thumb.**

---

## 2. Color

| Role | Hex | Use |
| --- | --- | --- |
| Teal | `#0F766E` | Brand, icons, accent ink, active tab, selected border |
| Deep teal | `#0E5952` | Primary CTA fill, screen titles, ink on jade |
| Amber | `#F59E0B` | Money-commitment CTA only, notification dot, rating stars |
| Beige | `#F7EED7` | Offer surfaces, brand screen ground |
| Jade | `#A7D7C5` | Hero accents |
| Ceramic blue | `#3B82F6` | Electrical/air-con icon family, group 03 badge |
| Light sand | `#E8DDD0` | Supporting neutral |
| App ground | `#FAF6EE` | `--bg` |
| Card | `#FFFFFF` | `--sf` |
| Border | `#EAE2D4` / `#E1D8C8` | Card border `--line` / input border `--line-strong` |
| Primary ink | `#14312E` | `--ink` |
| Secondary ink | `#374151` | `--ink-2` |
| Muted ink | `#5F6871` | `--ink-3`, descriptions |
| Faint ink | `#767065` | `--ink-4`, metadata, placeholders, inactive tabs |

### Ink levels (text on light tints)

Base colors are for strokes, fills and buttons. Text in the same hue must use the ink level to reach 4.5:1.

| | Stroke | Ink | Tint |
| --- | --- | --- | --- |
| Amber | `#F59E0B` | `#A35A06` (`#8A4E05` for titles) | `#FDF0D8` |
| Success | `#10B981` | `#047857` | `#E3F1EA` |
| Error | `#EF4444` | `#B91C1C` | `#FDE8E4` |
| Blue | `#3B82F6` | `#2563EB` | `#E3EEFC` |

Text on a solid amber button uses `--on-amber` `#3A2410`, never white (white on amber is 2:1).

### CTA rules

- One solid block per screen.
- **Teal** (`--acc-deep`) for forward navigation: Next, Continue, Get started, Accept job.
- **Solid amber is reserved for money-commitment steps**: confirm booking, pay, tip. Nowhere else.
- If a screen already has a teal CTA, amber may appear only as a dot, star or light tint.
- No pure black. No opaque shadows in place of hairline borders.

### Theme tokens

The root element carries `data-th="light"` or `data-th="dark"`. The helmet declares two complete rule sets, `[data-th="light"]` and `[data-th="dark"]`; these are the single source of truth for color. All template colors are written `var(--token, #hex)`; the hex is only a fallback for the moment before `data-th` resolves. **Never fix a color by editing the fallback.**

Colors generated in logic go through `K('#hex')`, which maps via table `LT` (light) or `DK` (dark). This is for colors passed into style holes, where `var()` cannot be resolved.

Teal has two roles and needs two values in dark mode: as **ink** it is `#5EEAD4` (legible on dark), as **button fill** it is `#11827A` (enough contrast for white text). In logic these are `TEAL` and `TEALBG`; in templates `--acc-ink` and `--acc`. Mixing them up makes text disappear.

Icon tiles use `--tile` and stay light in dark mode, because the color icons are light-background images.

Brand screens (splash, onboarding, intro) always stay light, because they are almost entirely light illustrations.

---

## 3. Typography

Manrope for all UI, weights 500 / 600 / 700 / 800. Caveat only for handwritten lines on brand screens.

| Level | Size / weight | Use |
| --- | --- | --- |
| Splash logo | 35px / 800, −1.2px | Splash only |
| Display | 25–27px / 800, −.7px | Brand screen titles |
| Screen title | 19px / 800, −.5px | Headers with back button |
| User name | 22px / 800, −.6px | Home greeting |
| Section title | 15–16px / 800, −.2px | Block headers |
| List item title | 14.5px / 800 | Service and device rows |
| Body | 13–13.5px / 600 | Descriptions, chat bubbles |
| Caption | 11.5–12.5px / 600 | Metadata |
| Uppercase label | 10–10.5px / 800, .3px | Status chips |
| Dock label | 10.5px / 600–800 | Bottom nav |

All figures (money, time, date, order ID, rating) use `font-variant-numeric: tabular-nums`.

---

## 4. Shape and spacing

- **Radius**: large card 20–22px · small card 18px · icon tile 14–15px · input 14px · status chip 8–9px · buttons and search fully rounded.
- **Border**: 1px `--line` for cards, `--line-strong` for inputs, 1.5px teal for selected items.
- **Shadow**: none inside the app. Only the presentation board shadows the device frames.
- **Horizontal margin**: 20px (24px on brand form screens).
- **Heights**: primary CTA 52–54px · secondary 46–48px · input 50–52px · list row ≥44px · dock 86px.
- Screens with a dock pad their body by 104px at the bottom.

---

## 5. Components

**Status bar** — 9:41, signal, wifi, battery. Deep teal on splash, `--ink` elsewhere.

**Header with back** — 24px chevron-left offset −8px, 19px/800 deep-teal title, 8px gap.

**Search bar** — 48–50px, fully rounded, hairline border, 18–19px search icon in faint ink.

**Home hero** — banner image, 159px high, 22px radius. Text and button are part of the image; the whole block is one tap target to Booking.

**Service tile** — 3-column grid, white card 18px radius, 48px icon tile with a full-bleed color icon, 11.5px/700 two-line label.

**List row** — 44–50px icon tile left, title + description middle, chevron-right right, 1px `--line-soft` divider.

**Status chip** — 10–10.5px/800, 4–5 × 10–11px padding, 8–9px radius, tint fill with ink-level text.

**Booking stepper** — four 28px circles joined by 2px bars. Done = solid teal, current = teal ring on white, upcoming = `#DCD2C0` ring. Labels in a separate row below.

**Tracking timeline** — four horizontal stages, 31px circles. Passed = solid teal with check; current adds a pulsing outer ring; upcoming = grey ring.

**Price breakdown** — white card, one row per line item, label in muted ink left, amount right in tabular figures. See §7.

**Tabs** — two equal tabs; active has a 2.5px teal underline and deep-teal text; inactive in faint ink.

**Dock** — each role has its own dock. Active item: teal icon and 800 label; inactive: `#A8A092` (dark `#909B96`) at 600.
- Customer: Trang chủ · Đơn hàng · AI hỗ trợ · Thông báo · Tài khoản
- Worker: Việc · Lịch · Ví · Hồ sơ

### Icons

Two layers, never mixed:

*Color illustration icons* (source in `assets/ic/`, embedded in `IMG`) for everything the user chooses: service tiles, category rows, devices, AI suggestions, wallet transactions, worker skills. Placed on a white 15px-radius tile, full bleed, no tinted background.

| Prefix | Contents |
| --- | --- |
| `svc_` | 8 services: clean, plumb, ac, laundry, maid, pest, install, appliance |
| `dev_` | 4 devices: fridge, ac, washer, heater |
| `ut_` | utilities: tech (technician avatar) |
| `sup_` | support: ai, wallet, rate |
| `nav_` | grid |

*Monochrome UI icons* (Lucide, 2px stroke, 13–24px) for chevrons, eye, search, settings rows and **both docks**. Built as inline SVG data URIs from path tables in the logic class (`IC(name, color)` in the shell, `DIC(name, color)` in the Worker component). No external CDN.

Color icons are not used in docks: at 23px they lose definition, and greyed-out inactive states read as smudges.

When cutting new icons from a source sheet, crop inside the white card; beige from the sheet at the edges shows as a hard two-tone edge.

---

## 6. Information architecture

**Group 01 — Onboarding & Brand**: Splash → Onboarding (5 slides) → Log in → Sign up

Slide 5 is the Intro/Value screen (`screen: 'intro'`): it restates the three values from slides 1–3 and closes with the family illustration and a single commitment button. Technically it is a separate screen, not an `obDef` entry, but the 5-dot indicator runs continuously across all five slides and is tappable both ways.

**Group 02 — Core Journey (Customer)**: Home → Categories → Booking → Tracking → Your home

**Group 03 — Support & Account (Customer)**: AI Assistant → AI suggestions → Profile → Settings & History

**Group 04 — Worker**: Today → Job request → In progress → Wallet → Skills profile

**Group 05 — Role & Auth**: Role selection → Log in (role-aware) → OTP → Forgot password → New password → Success · Log out

**Group 06 — Worker sign-up (UC-W-10)**: six KYC steps → application status (3 variants)

Customer Home priority: personal greeting → search → hero/CTA → frequent services → offers.

---

## 6b. App structure & roles

One app, two roles. Built in Phase 1, batch 1.

```
Splash → Onboarding (5) → Role selection → Log in / Sign up / Forgot password
   ├─ role = customer → Customer Home (Customer dock)
   └─ role = worker   → Worker "Việc hôm nay" (Worker dock)
Log out (Customer Settings, Worker Skills profile) → confirm → Role selection
```

**Wiring**

- The shell holds `role` (`customer` | `worker`) and `pick` (the card chosen on Role selection) in state. Onboarding Skip and Intro "Bắt đầu ngay" both go to Role selection.
- When `role === 'worker'` and the screen key is a Worker key (`whome`, `wjob`, `wwork`, `wwallet`, `wprofile`, `wkyc`), the shell overlays `HomeServiceWorker` full-frame (z-index 40) and passes `screen`, `theme`, `lang`, `kycStep`, `kycStatus`, `dlg`, `onLogout`. The Worker component keeps its own internal navigation.
- `onLogout` sets `role = null`, `pick = null`, `screen = 'role'` in the shell.
- A Worker key passed to the shell's `screen` prop implies `role = 'worker'`.
- Both components reset internal state in `componentDidUpdate` when their props change, so the presentation board can drive the live phone.
- Language: the shell reads `uiLang` state first (set by the VI/EN toggle on Role selection), then the `lang` prop, and passes the result down to the Worker.

**Auth rules**

| | Customer | Worker |
| --- | --- | --- |
| Login ID | Phone or email, prefilled 0901 234 567 | Phone only, prefilled 0912 345 678 |
| Social login | Google, Apple, Facebook | None |
| Sign up | Existing form → OTP → Home | 6-step KYC (UC-W-10) → status → Today |
| After login | Customer Home | Worker "Việc hôm nay" |

Login shows the role as a chip at the top with a "Đổi vai trò" link back to Role selection.

**OTP (shared)** — one screen, context in `otpCtx`: `register` → Home, `login` → role home, `forgot` → New password, `wreg` → KYC step 2. Six digit boxes and an in-screen keypad. The demo code is **123456**; the "Từ Tin nhắn" bar fills it in one tap. Six digits auto-verify; a wrong code turns all boxes red with an error line, and typing again clears it. Resend unlocks after a 60 s countdown.

**Forgot password** — phone → OTP → new password → success → Log in, keeping the chosen role.

**Worker sign-up (UC-W-10)** — progress bar "Bước n/6":

| Step | Screen | CTA rule |
| --- | --- | --- |
| 1 | Phone (in shell) + OTP | Gửi mã OTP |
| 2 | Personal details; service areas as multi-select chips | Tiếp tục |
| 3 | ID card front and back | Enabled only when both captured |
| 4 | Face-verification selfie | "Chụp ảnh khuôn mặt" first, then "Tiếp tục" |
| 5 | Services + certificates | Air-con or Installation makes the work-at-height certificate **required** (PRD v2.3); CTA stays disabled until uploaded |
| 6 | Payout bank account; holder name must match ID | Gửi hồ sơ |
| — | Application status | Pending → "Kiểm tra trạng thái" · Needs info (with reason) → "Bổ sung ảnh CCCD" returns to step 3, then "Gửi lại hồ sơ" · Approved → "Bắt đầu nhận việc" → Today |

Demo loop: first status check returns **Cần bổ sung**; after re-uploading, the next check returns **Đã duyệt**.

**Log out** — a bottom sheet with a solid error-red "Đăng xuất" (the one destructive solid block on the screen) and an outlined "Ở lại". Error ink uses `--err-ink` (`#B91C1C` light, `#F87171` dark).

**Demo-state props** (for board cells; not needed in the live flow): `role`, `pick`, `otpPreset`, `otpErr`, `otpCtx`, `dlg`, `kycStep` (2–7, 7 = status), `kycStatus` (`pending` | `needs` | `approved`).

---

## 7. Booking and pricing

Phase 1, batch 2 (revised). Customer role only. **Booking ends when a worker accepts. No money is charged during booking;** payment happens after the service is completed and signed off (next batch).

```
Home / Categories / AI → Service detail → Step 1 Service → Step 2 Time & place → Step 3 Confirm
  → Step 4 Booked → Matching ─┬─ found → Tracking
                              └─ none  → Change time | Cancel (free)
Cancel booking: from Matching (free while searching; 50.000đ fee once a pro has accepted). Not allowed once the pro is on the way.
```

**Pricing (PRD v2.3): not based on travel distance.** `Estimate = Labour (package) + Add-ons + Site surcharge`.

| Line | Amount |
| --- | --- |
| Công thợ (package "Căn hộ dưới 70m²") | 350.000đ |
| Add-on: Thu gom rác mang xuống | 30.000đ |
| Phụ phí mặt bằng — chung cư tầng 12, có thang máy | 20.000đ |
| **Tổng dự kiến** | **400.000đ** |

Site surcharge: townhouse 0đ · apartment with lift 20.000đ · without lift 50.000đ. Worker: 15% fee 60.000đ, net **340.000đ**. Worker Job detail shows the same three lines plus site context, the customer's 2 photos and "Khách trả sau nghiệm thu".

| Key | Screen | Notes |
| --- | --- | --- |
| `service` | Service detail | 8 services in table `SVC`; TRONG NHÀ / NGOÀI TRỜI tags; teal "Đặt lịch" |
| `book1` | Step 1 | Package cards; add-on chips (`ADDONS`) |
| `booking` | Step 2 | Date/slot, address + "Đổi địa chỉ" sheet, home type / floor / lift, up to 5 photos or 1 video, notes. Footer estimate updates live |
| `book3` | Step 3 | Summary, itemized estimate, pay-later method (VNPay / ZaloPay), voucher, "Bạn chỉ thanh toán sau khi nghiệm thu dịch vụ.", one-line cancellation policy. **Amber "Xác nhận đặt lịch · 400.000đ"** — commits to the price, charges nothing |
| `done` | Step 4 | Order ID, estimate, "Sau nghiệm thu · VNPay"; teal "Theo dõi đơn" |
| `matching` | Finding a pro | Searching (auto → found after ~6 s) · found (Hùng's card) · none. Red text link "Huỷ đặt lịch" in searching and found |
| `cancel` | Cancel booking | Reason picker; fee card (free / 50.000đ); **red outline** CTA, locked until a reason is picked; "Giữ lịch hẹn" back |

Screens `pay`, `review`, `thanks`, `receipt` remain in the file for the payment batch but are off the board. `receipt` is still reachable from Tracking ("Xem chi tiết đơn hàng") and Order history.

Demo props: `svc`, `matchState` (`hold` | `found` | `none`), `cancelFee`.

**CTA check:** solid amber appears only on Step 3 "Xác nhận đặt lịch". Cancel is an outline button in error red.

---

## 7b. Service execution & payment

Phase 1, batch 3. Shared order status, identical names in both roles (table `OST` in both components, index = prop `ost`):

| ost | Status | Customer sees | Worker sees |
| --- | --- | --- | --- |
| 0 | Đã nhận việc | Tracking: "Anh Hùng đã nhận việc" | `wgo` |
| 1 | Thợ đang đến | Tracking: code-drawn map, "Còn 8 phút · 2,4 km", Gọi / Nhắn tin | `wgo`: map, "Mở chỉ đường", masked call/chat, teal "Tôi đã đến" |
| 2 | Thợ đã đến | Tracking: arrival + check-in 13:58 | `warr`: check-in, teal "Bắt đầu làm" |
| 3 | Đang thực hiện | Tracking: running timer, checklist 3/5 | `wwork` (existing checklist) |
| 4 | Chờ nghiệm thu | Tracking → teal "Nghiệm thu ngay" → `accept` | `wwait`: "Chờ khách nghiệm thu" |
| 5 | Chờ thanh toán | Tracking → "Đến thanh toán" → `paysum` | `wwait`: "Chờ khách thanh toán" |
| 6 | Hoàn tất | Tracking → e-receipt | `wwait`: "Đã nhận 340.000đ vào ví" → Wallet (new +340.000đ on top, balance 5.200.000đ) |
| 7 | Đang xem xét (dispute) | `disputed` | `wwait`: "Đơn đang được xem xét", no money released |

Tracking keeps the Customer dock; the status timeline is a bottom sheet above it (collapsed = current status, tap to expand all seven with times).

**Customer flow:** Tracking → `accept` (before/after photos, 5/5 checklist, actual time 2 h 25 min, final bill 400.000đ; teal "Xác nhận hoàn tất", red text link "Báo vấn đề") → `paysum` (bill, method pre-selected from booking and changeable, voucher, **amber "Thanh toán 400.000đ"**) → `pay` gateway (QR, 10:00 expiry, "Tôi đã thanh toán"; cancel/expiry → failed with "Thử lại" / "Đổi phương thức" back to `paysum`) → `paid` → `review` (tip makes the CTA amber) → `thanks` → Home. E-receipt from `paid`, `thanks`, Tracking and Order history.

"Báo vấn đề" → `dispute` (type chips, description, photo; CTA locked until a type is picked) → `disputed` (ost 7).

**Money check:** customer pays 400.000đ; worker sees 400.000đ − 60.000đ (15%) = 340.000đ on Job detail, waiting screens and Wallet. Solid amber only on `book3` (commit price), `paysum` (pay) and `review` with a tip.

**Demo control:** the presentation page's "TRẠNG THÁI ĐƠN" row picks Khách / Thợ, steps ◀ ▶ through ost 0–6, and "Báo vấn đề" sets 7. It drives the live phone only; clicking any board cell returns to normal.

---

## 7c. Job lists

Phase 1, batch 4. The main place to find any order.

**Customer — "Đơn của tôi"** (`orders`, Customer dock "Đơn hàng"; Tracking keeps the same dock tab active). Three tabs with counts:

| Tab | Contains | Sample |
| --- | --- | --- |
| Đang chờ | Finding a pro, or accepted (ost 0) | #HS20250426-0031 Vệ sinh máy lạnh, tomorrow 09:00, 480.000đ, "Đang tìm thợ" |
| Đang làm | ost 1–5 and 7 (Đang xem xét) | #HS20250425-0012 (moves with `ost`) |
| Hoàn thành | Completed + cancelled, chip filter Tất cả / Hoàn tất / Đã hủy | #…0087 (350.000đ), #…0054 (620.000đ), #…0021 cancelled (0đ); #…0012 when ost 6 |

Card: icon, service, order ID, date/time, worker, total, status chip (exact Batch 3 names), one outline action: Theo dõi → Tracking/Matching · Thanh toán → `paysum` (ost 5) · Đánh giá → `review` (ost 6) · Đặt lại → Service detail. Tapping a finished card opens its receipt. Empty tab: teal "Đặt dịch vụ". "Bảo hành" is not shown until the warranty batch.

Settings is renamed **Cài đặt**; its history tab is a single link to Đơn của tôi › Hoàn thành.

**Worker — "Công việc"** (`wjobs`). Dock is now Hôm nay · Công việc · Lịch · Ví · Hồ sơ. "Xem tất cả" next to "Lịch hôm nay" opens it.

| Tab | Contains |
| --- | --- |
| Mới phân công | Pinned incoming offer (#…0012 with 00:45 countdown, Nhận / Từ chối) while not yet accepted; 17:30 Sửa ống nước (Phạm Thu Hà, nhà phố, thực nhận 238.000đ) |
| Đang làm | #…0012 at ost 1–5 / 7 |
| Hoàn thành | 09:00 Vệ sinh máy lạnh (297.500đ), yesterday's cancelled fan install (0đ), #…0012 at ost 6 |

Card: time, optional **BẢO HÀNH** tag slot (reserved), status chip, service, customer · district, site context, "Thực nhận", action Bắt đầu di chuyển → `wgo` · Tiếp tục → the screen for the current status · Xem. Worker status chips use the worker-side wording of the same statuses (Đang đến / Đã đến for Thợ đang đến / Thợ đã đến).

**Demo control:** "Xem danh sách" in the TRẠNG THÁI ĐƠN row switches the live phone to Đơn của tôi or Công việc on the matching tab; ◀ ▶ then move #…0012 between tabs.

Demo props: `oTab` (Customer), `jTab` (Worker).

---

## 7d. In-app chat & masked calls (UC-B2C-08, UC-W-04)

Phase 1, batch 6. One shared component `HomeServiceChat.dc.html` (props `role`, `mode` chat | callout | callin, `readonly`, `ost`, `theme`, `lang`, `simKind`, `simN`, `onClose`). Both roles render the **same message list** (`BASE`) and flip sides by `role`, so the conversation is identical on both phones.

**Entry points**
- Customer: Tracking worker card (Gọi / Nhắn tin), chat icon on active cards in Đơn của tôi.
- Worker: Job detail (locked until the job is accepted), Đang đến (Gọi / Nhắn tin), Đã đến, Đang thực hiện (call and chat circles), chat icon on the active card in Công việc.

**Thread** — header: other person, order ID, current status; persistent banner "Số điện thoại của hai bên được ẩn". Message types: text, photo, current location (code-drawn mini map), system lines (accepted, check-in, call log, missed call with "Gọi lại"), extra-cost card. Read receipts ("Đã gửi" → "Đã xem") on your last message; typing indicator before incoming messages. Quick replies differ per role. Tapping the input fills a sample draft; the send button is a tinted icon so the amber approve button stays the only solid block. Phone numbers typed in a message are masked (`0901 ••• •••`) with a note under the bubble.

**Extra-cost card** — "Thay ron vòi sen +60.000đ". Customer: amber "Đồng ý" / outline "Từ chối"; worker sees "Đang chờ khách xác nhận". The approval only changes the card state: batch 5 (extra-cost flow and bill update) has not been built, so totals stay 400.000đ / 340.000đ.

**Calls** — outgoing: avatar, name, role, "Đang kết nối…" (2 s) then duration, mute / speaker toggles, red end button; ending adds a call-log line. Incoming: teal "Nghe máy", red-outline "Từ chối"; declining or 20 s without answer adds a missed-call line with "Gọi lại". Recording notice on both call screens.

**Availability** — from assignment until 24 h after completion. `chatClosed` makes the thread read-only with a note and disables calling.

**Unread badges** — on Nhắn tin buttons, active list cards and the Đơn hàng / Công việc dock tabs (starts at 1, cleared on opening the chat). An incoming message while the chat is closed also shows a tappable banner.

**Demo control** — "LIÊN LẠC" row on the page: "Tin nhắn đến" and "Cuộc gọi đến" for the role currently on the live phone.

---

## 7e. Warranty (PRD 3.9 Auto-Warranty)

Phase 1, batch 7. "Today" in the sample is 25/04/2025.

| Order | Service | Completed | Period | Ends | Days left |
| --- | --- | --- | --- | --- | --- |
| #HS20250318-0087 | Vệ sinh máy lạnh | 18/03 | 60 days | 17/05 | 22 (active) |
| #HS20250425-0012 | Vệ sinh nhà cửa | 25/04 (once ost 6) | 7 days | 02/05 | 7 |
| #HS20250228-0054 | Giặt sofa - nệm | 28/02 | 30 days | 30/03 | expired (grey chip) |

A certificate is issued automatically when an order reaches Hoàn tất. Warranty jobs are always **0đ**, and the **BẢO HÀNH** tag (tint teal, 9.5px/800) is identical on both roles.

**Customer:** warranty chip "Còn bảo hành N ngày · đến dd/mm" + "Xem phiếu bảo hành" on Hoàn thành cards and receipts → `bhcert` (service, technician, completion date, period, covered / not covered, QR). Active certificate CTA "Yêu cầu bảo hành" → `bhreq` (description, up to 5 photos or 1 video, preferred slots; teal "Gửi yêu cầu bảo hành", locked until description + slot) → `bhstat` (Đã gửi → Thợ đã nhận → Đang xử lý → Đã khắc phục). The warranty job #BH20250425-0087 appears in Đơn của tôi (Đang chờ → Đang làm → Hoàn thành by stage). Prop `bh`: `none` or stage 0–3 (default 0 = submitted).

**Worker:** warranty job in Công việc › Mới phân công (tag, 0đ, original order ref, issue, "Phản hồi trong 23:59:00") → `wbh` (issue + customer photos, original job 18/03 with before/after photos; Nhận teal / Từ chối outline). Accept runs the normal flow (Đang đến → Đã đến → Đang thực hiện → wait) with no payment step; the wait screen shows "Bảo hành 0đ" and the wallet gets "Bảo hành – 0đ". Decline → `wbhno`: warning (job reassigned, 120.000đ rework cost deducted), required reason and explicit tick; red-outline confirm → wallet shows −120.000đ with the reason. Skills profile shows "Tỉ lệ bảo hành 2% · 3/128 việc". Prop `wbh`: `acc` | `no`.

---

## 7f. Order detail, notifications, complaint center

Phase 1, batch 8.

**Order detail** (`odetail`, Customer) — from the #…0012 card in Đơn của tôi, Tracking ("Xem chi tiết đơn hàng"). Sections in order: status chip + timeline with times (check-in 13:58) · service, package, add-ons, incident photos · address + site context · technician with Chat / Gọi (greyed with a note when `chatClosed`) · cost: estimate lines, "Chi phí phát sinh" (the declined 60.000đ seal shown struck through), total · payment/escrow box · before/after photos (from Chờ nghiệm thu) · warranty chip (Hoàn tất).

| ost | Escrow wording | Solid CTA | Text links |
| --- | --- | --- | --- |
| 0–1 | Chưa thanh toán – bạn trả sau khi nghiệm thu | Theo dõi đơn | Hủy đơn |
| 2–3 | same | Theo dõi đơn | Báo vấn đề |
| 4 | same | Nghiệm thu | Báo vấn đề |
| 5 | same | **Thanh toán 400.000đ** (amber) | Báo vấn đề |
| 6 | Đã thanh toán · VNPay · 16:34 | Đánh giá | Báo vấn đề, Đặt lại |
| 7 | Tiền đang được giữ an toàn, chưa chuyển cho thợ | Xem khiếu nại | — |

**Notifications** — Customer: Thông báo dock tab (`notif`, badge = unread). Worker: bell with unread dot on the Hôm nay header (`wnotif`). Groups Hôm nay / Trước đó, unread dot and tint, "Đánh dấu đã đọc tất cả"; tapping marks the item read and deep-links:

| Customer item | Opens | Worker item | Opens |
| --- | --- | --- | --- |
| Đã có thợ nhận / đang đến / check-in | tracking | Yêu cầu mới | wjobs › Mới phân công |
| Tin nhắn mới, cuộc gọi nhỡ, phát sinh chờ duyệt | chat | Việc bảo hành mới | wbh |
| Chờ nghiệm thu | accept | Tin nhắn, cuộc gọi nhỡ, phát sinh bị từ chối | chat |
| Thanh toán thành công / thất bại | receipt | Khách đã khiếu nại, khách đã nghiệm thu | wwait |
| Bảo hành: thợ đã nhận | bhstat | Đã nhận 340.000đ, rút tiền thành công | wwallet |
| Khiếu nại đã giải quyết | cdetail | Hồ sơ đã được duyệt | wkyc (approved) |
| Ưu đãi · Nhắc bảo trì | home · devices | | |

Settings → "Thông báo" (`nset` / `wnset`): toggles Đơn hàng, Tin nhắn & cuộc gọi, Ưu đãi (Customer only; switching Ưu đãi off hides the offer item).

**Complaint center (UC-PAY-06)** — "Khiếu nại của tôi" (`clist`) from Profile › Khiếu nại của tôi (replaces the old Hỗ trợ row) and from Order detail / the dispute screen. Statuses: Đang xem xét · Cần bổ sung · Đã giải quyết · Đã đóng. Detail (`cdetail`): ID, linked order, issue type, description, photos, status timeline, resolution; "Bổ sung thông tin" (`cadd`) only when Cần bổ sung. The Batch 3 "Báo vấn đề" form creates #KN-0425-031 (ost 7) with the chosen issue type.

| Complaint | Order | Status | Result |
| --- | --- | --- | --- |
| #KN-0425-031 | #HS20250425-0012 | Đang xem xét / Cần bổ sung (`cst`) | 400.000đ not charged; worker's 340.000đ on hold |
| #KN-0228-014 | #HS20250228-0054 | Đã giải quyết | Partial refund 100.000đ to ZaloPay, 3–5 working days |
| #KN-0115-002 | #HS20250115-0021 | Đã đóng | No refund |

Worker (ost 7): wait screen shows "Khách đã khiếu nại" with the same status chip and summary; "Gửi phản hồi" (`wreply`, explanation + photo). Wallet top row: "Đang tạm giữ · #…0012 340.000đ"; balance unchanged.

---

## 7g. Customer account

Phase 1, batch 9. Profile menu rows and where they go:

| Row | Screen |
| --- | --- |
| Thông tin cá nhân (also "Chỉnh sửa" on the header card) | `eprof` |
| Địa chỉ của tôi | `addrs` → `addredit` |
| Thợ yêu thích | `favs` → `wprev` |
| Phương thức thanh toán | `pms` → `pmlink` |
| Thông báo | `nset` |
| Cài đặt | `settings` (Ngôn ngữ toggles VI/EN, Đổi mật khẩu → `chpass`, Phương thức thanh toán, Trung tâm trợ giúp → `clist`, Về ứng dụng → dialog, Xoá tài khoản → `delacc`, Thông báo, Đăng xuất) |
| Khiếu nại của tôi | `clist` |

"Thành viên gia đình" and "Mã ưu đãi của tôi" were removed (no screens).

**Edit profile** — avatar with initials fallback, name, phone, email, date of birth; each field toggles between two sample values on tap. "Lưu thay đổi" is locked until something changes. If the phone changed, saving goes to OTP (`otpCtx: 'phone'`, sent to the new number) and returns with "Đã xác thực số điện thoại mới". The saved name/email show on the Profile header.

**Addresses** — state `addrs` (seed `ADDR0`: Căn hộ Riverside, default, chung cư tầng 12, thang máy, note "Gửi xe ở hầm B2…"; Nhà ba mẹ, nhà phố). Cards show label, MẶC ĐỊNH tag, site context, note; links Sửa / Đặt mặc định / Xoá. The default address shows "không xoá được" instead of Xoá. Delete asks for confirmation. Add/Edit: label Nhà / Công ty / Khác, address (tap fills a sample for new), code-drawn pin map (`PINMAP`), house type, floor, lift, note, default toggle. **Booking uses the same list**: step 2 starts on the default address, and the "Đổi địa chỉ" sheet lists all saved addresses with a "Quản lý" link.

**Payment methods** — state `wal` (seed VNPay Vietcombank ••• 4821 default, ZaloPay 0901 ••• 567). Set default / unlink (confirm dialog; the default cannot be unlinked). "Liên kết ví mới": pick MoMo or ShopeePay → confirm in wallet → linked. **Step 3 and Payment list only linked wallets and pre-select the default.**

**Favourite pros (UC-B2C-07)** — state `favs` (seed Trần Văn Hùng, Phạm Minh Đức). Heart toggles on the worker card in Matching (found), Tracking and Review, on `favs` and on `wprev`. "Đặt lại với thợ này" opens step 1 for that pro's last service; step 3 shows "Ưu tiên thợ: Trần Văn Hùng". Tapping the worker avatar on those cards opens `wprev`.

**Change password** — three fields, CTA locked until all are filled; returns to Settings with "Đã đổi mật khẩu."

**Delete account** — what gets deleted, active-order warning, reason picker; red-outline CTA → OTP (`otpCtx: 'delacc'`) → Role selection with account data cleared.

---

## 7h. Worker operations

Phase 1, batch 10. All in `HomeServiceWorker.dc.html`; customer-side effects in the shell.

**Customer no-show (UC-W-07)** — link "Khách không có mặt?" on `warr` (only after check-in) → `wns`: 15-minute wait with countdown (demo starts at 00:59 left, i.e. 14 min already waited since 13:58), contact log (calls 14:02, 14:08, message 14:03) with a link to the chat call log; CTA locked until 00:00 → `wnsrep` (evidence photo required, note) → `wnsdone`. Job #…0012 moves to Hoàn thành as "Khách vắng mặt"; wallet +50.000đ "Phí khách vắng mặt". **The customer pays a 50.000đ no-show fee, 100% to the worker, no platform fee, and is not charged the 400.000đ service price.** Customer (prop `ns`): Order detail shows the no-show notice and escrow "Đã thu phí vắng mặt 50.000đ"; Đơn của tôi moves #…0012 to Hoàn thành with chip "Khách vắng mặt".

**Cancel job by worker** — red link "Huỷ việc" on `wgo` → `wcxl`: reason picker, impact card (Tỉ lệ nhận 96% → 95%, Tỉ lệ hoàn thành 98% → 97%, 3 cancels / 30 days pauses jobs 24 h), red-outline CTA. After cancelling: dashboard banner, #…0012 removed from Công việc and Lịch shows "Đã huỷ", dashboard accept rate and Performance drop by 1 point. Customer (prop `wcx`): #…0012 returns to Đang chờ "Đang tìm thợ", and Matching shows "Anh Hùng vừa huỷ việc… bạn không mất phí".

**Wallet (UC-PAY-03)** — one ledger `LG` drives every number:

| Row | Amount |
| --- | --- |
| Số dư chuyển sang (01/04) | +5.884.500đ |
| Thưởng hoàn thành 10 việc (20/04) | +100.000đ |
| Vệ sinh nhà cửa #…0031 (21/04) | +340.000đ |
| Rút về Vietcombank (22/04) | −2.000.000đ |
| Sửa chữa điện nước #…0019 (24/04) | +238.000đ |
| Vệ sinh máy lạnh #…0007 (25/04) | +297.500đ |
| **Có thể rút** | **4.860.000đ** |

Conditional rows: #…0012 paid +340.000đ (→ 5.200.000đ); #…0012 on hold 340.000đ under complaint (shown in "Đang tạm giữ", **not** in the balance); no-show +50.000đ; warranty decline −120.000đ; warranty 0đ; new withdrawals (deducted as soon as requested). Summary card: Tổng thu nhập đã về − Đã rút / đang rút − Khấu trừ = Có thể rút; Đang tạm giữ on its own line. Every row opens `wtx` (type, amount, breakdown customer paid − 15% fee = net, time, transaction ID, order link, status).

Withdraw: "Rút về tài khoản" → `wwd` (chips 500k / 1 triệu / Tất cả, minimum 100.000đ, fee 0đ, balance after, Vietcombank ••• 4821 from KYC) → `wwdpin` (6-digit keypad) → `wwdst` (Đã gửi → Chờ kế toán duyệt trong 24 giờ → Đã chuyển khoản). Prop `wd`: `pending` | `done`.

**Schedule** — Lịch dock tab (`wcal`): week 21/04–27/04, job counts per day, tap a day for its jobs (warranty job on 26/04 tagged BẢO HÀNH), Sunday off. `wavail`: day toggles, tap a time range to cycle 08:00–18:00 / 07:00–20:00 / 13:00–21:00, "Nghỉ đột xuất" date chips (26/04–02/05) with a warning when the day already has an accepted job.

**Work zone** (`wzone`, Profile menu): district chips (at least one), radius stops 3 / 5 / 8 / 12 km, code-drawn map with the radius circle.

**Skills & certificates (UC-W-02)** (`wskill`): 8 services toggle on/off (profile grid follows). Certificates: work-at-height **Hết hạn 15/04/2025**, electrician Đã duyệt, Daikin Chờ duyệt. While the height certificate is expired or pending, outdoor services show "ẨN" with a red / amber note. `wcert`: type, photo, expiry → Chờ duyệt.

**Performance (UC-W-09)** (`wperf`, from the dashboard stats row and Profile menu): 4.9 rating, acceptance 96%, completion 98%, on-time check-in 94%, warranty 2%, one line each with the target; badges (3 earned, 1 locked).

Profile menu rows: Kỹ năng & chứng chỉ · Khu vực nhận việc · Lịch làm việc · Hiệu suất · Tài khoản nhận tiền (→ `wwd`). "Hỗ trợ thợ" removed.

---

## 8. Your home (Customer)

The most distinctive module. Two tabs share the selected address:

**Devices** — name, brand, status, last service date. Two status levels only: Running well (green ink) and Needs service (red ink).

**Maintenance schedule** — sorted by date; left bar color by priority: red overdue, amber due soon, jade later. Each item has a chip stating the action.

The reminder card states a concrete benefit ("longer device life, lower repair bills").

---

## 9. Role of AI

AI assists; it does not take over the main flow. Chat opens with a greeting followed by five preset intents — faster than typing, and it shows what the AI can do.

Suggestions always give a **specific reason with data** ("It has been 3 weeks since your last cleaning"). The main suggestion sits on a light amber card with its own CTA; secondary suggestions are a plain list.

---

## 10. Illustrations

| Key in `IMG` | Source | Used on | Fit |
| --- | --- | --- | --- |
| `splash_full` | `assets/splash-full.png` | Splash | `cover`, top-aligned; only the progress bar is code |
| `ob_1_clean` | `assets/ob-1-clean.png` | Onboarding 1 | `contain`, centered |
| `ob_2_tech` | `assets/ob-2-tech.png` | Onboarding 2 | `contain`; badges are part of the image |
| `ob_3_steps` | `assets/ob-3-steps.png` | Onboarding 3 | `contain`; 3-step row is part of the image |
| `ob_4_ai` | `assets/ob-4-ai.png` | Onboarding 4 | `contain`, centered |
| `ob_5_family` | `assets/ob-5-family.png` | Onboarding 5 | `contain`, bottom-aligned so no one is cropped |
| `hero_banner` | `assets/hero-banner.png` | Customer Home hero | `cover`; text and button are in the image |

Onboarding illustrations always use `contain`: characters sit mid-frame, so `cover` crops heads or feet when the aspect ratio changes.

**No illustrations on functional screens.** Maps are drawn in code as simplified SVG streets, never map images. Text over imagery needs a gradient or background to reach contrast.

Source images come from user-supplied files in `uploads/`. Re-crop from the originals there, never by upscaling files in `assets/`.

---

## 10b. Onboarding

Four slides share one frame: title, flexible illustration, optional caption, dot indicator, button pair. The illustration is a single image; only titles, captions, dots and buttons are code.

| Slide | Adds | Primary button |
| --- | --- | --- |
| 1 — Opening | One caption | Tiếp theo |
| 2 — Trust | Description under title; badges in the image | Tiếp theo |
| 3 — How it works | One caption; 3-step row in the image | Tiếp theo |
| 4 — AI | One long caption | Tiếp theo |
| 5 — Summary | Three values + family illustration; separate `intro` screen | **Bắt đầu ngay** |

Dots are tappable to jump slides, including backwards from 5 to 1.

---

## 10c. Language and theme implementation

**Language.** Template strings read `{{ L.kNN }}`; table `LSTR` at the top of the logic holds `[vi, en]` pairs. Strings generated in logic are wrapped in `S('…')` and looked up in table `EN`. Missing translations fall back to Vietnamese rather than blank. New strings get a new entry in the right table.

Names, addresses and order IDs stay the same in both languages — they are sample data, not UI strings.

**Theme.** See §2 "Theme tokens".

---

## 11. Copywriting

Natural Vietnamese that talks about the job, not the system. Each service has one line stating a **benefit**, not a scope:

- Good: "Nhà sạch, sống khỏe hơn" · "Không còn lo muỗi, gián"
- Avoid: "Dịch vụ vệ sinh tổng thể căn hộ"

Status copy says what is happening and the next time marker ("Kỹ thuật viên đang thực hiện dịch vụ, dự kiến hoàn tất lúc 16:30").

Worker money copy always says **"thực nhận về ví"** (net to wallet), and the net figure is the largest number and last row.

---

## 12a. Board order (by flow)

Batch 2 added old #40–53 and split the Customer groups into four: Discover & book · Payment & matching · After the service · Support & account. The board renumbers cells in flow order at runtime (`FLOW` in the page and print file), so the tables below list keys; the page shows the current numbers.


The presentation board and print version are ordered by user flow, and cells are **renumbered in that order**. Use these numbers when discussing screens. The "Old #" column maps to the numbering used in the tables in §12 below and in earlier conversations.

**01 · Mở đầu & Thương hiệu**

| Cell | Key | Old # |
| --- | --- | --- |
| 01 | `splash` | 01 |
| 02 | `onboarding · obSlide 0` | 02 |
| 03 | `onboarding · obSlide 1` | 03 |
| 04 | `onboarding · obSlide 2` | 04 |
| 05 | `onboarding · obSlide 3` | 05 |
| 06 | `intro` | 06 |

**02 · Chọn vai trò & Đăng nhập**

| Cell | Key | Old # |
| --- | --- | --- |
| 07 | `role` | 23 |
| 08 | `login` | 07 |
| 09 | `login · role worker` | 24 |
| 10 | `register` | 08 |
| 11 | `otp` | 25 |
| 12 | `otp · otpErr` | 26 |
| 13 | `forgot` | 27 |
| 14 | `newpass` | 28 |
| 15 | `passok` | 29 |

**03 · Đăng ký đối tác · UC-W-10**

| Cell | Key | Old # |
| --- | --- | --- |
| 16 | `register · role worker` | 31 |
| 17 | `wkyc · step 2` | 32 |
| 18 | `wkyc · step 3` | 33 |
| 19 | `wkyc · step 4` | 34 |
| 20 | `wkyc · step 5` | 35 |
| 21 | `wkyc · step 6` | 36 |
| 22 | `wkyc · pending` | 37 |
| 23 | `wkyc · needs` | 38 |
| 24 | `wkyc · approved` | 39 |

**04 · Khách hàng — Đặt & theo dõi dịch vụ**

| Cell | Key | Old # |
| --- | --- | --- |
| 25 | `home` | 09 |
| 26 | `categories` | 10 |
| 27 | `booking` | 11 |
| 28 | `tracking` | 12 |
| 29 | `devices` | 13 |

**05 · Khách hàng — Hỗ trợ & Tài khoản**

| Cell | Key | Old # |
| --- | --- | --- |
| 30 | `chat` | 14 |
| 31 | `suggestions` | 15 |
| 32 | `profile` | 16 |
| 33 | `settings` | 17 |
| 34 | `settings · dlg` | 30 |

**06 · Thợ — Nhận việc & Thu nhập**

| Cell | Key | Old # |
| --- | --- | --- |
| 35 | `whome` | 18 |
| 36 | `wjob` | 19 |
| 37 | `wwork` | 20 |
| 38 | `wwallet` | 21 |
| 39 | `wprofile` | 22 |

## 12. Screen list

Cell numbers are the numbers on the presentation board — use these when discussing screens.

### Customer (`HomeServicePhone`)

| Cell | `screen` key | Screen | Dock |
| --- | --- | --- | --- |
| 01 | `splash` | Splash | — |
| 02–05 | `onboarding` | Onboarding slides 1–4 (`obSlide` 0–3) | — |
| 06 | `intro` | Onboarding slide 5 — Summary | — |
| 07 | `login` | Log in | — |
| 08 | `register` | Sign up | — |
| 09 | `home` | Home | Trang chủ |
| 10 | `categories` | Service categories | — |
| 11 | `booking` | Book a service | — |
| 12 | `tracking` | Track order | Đơn hàng |
| 13 | `devices` | Your home | — |
| 14 | `chat` | AI Assistant | AI hỗ trợ |
| 15 | `suggestions` | AI suggestions | AI hỗ trợ |
| 16 | `profile` | Profile | Tài khoản |
| 17 | `settings` | Settings & History | Tài khoản |

### Worker (`HomeServiceWorker`)

| Cell | `screen` key | Screen | Dock |
| --- | --- | --- | --- |
| 18 | `whome` | Today's jobs | Việc |
| 19 | `wjob` | Job request detail | — |
| 20 | `wwork` | Job in progress | — |
| 21 | `wwallet` | Earnings wallet | Ví |
| 22 | `wprofile` | Skills profile | Hồ sơ |

**Worker flow:** Today → tap request card → Accept → In progress → tick all 5 checklist items → Finish → Wallet. Decline removes the request and returns to Today. Turning the availability switch off hides the new-request card. The Finish button is enabled only when all 5 items are ticked; until then its label says how many remain.

### Role & Auth (shell)

| Cell | `screen` key | Screen | Dock |
| --- | --- | --- | --- |
| 23 | `role` | Role selection | — |
| 24 | `login` + `role: worker` | Log in — Worker (cell 07 is the Customer variant) | — |
| 25 | `otp` | OTP entry | — |
| 26 | `otp` + `otpErr` | OTP — wrong code | — |
| 27 | `forgot` | Forgot password | — |
| 28 | `newpass` | New password | — |
| 29 | `passok` | Password updated | — |
| 30 | `settings` + `dlg` | Log out confirm — Customer | Tài khoản |

### Worker sign-up (Worker component, except step 1)

| Cell | `screen` key | Screen |
| --- | --- | --- |
| 31 | `register` + `role: worker` | Step 1 — Phone |
| 32–36 | `wkyc` + `kycStep` 2–6 | Steps 2–6 |
| 37 | `wkyc` + `kycStep 7`, `pending` | Status — under review |
| 38 | `wkyc` + `kycStep 7`, `needs` | Status — more info needed |
| 39 | `wkyc` + `kycStep 7`, `approved` | Status — approved |

The Worker log-out confirm is `wprofile` + `dlg` (not a separate board cell).

New cells continue from 40.

---

## 13. Sample data

One consistent cast so every screen tells the same story.

| | |
| --- | --- |
| Customer | Nguyễn Thị Mai · 0901 234 567 · maingvyen@gmail.com |
| Address | Căn hộ Riverside, 123 Nguyễn Thị Minh Khai, Quận 1 (floor 12, lift) |
| Worker | Trần Văn Hùng · 0912 345 678 · 4.9 stars · 128 reviews · 3 years |
| Active order | #HS20250425-0012 · Vệ sinh nhà cửa · today 14:00–17:00 · 400.000đ · expected done 16:30 |
| Price lines | Labour 350.000đ · Rubbish add-on 30.000đ · Floor-12 surcharge 20.000đ |
| Worker net | 400.000đ − 15% fee 60.000đ = 340.000đ |
| Devices | Daikin air-con, LG washer, Samsung fridge (good) · Ariston water heater (needs service) |
| Running thread | Ariston heater overdue since 10/01/2025 — appears in Devices, Maintenance and AI suggestions |

The Worker's new request is the Customer's active order; the Worker is the technician the Customer sees on Tracking.

---

## 14. Adding a screen

1. Add an `<sc-if>` branch in the right component, before the DOCK block.
2. Add the flag `isXxx: s==='xxx'` and a `goXxx` handler in `renderVals()`.
3. Add the key to `dockFor` only if the screen needs the dock; sub-screens use a back button instead.
4. Add the key to the `options` of the `screen` prop in `data-props`.
5. Add all copy to `LSTR` (template) or `EN` (logic) as `[vi, en]`.
6. New images: embed in `IMG` and render with `<img>` + `object-fit` (§17).
7. Add a cell to the presentation page groups (numbered from 23), with a one-line caption stating the design decision.
8. Add a row to array `G` in the print file.
9. Update §12, §6b if routing changed, and §15.

Onboarding slides are added to `obDef` rather than as new screens.

---

## 14b. Print version

`HomeServices Concept 02-print.dc.html` uses `doc-page`, landscape, explicit pagination: a cover then content pages with 3 screens each at 68%. Each page header names the current group; a page spanning two groups says "Chuyển nhóm" with both names. Cells render with `theme="light"` and `lang="vi"`.

Do not write `@page` or page-break CSS — `doc-page` owns that. Adding a screen means adding one row to array `G`; page count recalculates.

---

## 15. Remaining work (Việc còn lại)

Updated at the end of Phase 1.

**Cross-role sync** — Both roles run on one phone and do not update each other in real time. Order status, no-show, worker cancel, extra-cost approval, complaint state, warranty stage and withdrawal approval are driven by props (`ost`, `ns`, `wcx`, `xc`, `cst`, `bh` / `wbh`, `wd`) from the page's control rows.

**Simulated inputs** — Camera, photo/video pickers, address search, password/PIN fields, voucher codes and the payment gateway redirect are tap-to-fill. The warranty 23:59:00 response timer is static; the no-show countdown starts at 00:59 for the demo.

**Not built**
- Vouchers / promotions screen ("Mã ưu đãi" removed from the menu).
- Full complaint centre on the operator side; accounting approval screen for withdrawals.
- Extra-cost request form on the Worker side (the request exists as a chat card; approval changes totals only through the `xc` prop).
- Preferred-pro matching (step 3 shows it; matching still assigns Trần Văn Hùng).
- Availability, work zone and services do not filter the job list.
- Family members, device purchase history, admin/back-office.

**Known simplifications**
- Order history receipts for past orders show a single labour line.
- Notification settings: only the Ưu đãi toggle changes the list.

## 16. Worker experience

Separate file `HomeServiceWorker.dc.html`, same tokens and `data-th` mechanism as the shell.

- **Same order, both sides.** The new request on cells 18–19 is Mai's order #HS20250425-0012; the worker is Trần Văn Hùng from the Customer's Tracking screen.
- **Money always reads "thực nhận về ví".** Line items per §7, then platform fee −60.000đ, then net 340.000đ as the largest, last figure.
- **Conditional finish.** See §12 Worker flow.

---

## 17. Images at publish time

Every image in use is compressed to JPEG (≈770 KB total) and embedded in the `IMG` constant at the top of the logic in `HomeServicePhone` and `HomeServiceWorker`. Reason: publishing uploads only the page files, not `assets/`, so path-based images come out blank.

`assets/` remains the source. Adding or replacing an image means re-embedding it in `IMG` — editing `assets/` alone has no effect on the published version.

Embedded images render as `<img>` with `object-fit`, **never** `background-image:url()` in an inline style: the `data:image/jpeg;base64,…` string contains semicolons and breaks the style.

Opening the `.dc.html` files directly from disk (`file://`) shows empty phones because the browser blocks loading sibling component files. Use the bundled `… - mo tren may.html` for local viewing.
