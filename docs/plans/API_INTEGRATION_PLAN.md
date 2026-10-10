# Kế hoạch tích hợp API — VSTech Home Services

> Nguồn contract: `docs/api/openapi.json` (thực chất là **YAML** OpenAPI 3.1, file bị lỗi cú pháp —
> xem mục 6) đối chiếu với `docs/reference/api/*.md`.
> Môi trường: **UAT** `https://homeservice-uat.vitinhkimhung.com` (đã probe 2026-10-06: server sống,
> trả đúng envelope `{status, message, errorCode, timestamp}`).

## 0. Lộ trình & tiến độ (cập nhật mỗi khi xong một phần)

> 📌 Tóm tắt những chỗ app đang làm tạm ở local, API còn thiếu, mâu thuẫn tài liệu và việc cần làm: [`NOTES_LOCAL_WORKAROUNDS_AND_API_GAPS.md`](NOTES_LOCAL_WORKAROUNDS_AND_API_GAPS.md).

### A. Tích hợp API vào app (mình làm)

| Pha | Nội dung | Trạng thái |
| :--- | :--- | :--- |
| 0 | Nền tảng: env, ApiClient, lỗi/l10n, token, session, DI | ✅ Xong 2026-10-06 (commit `ae54ec0`) |
| 1 | Auth & Profile: login, register, logout, splash/role routing, profile/edit/address, guard router | ✅ Code xong 2026-10-07 — ⏳ chờ tài khoản test UAT để smoke test đăng nhập thật |
| 2 | Khách: danh mục, ước tính, tạo booking, danh sách đơn, huỷ, khiếu nại, duyệt/từ chối báo giá | ✅ Code xong 2026-10-10 (hướng "Gọn theo API") — ⏳ chờ tài khoản test UAT; UI duyệt báo giá chờ Batch 14 |
| 3 | Thợ: nhận việc, bắt đầu, gửi báo giá, hoàn thành, GPS 2s | ✅ Code xong 2026-10-10 (commit 3.1–3.4) — ⏳ chờ tài khoản test UAT |
| 4 | Ví thợ: số dư, sổ giao dịch, tạo/list yêu cầu rút | ⏳ Chưa làm |
| 5 | Thông báo + cài đặt, Chat REST + WS, log VoIP | ⏳ Chưa làm |

### B. UI còn thiếu cho API có sẵn (bạn làm trên Claude Design → mình chuyển sang Flutter + nối API)

Prompt: `docs/design/prompts/CLAUDE_DESIGN_PROMPTS_API_GAPS.md`

| Batch | Nội dung | Cells | Thiết kế | Flutter + API |
| :--- | :--- | :--- | :--- | :--- |
| 14 | Báo giá chi tiết (thợ gửi, khách duyệt) | 132–135 | ⏳ | ⏳ (gắn với Pha 2/3) |
| 15 | Nạp tiền ví thợ (⚠ cần BA xác nhận ví nào) | 136–138 | ⏳ | ⏳ (gắn với Pha 4) |
| 16 | Đọc tất cả thông báo (khách) + cài đặt thông báo (thợ) | 139–140 | ⏳ | ⏳ (gắn với Pha 5) |
| 17 | Lịch sử cuộc gọi của đơn | 141 | ⏳ | ⏳ (gắn với Pha 5) |

### C. Màn hình thiếu API (backend đang bổ sung — chờ API doc mới)

Xem mục 6. Khi có doc mới: đối chiếu lại, cập nhật `ApiEndpoints` + bảng này, rồi xếp vào pha phù hợp.
Trong lúc chờ, các màn này **giữ dữ liệu mock**.

## 1. Hiện trạng (trước Pha 0)

- Toàn bộ 14 feature đang là **UI-only** với dữ liệu mock — chưa có `data/` / `domain/`, chưa có
  Cubit/BLoC nào.
- `core/network` đã có khung: `ApiClient` (dio + interceptor 401), `ApiResponse`, `PagedResponse`,
  `AuthTokenStore` (abstract), `NetworkException`, `ApiEndpoints` (mới có Auth/Profiles).
- `configureDependencies()` đang rỗng; `main.dart` chưa khởi tạo `ApiClient`.

## 2. Phạm vi endpoint (55 operation trong spec)

| Nhóm | Endpoint dùng cho app | Feature | Pha |
| :--- | :--- | :--- | :--- |
| Auth | `POST /auth/login, /register, /refresh, /logout` | auth | 1 |
| Profiles | `GET/PUT /profiles` | auth (profile, edit, address), worker_kyc | 1 |
| Devices | `POST /devices/register`, `DELETE /devices?token=` | core (FCM) | 1 |
| ServiceCategories | `GET /service-categories`, `GET /service-categories/{id}` | home, booking | 2 |
| Bookings | `POST /bookings/estimate`, `POST /bookings`, `GET /bookings`, `POST /{id}/cancel`, `/{id}/dispute` | booking, orders, exceptions | 2 |
| Quotes (khách) | `POST /bookings/{id}/quote/approve`, `/quote/reject` | orders, checkout | 2 |
| Bookings (thợ) | `POST /bookings/{id}/accept`, `/start`, `/complete`, `/quote` | worker_dispatch, worker_task, checkout | 3 |
| Technician | `PUT /technician/location` (mỗi ~2s khi online) | tracking, worker_dashboard | 3 |
| Wallet | `GET /wallets/me`, `GET /wallets/me/transactions` | wallet | 4 |
| Withdrawals | `POST/GET /wallets/withdrawals` | wallet | 4 |
| Payments | `POST /wallets/payments/deposit`, `/withdraw` | checkout, wallet | 4 (chờ làm rõ) |
| Notifications | `GET /notifications`, `POST /read-all`, `POST /{id}/read`, `GET/PUT /settings` | orders (notifications pages) | 5 |
| Chat | `POST /chat/rooms`, `GET/POST /chat/rooms/{roomId}/messages` + WS | messaging | 5 |
| VoIP | `POST /voip/calls`, `POST /voip/calls/end`, `GET /voip/calls?bookingId=` | messaging | 5 |

**Không làm (ngoài phạm vi app / admin):** `/admin/voip/...`, `/wallets/withdrawals/all`,
`/withdrawals/{id}/approve|reject`, `/dispatch/manual-queue*`, `POST/PUT/DELETE /service-categories`,
`/bookings/{id}/resolve-dispute`, `DELETE /devices/{token}` (legacy), toàn bộ `/assets*`
(post-MVP theo CLAUDE.md — feature `warranty` giữ mock).

## 3. Pha 0 — Nền tảng ✅ Hoàn thành 2026-10-06

> Bản spec đã sửa: `docs/api/openapi.yaml` (giữ nguyên file gốc `openapi.json`). Smoke test trên UAT:
> `GET /service-categories` không token → `HS-401-0001` + phát session expired; login sai → `HS-401-0002`.

1. **Cấu hình môi trường** — `core/config/app_env.dart`:
   `String.fromEnvironment('API_BASE_URL', defaultValue: 'https://homeservice-uat.vitinhkimhung.com')`
   (+ `WS_BASE_URL` suy ra `wss://…`). Chạy: `flutter run --dart-define=API_BASE_URL=...`.
2. **Sửa spec** — chuyển thành `docs/api/openapi.yaml` hợp lệ (sửa các key path bị xuống dòng
   `{id\n}`, `responses: "200":` dính dòng, example `16: 15: 50Z`) để đọc/generate được.
3. **ApiClient nâng cấp**
   - Refresh token bằng một `Dio` riêng (không đi qua interceptor) + khoá chống refresh song song
     (`QueuedInterceptorsWrapper`).
   - `/auth/refresh` chỉ trả `accessToken` (không trả refresh mới) → giữ lại refresh token cũ.
   - Parse body lỗi thành `NetworkException(errorCode, statusCode)` — hiện tại đang bỏ qua `errorCode`.
   - Header `X-Idempotency-Key` tự gắn qua `options.extra['idempotent'] = true` cho POST thay đổi
     trạng thái (bookings, payments, withdrawals, accept/complete…).
   - Timeout connect/receive, `Accept-Language` theo locale app.
4. **Error mapping** — `core/network/error_code_mapper.dart`: `HS-XXX-XXXX` → key l10n (vi/en),
   theo `docs/reference/api/11-appendices.md`. Bỏ các chuỗi tiếng Việt viết cứng trong
   `NetworkException.fromDioException` (vi phạm rule 100% l10n).
5. **Token store** — `SecureAuthTokenStore` (flutter_secure_storage) implement `AuthTokenStore`.
6. **DI** — bật `injectable` codegen (`@InjectableInit`), đăng ký `ApiClient`, token store,
   datasource/repository/usecase theo từng feature.
7. **Session & router** — `SessionCubit` (app-level, duy nhất được phép ở root) giữ trạng thái
   đăng nhập + role; GoRouter `redirect` + `refreshListenable` đọc nó; `onSessionExpired` → logout.
8. **Dùng chung** — `Failure` sealed class, `Result<T>` (hoặc Either tự viết), `MoneyFormatter`
   (string/number → `NumberFormat` VND), parse `OffsetDateTime` UTC → local.
9. **Test hạ tầng** — `test/fixtures/` (JSON mẫu theo spec), helper mock `ApiClient` bằng mocktail.

## 4. Các pha theo feature (vertical slice)

Mỗi feature làm theo đúng skill `api-module-integration`:
DTO request/response riêng (freezed) → RemoteDataSource → Repository (map lỗi) → UseCase →
Cubit/BLoC (sealed state) → nối vào page có sẵn (thay mock, giữ nguyên UI) → unit + bloc test.

**Pha 1 — Auth & Profile**
Login (`identifier` = phone/email), Register (201 — spec không khai báo body, doc foundation nói trả `AuthResponse`: parse nếu có, nếu không thì gọi login), Logout (gửi
refreshToken + huỷ FCM token), Splash kiểm tra token → `GET /profiles` → route theo `role`
(CUSTOMER / WORKER). Profile/Edit profile/Edit address dùng `PUT /profiles`. Đăng ký FCM token sau
khi đăng nhập.

> **Kết quả Pha 1 (2026-10-07):**
> - Splash → `SplashCubit`: chưa đăng nhập → onboarding; có token → `GET /profiles` → home theo role; lỗi mạng → thông báo + Thử lại.
> - Login/Register gọi API thật, rồi **đi qua màn OTP mô phỏng** (mã demo `123456`, chưa có API OTP) — xác thực xong: khách → Home, thợ đăng ký → KYC wizard, thợ đăng nhập → Dashboard. Mật khẩu tối thiểu 8 ký tự (khớp `HS-400-0022`).
> - **Ghi nhớ đăng nhập:** ô "Ghi nhớ đăng nhập" (mặc định bật) lưu SĐT/email + mật khẩu theo từng vai trò trong Keychain/Keystore (`flutter_secure_storage`); đăng xuất không xoá, mở Login sẽ tự điền; bỏ chọn khi đăng nhập → quên thông tin đã lưu. Đăng ký thành công cũng được ghi nhớ.
> - Router guard: chưa đăng nhập vào màn cần đăng nhập → Login; đã đăng nhập vào onboarding/role gateway → Home; khách vào `/worker/*` (hoặc ngược lại) → Home của mình. Tài khoản ADMIN/SUPPLIER bị từ chối.
> - Hồ sơ khách, Sửa hồ sơ, Sửa địa chỉ, Hồ sơ thợ đọc/ghi `GET/PUT /profiles`. Ngày sinh, nhãn/tầng/ghi chú địa chỉ chưa có field API → chỉ giữ trên màn hình. Mã đối tác hiển thị `id` số của user.
> - Đăng xuất (Settings khách, Hồ sơ thợ) gọi `POST /auth/logout` rồi luôn xoá token cục bộ.
> - **Hoãn:** đăng ký FCM (`/devices/*`) — dự án chưa cấu hình Firebase (`google-services.json`/`GoogleService-Info.plist`), làm cùng Pha 5.

**Pha 2 — Luồng khách đặt lịch**
Home/Categories/Service detail ← `service-categories`. Booking step 1–3: estimate → create
(⚠ response 201 **không bọc** `ApiResponse`). Orders tabs ← `GET /bookings?status=`. Huỷ/khiếu nại,
duyệt/từ chối báo giá.

> **Kết quả Pha 2 (2026-10-10) — hướng "Gọn theo API":**
> - Home (8 danh mục đầu), Danh mục (tìm kiếm cục bộ), Chi tiết dịch vụ đọc `GET /service-categories[/{id}]`; ảnh `imageUrl` (có ảnh dự phòng). Bỏ khu "Ưu đãi", chip lọc nhóm, rating — không có API.
> - Đặt lịch dùng 1 `BookingFlowBloc` (ShellRoute) cho 4 màn: **B1** mô tả vấn đề → `POST /bookings/estimate`; **B2** ngày (hôm nay/mai, ngày thật) + khung giờ 2 tiếng (khung đã qua bị khoá) → `scheduledTime` UTC, địa chỉ (điền từ hồ sơ) → `addressDetail`, toạ độ từ hồ sơ hoặc GPS (`geolocator`, đã khai báo quyền iOS/Android) → `locationLat/Lng`, ghi chú nối vào `description`; **B3** tóm tắt + giá dịch vụ / phí nền tảng / tổng từ server → `POST /bookings` (idempotent, nhận cả response có/không bọc envelope); **Hoàn tất** hiện `requestId` thật. Bỏ gói/add-on/phụ phí loại nhà/ảnh/voucher/chọn thanh toán.
> - Đơn hàng: `GET /bookings` phân trang ("Xem thêm"), kéo để làm mới; 3 tab theo trạng thái (Đang làm: ACCEPTED/IN_PROGRESS/DISPUTE · Đang chờ: PENDING/DISPATCH_FAILED · Hoàn thành: COMPLETED/CANCELLED); chip trạng thái Icon + Nhãn + Màu.
> - Chi tiết đơn: dựng lại chỉ với field `BookingResponse`; lấy từ cache repository, không có thì dò tối đa 5 trang (chưa có `GET /bookings/{id}`). Nút theo state machine: Theo dõi (ACCEPTED/IN_PROGRESS), Huỷ (PENDING/ACCEPTED), Báo vấn đề (COMPLETED).
> - Huỷ / Khiếu nại: màn xác nhận → `POST /bookings/{id}/cancel|dispute` (idempotent). Bỏ lý do huỷ, phí huỷ, loại vấn đề, mô tả, ảnh — API không nhận body.
> - Duyệt/từ chối báo giá: có datasource + use case, chờ UI Batch 14.
> - Màn còn mock (chưa có API): theo dõi thợ, tìm thợ (radar), thanh toán/nghiệm thu/đánh giá, bảo hành, gợi ý AI, thợ yêu thích.

**Pha 3 — Luồng thợ**

> **Kế hoạch commit Pha 3** (mỗi bước: `flutter analyze` sạch + test xanh → commit ngay; push khi xong bước cuối):
>
> | # | Commit | Nội dung |
> | :- | :--- | :--- |
> | 3.1 | `feat(worker): add worker booking actions data layer` | DTO `CompleteBookingRequest`, `SubmitQuoteRequest`; datasource/repository `accept`, `start`, `complete`, `submitQuote`; use case (chặn `actualPrice` > 1,5 × giá ước tính → `HS-400-0012`); unit test |
> | 3.2 | `feat(worker): broadcast GPS every 2s while online` | `LocationUpdateRequest` + `PUT /technician/location` mỗi 2 giây khi Online; `WorkerPresenceCubit` (bật/tắt Online — chỉ ở app vì API chưa có, tự tắt khi đăng xuất); nút Online trên Dashboard; test |
> | 3.3 | `feat(worker): load jobs hub and dashboard job offer from bookings` | `WorkerJobsCubit` từ `GET /bookings`; Jobs Hub 3 tab theo trạng thái; thẻ việc mới trên Dashboard lấy đơn PENDING; test |
> | 3.4 | `feat(worker): run job execution through accept/start/quote/complete` | `WorkerTaskCubit` theo `bookingId`; Chi tiết việc → Nhận việc; Đã đến → Bắt đầu; Đang làm → Báo giá phát sinh + Hoàn thành (`actualPrice`); route truyền `?id=`; test |
>
> Lỗ hổng đã biết: `/ws/dispatch` (ping việc mới) chưa có định dạng message; không có API từ chối việc / bật-tắt Online; WebSocket tracking trong doc là JSON thuần, không phải STOMP như CLAUDE.md ghi.

Nhận việc (accept), bắt đầu (start), gửi báo giá (quote), hoàn thành (complete). Stream GPS
`geolocator` → `PUT /technician/location` mỗi 2s, chỉ khi online, gói trong `LocationTrackingBloc`.

> **Kết quả Pha 3 (2026-10-10):**
> - GPS: Online → lấy vị trí liên tục, gửi bản mới nhất `PUT /technician/location` mỗi 2 giây; Offline/đăng xuất → dừng. Bật/tắt Online chỉ ở app (chưa có API).
> - Việc mới: Dashboard hiện đơn PENDING đầu tiên từ `GET /bookings` (chưa có định dạng `/ws/dispatch`); "Từ chối" chỉ ẩn trên máy.
> - Jobs Hub: Mới phân công (PENDING/ACCEPTED) · Đang làm (IN_PROGRESS) · Đã hoàn tất; nút bước tiếp theo theo trạng thái.
> - Thực hiện: Nhận việc (`accept`) → Đang đến (bản đồ còn mock) → Bắt đầu (`start`) → Báo giá phát sinh (`quote`, 1 dòng, chưa có ảnh vì thiếu API upload) → Hoàn tất với giá chốt (`complete`, ≤ 1,5 × ước tính).
> - Còn mock: bản đồ/dẫn đường, checklist các bước, màn quyết toán sau hoàn tất (thu nhập/phí), thu nhập trên Dashboard, lịch tuần.

**Pha 4 — Ví & rút tiền**
Wallet balance + transactions (phân trang, filter `type`/`status`), tạo/list yêu cầu rút.
Money hiển thị qua formatter.

**Pha 5 — Thông báo, Chat, VoIP**
Notifications (manual load-more, không có metadata phân trang) + settings. Chat: tạo/lấy room
theo booking, lịch sử tin nhắn, gửi tin, realtime qua WS `/ws/chat/{roomId}` (mở/đóng theo BLoC).
VoIP chỉ ghi log cuộc gọi.

## 5. Kiểm thử & xác minh mỗi pha

- `flutter analyze` sạch, unit test datasource/repository, `bloc_test` cho mọi transition.
- Smoke test thật trên UAT bằng tài khoản test (khách + thợ) do team backend cấp.
- Cập nhật `CHANGELOG.md` cuối mỗi pha.

## 6. Lỗ hổng contract cần backend xác nhận (chặn một số màn)

| # | Vấn đề | Ảnh hưởng |
| :- | :--- | :--- |
| 1 | `openapi.json` là YAML và hỏng cú pháp (path key xuống dòng, `responses` dính dòng) | Không generate/validate được |
| 2 | **Không có `GET /bookings/{id}`** | Order detail, tracking, task worker phải lấy từ list |
| 3 | Không có OTP, quên/đặt lại/đổi mật khẩu, xoá tài khoản | Các màn auth tương ứng giữ mock |
| 4 | **Không có endpoint upload file** (avatar, CCCD KYC, ảnh báo giá/bằng chứng, media chat) | KYC, báo giá, chat ảnh |
| 5 | Không có online/offline toggle và **decline** việc cho thợ, không có danh sách việc được dispatch | worker_dashboard, worker_dispatch |
| 6 | `LocationUpdateRequest.technicianId` là **UUID** trong khi user id là int64 | Không biết gửi giá trị nào |
| 7 | Không có khởi tạo thanh toán VNPay/ZaloPay (chỉ `deposit` với `gatewayTxId` có sẵn) | PaymentGatewayPage |
| 8 | Không có GET báo giá, đánh giá/rating, danh sách phòng chat | Order detail, review |
| 9 | Enum trạng thái booking không có trong OpenAPI (chỉ có ở `11-appendices.md`: PENDING/ACCEPTED/IN_PROGRESS/COMPLETED/CANCELLED/DISPUTE/DISPATCH_FAILED), không có trạng thái "đang đến/đã đến" | Mapping tab đơn hàng / chip trạng thái, màn En Route/Arrived |
| 10 | `GET /service-categories` yêu cầu JWT → khách chưa đăng nhập không xem được danh mục | Onboarding/Home guest |
| 11 | Thiếu field bắt buộc trả **500 HS-500-0001** thay vì 400: `POST /auth/login` body rỗng; `POST /auth/register` thiếu `email` (2026-10-07). OpenAPI cũng không đánh dấu `required` cho `RegisterRequest` dù doc module ghi tất cả bắt buộc | Bug backend (đã probe UAT) — app đã gửi đủ field |
| 12 | Không có PIN ví cho rút tiền, không lưu tài khoản ngân hàng | WorkerWithdrawPinPage, WorkerWithdrawPage |
| 13 | `POST /bookings/{id}/cancel` và `/dispute` **không nhận body** (lý do, ảnh) | Customer Cancellation, Dispute Report — đã ẩn phần nhập lý do/ảnh |
| 23 | `POST /bookings` 201: OpenAPI nói không bọc envelope, doc nói `ApiResponse<BookingResponse>`; state machine nói khiếu nại từ IN_PROGRESS nhưng ghi chú nói chỉ khi COMPLETED | App chấp nhận cả hai dạng response; cho khiếu nại khi COMPLETED |
| 24 | Không có API khuyến mãi, phụ phí loại nhà, gói/add-on, voucher, chọn phương thức thanh toán khi đặt lịch | Các phần này đã ẩn khỏi Home/Đặt lịch |
| 14 | Không có API thợ huỷ đơn / báo khách vắng mặt | Worker Cancellation, Customer No-show |
| 15 | Không có API lịch làm việc, vùng làm việc, kỹ năng, chứng chỉ | Worker Schedule/Availability/Zone/Skills/Upload Cert |
| 16 | Không có API thanh toán đơn, nghiệm thu, hoá đơn, đánh giá & tip | Checkout (Inspection, Payment, Receipt, Review) |
| 17 | Không có API tạo yêu cầu bảo hành | 5 màn Warranty |
| 18 | Chỉ 1 `defaultAddress`, không có danh sách địa chỉ; không có phương thức thanh toán / liên kết ví | My Addresses, Payment Methods, Link Wallet |
| 20 | `user.id`: OpenAPI ghi int64, doc module ví dụ `"uuid"` | App parse được cả hai (lưu dạng chuỗi) — cần backend chốt một kiểu |
| 21 | `PUT /profiles`: doc module lồng địa chỉ trong `userProfile: {defaultAddress, lat, lng}`, OpenAPI để phẳng; doc không có `phoneNumber/email` nhưng OpenAPI có | App gửi theo OpenAPI (phẳng) — cần backend xác nhận |
| 22 | `/auth/refresh`: doc trả cả `refreshToken` mới, OpenAPI chỉ `accessToken` | App lưu refresh mới nếu có, không thì giữ cái cũ |
| 19 | `voip/calls/end` bắt buộc `recordingUrl` nhưng app không tự ghi âm | VoIP Call |
