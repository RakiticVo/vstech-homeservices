# Tài liệu Mobile Developer — HomeService

## Mục đích
Bộ tài liệu này cung cấp thông tin kỹ thuật đầy đủ để mobile developer Flutter bắt đầu phát triển ứng dụng di động cho dự án HomeService. Tài liệu dựa trên backend Quarkus đã hoàn thành MVP Epic 1-8.

## Đối tượng
- Mobile developer Flutter (có thể chưa quen backend Quarkus)
- Các agent hỗ trợ phát triển (AI agent)

## Cách đọc
1. **Bắt đầu:** Đọc `00-foundation.md` để hiểu quy ước chung (ApiResponse, error codes, auth flow, enums).
2. **Theo module:** Đọc các file theo từng domain tính năng (01-10).
3. **Tra cứu:** Sử dụng `11-appendices.md` cho thông tin tham khảo nhanh.

## Map module MVP → Tài liệu

| Module MVP | File tài liệu | Tính năng chính | Ghi chú |
|---|---|---|---|
| Auth, Profile | `01-auth-profiles.md` | Đăng ký, đăng nhập, refresh token, quản lý hồ sơ | Core MVP |
| Booking, Quote | `02-bookings.md` | Đặt lịch, trạng thái, báo giá, idempotency | Core MVP |
| Categories, Dispatch | `03-categories-dispatch.md` | Danh mục dịch vụ, phân công thợ | Core MVP |
| Assets, Warranty | *(04-assets-warranty)* | Quản lý tài sản, bảo hành | **Post-MVP** (Chưa dùng trong Phase 1) |
| Wallet, Payments | `05-wallet-payments.md` | Ví tiền, giao dịch, nạp tiền | Core MVP |
| Withdrawals | `06-withdrawals.md` | Rút tiền (worker/admin) | Core MVP |
| Chat | `07-chat.md` | Tin nhắn REST + WebSocket real-time | Core MVP |
| Notifications | `08-notifications.md` | Thông báo + FCM (trạng thái thật) | Core MVP |
| Location Tracking | `09-location-tracking.md` | GPS worker, theo dõi khách hàng | Core MVP |
| VoIP | `10-voip.md` | Cuộc gọi voice | Core MVP |

## Checklist bắt đầu dev

### Thiết lập môi trường
- [x] Cài đặt Flutter SDK (≥ 3.22, Dart ≥ 3.0)
- [x] Chạy `flutter pub get` tại thư mục gốc của repository
- [ ] Kết nối Firebase (`firebase_core`, `firebase_messaging`, `firebase_crashlytics`)
- [ ] Cấu hình base URL (dev/test/prod) trong `ApiClient` — KHÔNG hardcode

### Kiến trúc ứng dụng (Locked Stack)
- [x] State management: **flutter_bloc / Cubit**
- [x] Dependency injection: **get_it + injectable**
- [x] HTTP Client: **Dio** + Interceptor parse `ApiResponse<T>` ([`lib/core/network/api_client.dart`](../../lib/core/network/api_client.dart))
- [ ] DTO Models: sinh mã với **freezed + json_serializable** (Request & Response tách biệt)

### Bảo mật & Lưu trữ
- [x] Cài đặt `flutter_secure_storage` cho Token ([`lib/core/network/auth_token_store.dart`](../../lib/core/network/auth_token_store.dart))
- [ ] Implement luồng Auth (login → refresh token transparent → logout / redirect)
- [ ] Mock auth CHỈ dùng ở môi trường dev/test (`Bearer mock-token-<role>-<id>`)

### Tích hợp backend
- [x] Đọc kỹ `00-foundation.md` để hiểu error codes (`HS-XXX-XXXX`) và response envelope
- [ ] Implement WebSocket STOMP chat theo `07-chat.md`
- [ ] Implement location tracking GPS theo `09-location-tracking.md`
- [ ] Xử lý FCM push notification client-side

### Kiểm thử
- [ ] Viết unit test cho API datasource, repositories và usecases
- [ ] Viết BLoC test với `bloc_test` cho các chuyển đổi trạng thái
- [ ] Test trên cả thiết bị iOS và Android

## Lưu ý quan trọng
1. **Backend chưa hỗ trợ FCM:** Notification chỉ persist trong database, mobile tự xử lý Firebase client-side.
2. **Mock auth:** CHỈ dùng ở dev/test (`Bearer mock-token-<role>-<id>`), production bắt buộc JWT thật.
3. **Chat roomId:** cả REST (`/api/v1/chat/rooms/{roomId}/messages`) và WebSocket (`/ws/chat/{roomId}`) đều dùng **Long** (số). Lưu một `roomId` duy nhất, dùng cho cả hai kênh — không cần mapping/convert.
4. **Endpoint profiles:** Path là `/profiles` KHÔNG phải `/users`.
5. **Wallet payments:** Không tồn tại endpoint `POST /payments`, chỉ có `/deposit` và `/withdraw`.

## Tài liệu quy chuẩn liên quan
- [AGENTS.md](../../AGENTS.md) — Quy tắc kiến trúc & kỹ thuật tối cao cho mọi AI Agent & Dev
- [CLAUDE.md](../../CLAUDE.md) — Quy tắc dành riêng cho Claude
- [PHASE1_SCOPE.md](../PHASE1_SCOPE.md) — Phạm vi tính năng Phase 1 MVP
- [PRD.md](../PRD.md) — Product Requirements Document V2.3
- [MASTER_SPEC_V9.md](../../docs/design/MASTER_SPEC_V9.md) — Quy chuẩn thiết kế Eco-Clean Sanctuary v9.0