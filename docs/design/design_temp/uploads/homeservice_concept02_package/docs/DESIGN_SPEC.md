# HomeService — Concept 02: Contemporary Folk Utility

## 1. Art direction

**Contemporary Folk Utility** = hiện đại, tiện ích, gần gũi, đậm chất Việt. Visual lấy cảm hứng từ nhịp sống đô thị Việt Nam/TP.HCM, nhưng lớp chức năng vẫn ưu tiên tốc độ, clarity và thao tác nhanh.

### Brand tone

- Hiện đại
- Tiện ích
- Gần gũi
- An tâm
- Gia đình Việt

### Tagline đang dùng trong concept

- `Nhà tốt hơn mỗi ngày`
- `Nhịp sống vội, nhà vẫn luôn là nơi chờ bạn.`
- `Việc nhà nhẹ hơn — Cuộc sống tươi hơn`

## 2. Color tokens

| Token | Hex | Vai trò |
|---|---|---|
| Teal | `#0F766E` | Primary / brand / navigation |
| Amber | `#F59E0B` | CTA / active action |
| Beige | `#F7EED7` | Warm background |
| Jade | `#A7D7C5` | Support surfaces |
| Ceramic Blue | `#3B82F6` | Accent / informational |
| Light Sand | `#E8DDD0` | Neutral support |

## 3. Shape & spacing

- Card radius: 20–24px
- Buttons: rounded / pill, primary CTA amber hoặc teal tùy ngữ cảnh
- Surfaces: light, warm, có nhiều khoảng trắng
- Shadow: mềm, nhẹ, không đậm kiểu neumorphism
- Cultural motifs: cloud line, gạch bông, skyline, illustration gia đình Việt; dùng như layer phụ, không lấn content chính

## 4. Information architecture của board

### 01 — Onboarding & Brand

1. Splash
2. Onboarding
3. Intro / Value proposition
4. Đăng nhập
5. Đăng ký

### 02 — Core Journey

6. Trang chủ
7. Danh mục dịch vụ
8. Đặt lịch dịch vụ
9. Theo dõi đơn hàng
10. Ngôi nhà của bạn / quản lý thiết bị

### 03 — Support & Account

11. AI Assistant (chat)
12. AI gợi ý dịch vụ
13. Hồ sơ cá nhân
14. Cài đặt & lịch sử

## 5. UX intent theo màn

### Splash

Mục tiêu: tạo nhận diện thương hiệu Việt hiện đại + cảm giác thân thiện, đáng tin.

### Home

Ưu tiên theo thứ tự:

1. Greeting / contextual personalization
2. Search
3. Hero / CTA
4. Dịch vụ thường dùng
5. `Ngôi nhà của bạn`
6. Promo / ưu đãi

### AI Assistant

AI đóng vai trò hỗ trợ, không lấn át core journey. Giao diện dạng chat, action chips, quick intents.

### Booking

Tư duy nhanh kiểu 3–4 bước:

1. Chọn dịch vụ
2. Chọn thời gian
3. Xác nhận thông tin
4. Hoàn tất / thanh toán

### Tracking

Map + status + technician card + ETA + call/chat.

### Ngôi nhà của bạn

Quản lý thiết bị trong nhà và tình trạng bảo trì; đây là module có tiềm năng trở thành điểm khác biệt lớn của HomeService.

## 6. Asset rule

- `assets/reference-concept02.png` là nguồn thị giác chuẩn.
- Screen crops không được tự ý recolor hoặc chỉnh layout nếu cần giữ fidelity với concept này.
- Bản `@3x` chỉ phục vụ trình bày/zoom.

## 7. Hướng chuyển sang UI code thật

Để tạo bản production-editable 1:1 hơn, nên dựng lại từng màn bằng component thay vì nhúng ảnh. Recommended component inventory:

- AppHeader
- LocationPicker
- SearchField
- HeroBanner
- ServiceShortcutGrid
- DeviceStatusCard
- SectionHeader
- AIChatBubble
- QuickActionChip
- BookingStepper
- TimeSlotPicker
- TechnicianCard
- TrackingTimeline
- BottomNavigation
- ProfileMenuItem

Khi triển khai thật, giữ typography, spacing và content hierarchy giống reference; chỉ thay crop-image bằng component thực.
