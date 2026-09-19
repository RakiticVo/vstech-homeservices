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

| Module MVP | File tài liệu | Tính năng chính |
|---|---|---|
| Auth, Profile | `01-auth-profiles.md` | Đăng ký, đăng nhập, refresh token, quản lý hồ sơ |
| Booking, Quote | `02-bookings.md` | Đặt lịch, trạng thái, báo giá, idempotency |
| Categories, Dispatch | `03-categories-dispatch.md` | Danh mục dịch vụ, phân công thợ |
| Assets, Warranty | `04-assets-warranty.md` | Quản lý tài sản, bảo hành |
| Wallet, Payments | `05-wallet-payments.md` | Ví tiền, giao dịch, nạp tiền |
| Withdrawals | `06-withdrawals.md` | Rút tiền (worker/admin) |
| Chat | `07-chat.md` | Tin nhắn REST + WebSocket real-time |
| Notifications | `08-notifications.md` | Thông báo + FCM (trạng thái thật) |
| Location Tracking | `09-location-tracking.md` | GPS worker, theo dõi khách hàng |
| VoIP | `10-voip.md` | Cuộc gọi voice |

## Checklist bắt đầu dev

### Thiết lập môi trường
- [ ] Clone repo, cài đặt Flutter SDK phiên bản mới nhất
- [ ] Chạy `flutter pub get` trong `mobile_app/`
- [ ] Kết nối Firebase (flutterfire configure)
- [ ] Cấu hình base URL (dev/test/prod) — KHÔNG hardcode

### Kiến trúc ứng dụng
- [ ] Chọn state management (Riverpod hoặc Bloc)
- [ ] Thiết lập dependency injection (get_it hoặc provider)
- [ ] Tạo `api_client.dart` parse `ApiResponse<T>`
- [ ] Tạo model classes từ DTO (sử dụng freezed + json_serializable)

### Bảo mật
- [ ] Cài đặt `flutter_secure_storage` cho token
- [ ] Implement auth flow (login → refresh → logout)
- [ ] Xử lý mock auth CHỈ ở môi trường dev/test

### Tích hợp backend
- [ ] Đọc kỹ `00-foundation.md` để hiểu error codes và response format
- [ ] Implement WebSocket chat theo `07-chat.md`
- [ ] Implement location tracking theo `09-location-tracking.md`
- [ ] Xử lý FCM push notification (xác nhận với PM về trạng thái backend)

### Kiểm thử
- [ ] Viết unit test cho API client và models
- [ ] Viết integration test cho luồng quan trọng (auth, booking)
- [ ] Test trên cả iOS và Android

## Lưu ý quan trọng
1. **Backend chưa hỗ trợ FCM:** Notification chỉ persist trong database, mobile tự xử lý Firebase client-side.
2. **Mock auth:** CHỈ dùng ở dev/test (`Bearer mock-token-<role>-<id>`), production bắt buộc JWT thật.
3. **Chat roomId:** cả REST (`/api/v1/chat/rooms/{roomId}/messages`) và WebSocket (`/ws/chat/{roomId}`) đều dùng **Long** (số). Lưu một `roomId` duy nhất, dùng cho cả hai kênh — không cần mapping/convert.
4. **Endpoint profiles:** Path là `/profiles` KHÔNG phải `/users`.
5. **Wallet payments:** Không tồn tại endpoint `POST /payments`, chỉ có `/deposit` và `/withdraw`.

## Tài liệu liên quan
- [Backend API Contracts](../references/api-contracts.md)
- [Client API Reference](../references/client-api-reference.md)
- [User Action → API Map](../references/user-action-api-map.md)
- [Mobile Dev Rules](../rules/MOBILE_DEV_RULES.md)
- [AGENTS.md](../../AGENTS.md)