# CHANGELOG — VSTech Home Services

Tất cả các thay đổi đáng chú ý của dự án sẽ được ghi nhận chi tiết tại file này.
Định dạng dựa trên [Keep a Changelog](https://keepachangelog.com/vi/1.0.0/).

---

## [0.13.0] — 2026-09-28: Batch 13 UI Implementation (Worker Wallet, Withdrawals, Schedule & Operations — Cells 117–128 & Cell 106) — COMPLETE 128-CELL CONCEPT 02 MATRIX 🎉

### Added
- **Giao diện Batch 13 (Hành trình Ví thu nhập Thợ, Rút tiền ngân hàng, Lịch làm việc & Hiệu suất Vận hành):**
  - `WorkerWalletPage` (`/worker/wallet` — Cells 117, 118 `wwallet`): Quản lý ví thu nhập đối tác Thợ, thẻ số dư khả dụng nổi bật (`4.860.000đ`) kèm nút rút tiền nhanh, thẻ tổng kết số liệu tài chính (Tổng thu nhập đã về, Đã rút/đang rút, Khấu trừ, Đang tạm giữ), bộ 4 tab lọc sổ cái giao dịch (Tất cả, Thu nhập, Rút tiền, Tạm giữ), danh sách lịch sử giao dịch trực quan kèm icon phân loại và nhãn trạng thái.
  - `WorkerTransactionDetailPage` (`/worker/wallet/transaction-detail` — Cell 119 `wtx`): Chi tiết bóc tách giao dịch thu nhập và khấu trừ minh bạch: Khách trả, Chi phí phát sinh đã duyệt (+45.000đ), Phí nền tảng 15% trên giá dịch vụ, Thực nhận về ví, mã giao dịch, thời gian và liên kết dẫn thẳng đến đơn hàng liên quan trên Hub cuốc việc.
  - `WorkerWithdrawPage` (`/worker/wallet/withdraw` — Cell 120 `wwd`): Biểu mẫu rút tiền về tài khoản ngân hàng, ô nhập số tiền rút có kiểm tra số dư và hạn mức tối thiểu 100.000đ, 3 chip chọn nhanh số tiền (500k, 1 triệu, Tất cả), thẻ tài khoản ngân hàng thụ hưởng (Vietcombank · CN Tân Bình ••• 4821), bảng tính số dư trước/sau rút và phí rút 0đ (Miễn phí), nút Tiếp tục chuyển tiếp sang bước nhập mã PIN.
  - `WorkerWithdrawPinPage` (`/worker/wallet/withdraw/pin` — Cell 121 `wwdpin`): Màn hình nhập mã PIN bảo mật ví 6 chữ số, 6 chấm chỉ báo trạng thái nhập, bàn phím số tùy biến chuyên dụng với nút xoá lùi backspace, tự động xác thực và điều hướng sang màn hình trạng thái khi nhập đủ 6 số.
  - `WorkerWithdrawStatusPage` (`/worker/wallet/withdraw/status` — Cell 122 `wwdst`): Màn hình trạng thái yêu cầu rút tiền với dòng thời gian (timeline) 3 giai đoạn: Đã gửi yêu cầu -> Chờ kế toán duyệt (trong 24 giờ) -> Đã chuyển khoản; hiển thị số tiền rút đã trừ khỏi số dư khả dụng, ghi chú hoàn tiền nếu bị từ chối và nút CTA quay về ví thu nhập.
  - `WorkerScheduleWeekPage` (`/worker/schedule` — Cell 123 `wcal`): Lịch làm việc tuần (21/04 – 27/04), dải 7 ngày nằm ngang (T2–CN) hiển thị số cuốc việc hoặc nhãn Nghỉ, chọn ngày hiển thị danh sách chi tiết các ca làm việc, hỗ trợ nhãn bảo hành nổi bật màu bạc hà ("BẢO HÀNH 0đ" trên ca ngày 26/04), nút truy cập nhanh vào cài đặt giờ nhận việc & nghỉ đột xuất.
  - `WorkerAvailabilityPage` (`/worker/schedule/availability` — Cell 124 `wavail`): Cài đặt khung giờ nhận việc hàng tuần theo từng thứ (T2–CN) có thể chạm để xoay vòng 3 khung giờ (08:00–18:00 · 07:00–20:00 · 13:00–21:00) hoặc tắt nhận việc; mục Nghỉ đột xuất với dải chip ngày nghỉ (26/04–02/05) kèm hộp cảnh báo nổi bật khi chọn ngày 26/04 có việc bảo hành đã nhận.
  - `WorkerWorkZonePage` (`/worker/profile/zone` — Cell 125 `wzone`): Bản đồ radar thu nhỏ minh họa bán kính hoạt động, bộ chọn 4 nấc bán kính hoạt động (3 km, 5 km, 8 km, 12 km), dải chip đa lựa chọn các quận/huyện nhận việc sẵn sàng (Q1, Q2, Q3, Q7, Bình Thạnh, Phú Nhuận...), nút lưu cài đặt kèm thông báo thành công.
  - `WorkerSkillsPage` (`/worker/profile/skills` — Cell 126 `wskill`): Quản lý 8 kỹ năng dịch vụ nhận làm kèm công tắc bật/tắt, hộp cảnh báo chứng chỉ an toàn trên cao hết hạn tự động gắn nhãn "ẨN" trên các dịch vụ ngoài trời (dàn nóng máy lạnh, ban công, diệt côn trùng ngoài vườn), danh sách thẻ chứng chỉ hành nghề (Hết hạn, Đã duyệt, Chờ duyệt) và nút CTA "+ Tải chứng chỉ mới".
  - `WorkerUploadCertPage` (`/worker/profile/upload-cert` — Cell 127 `wcert`): Biểu mẫu tải chứng chỉ mới xét duyệt trong 48 giờ: chọn loại chứng chỉ (An toàn trên cao, Máy lạnh Daikin, Khác), khung chụp/đính kèm ảnh chứng chỉ tương tác chạm, chọn mốc ngày hết hạn (12/2026, 06/2027, 12/2027), nút gửi duyệt.
  - `WorkerPerformancePage` (`/worker/profile/performance` — Cell 128 `wperf`): Bảng theo dõi hiệu suất hoạt động đối tác: thẻ xếp hạng 4.9★ (128 đánh giá · Hạng Vàng), 4 thanh đo tiến độ chỉ số cốt lõi (Tỉ lệ nhận việc 96%, Tỉ lệ hoàn thành 98%, Check-in đúng giờ 94%, Tỉ lệ bảo hành 2%), lưới huy hiệu đạt được (Đúng giờ 30 ngày, Hoàn thành 100 việc, Khách yêu thích 24 khách, và huy hiệu khóa Không khiếu nại).
  - `WorkerProfilePage` (`/worker/profile` — Cell 106 `wprofile`): Trang hồ sơ đối tác Thợ, thẻ thông tin cá nhân (ảnh đại diện initials, tên, số điện thoại, mã đối tác `#TH-8821`, huy hiệu xác minh), menu điều hướng liên kết toàn diện đến Kỹ năng & chứng chỉ, Khu vực nhận việc, Lịch làm việc, Hiệu suất hoạt động, Tài khoản nhận tiền, bộ chuyển đổi ngôn ngữ VI/EN và nút Đăng xuất kích hoạt hộp thoại xác nhận.
- **Định tuyến (GoRouter):**
  - Khai báo 12 route hằng số trong `lib/core/router/app_routes.dart` và liên kết toàn bộ trong `app_router.dart`.
- **Đa ngôn ngữ (Localization):**
  - Bổ sung hơn 80 translation keys hoàn thiện cho Thợ trong `app_vi.arb` và `app_en.arb` với chuẩn 100% không hardcode.
- **Kiểm thử tự động (Widget Testing):**
  - Bổ sung 2 test suite `worker_wallet_screens_test.dart` (5 tests) và `worker_operations_screens_test.dart` (7 tests) đạt 12/12 tests pass.
  - Toàn bộ test suite dự án đạt **86/86 tests pass** (100% pass rate).
  - `flutter analyze` đạt **0 lỗi, 0 cảnh báo** (Hoàn hảo tuyệt đối).

---

## [0.12.0] — 2026-09-28: Batch 12 UI Implementation (Home Devices, AI Assistant & Account Settings — Cells 101–116)

### Added
- **Giao diện Batch 12 (Hành trình Quản lý Thiết bị Gia đình, Trợ lý AI và Thiết lập Tài khoản Khách hàng):**
  - `MyHomeDevicesPage` (`/home/devices` — Cell 101 `devices`): Quản lý ngôi nhà và thiết bị gia đình, thẻ chọn địa chỉ mặc định kèm nút đổi địa chỉ, 2 tab "Thiết bị ({count})" và "Lịch bảo trì", thẻ cảnh báo quá hạn bảo trì Ariston nổi bật, danh sách thiết bị kèm nhãn trạng thái và ngày bảo trì gần nhất, nút CTA "+ Thêm thiết bị mới".
  - `AiAssistantPage` (`/home/ai-assistant` — Cell 102 `ai-chat`): Trợ lý AI tư vấn và chẩn đoán sự cố 24/7, bong bóng trò chuyện phong cách Eco-Clean Sanctuary v9.0, thanh chip gợi ý ý định nhanh (chi phí dọn nhà, cách vệ sinh máy lạnh, đặt thợ điện, chính sách bảo hành), khung nhập liệu tin nhắn kèm nút gửi trực quan.
  - `AiSuggestionsPage` (`/home/ai-suggestions` — Cell 103 `ai-sug`): Trung tâm đề xuất dịch vụ thông minh của AI dựa trên thời gian sử dụng thiết bị gia đình, đề xuất ưu tiên cao (Bảo trì máy nước nóng 250k) kèm nút "Đặt lịch ngay", danh sách dịch vụ định kỳ gợi ý (Vệ sinh máy lạnh, Giặt rèm - Sofa, Diệt côn trùng).
  - `CustomerProfilePage` (`/customer/profile` — Cell 104 `profile`): Trung tâm hồ sơ khách hàng, thẻ thông tin cá nhân (ảnh đại diện, họ tên, email, liên kết Chỉnh sửa), menu điều hướng phân nhóm rõ ràng (Thông tin cá nhân, Địa chỉ của tôi, Thợ yêu thích, Phương thức thanh toán, Cài đặt thông báo, Cài đặt & bảo mật).
  - `EditProfilePage` (`/customer/edit-profile` — Cell 105 `pedit`): Chỉnh sửa thông tin cá nhân, ảnh đại diện với icon máy ảnh, các ô nhập họ tên, số điện thoại (kèm ghi chú yêu cầu xác thực OTP khi đổi), email, ngày sinh, nút lưu thay đổi hiển thị thanh SnackBar thông báo thành công.
  - `MyAddressesPage` (`/customer/addresses` — Cell 107 `addrs`): Quản lý sổ địa chỉ giao nhận, hiển thị huy hiệu MẶC ĐỊNH, nhãn phân loại (NHÀ, CÔNG TY, KHÁC), chi tiết mặt bằng/thang máy và ghi chú vào nhà, các nút thao tác Sửa, Đặt mặc định, Xoá (khóa xoá với địa chỉ mặc định), nút CTA "Thêm địa chỉ mới".
  - `EditAddressPage` (`/customer/edit-address` — Cell 108 `addred`): Biểu mẫu thêm/sửa địa chỉ chuẩn hóa, chip chọn nhãn (Nhà riêng, Văn phòng, Khác), ô tìm kiếm địa chỉ kèm bản đồ mini ghim vị trí, chọn loại hình nhà ở (Nhà phố, Chung cư), bộ tăng giảm số tầng stepper, công tắc có thang máy và công tắc đặt làm địa chỉ mặc định.
  - `PaymentMethodsPage` (`/customer/payment-methods` — Cell 109 `pms`): Quản lý các phương thức thanh toán, danh sách ví điện tử đã liên kết (VNPay, ZaloPay) kèm số điện thoại che mặt nạ và huy hiệu MẶC ĐỊNH, thao tác Đặt mặc định và Huỷ liên kết (có hộp thoại xác nhận an toàn), thẻ cam kết bảo mật PCI-DSS, nút CTA "Liên kết ví mới".
  - `LinkWalletPage` (`/customer/link-wallet` — Cell 110 `pmsadd`): Quy trình 3 bước liên kết ví điện tử không ma sát: Bước 1 chọn ví (MoMo, ZaloPay, ShopeePay), Bước 2 hướng dẫn xác nhận trừ tiền tự động trên ứng dụng ví, Bước 3 thông báo liên kết thành công kèm nút quay về danh sách ví.
  - `FavouriteProsPage` (`/customer/favourites` — Cell 111 `favs`): Danh sách thợ yêu thích được lưu lại sau các đơn hàng 5 sao, hiển thị số sao, số việc hoàn tất, lần phục vụ gần nhất, nút thả tim/bỏ yêu thích tức thì và nút CTA "Đặt lại thợ này".
  - `WorkerProfilePreviewPage` (`/customer/worker-profile` — Cell 112 `favprof`): Xem trước hồ sơ năng lực chi tiết của thợ, huy hiệu "Kỹ thuật viên đã xác minh", danh sách dịch vụ chuyên môn dạng chip mint, trích dẫn đánh giá thực tế của khách hàng trước, nút CTA "Đặt lịch với thợ này".
  - `CustomerSettingsPage` (`/customer/settings` — Cells 113, 116 `settings`, `profileHistory`): Trung tâm cài đặt & bảo mật với 2 tab: Tab Cài đặt (Đổi ngôn ngữ, Đổi mật khẩu, Phương thức thanh toán, Trung tâm trợ giúp, Về ứng dụng, Xoá tài khoản, Đăng xuất qua Bottom Sheet), Tab Lịch sử (truy cập nhanh toàn bộ đơn hàng).
  - `ChangePasswordPage` (`/customer/change-password` — Cell 114 `chpass`): Màn hình đổi mật khẩu, 3 ô nhập mật khẩu (hiện tại, mới, xác nhận) kèm nút bật/tắt hiển thị mật khẩu, ghi chú quy chuẩn an toàn tối thiểu 8 ký tự, nút CTA xác nhận.
  - `DeleteAccountPage` (`/customer/delete-account` — Cell 115 `delacc`): Màn hình xoá tài khoản tuân thủ quy chuẩn quyền riêng tư, hộp cảnh báo rủi ro màu cam/đỏ, danh sách 4 hậu quả khi xoá tài khoản, bộ radio chọn lý do xoá, nút xác nhận xoá tài khoản (yêu cầu OTP) và nút giữ lại tài khoản.
- **Định tuyến (GoRouter):**
  - Khai báo 14 route hằng số trong `lib/core/router/app_routes.dart` và đăng ký tương ứng trong `app_router.dart`.
- **Đa ngôn ngữ (Localization):**
  - Bổ sung ~60 translation keys cho Batch 12 trong `app_vi.arb` và `app_en.arb` với tỷ lệ tương thích 1:1, không có hardcoded text.
- **Kiểm thử tự động (Widget Testing):**
  - Bổ sung 2 test suite `home_devices_and_ai_screens_test.dart` (5 tests) và `customer_account_and_settings_screens_test.dart` (9 tests) đạt 14/14 tests pass.
  - Toàn bộ test suite dự án đạt **74/74 tests pass** (100% pass rate), `flutter analyze` đạt **0 lỗi, 0 cảnh báo**.

---

## [0.11.0] — 2026-09-28: Batch 11 UI Implementation (In-App Chat & Masked VoIP Calls — Cells 80–84)

### Added
- **Giao diện Batch 11 (Hành trình Trò chuyện & Cuộc gọi ẩn danh bảo vệ số điện thoại):**
  - `ChatPage` (`/messaging/chat` — Cells 80, 81, 84 `chat`): Luồng trò chuyện thời gian thực đồng bộ hai vai trò Khách hàng và Thợ cho đơn hàng `#HS20250425-0012`:
    - Thanh thông báo bảo mật mã hóa số điện thoại: Biểu tượng ổ khóa và dòng cam kết "Số điện thoại của hai bên được ẩn" nền xanh bạc hà mint (`AppColors.secondarySurface`) sắc nét.
    - Bộ lọc mặt nạ số điện thoại tự động (Masked Phone Regex): Nhận diện số điện thoại tự gõ (ví dụ `0901 234 567`) và chuyển đổi thành `0901 ••• •••` kèm dòng chú thích bảo vệ hai bên dưới bong bóng chat.
    - Đa dạng các loại tin nhắn: Tin nhắn văn bản (phân biệt màu Teal cho người gửi vs Thẻ trắng cho đối tác), tin ảnh hiện trường (`Ron vòi sen bị mục`), chia sẻ định vị GPS live (kèm bản đồ mini), nhật ký cuộc gọi và cuộc gọi nhỡ (kèm nút bấm "Gọi lại" trực tiếp).
    - Thẻ đề xuất chi phí phát sinh (Change Order): Hiển thị chi phí `Thay ron vòi sen +45.000đ` kèm nút "Đồng ý" (Cam Hổ phách `#F59E0B`) và "Từ chối" (viền mảnh). Phía Thợ hiển thị trạng thái "Đang chờ khách xác nhận".
    - Dàn thanh trả lời nhanh (Quick Replies Bar): 4 gợi ý theo từng vai trò (Thợ: *Tôi đang đến, Tôi đã tới sảnh, Tôi sắp xong, Vui lòng mở cửa giúp tôi*; Khách: *Mình ở nhà rồi, Gửi xe ở hầm B1, Vui lòng gọi trước khi đến, Cảm ơn anh*).
    - Thanh nhập liệu và gửi tệp đa phương tiện (ChatInputBar): Nút đính kèm ảnh, nút gửi định vị GPS, ô nhập văn bản bo tròn viên nang và nút gửi Teal.
    - Trạng thái cuộc trò chuyện đóng (Cell 84 `chatClosed`): Khóa toàn bộ khung nhập và thay bằng thông báo "Cuộc trò chuyện đã đóng 24 giờ sau khi hoàn tất đơn. Cần hỗ trợ, vui lòng liên hệ Trung tâm hỗ trợ."
  - `VoipCallPage` (`/messaging/call` — Cells 82, 83 `call`): Màn hình cuộc gọi mã hóa ẩn danh:
    - Cuộc gọi đi (Cell 82): Avatar lớn 110px, trạng thái "Đang kết nối…" (2 giây) chuyển sang bộ đếm thời gian đàm thoại trực tiếp `mm:ss`, bộ 3 nút điều khiển (Tắt mic, Loa ngoài, Kết thúc cuộc gọi màu đỏ).
    - Cuộc gọi đến (Cell 83): Chuông gọi đến với bộ đôi nút hành động "Nghe máy" (Teal `#0D9488`) và "Từ chối" (Viền đỏ `#EF4444`), tự động xử lý cuộc gọi nhỡ sau 20 giây.
    - Biển cảnh báo ghi âm bắt buộc: "Cuộc gọi được ghi âm để bảo vệ hai bên và hỗ trợ giải quyết khiếu nại" nền vàng ấm.
- **Định tuyến (GoRouter):**
  - Khai báo 2 route hằng số `AppRoutes.chat` và `AppRoutes.voipCall` trong `lib/core/router/app_routes.dart` và đăng ký tương ứng trong `app_router.dart`.
- **Đa ngôn ngữ (Localization):**
  - Bổ sung 100% từ điển cho Batch 11 trong `app_vi.arb` và `app_en.arb` với tỷ lệ tương thích 1:1, truy xuất toàn bộ qua `context.l10n`.
- **Kiểm thử tự động (Widget Testing):**
  - Thêm test suite `test/features/messaging/messaging_screens_test.dart` đạt 6/6 tests pass.
  - Toàn bộ test suite dự án đạt **60/60 tests pass** (100% pass), `flutter analyze` đạt **0 lỗi, 0 cảnh báo**.

---

## [0.10.0] — 2026-09-25: Batch 10 UI Implementation (Auto-Warranty Journey — Cells 88–93)

### Added
- **Giao diện Batch 10 (Hành trình Bảo hành điện tử 0đ):**
  - `WarrantyCertificatePage` (`/customer/warranty/certificate` — Cell 88 `bhcert`): Phiếu bảo hành điện tử chuẩn Eco-Clean tự động phát hành khi đơn hoàn tất, hiển thị mã định danh `Phiếu BH-0087`, huy hiệu CÒN HIỆU LỰC (mint `#E3F1EA`) hoặc HẾT HẠN, thông tin kỹ thuật viên, thời hạn bảo hành 60 ngày, số ngày còn lại, mã QR để thợ quét kiểm tra đơn gốc khi đến bảo hành, danh sách hạng mục Được bảo hành (✓) và Không bảo hành (−), nút CTA thông minh theo trạng thái phiếu.
  - `WarrantyRequestPage` (`/customer/warranty/request` — Cell 89 `bhreq`): Yêu cầu bảo hành 0đ, ô nhập mô tả chi tiết sự cố kèm gợi ý nhanh 1 chạm, bộ đính kèm tối đa 5 ảnh / video hiện trường sự cố, danh sách chọn đa khung giờ mong muốn, thẻ cam kết bảo hành miễn phí 0đ không phát sinh chi phí, nút CTA gửi yêu cầu khóa tự động cho đến khi nhập mô tả và chọn ít nhất một khung giờ.
  - `WarrantyStatusPage` (`/customer/warranty/status` — Cell 90 `bhstat`): Sơ đồ tiến trình bảo hành 4 giai đoạn minh bạch (Đã gửi -> Thợ đã nhận -> Đang xử lý -> Đã khắc phục), mã định danh `#BH20250425-0087` kèm huy hiệu "BẢO HÀNH" mint pill đặc trưng, thông báo bối cảnh hướng dẫn theo từng bước, nút điều hướng "Về Đơn của tôi".
  - `CustomerOrdersPage` (Cell 91): Cập nhật thẻ công việc bảo hành đang thực hiện trong tab Đang làm (hiển thị tag BẢO HÀNH và giá 0đ); bổ sung dải thẻ cam kết bảo hành "Còn bảo hành 22 ngày · đến 17/05" kèm nút "Xem phiếu bảo hành" trực tiếp trên thẻ đơn hàng đã hoàn tất.
  - `WorkerWarrantyJobDetailPage` (`/worker/job/warranty` — Cell 92 `wbh`): Chi tiết việc bảo hành phía Thợ đối tác với đồng hồ đếm ngược phản hồi 24 giờ (`Phản hồi trong 23:59:00`), thu nhập thực nhận 0đ, ảnh chụp sự cố phản ánh của khách hàng, hồ sơ đơn gốc kèm ảnh chụp thực tế trước/sau khi thi công, bộ 2 nút hành động Từ chối và Nhận việc bảo hành.
  - `WorkerWarrantyDeclinePage` (`/worker/job/warranty-decline` — Cell 93 `wbhno`): Màn hình xử lý từ chối bảo hành phía Thợ, hiển thị cảnh báo khấu trừ 120.000đ chi phí khắc phục trực tiếp từ ví thu nhập, danh sách chọn lý do từ chối (Không đúng lỗi, Kẹt lịch, Thiếu linh kiện...), hộp kiểm cam kết hiểu rõ chế tài, nút viền đỏ xác nhận từ chối và nút quay lại xem việc.
- **Định tuyến (GoRouter):**
  - Khai báo 5 route hằng số trong `lib/core/router/app_routes.dart` và đăng ký tương ứng trong `app_router.dart`.
- **Đa ngôn ngữ (Localization):**
  - Bổ sung 100% bản dịch tiếng Việt và tiếng Anh cho Batch 10 trong `app_vi.arb` và `app_en.arb`, truy xuất toàn bộ qua `context.l10n`.
- **Kiểm thử tự động (Widget Testing):**
  - Thêm test suite `test/features/warranty/warranty_screens_test.dart` đạt 7/7 tests pass.
  - Toàn bộ test suite dự án đạt **54/54 tests pass** (100% pass), `flutter analyze` đạt **0 lỗi, 0 cảnh báo**.

---

## [0.9.0] — 2026-09-25: Batch 9 UI Implementation (Exceptions, Cancellation, Customer No-Show & Escrow Dispute)

### Added
- **Giao diện Batch 9 (Exceptions, Cancellation & Escrow Dispute):**
  - `CustomerCancellationPage` (`/customer/booking/cancel` — Cells 67, 68 `cancel`): Huỷ đặt lịch phía Khách hàng linh hoạt 2 chế độ: Huỷ miễn phí (0đ) trước giờ hẹn và Huỷ có phí phạt giữ chỗ (50.000đ) sát giờ hẹn sử dụng nút Cam Hổ phách (`#F59E0B`), danh sách chọn lý do huỷ, ô nhập lý do khác, thông báo chính sách huỷ minh bạch.
  - `WorkerCancellationPage` (`/worker/job/cancel` — Cell 71 `wcxl`): Huỷ việc phía Thợ đối tác, hiển thị cảnh báo sụt giảm tỷ lệ nhận việc (96% -> 95%), danh sách chọn lý do từ chối (Trùng lịch, Phương tiện gặp sự cố, Sức khỏe đột xuất...), nút viền đỏ xác nhận huỷ và nút Teal chính giữ nguyên đơn nhận.
  - `CustomerNoShowPage` (`/worker/job/no-show` — Cells 73–75 `wns`, `wnsrep`, `wnsdone`): Xử lý tình huống Khách vắng mặt sau khi Thợ đã đến nơi: Đồng hồ đếm ngược 15 phút, các nút gọi điện và nhắn tin nhắc nhở khách, bộ chụp ảnh bằng chứng hiện trường căn hộ vắng khách, thẻ bồi hoàn tiền công Deep Teal (`#0E5952`) cộng ngay 50.000đ vào ví thợ.
  - `DisputeReportPage` (`/customer/order/dispute` — Cell 79 `dispute`): Màn hình tạo yêu cầu khiếu nại chất lượng dịch vụ, bộ chip chọn loại khiếu nại (Chưa dọn kỹ góc khuất, Làm hỏng vật dụng, Thợ có thái độ thiếu lịch sự...), ô nhập mô tả chi tiết, khu vực đính kèm tối đa 5 ảnh bằng chứng, thông báo bảo vệ ký quỹ Escrow, nút gửi khiếu nại khóa tự động khi chưa chọn lý do.
  - `OrderDisputedPage` (`/customer/order/disputed` — Cell 80 `disputed`): Màn hình xác nhận đơn hàng đang trong tình trạng tranh chấp, khiên bảo vệ Escrow đóng băng thanh toán 400.000đ, mã khiếu nại `#KN-0425-031`, sơ đồ tiến trình 3 bước (Tiếp nhận -> Thợ phản hồi -> Trọng tài VSTech xử lý), nút "Theo dõi khiếu nại" và "Về trang chủ".
  - `CustomerDisputeListPage` (`/customer/disputes` — Cell 82 `clist`): Danh sách khiếu nại của Khách hàng với 4 tab phân loại (Đang xem xét, Cần bổ sung, Đã giải quyết, Đã đóng), thẻ khiếu nại kèm mã đơn hàng liên kết, huy hiệu trạng thái sắc nét, tóm tắt kết quả hoàn tiền.
  - `DisputeDetailPage` (`/customer/disputes/detail` — Cells 83, 84 `cdetail`): Chi tiết khiếu nại chuyên sâu, hiển thị toàn bộ nội dung, ảnh chụp bằng chứng thực tế, dòng thời gian giải quyết tranh chấp, thẻ bồi hoàn tiền mặt (+100.000đ về ví ZaloPay) hoặc hộp kêu gọi bổ sung thêm ảnh hiện trường theo yêu cầu trọng tài.
  - `WorkerDisputeNotificationPage` (`/worker/job/dispute` — Cells 85, 87 `wwait` dispute / `wreply`): Thông báo Thợ bị khách khiếu nại, cảnh báo tạm giữ tiền công 340.000đ trong ví ký quỹ Escrow, tóm tắt yêu cầu của khách, biểu mẫu gửi giải trình và đính kèm ảnh đối chứng của Thợ.
- **Định tuyến (GoRouter):**
  - Khai báo 8 route hằng số trong `lib/core/router/app_routes.dart` và đăng ký route trong `app_router.dart`.
- **Đa ngôn ngữ (Localization):**
  - Bổ sung 100% bản dịch tiếng Việt và tiếng Anh cho Batch 9 trong `app_vi.arb` và `app_en.arb`, truy xuất toàn bộ qua `context.l10n`.
- **Kiểm thử tự động (Widget Testing):**
  - Thêm test suite `test/features/exceptions/exceptions_screens_test.dart` đạt 9/9 tests pass.
  - Toàn bộ test suite dự án đạt **47/47 tests pass** (100% pass), `flutter analyze` đạt **0 lỗi, 0 cảnh báo**.

---

## [0.8.0] — 2026-09-24: Batch 8 UI Implementation (Orders Hub, Order Details & Role-aware Notifications)

### Added
- **Giao diện Batch 8 (Orders Hub & Role-aware Notifications):**
  - `CustomerOrdersPage` (`/customer/orders` — Cells 36–39 `orders`): Bộ lọc 3 tab mượt mà (Đang thực hiện, Đang chờ, Đã hoàn thành), thẻ đơn hàng chi tiết hiển thị trạng thái tiến trình thực tế, ngày giờ, thông tin Thợ đối tác kèm rating, tổng tiền thanh toán, nút hành động thông minh (Theo dõi thợ / Đặt lại dịch vụ), thanh dock nổi Customer cố định với khoảng trống an toàn chuẩn mực (`AppSpacing.dockClearanceMax`).
  - `CustomerOrderDetailPage` (`/customer/orders/detail` — Cells 62, 63 `orderdet`): Trang đặc tả đơn hàng chuyên sâu, thẻ Thợ đối tác có avatar, tên, đánh giá sao kèm 2 nút liên lạc trực tiếp (nhắn tin/gọi ẩn danh), thông tin lịch hẹn và địa chỉ căn hộ Flora Novia, bảng kê chi phí minh bạch từng khoản (Công thợ 350.000đ, Dịch vụ thêm 30.000đ, Phụ phí mặt bằng 20.000đ, Tổng 400.000đ), thẻ cam kết bảo hành 30 ngày tự động, nút tải hóa đơn điện tử và theo dõi thợ.
  - `WorkerJobsHubPage` (`/worker/jobs` — Cells 40–42 `wjobs`): Trung tâm điều phối việc làm của Thợ với 3 tab: Mới phân công (hiển thị khoảng cách 2.4km, thu nhập ước tính thực nhận +340.000đ, nút Nhận việc ngay), Đang làm (đồng hồ đếm giờ làm việc thực tế, nút Vào ca làm việc), Đã hoàn tất (đánh giá 5.0★, trích dẫn nhận xét của khách hàng, thu nhập thực nhận đã quyết toán), thanh dock nổi Worker cố định.
  - `CustomerNotificationsPage` (`/customer/notifications` — Cell 64 `notif`): Dòng thời gian thông báo phân đoạn chuẩn mực (Hôm nay / Trước đó), dàn chip lọc 4 danh mục (Tất cả, Đơn hàng, Khuyến mãi, Hệ thống), thẻ thông báo trực quan với biểu tượng màu sắc và chấm tròn chỉ báo chưa đọc.
  - `CustomerNotificationSettingsPage` (`/customer/settings/notifications` — Cell 65): Trung tâm tùy chỉnh kênh nhận thông báo với 4 bộ chuyển mạch thích ứng Switch chuẩn Eco-Clean (Thông báo đẩy Push, Tin nhắn SMS, Zalo ZNS, Tin khuyến mãi), nút lưu xác nhận.
  - `WorkerNotificationsPage` (`/worker/notifications` — Cell 66 `wnotif`): Bảng tin thông báo chuyên biệt cho đối tác Thợ (Phân công đơn mới, Tiền về ví +340.000đ, Đánh giá 5 sao từ khách hàng, Lưu ý an toàn lao động đồ bảo hộ), nút "Đánh dấu đã đọc tất cả".
- **Định tuyến (GoRouter):**
  - Khai báo hằng số định tuyến trong `lib/core/router/app_routes.dart` và đăng ký route trong `app_router.dart` cho 6 màn hình mới.
- **Đa ngôn ngữ (Localization):**
  - Bổ sung 100% từ điển cho Batch 8 trong `app_vi.arb` và `app_en.arb` với tỷ lệ 1:1, truy xuất toàn bộ qua `context.l10n`.
- **Kiểm thử tự động (Widget Testing):**
  - Thêm test suite `test/features/orders/orders_screens_test.dart` đạt 6/6 tests pass.
  - Toàn bộ test suite dự án đạt **38/38 tests pass** (100% pass), `flutter analyze` đạt **0 lỗi, 0 cảnh báo**.

---

## [0.7.0] — 2026-09-24: Batch 7 UI Implementation (Inspection, Payment Gateway, Electronic Receipt, Review & Worker Payout)

### Added
- **Giao diện Batch 7 (Checkout, Payment, Review & Payout Journey):**
  - `InspectionSignoffPage` (`/customer/order/inspect` — Cell 50 `accept`): Bảng kiểm tra chất lượng 5 hạng mục thực tế (Kính sáng bóng, Rác cồng kềnh thu gom, Thiết bị về vị trí ban đầu...), huy hiệu cam kết bảo hành 0đ trong 30 ngày, nút CTA chính "Nghiệm thu hài lòng" và nút phụ "Chưa đạt yêu cầu".
  - `OrderPaymentSummaryPage` (`/customer/order/payment` — Cell 52 `paysum`): Hóa đơn kê khai tài chính minh bạch (Công thợ 350.000đ, Dịch vụ thêm 30.000đ, Phụ phí mặt bằng 20.000đ, Phát sinh linh kiện nếu có), tùy chọn phương thức thanh toán (VietQR quét tức thì, Thẻ ATM/Ví điện tử, Tiền mặt), nút cam kết tài chính Cam Hổ phách (`#F59E0B`) "Thanh toán 400.000đ".
  - `PaymentGatewayPage` (`/customer/order/pay` — Cell 53 `pay`): Cổng thanh toán VietQR động 24/7, đồng hồ đếm ngược 15 phút, bảng chi tiết chuyển khoản ngân hàng (MB Bank, Số tài khoản, Chủ thụ hưởng, Nội dung chuyển khoản kèm nút sao chép nhanh và thông báo snackbar), nút xác nhận "Tôi đã chuyển khoản thành công".
  - `PaymentSuccessPage` (`/customer/order/paid` — Cell 55 `paid`): Màn hình xác nhận thanh toán thành công, huy hiệu cộng điểm Eco-Clean (+40 điểm), thẻ chi tiết mã đơn, nút điều hướng "Xem hóa đơn điện tử" và "Đánh giá Thợ đối tác".
  - `ElectronicReceiptPage` (`/customer/order/receipt` — Cell 56 `receipt`): Hóa đơn điện tử hợp chuẩn, minh bạch phân bổ dòng tiền nền tảng (85% tiền công thợ trực tiếp 340.000đ vs. 15% phí nền tảng & bảo hiểm 60.000đ), nút "Tải hóa đơn PDF" và "Chia sẻ biên lai".
  - `OrderReviewTipPage` (`/customer/order/review` — Cells 57, 58 `review`): Đánh giá sao tương tác (1 đến 5 sao), dàn tag khen ngợi (Đúng giờ, Tận tâm, Sạch sẽ, Lịch sự), bộ chọn tiền tip hỗ trợ thợ (Không tip, 20.000đ, 50.000đ, 100.000đ - 100% về ví thợ), ô góp ý văn bản, nút cam kết tài chính Cam Hổ phách "Gửi đánh giá & Tip".
  - `OrderThanksPage` (`/customer/order/thanks` — Cell 59 `thanks`): Màn hình cảm ơn ấm áp, thẻ xác nhận kích hoạt bảo hành 30 ngày tự động 0đ, nút "Về trang chủ".
  - `WorkerJobCompletionPage` (`/worker/job-completion` — Cells 51, 54, 60 `wwait`): Màn hình Thợ chờ hoàn tất & nhận tiền với 3 giai đoạn chuyển tiếp: Chờ khách nghiệm thu (vòng xoay tiến trình), Chờ khách thanh toán qua VietQR, và Thẻ thu nhập Deep Teal (`#0E5952`) thông báo cộng tiền vào ví (+340.000đ sau khi trừ 15% phí sàn) kèm nút "Xem ví thu nhập".
- **Đa ngôn ngữ (Localization):**
  - Bổ sung 100% từ điển cho Batch 7 trong `app_vi.arb` và `app_en.arb` với tỷ lệ tương thích 1:1, truy xuất toàn bộ qua `context.l10n`.
- **Kiểm thử tự động (Widget Testing):**
  - Thêm test suite `test/features/checkout/checkout_screens_test.dart` đạt 8/8 tests pass.
  - Toàn bộ test suite dự án đạt **32/32 tests pass** (100% pass), `flutter analyze` đạt **0 lỗi, 0 cảnh báo**.

---

## [0.6.0] — 2026-09-24: Batch 6 UI Implementation (Real-time Tracking & Worker Execution Progress)

### Added
- **Giao diện Batch 6 (Real-time Tracking & Worker Execution Progress):**
  - `CustomerTrackingPage` (`/customer/tracking`): Màn hình theo dõi tiến độ công việc trực quan 4 giai đoạn cốt lõi: Giai đoạn 1 Thợ đang đến (ETA: 8 phút · 2.4 km), Giai đoạn 2 Thợ đã đến (Check-in 13:58), Giai đoạn 3 Đang thực hiện (Đồng hồ đếm giờ làm việc + checklist 5 bước an toàn), Giai đoạn 4 Chờ nghiệm thu (Thông báo hoàn tất + nút CTA "Tiến hành nghiệm thu"). Thẻ thợ đồng hành Nguyễn Văn Hùng 4.9★, nút Gọi ẩn danh và Nhắn tin nhanh.
  - `WorkerEnRoutePage` (`/worker/job-en-route`): Màn hình Thợ di chuyển (`wgo` - Cell 44), bản đồ dẫn đường vector Eco-Clean, nút Mở Google Maps dẫn đường, thẻ địa chỉ và ghi chú khách hàng, nút Huỷ việc cảnh báo tỷ lệ nhận việc (96% -> 95%), nút CTA "Tôi đã đến nơi".
  - `WorkerArrivedPage` (`/worker/job-arrived`): Màn hình Thợ có mặt (`warr` - Cell 46), xác nhận check-in 13:58, tóm tắt thông tin khách, nút CTA "Bắt đầu làm việc", tùy chọn xử lý "Khách không có mặt?" bồi hoàn 50.000đ sau 15 phút.
  - `WorkerExecutingPage` (`/worker/job-executing`): Màn hình Thợ thi công (`wwork` - Cell 48), đồng hồ đếm giờ làm việc, danh mục 5 bước an toàn tương tác đánh dấu hoàn thành, nút "+ Đề xuất chi phí phát sinh" kèm dialog nhập tên linh kiện/giá tiền (thay ron vòi sen +45.000đ), nút CTA "Hoàn tất công việc -> Chờ nghiệm thu".
- **Thành phần dùng chung (Shared Components):**
  - `TrackingMapWidget`: Khung bản đồ vector phong cách Eco-Clean Sanctuary v9.0, hiển thị lộ trình polyline Teal, marker thợ xe máy chuyển động, marker điểm đến và nút định vị GPS.
  - `WorkingTimerWidget`: Đồng hồ đếm giờ làm việc trực tiếp định dạng `HH:MM:SS`, viền hairline 1px, badge trạng thái Đang làm.
  - `ServiceChecklistWidget`: Danh mục kiểm tra quy chuẩn an toàn 5 bước chuyên nghiệp, hỗ trợ chế độ tương tác đánh dấu tiến độ hoàn thành cho Thợ và chế độ xem cho Khách hàng.
- **Thiết kế & Công thái học (Typography & Ergonomics):**
  - Bổ sung alias `labelSmall` và `bodySmall` trong `AppTextStyles` đảm bảo tuân thủ `GoogleFonts.sourceSans3`.
  - Nâng cấp `AppButton` và `AppSecondaryButton` với `Flexible` chống tràn văn bản đa ngôn ngữ trên mọi kích cỡ màn hình.
- **Đa ngôn ngữ (Localization):**
  - Bổ sung 100% từ điển cho Batch 6 trên cả `app_vi.arb` và `app_en.arb` đối ứng 1:1, truy xuất qua `context.l10n`.
- **Kiểm thử tự động (Widget Testing):**
  - Test suite `test/features/tracking/tracking_screens_test.dart` đạt 5/5 tests pass. Toàn bộ test suite dự án đạt **24/24 tests pass**, `flutter analyze` đạt **0 lỗi, 0 cảnh báo**.

---

## [0.5.0] — 2026-09-24: Batch 5 UI Implementation (Customer Booking & Dispatch Radar Matching)

### Added
- **Giao diện Batch 5 (Customer Booking & Dispatch Radar Matching):**
  - `BookingStep1ServiceOptionPage` (`/customer/booking/step1`): Lựa chọn quy mô căn hộ tương tác (Nhỏ <70m² 350.000đ, Vừa 70-100m² 450.000đ, Lớn >100m² 600.000đ) kết hợp chọn dịch vụ cộng thêm đa lựa chọn (Thu gom rác cồng kềnh +30k, Khử khuẩn nano bạc +50k, Lau kính mặt ngoài +40k), tính tổng giá động thời gian thực.
  - `BookingStep2ScheduleAddressPage` (`/customer/booking/step2`): Chọn ngày làm việc dạng lịch trượt ngang (7 ngày tới), chọn khung giờ 2 tiếng (Sáng 08:00 - 10:00, Chiều 14:00 - 16:00, Tối 17:00 - 19:00), định vị địa chỉ GPS, chọn loại hình mặt bằng (Nhà đất +0đ, Chung cư có thang máy +20.000đ, Chung cư thang bộ +50.000đ), nhập ghi chú cho thợ và đính kèm ảnh hiện trường.
  - `BookingStep3ConfirmPage` (`/customer/booking/step3`): Bảng kê chi phí minh bạch từng dòng (Công thợ, Dịch vụ thêm, Phụ phí mặt bằng, Giảm giá voucher), bộ nhập mã voucher khuyến mãi (nhập thử `NHAMOICHI15` giảm 15%), chọn phương thức thanh toán (VietQR quét tức thì, Ví điện tử Momo/ZaloPay, Tiền mặt sau nghiệm thu), huy hiệu cam kết bảo hành 0đ trong 30 ngày, và nút chốt Cam Hổ phách (`#F59E0B`) "Xác nhận đặt lịch".
  - `DispatchRadarMatchingPage` (`/customer/booking/matching`): Màn hình radar quét thợ đồng tâm 2.5km với hiệu ứng sóng teal lan tỏa, thanh trạng thái tiến trình ghép thợ, thẻ thông tin thợ nhận việc (Ảnh thợ, Tên thợ, 4.9★, thời gian dự kiến đến 15 phút, nút Gọi & Nhắn tin thợ).
- **Thành phần tương tác & Animation:**
  - `RadarPulseAnimation`: Vòng sóng quét radar đồng tâm hiệu ứng tỏa tròn lặp vô tận, thể hiện sống động quá trình quét bán kính 2.5km tìm thợ quanh khu vực khách hàng.
  - `VoucherInputCard`: Thẻ áp dụng mã khuyến mãi có phản hồi trạng thái hợp lệ và tính toán chiết khấu tự động.
- **Đa ngôn ngữ (Localization):**
  - Bổ sung 100% từ điển cho Batch 5 trên cả `app_vi.arb` và `app_en.arb` với tỉ lệ đối ứng 1:1, truy xuất toàn bộ qua `context.l10n`.
- **Kiểm thử tự động (Widget Testing):**
  - Thêm test suite `test/features/booking/booking_screens_test.dart` kiểm tra `BookingStep1ServiceOptionPage`, `BookingStep2ScheduleAddressPage`, `BookingStep3ConfirmPage` (áp mã voucher, đổi phương thức thanh toán, nút chốt Cam Hổ phách) và `DispatchRadarMatchingPage` (hiệu ứng radar quét, hiển thị thẻ thợ).
  - Đạt 100% test passing (19/19 tests) và 0 lint warnings trên toàn bộ codebase (`flutter analyze`).

---

## [0.4.0] — 2026-09-23: Batch 4 UI Implementation (Worker Experience & KYC Onboarding)

### Added
- **Giao diện Batch 4 (Worker Experience & KYC Onboarding):**
  - `WorkerDashboardPage` (`/worker/dashboard`): Bàn làm việc Thợ đối tác toàn diện gồm Header lời chào ("Chào anh Hùng, hôm nay sẵn sàng nhận việc?"), công tắc gạt Online/Offline an toàn, Thẻ thu nhập Deep Teal (`#0E5952`) chống chói ngoài trời hiển thị tiền to "340.000đ" và 3 chỉ số hiệu suất (1/3 Đơn hoàn tất, 4.9 ★ Đánh giá sao, 96% Tỷ lệ nhận việc), Thẻ thông báo đơn hàng mới ("Dọn dẹp căn hộ 70m²", cự ly 2.1km, đến sau 20 phút), Lịch việc hôm nay (Đã xong, Sắp tới), và Worker Floating Dock 4 tabs với đệm an toàn `128px`.
  - `WorkerJobDetailPage` (`/worker/job-detail`): Chi tiết yêu cầu công việc, vị trí căn hộ khách hàng, phân rã công thức giá minh bạch (Công thợ 350.000đ + Phụ phí mặt bằng 50.000đ - Phí sàn 15% 60.000đ = Thực nhận về ví 340.000đ), nút CTA Teal "Nhận việc ngay" với thông báo điều hướng chuẩn GoRouter.
  - `WorkerKycWizardPage` (`/worker/kyc`): Trình hướng dẫn 6 bước KYC hoàn chỉnh: Thanh tiến trình Bước n/6 (17% - 100%), Bước 2 (Thông tin cá nhân & Chọn khu vực nhận việc đa quận), Bước 3 (Chụp ảnh 2 mặt CCCD gắn chip, khóa nút Tiếp tục nếu chưa đủ 2 mặt), Bước 4 (Chụp ảnh selfie khuôn mặt), Bước 5 (Chuyên môn & Chứng chỉ an toàn lao động), Bước 6 (Tài khoản ngân hàng nhận tiền với xác thực tên chủ TK trùng khớp 100% với CCCD).
  - `WorkerKycStatusPage` (`/worker/kyc-status`): Màn hình thông báo trạng thái hồ sơ với 3 biến thể: Đang duyệt (`pending`), Cần bổ sung (`needs` - nút bổ sung ảnh CCCD), và Đã duyệt (`approved` - nút "Bắt đầu nhận việc" chuyển tới Dashboard).
- **Thành phần dùng chung (Reusable Worker Components):**
  - `WorkerFloatingDock`: Thanh điều hướng đáy dạng viên nang nổi (`rounded-full`), 4 tabs (Việc, Lịch, Ví, Hồ sơ), tab active viên thuốc Teal, Zero Shadows, đệm viền hairline 1px `#E2E8F0`.
  - `WorkerEarningsCard`: Thẻ thu nhập khối Deep Teal `#0E5952` chữ trắng sang trọng, hiển thị số tiền to thực nhận và 3 thông số hiệu suất cốt lõi.
  - `WorkerJobRequestCard`: Thẻ thông báo đơn hàng mới đổ về: icon dịch vụ, cự ly, thời gian đến 20 phút, tiền thực nhận về ví, nút "Xem & Nhận việc".
- **Hệ màu bổ sung:**
  - `AppColors.workerTeal`: Token màu Deep Teal `#0E5952` định nghĩa chính thức trong `app_colors.dart`.
  - Các bí danh typography chuẩn hóa trong `AppTextStyles` (`headlineLarge`, `headlineMedium`, `headlineSmall`, `labelLarge`, `labelMedium`, `bodyLarge`, `bodyMedium`, `buttonText`) đảm bảo 100% sử dụng `GoogleFonts.sourceSans3`.
- **Đa ngôn ngữ (Localization):**
  - Bổ sung 100% từ điển cho Batch 4 trên cả `app_vi.arb` và `app_en.arb` với tỉ lệ đối ứng 1:1, truy xuất toàn bộ qua `context.l10n`.
- **Kiểm thử tự động (Widget Testing):**
  - Thêm test suite `test/features/worker/worker_screens_test.dart` kiểm tra toàn diện `WorkerDashboardPage`, chuyển đổi trạng thái Online/Offline, `WorkerJobDetailPage`, `WorkerKycWizardPage` qua các bước, và `WorkerKycStatusPage` cả 3 trạng thái.
  - Đạt 100% test passing và 0 lint warnings trên toàn bộ codebase (`flutter analyze`).

---

## [0.3.5] — 2026-09-23: Batch 3 UI Implementation (Customer Home & Categories)

### Added
- **Giao diện Batch 3 (Customer Home & Categories):**
  - `CustomerHomePage` (`/customer/home`): Trang chủ Khách hàng toàn diện gồm Header lời chào gia đình ("Chào bạn, Mai 👋"), bộ chọn địa chỉ nhanh, chuông thông báo chấm đỏ, Search bar bo tròn, Hero Banner 159px, Lưới 8 danh mục dịch vụ thiết yếu, Mục ưu đãi đặc quyền cuộn ngang, và Sổ theo dõi thiết bị gia đình.
  - `CategoriesPage` (`/customer/categories`): Trang duyệt toàn bộ danh mục dịch vụ với thanh tìm kiếm và bộ lọc chip ngang (Tất cả, Vệ sinh, Điện lạnh, Điện nước, Sửa chữa).
  - `ServiceDetailPage` (`/customer/service-detail`): Trang chi tiết dịch vụ với thông tin gói, checklist 5 hạng mục bao gồm, huy hiệu cam kết bảo hành 0đ trong 30 ngày và CTA chính Teal "Đặt lịch ngay".
- **Thành phần dùng chung (Reusable Home Components):**
  - `CustomerFloatingDock`: Thanh điều hướng đáy dạng viên nang nổi cố định chân màn hình (`rounded-full`), 5 tabs (Trang chủ, Đơn hàng, AI hỗ trợ, Thông báo, Tài khoản), tab active viên thuốc Teal, Zero Shadows.
  - `HomeTopHeader`: Lời chào cá nhân hóa, bộ chọn địa chỉ căn hộ, chuông thông báo.
  - `ServiceCategoryTile`: Thẻ danh mục dịch vụ lưới 3 cột, viền hairline, icon đồ họa 48px, nhãn 2 dòng.
  - `ServiceOfferCard`: Thẻ dịch vụ khuyến mãi nổi bật kèm badge "Giảm 15%", "Có mặt 20p", giá niêm yết và đánh giá 4.9 sao.
  - `HomeDevicesCard`: Thẻ theo dõi tình trạng thiết bị (Máy lạnh Daikin, Tủ lạnh Samsung) và lịch bảo dưỡng định kỳ.
- **Đa ngôn ngữ (Localization):**
  - Bổ sung 100% từ điển cho Batch 3 trên cả `app_vi.arb` và `app_en.arb` với tỉ lệ đối ứng 1:1, truy xuất toàn bộ qua `context.l10n`.
- **Kiểm thử tự động (Widget Testing):**
  - Thêm test suite `test/features/home/home_screen_test.dart` kiểm tra toàn diện `CustomerHomePage`, chuyển tab trên Floating Dock, bộ lọc danh mục và chi tiết dịch vụ.
  - Đạt 100% test passing (9/9 tests) và 0 lint warnings trên toàn bộ codebase (`flutter analyze`).

---

## [0.3.0] — 2026-09-23: Batch 2 UI Implementation (Auth Screens)
### Added
- **Giao diện Batch 2 (Auth Screens):**
  - `LoginPage` (`/auth/login`): Hỗ trợ đa vai trò (Khách hàng & Thợ), nhập SĐT/Email + Mật khẩu kèm ẩn/hiện, liên kết Quên mật khẩu, nút Social Login (Google, Apple, Facebook cho Khách hàng) và chuyển sang Đăng ký.
  - `RegisterPage` (`/auth/register`): Đăng ký tài khoản mới (Họ tên, SĐT, Mật khẩu, Xác nhận mật khẩu), checkbox Điều khoản dịch vụ & Chính sách bảo mật, liên kết Đăng nhập.
  - `OtpVerificationPage` (`/auth/verify-otp`): Bộ 6 ô nhập mã OTP tách rời (`OtpPinInputWidget`), tính năng Quick-Fill demo 1-chạm ("Từ Tin nhắn: 123456"), bộ đếm ngược 60 giây gửi lại mã, điều hướng linh hoạt theo context (`register`, `login`, `forgot`).
  - `ForgotPasswordPage` (`/auth/forgot-password`): Khôi phục mật khẩu qua SĐT đã đăng ký và gửi mã OTP.
- **Thành phần dùng chung (Reusable Auth Components):**
  - `AuthRoleBadge`: Chip hiển thị vai trò hiện tại và nút chuyển nhanh vai trò.
  - `SocialAuthButton`: Nút đăng nhập bên thứ 3 chuẩn viền hairline, Zero Shadows.
  - `OtpPinInputWidget`: Quản lý 6 ô pin focus tuần tự, hỗ trợ xóa lùi (backspace) và điền nhanh cả chuỗi mã.
- **Mở rộng Core Widgets:**
  - `AppTextField`: Mở rộng thêm `prefixIcon`, `suffixIcon`, `textInputAction`, `onSubmitted`, `focusNode`, `autofocus`.
  - `AppButton.primary`: Bổ sung named constructor cho nút CTA chính full-width.
- **Đa ngôn ngữ (Localization):**
  - Bổ sung 100% từ điển cho phân hệ Auth trên cả `app_vi.arb` và `app_en.arb` với tỉ lệ đối ứng 1:1, truy xuất qua `context.l10n`.
- **Kiểm thử tự động (Widget Testing):**
  - Thêm test suite `test/features/auth/auth_screens_test.dart` kiểm tra toàn bộ luồng Auth, ẩn/hiện social login theo vai trò, nhập form và quick fill OTP.
  - Đạt 100% test passing (5/5 tests) và 0 lint warnings trên toàn bộ codebase (`flutter analyze`).

---

## [0.2.0] — 2026-09-23: Batch 1 UI Implementation
- **Đa ngôn ngữ (Localization Engine):**
  - Cấu hình `l10n.yaml` và `flutter_localizations` trong `pubspec.yaml`.
  - Bộ từ điển 1:1 Tiếng Việt (`lib/l10n/app_vi.arb`) và Tiếng Anh (`lib/l10n/app_en.arb`).
  - Tiện ích `context.l10n` tại `lib/core/extensions/l10n_extension.dart`.
  - `appLocaleNotifier` tại `lib/app.dart` cho phép chuyển đổi ngôn ngữ tức thời.
- **Tài nguyên đồ họa (Assets Pipeline):**
  - Trích xuất 7 ảnh minh họa bản sắc Việt vào `assets/images/` (`splash-full.png`, `ob-1` đến `ob-5`, `hero-banner.png`).
  - Trích xuất 30 icon danh mục chuyên biệt vào `assets/icons/`.
  - Lớp hằng số định danh `AppAssets` tại `lib/core/constants/app_assets.dart`.
- **Giao diện Batch 1 (Khởi động & Cửa ngõ vai trò):**
  - `SplashScreen` (`/splash`): Thương hiệu HomeService, thanh loading tiến trình tự động chuyển trang.
  - `OnboardingPage` (`/onboarding`): 4 slide trình diễn giá trị, chấm tròn chuyển slide tương tác 2 chiều.
  - `IntroValuePage` (`/intro`): 3 giá trị cốt lõi (Minh bạch, Bảo hành tự động, Tốc độ), ảnh gia đình Việt, 1 CTA chính "Bắt đầu ngay".
  - `RoleGatewayPage` (`/role-gateway`): Cổng phân vai trò 50/50 (Khách hàng vs Thợ), nút chuyển nhanh ngôn ngữ VI/EN.
- **Kiểm thử & Linter:**
  - Cập nhật bộ kiểm thử `test/widget_test.dart` xác minh khởi chạy `SplashPage` và tự động điều hướng sang `OnboardingPage`.
  - Vượt qua kiểm tra toàn diện `flutter analyze` và `flutter test` với 0 cảnh báo và 100% kiểm thử đạt.
- **Thư viện nền tảng bổ sung:**
  - `intl`, `permission_handler`, `geolocator`, `url_launcher`, `connectivity_plus`.
- **Tài liệu kỹ thuật mới:**
  - `docs/reference/MOBILE_ARCHITECTURE_SPEC.md`: Đặc tả chi tiết 8 phần kiến trúc mobile.
  - `docs/design/DESIGN.md`: Bản đặc tả Concept 02 (Contemporary Folk Utility) chuẩn hóa 630 dòng.
  - `CHANGELOG.md`: Nhật ký thay đổi dự án.

### Changed
- **Typography:** Khóa cứng toàn bộ hệ thống phông chữ sử dụng `GoogleFonts.sourceSans3` theo yêu cầu người dùng.
- **Tài liệu cũ:** Dọn dẹp link hỏng trong `docs/reference/api/README.md`, viết lại root `README.md`.
- **Tech Stack:** Cập nhật bảng công nghệ trong `AGENTS.md` và `CLAUDE.md`.

---

## [0.1.0] — 2026-09-23
### Added
- Bootstrap dự án Flutter `vstech_home_services`.
- Thiết lập hệ thống tokens Eco-Clean Sanctuary v9.0 (`AppColors`, `AppSpacing`, `AppTheme`).
- Cấu trúc Feature-First Clean Architecture cho 11 modules nghiệp vụ.
- Thiết lập Universal Agent Rules (`AGENTS.md`, `.agents/skills/`, `.claude/skills/`).
