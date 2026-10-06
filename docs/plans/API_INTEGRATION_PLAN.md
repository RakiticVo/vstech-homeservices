# Kế hoạch tích hợp API — VSTech Home Services

> Nguồn contract: `docs/api/openapi.json` (thực chất là **YAML** OpenAPI 3.1, file bị lỗi cú pháp —
> xem mục 6) đối chiếu với `docs/reference/api/*.md`.
> Môi trường: **UAT** `https://homeservice-uat.vitinhkimhung.com` (đã probe 2026-10-06: server sống,
> trả đúng envelope `{status, message, errorCode, timestamp}`).

## 1. Hiện trạng

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

**Pha 2 — Luồng khách đặt lịch**
Home/Categories/Service detail ← `service-categories`. Booking step 1–3: estimate → create
(⚠ response 201 **không bọc** `ApiResponse`). Orders tabs ← `GET /bookings?status=`. Huỷ/khiếu nại,
duyệt/từ chối báo giá.

**Pha 3 — Luồng thợ**
Nhận việc (accept), bắt đầu (start), gửi báo giá (quote), hoàn thành (complete). Stream GPS
`geolocator` → `PUT /technician/location` mỗi 2s, chỉ khi online, gói trong `LocationTrackingBloc`.

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
| 9 | Enum trạng thái booking không được định nghĩa trong spec | Mapping tab đơn hàng / chip trạng thái |
| 10 | `GET /service-categories` yêu cầu JWT → khách chưa đăng nhập không xem được danh mục | Onboarding/Home guest |
| 11 | `POST /auth/login` body rỗng trả **500 HS-500-0001** thay vì 400 | Bug backend (đã probe UAT) |
| 12 | Không có PIN ví cho rút tiền | WorkerWithdrawPinPage |
