# Ghi chú cần biết — chỗ đang làm tạm ở app & API còn thiếu

> Cập nhật: 2026-10-12 (sau Pha 5 — thông báo, chat, VoIP). Tổng hợp từ `API_INTEGRATION_PLAN.md` §6 và các commit Pha 0–5.
> Mục đích: (1) biết app đang **giả lập / lưu tạm trên máy** ở đâu, (2) có danh sách gửi team backend.

---

## 0. Tóm tắt nhanh — đọc phần này trước

- **Đã nối API:** đăng nhập/đăng ký/hồ sơ, danh mục, đặt lịch + đơn hàng, luồng thợ (nhận/bắt đầu/báo giá/hoàn thành, GPS 2s), ví + rút tiền, thông báo + cài đặt, chat realtime, nhật ký cuộc gọi.
- **Chưa thử trên UAT thật** — mới chạy bằng test (351 test xanh). Đang chờ tài khoản test (việc #1).
- **Đang giả lập:** OTP (`123456`), PIN rút tiền, bật/tắt Online, **âm thanh cuộc gọi** (chỉ ghi nhật ký) — chi tiết ở mục 2.
- **Realtime:** WebSocket là **JSON thuần, không STOMP** (đã chốt theo doc, CLAUDE.md đã sửa, đã gỡ `stomp_dart_client`).
- **Biến môi trường:** `.env.development` / `.env.production` ở thư mục gốc (không lên git), chạy bằng `flutter run --dart-define-from-file=.env.development`.

---

## 1. Việc bạn cần làm / quyết định

**Đang chờ (bạn đã biết, làm sau):**

| # | Việc | Ghi chú |
| :- | :--- | :--- |
| 1 | **Tài khoản test UAT** (1 khách, 1 thợ) → điền `.env.development` (`TEST_CUSTOMER_*`, `TEST_WORKER_*`) | Chưa đăng ký được — chờ. Khi có, chạy thử đầu-cuối các Pha 1–5 trên UAT |
| 2 | **Gửi backend mục 2, 4, 5** dưới đây | Không bắt buộc để app chạy (app đã có cách làm tạm), nhưng nên gửi: L26 (`senderId` cùng loại id với hồ sơ — sai thì tin của mình hiện như của bên kia), C14 (`recordingUrl` bắt buộc — sai thì server từ chối ghi kết thúc cuộc gọi), L12 (khách chưa đọc được báo giá), L22, L24, C2. Kiểm chứng được ngay khi có tài khoản test |
| 3 | **URL backend production** (+ Google Maps key production) → `.env.production` | Chỉ cần trước khi phát hành bản production; dev/UAT không cần |
| 4 | **Nạp tiền vào ví nào** (Batch 15 đang giả định ví thợ) | Bạn sẽ hỏi BA sau. Chưa làm `POST /wallets/payments/deposit` |
| 5 | **Firebase** (`google-services.json`, `GoogleService-Info.plist`) | Bạn tạo sau. Cần cho FCM / push / Crashlytics; backend cũng chưa gửi push |
| 6 | **Claude Design Batch 14–15** — prompt đã cập nhật ở `docs/design/prompts/CLAUDE_DESIGN_PROMPTS_API_GAPS.md` | Dán *Khối ngữ cảnh chung* + prompt từng batch, mỗi batch 1 phiên. Batch 16–17 đã làm, bỏ qua |
| 7 | **VoIP tự dựng server** — gửi mình tài liệu khi có | App cần từ phía bạn: (a) signaling (gợi ý: thêm sự kiện gọi/nhận/huỷ vào WebSocket JSON sẵn có), (b) STUN/TURN (coturn) nếu dùng WebRTC hoặc SIP server (Asterisk/FreeSWITCH), (c) API cấp token/credential, (d) **báo cuộc gọi đến** khi app đóng (iOS PushKit/CallKit, Android FCM high-priority — cần Firebase), (e) URL file ghi âm nếu muốn lưu `recordingUrl`. App sẽ dùng `flutter_webrtc` (hoặc SIP client) + `flutter_callkit_incoming`; phần nhật ký `/voip/calls` hiện có giữ nguyên |
| 8 | **Git identity** (tuỳ chọn): `git config --global user.name "Tên bạn"` + `user.email` | Chỉ để commit ghi đúng tên/email của bạn (hiện ghi `Admin <admin@Admins-MacBook-Pro.local>`). Không ảnh hưởng code |
| 9 | Cài **CocoaPods** nếu muốn build iOS trên máy này (`brew install cocoapods`) | Máy hiện build iOS báo thiếu CocoaPods |

**Đã chốt:**

| Việc | Quyết định |
| :--- | :--- |
| Bản production thiếu `API_BASE_URL` | **Giữ: rơi về UAT + log cảnh báo** (không dừng app) |
| Câu xin quyền vị trí iOS tiếng Anh | ✅ Đã làm: `ios/Runner/en.lproj` + `vi.lproj/InfoPlist.strings`, `CFBundleLocalizations` = vi, en |
| WebSocket STOMP hay JSON | ✅ JSON thuần (C9) |

---

## 2. Chỗ app đang làm tạm ở local — **đáng lẽ phải có API**

| # | Tính năng | App đang làm gì (tạm) | Cần API gì | Ở đâu trong code |
| :- | :--- | :--- | :--- | :--- |
| L1 | **OTP** đăng ký / đăng nhập / quên mật khẩu | Màn OTP **giả lập**, mã demo `123456`. Tài khoản đã đăng nhập (token đã lưu) **trước** khi qua OTP — tắt app ở màn OTP thì lần sau vào thẳng app | Gửi OTP + xác thực OTP (rồi mới cấp token) | `otp_verification_page.dart`, `login_page.dart`, `register_page.dart` |
| L2 | **Quên / đặt lại / đổi mật khẩu, xoá tài khoản** | Màn mock, không gọi API | Forgot / reset / change password, delete account | `forgot_password_page.dart`, `reset_password_page.dart`, `change_password_page.dart`, `delete_account_page.dart` |
| L3 | **Ghi nhớ đăng nhập** | Lưu **SĐT + mật khẩu** trong Keychain/Keystore (`flutter_secure_storage`) theo vai trò | Không bắt buộc API — nhưng nên chuyển sang đăng nhập sinh trắc học / refresh token dài hạn để **không phải giữ mật khẩu** | `secure_credentials_repository.dart` |
| L4 | **Thợ Online/Offline** | Chỉ là trạng thái trên máy; Online thì gửi GPS mỗi 2 s | Endpoint đặt trạng thái sẵn sàng (AVAILABLE/BUSY/OFFLINE) — hoặc xác nhận dùng field `status` của WebSocket `/ws/tracking` | `worker_presence_cubit.dart` |
| L5 | **Việc mới cho thợ** | Lấy đơn **PENDING** đầu tiên từ `GET /bookings` khi mở Dashboard (không realtime) | Định dạng message của **`/ws/dispatch`** (ping việc mới) hoặc API danh sách việc được phân cho thợ | `worker_dashboard_page.dart` |
| L6 | **Từ chối việc** | Chỉ **ẩn thẻ trên máy** đó | `POST /bookings/{id}/decline` (hoặc tương đương) | `worker_dashboard_page.dart` |
| L7 | **Chi tiết 1 đơn** | Đọc từ cache; nếu chưa có thì **dò tối đa 5 trang** `GET /bookings` — đơn cũ hơn sẽ báo không tìm thấy | `GET /bookings/{id}` | `get_booking_use_case.dart` |
| L8 | **Ghi chú cho thợ** khi đặt lịch | Nối vào cuối `description` | Field `notes` riêng trong `CreateBookingRequest` | `booking_draft.dart` |
| L9 | **Tìm kiếm dịch vụ** | Lọc trên máy sau khi tải toàn bộ danh mục | Tham số `q`/`search` cho `GET /service-categories` (nếu danh mục nhiều) | `categories_page.dart` |
| L10 | **Sổ địa chỉ** | Chỉ lưu được **1 địa chỉ mặc định** (`defaultAddress`); nhãn, loại nhà, tầng, thang máy, ghi chú chỉ nằm trên màn hình | CRUD danh sách địa chỉ | `edit_address_page.dart`, `my_addresses_page.dart` (mock) |
| L11 | **Ảnh** (avatar, CCCD/KYC, ảnh báo giá & hoá đơn, ảnh khiếu nại, ảnh chat) | Nút "Đổi ảnh" chưa làm gì; báo giá **không có ảnh**; khiếu nại **bỏ phần ảnh** | **API upload file** trả URL | nhiều màn |
| L12 | **Báo giá phát sinh** | Mỗi lần gửi **1 dòng**, không ảnh; khách chưa có màn duyệt (đã có use case approve/reject) | Upload ảnh + `GET` báo giá của đơn (để khách xem) | `worker_executing_page.dart`, `quote_decision_use_case.dart` |
| L13 | **Huỷ đơn / khiếu nại** | Màn xác nhận, **không gửi lý do / loại vấn đề / ảnh** (đã ẩn các ô này) | Cho `cancel` / `dispute` nhận body (lý do, mô tả, ảnh) | `customer_cancellation_page.dart`, `dispute_report_page.dart` |
| L14 | **Đặt lịch**: gói, add-on, phụ phí loại nhà, voucher, chọn phương thức thanh toán | **Đã ẩn** — giá chỉ lấy từ `POST /bookings/estimate` | API nếu sản phẩm cần các lựa chọn này | `booking_step1..3` |
| L15 | **Khuyến mãi trên Home** | **Đã ẩn** | API khuyến mãi | `customer_home_page.dart` |
| L17 | **PIN ví** khi rút tiền | Màn PIN **giả lập** — 6 số bất kỳ đều qua, rồi mới gửi yêu cầu rút | API đặt / xác thực PIN ví (hoặc OTP rút tiền) | `worker_withdraw_pin_page.dart` |
| L18 | **Tài khoản ngân hàng nhận tiền** | Thợ **nhập tay** mã ngân hàng + số tài khoản mỗi lần rút (bỏ thẻ ngân hàng viết cứng) | API lưu / lấy tài khoản ngân hàng (hoặc lấy từ hồ sơ KYC) + danh sách mã ngân hàng | `worker_withdraw_page.dart` |
| L19 | **Mức rút tối thiểu 100.000đ** | Quy tắc **của app** (theo thiết kế) — API không ghi giới hạn này | Backend xác nhận có giới hạn tối thiểu không | `withdraw_cubit.dart` |
| L20 | **Tổng thu nhập / đã rút**, phí & thực nhận của từng giao dịch | **Đã bỏ** khỏi màn Ví / Chi tiết giao dịch | API tổng hợp ví + chi tiết phí của giao dịch | `worker_wallet_page.dart`, `worker_transaction_detail_page.dart` |
| L21 | **Chi tiết 1 giao dịch / 1 yêu cầu rút** | Đọc cache; không có thì dò tối đa 3 trang | `GET /wallets/me/transactions/{id}`, `GET /wallets/withdrawals/{id}` | `wallet_use_cases.dart` |
| L22 | **Thông báo đặt lịch → mở đơn** | Thông báo không có mã đơn, nên chạm vào chỉ mở danh sách đơn (khách) / danh sách việc (thợ) | Thêm `bookingId` (hoặc `deepLink`) vào `NotificationResponse` | `notifications_page.dart` |
| L23 | **Thông báo "còn nữa"** | API trả mảng trơn, app coi là còn khi trang đủ 20 mục (chat: đủ 50 tin) | Trả `hasMore`/`totalPages` như `PagedResponse` | `notification_repository_impl.dart`, `chat_repository_impl.dart` |
| L24 | **Tên / ảnh người bên kia trong chat** | Tiêu đề chat chỉ ghi vai trò ("Thợ phụ trách" / "Khách hàng") + mã đơn | Thêm tên, ảnh của khách / thợ vào `ChatRoomResponse` (hoặc `BookingResponse`) | `chat_page.dart` |
| L25 | **Ảnh / vị trí trong chat** | Đã bỏ nút gửi ảnh, vị trí; chỉ gửi chữ | Endpoint upload file để có `mediaUrls` | `chat_input_bar.dart` |
| L26 | **Tin của mình trong chat** | So `senderId` với `id` hồ sơ (`GET /profiles`) | Xác nhận `senderId` cùng loại id với hồ sơ (int64 vs UUID — xem C2) | `chat_cubit.dart` |
| L27 | **Âm thanh cuộc gọi VoIP** | Màn gọi chỉ **ghi nhật ký** (`POST /voip/calls` → `/end` kèm số giây), có ghi chú "Bản thử" — không có âm thanh, không đổ chuông máy bên kia | Chọn SDK/nhà cung cấp VoIP (Stringee, Twilio, Agora…) + API cấp token / signaling | `voip_call_cubit.dart`, `voip_call_page.dart` |
| L28 | **Cuộc gọi đến** | Đã bỏ màn "Cuộc gọi đến" — không có kênh nào báo cho máy nhận | Push (FCM — backend chưa gửi) hoặc WebSocket báo cuộc gọi đến | `voip_call_page.dart` |
| L16 | **Ngôn ngữ** (vi/en) | Chỉ đổi trên máy, không lưu vào hồ sơ | Đã có field `locale` trong `PUT /profiles` — **chưa nối** (tính năng, không cần API mới) | `language_toggle_button.dart` |

---

## 3. Màn hình vẫn là dữ liệu mẫu (chưa có API)

| Nhóm | Màn |
| :--- | :--- |
| Khách | Theo dõi thợ (bản đồ), Tìm thợ (radar), Nghiệm thu, Thanh toán đơn (VNPay/ZaloPay), Hoá đơn, Đánh giá & tip, Bảo hành (5 màn), Gợi ý AI / Trợ lý AI, Thợ yêu thích, Hồ sơ thợ (xem trước), Phương thức thanh toán / Liên kết ví, Danh sách & chi tiết khiếu nại, Thiết bị trong nhà |
| Thợ | Bản đồ & dẫn đường, checklist các bước làm, màn quyết toán sau hoàn tất (thu nhập/phí), thẻ thu nhập trên Dashboard, lịch tuần, khung giờ sẵn sàng, vùng làm việc, kỹ năng & chứng chỉ, hiệu suất, KYC (thiếu upload), Huỷ việc / Khách vắng mặt |
| Chung | Gọi VoIP: chỉ ghi nhật ký, chưa có âm thanh (L27) |

---

## 4. Tài liệu API mâu thuẫn — app đang xử lý cả hai, cần backend chốt

| # | Chỗ mâu thuẫn | App đang làm |
| :- | :--- | :--- |
| C1 | `openapi.json` thực chất là YAML và hỏng cú pháp | Dùng bản sửa `docs/api/openapi.yaml` |
| C2 | `id`: OpenAPI = int64, doc module = UUID string | Đọc được cả hai, lưu dạng chuỗi |
| C3 | `POST /bookings` 201: OpenAPI không bọc envelope, doc bọc `ApiResponse` | Nhận cả hai dạng |
| C4 | `PUT /profiles`: doc lồng `userProfile:{defaultAddress,lat,lng}`, OpenAPI để phẳng | Gửi theo OpenAPI (phẳng) |
| C5 | `/auth/refresh`: doc trả thêm `refreshToken` mới, OpenAPI không | Lưu refresh mới nếu có |
| C6 | Money: OpenAPI = number, doc = chuỗi số `"200000"` | Nhận cả hai |
| C7 | Khiếu nại: sơ đồ trạng thái cho từ IN_PROGRESS, ghi chú nói chỉ khi COMPLETED | Chỉ cho khi COMPLETED |
| C8 | `RegisterRequest`: OpenAPI không đánh dấu `required`, doc ghi tất cả bắt buộc | Gửi đủ 5 field |
| C9 | WebSocket: CLAUDE.md từng ghi STOMP, doc (`07-chat`, `09-location-tracking`, `11-appendices`) là JSON thuần, "không dùng subprotocol" | ✅ **Đã chốt theo doc:** `RealtimeSocket` JSON thuần qua `web_socket_channel`, token ở header `Authorization`; đã sửa CLAUDE.md / AGENTS.md / skill, đã gỡ `stomp_dart_client`. Chỉ cần backend xác nhận lại khi chạy UAT |
| C12 | `POST /chat/rooms`: OpenAPI trả 201 không có schema; doc trả 200 + `ApiResponse<ChatRoomResponse>` | Đọc theo doc |
| C13 | Lịch sử chat: doc mặc định `size=50`, OpenAPI `size=20`; không ghi thứ tự tin | App gửi `size=50`, tự sắp cũ → mới theo `sentAt` |
| C14 | `EndCallRequest.recordingUrl`: OpenAPI bắt buộc (400 nếu thiếu), doc ghi tuỳ chọn | App không ghi âm nên **không gửi**; nếu server trả 400 thì cuộc gọi vẫn kết thúc trên máy, chỉ ghi log cảnh báo |
| C15 | `POST /voip/calls`: OpenAPI trả 201 không có schema; doc trả `ApiResponse<VoipCallResponse>` có thêm `status` | Đọc theo doc |
| C11 | Ví: doc dùng `id`/`type` (giao dịch) và `id`/`reason` (rút tiền), OpenAPI dùng `transactionId`/`txType` và `requestId`/`rejectionReason` | Đọc được cả hai |
| C10 | `technicianId` trong `PUT /technician/location`: UUID nhưng server bỏ qua | Không gửi field này |

---

## 5. Lỗi backend đã thấy trên UAT

| # | Lỗi | Kỳ vọng |
| :- | :--- | :--- |
| B1 | `POST /auth/login` body rỗng → **500 `HS-500-0001`** | 400 `HS-400-0001` |
| B2 | `POST /auth/register` thiếu `email` → **500 `HS-500-0001`** (2026-10-07) | 400 `HS-400-0001` |
| B3 | `GET /service-categories` bắt buộc JWT | Khách chưa đăng nhập không xem được danh mục — cần xác nhận có chủ ý không |
