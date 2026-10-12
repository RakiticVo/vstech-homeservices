# Ghi chú cần biết — chỗ đang làm tạm ở app & API còn thiếu

> Cập nhật: 2026-10-10 (sau Pha 4). Tổng hợp từ `API_INTEGRATION_PLAN.md` §6 và các commit Pha 0–3.
> Mục đích: (1) biết app đang **giả lập / lưu tạm trên máy** ở đâu, (2) có danh sách gửi team backend.

---

## 1. Việc bạn cần làm / quyết định

| # | Việc | Vì sao |
| :- | :--- | :--- |
| 1 | Xin **2 tài khoản test UAT** (1 khách, 1 thợ) — ghi vào `.env.development` ở thư mục gốc (gitignore, mẫu ở `.env.development.example`) | Pha 1–3 mới chạy bằng test giả lập, chưa đăng nhập/đặt lịch/nhận việc thật trên UAT |
| 2 | Cấu hình **Firebase** (`android/app/google-services.json`, `ios/Runner/GoogleService-Info.plist`) | Cần cho đăng ký FCM (`/devices/*`) và Crashlytics — đang hoãn |
| 3 | Đặt **git identity** trên máy: `git config --global user.name/user.email` | Máy đã mất identity; mình đang commit bằng identity cũ `Admin <admin@Admins-MacBook-Pro.local>` |
| 4 | Thiết kế **Claude Design Batch 14–17** (`docs/design/prompts/CLAUDE_DESIGN_PROMPTS_API_GAPS.md`) | UI báo giá chi tiết, nạp tiền ví, đọc tất cả thông báo/cài đặt thông báo thợ, lịch sử cuộc gọi |
| 5 | Xác nhận với BA: **nạp tiền là ví nào** (Batch 15 đang giả định ví thợ) | `POST /wallets/payments/deposit` chưa rõ đối tượng |
| 6 | Bản dịch tiếng Anh cho câu xin quyền vị trí iOS (`NSLocationWhenInUseUsageDescription`) | Hiện chỉ có tiếng Việt trong `Info.plist` |
| 7 | Gửi mục 2–4 dưới đây cho team backend | Các chỗ app đang làm tạm sẽ gỡ khi có API |
| 8 | Xin **URL backend production** (và Google Maps key production) — điền vào `.env.production` | Chưa có thì app production rơi về UAT (có log cảnh báo) |

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
| L16 | **Ngôn ngữ** (vi/en) | Chỉ đổi trên máy, không lưu vào hồ sơ | Đã có field `locale` trong `PUT /profiles` — **chưa nối** (tính năng, không cần API mới) | `language_toggle_button.dart` |

---

## 3. Màn hình vẫn là dữ liệu mẫu (chưa có API)

| Nhóm | Màn |
| :--- | :--- |
| Khách | Theo dõi thợ (bản đồ), Tìm thợ (radar), Nghiệm thu, Thanh toán đơn (VNPay/ZaloPay), Hoá đơn, Đánh giá & tip, Bảo hành (5 màn), Gợi ý AI / Trợ lý AI, Thợ yêu thích, Hồ sơ thợ (xem trước), Phương thức thanh toán / Liên kết ví, Danh sách & chi tiết khiếu nại, Thiết bị trong nhà |
| Thợ | Bản đồ & dẫn đường, checklist các bước làm, màn quyết toán sau hoàn tất (thu nhập/phí), thẻ thu nhập trên Dashboard, lịch tuần, khung giờ sẵn sàng, vùng làm việc, kỹ năng & chứng chỉ, hiệu suất, KYC (thiếu upload), Huỷ việc / Khách vắng mặt |
| Chung | Gọi VoIP (âm thanh — xem Pha 5.6) |

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
| C9 | WebSocket: CLAUDE.md ghi STOMP, doc (`07-chat`, `09-location-tracking`, `11-appendices`) là JSON thuần, "không dùng subprotocol" | **Đã chốt theo doc (Pha 5):** `RealtimeSocket` gửi/nhận JSON thuần qua `web_socket_channel`, token ở header `Authorization`. `stomp_dart_client` hiện không còn dùng — nên sửa CLAUDE.md và gỡ package nếu backend xác nhận |
| C12 | `POST /chat/rooms`: OpenAPI trả 201 không có schema; doc trả 200 + `ApiResponse<ChatRoomResponse>` | Đọc theo doc |
| C13 | Lịch sử chat: doc mặc định `size=50`, OpenAPI `size=20`; không ghi thứ tự tin | App gửi `size=50`, tự sắp cũ → mới theo `sentAt` |
| C11 | Ví: doc dùng `id`/`type` (giao dịch) và `id`/`reason` (rút tiền), OpenAPI dùng `transactionId`/`txType` và `requestId`/`rejectionReason` | Đọc được cả hai |
| C10 | `technicianId` trong `PUT /technician/location`: UUID nhưng server bỏ qua | Không gửi field này |

---

## 5. Lỗi backend đã thấy trên UAT

| # | Lỗi | Kỳ vọng |
| :- | :--- | :--- |
| B1 | `POST /auth/login` body rỗng → **500 `HS-500-0001`** | 400 `HS-400-0001` |
| B2 | `POST /auth/register` thiếu `email` → **500 `HS-500-0001`** (2026-10-07) | 400 `HS-400-0001` |
| B3 | `GET /service-categories` bắt buộc JWT | Khách chưa đăng nhập không xem được danh mục — cần xác nhận có chủ ý không |
