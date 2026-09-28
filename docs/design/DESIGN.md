# HomeService — Concept 02: Contemporary Folk Utility (UI/UX Design Spec)

> **Dự án:** VSTech Home Services  
> **Phiên bản:** Concept 02 (Contemporary Folk Utility) — Đồng bộ chuẩn hóa với [`MASTER_SPEC_V9.md`](MASTER_SPEC_V9.md) và [`AGENTS.md`](../../AGENTS.md).  
> **Khung hiển thị:** Mobile **390 × 844 px** (Pure Native Viewport, không vẽ vỏ máy giả lập).  
> **Ngôn ngữ:** Tiếng Việt làm mặc định (hỗ trợ chuyển đổi Tiếng Anh `vi` | `en`).  
> **Tham chiếu gốc:** Thư mục thiết kế nguyên bản tại [`docs/design/design_temp/`](design_temp/).

---

## 0. Tổng Quan (Overview)

| Thuộc tính | Định nghĩa & Giá trị |
| :--- | :--- |
| **Sản phẩm** | Ứng dụng di động hợp nhất 2 vai trò: Khách hàng (Customer) và Đối tác Thợ (Worker). |
| **Phong cách chủ đạo** | **Contemporary Folk Utility** — Hiện đại, tiện ích, ấm áp, gần gũi, mang bản sắc đô thị Việt Nam. |
| **Khung màn hình** | **390 × 844 px** (Tỉ lệ 19.5:9, Pure Native Viewport, tối ưu công thái học 1 tay chạm). |
| **Ma trận màn hình** | 70 ô hiển thị trên presentation board: Khách hàng (01–17), Thợ (18–22), Phân quyền & Xác thực (23–30), Đăng ký Thợ KYC (31–39). |
| **Chủ đề (Theme)** | Light Mode làm mặc định trên nền ngà ấm `#FAF9F6`. |
| **Thông điệp (Taglines)** | *Nhà tốt hơn mỗi ngày* · *Nhịp sống vội, nhà vẫn luôn là nơi chờ bạn.* · *Việc nhà nhẹ hơn — Cuộc sống tươi hơn* |

---

## 1. Triết Lý & Nguyên Tắc Thiết Kế Cốt Lõi (Design Principles)

1. **Nền ngà ấm tự nhiên:** Sử dụng nền ngà ấm `#FAF9F6` thay cho màu xám xanh công nghệ lạnh lẽo. Mặt thẻ trắng `#FFFFFF` với viền hairline mỏng `1px` (`#E2E8F0`), triệt tiêu 100% bóng mờ đục (**Zero Shadows**).
2. **Một hành động chính dứt khoát (One Primary Action):** Mỗi màn hình có **đúng 1 Nút CTA chính** (chiều cao chuẩn 48–54px), dạng khối đặc nổi bật.
3. **Bản sắc văn bản & hình ảnh Việt:** Lớp hình ảnh văn hóa (skyline thành phố, gia đình Việt) xuất hiện tinh tế ở các màn thương hiệu và điểm xuyết nhẹ ở Trang chủ. Trong các luồng thao tác chức năng (Đặt việc, Check-in, Báo giá, Thanh toán), giao diện lùi về phong cách tối giản tuyệt đối để tối ưu tốc độ.
4. **Ba tiêu chuẩn bất biến:**
   - **Đọc hiểu trong 3 giây (Readable in 3 seconds)**.
   - **1 Nút CTA chính duy nhất trên màn hình (One CTA per screen)**.
   - **Thao tác thuận tiện bằng 1 ngón tay cái (Reachable with one thumb)**.

---

## 2. Hệ Thống Màu Sắc Chuẩn Hóa (Color System — Locked Tokens)

Hệ màu khóa cứng theo quy tắc vàng **60 - 30 - 10** và tuân thủ tuyệt đối quy định **Không sử dụng màu đen thuần `#000000`**:

| Nhóm màu | Token | Mã HEX | Vai trò & Quy định áp dụng |
| :--- | :--- | :--- | :--- |
| **Primary Teal** | `primary` | `#0D9488` | Màu nhấn thương hiệu độc tôn: Dành riêng cho **1 Nút CTA chính** điều hướng tiến bước (*"Tiếp tục"*, *"Đặt lịch"*, *"Tôi đã đến"*), tab Active, viền thẻ được chọn. |
| **Primary Pressed** | `primaryPressed`| `#0F766E` | Trạng thái chạm giữ (Pressed) của nút Teal chính. |
| **Secondary Tint** | `secondary` | `#CCFBF1` | Xanh bạc hà nhạt cho badge, điểm nhấn an toàn. |
| **Secondary Surface**|`secondarySurface`|`#F0FDFA`| Nền cho Chip ngành nghề / Thẻ đang chọn khi kết hợp cùng viền Teal `#0D9488`. |
| **App Ground** | `background` | `#FAF9F6` | Nền ngà ấm toàn ứng dụng, chống lóa mắt, tạo cảm giác thanh sạch thư thái. |
| **Card Surface** | `surface` | `#FFFFFF` | Nền mặt thẻ nội dung, danh mục, bảng biểu. |
| **Border Hairline**| `border` | `#E2E8F0` | Viền siêu mảnh 1px thay thế cho đổ bóng (**Zero Shadows**). |
| **Primary Ink** | `textPrimary` | `#0F172A` | Đen mực Slate cho tiêu đề lớn, nhãn chính, số tiền, số điện thoại (WCAG AAA). **Không dùng #000000**. |
| **Secondary Ink** | `textSecondary`| `#475569` | Xám đá Slate cho mô tả dịch vụ, địa chỉ phụ, thông tin thứ cấp. |
| **Muted Ink** | `textMuted` | `#94A3B8` | Xám nhạt cho placeholder, metadata, nhãn phụ, icon trung tính. |
| **Commitment Amber**| `warning` | `#F59E0B` | Dành riêng cho bước **Cam kết tài chính / Thanh toán** (*"Xác nhận đặt lịch"*, *"Thanh toán"*), sao đánh giá, chấm thông báo. |
| **Semantic Success**| `success` | `#10B981` | Trạng thái hoàn tất, đã xác thực OTP, bảo hành khả dụng. |
| **Semantic Error** | `error` | `#EF4444` | Dấu trường bắt buộc `*`, nút hủy đơn (dạng outline), cảnh báo vi phạm. |

### Quy tắc Nút Hành Động (CTA Rules):
- **Teal (`#0D9488`):** Dành cho tiến trình đi tới (Tiếp theo, Bắt đầu ngay, Nhận việc, Nghiệm thu ngay).
- **Amber (`#F59E0B`):** Dành độc tôn cho các bước cam kết tiền bạc (Xác nhận đặt lịch chốt tiền, Thanh toán hóa đơn). Khi màn hình đã có nút Teal, Amber chỉ được phép xuất hiện dưới dạng huy hiệu hoặc dấu sao.
- **Nút Hủy / Xóa:** Tuyệt đối không dùng nút khối đỏ đặc rực rỡ, sử dụng dạng nút viền mảnh đỏ (**Outline Red**) hoặc Text Link đỏ kèm hộp thoại xác nhận an toàn.

---

## 3. Typography & Công Thái Học (Typography & Ergonomics)

Hệ thống typography sử dụng Google Fonts, khóa cứng 2 bộ font chuẩn mực:
- **Tiêu đề & Nút bấm:** `GoogleFonts.plusJakartaSans` (đậm nét, hiện đại, uy tín).
- **Nội dung & Số liệu / Giá tiền:** `GoogleFonts.inter` (rõ ràng, dễ đọc trên màn hình nhỏ).

| Cấp độ | Size / Weight | Font Family | Ứng dụng |
| :--- | :--- | :--- | :--- |
| **Display / Splash** | 26–28px / Bold (700) | Plus Jakarta Sans | Màn hình Splash, Banner Onboarding |
| **Screen Title** | 19–20px / Bold (700) | Plus Jakarta Sans | Tiêu đề đầu trang kèm nút Back |
| **Card / User Name** | 18–20px / SemiBold (600)| Plus Jakarta Sans | Lời chào Home, Tên Thợ, Tiêu đề thẻ |
| **Section Title** | 15–16px / SemiBold (600)| Plus Jakarta Sans | Tiêu đề phân mục trong trang |
| **Input / Body** | 15–16px / Regular (400) | Inter | Văn bản nhập liệu (≥16px chống iOS auto-zoom), nội dung mô tả |
| **Price / Number** | 16–22px / Bold (700) | Inter (Tabular figures) | Giá tiền niêm yết, số dư ví, đồng hồ đếm ngược |
| **Functional / Label**| 13–14px / Medium (500) | Inter | Nhãn trường, chú thích bảo mật |
| **Status Chip / Dock**| 10–12px / SemiBold (600)| Plus Jakarta Sans | Nhãn trạng thái, nhãn thanh điều hướng đáy |

---

## 4. Hình Khối & Khoảng Cách (Shape & Spacing)

- **Phân cấp Bo góc (Border Radius):**
  - `AppRadius.chip = 8px`: Chip nhỏ, tag trạng thái, nhãn ưu đãi.
  - `AppRadius.control = 12px`: Ô nhập liệu (input), chip chọn nghề, nút bấm CTA.
  - `AppRadius.card = 16px`: Thẻ nội dung chính (Card), bảng kê chi phí, bottom sheet.
  - `AppRadius.full = 9999px`: Thanh điều hướng đáy (Floating Bottom Nav Dock) và nút tròn icon.
- **Viền mảnh:** 1px `#E2E8F0` cho thẻ thường; 1.5px Teal `#0D9488` cho thẻ/chip đang được chọn.
- **Kích thước chạm tối thiểu (Touch Targets):** Tối thiểu `44 × 44px`, khuyến nghị `48 × 48px`.
- **Thanh Dock Nổi & Khoảng Đệm Cuộn (Scroll Clearance):**
  - Floating Bottom Nav Dock cố định ở chân màn hình (`fixed bottom-4 left-4 right-4`).
  - Toàn bộ thân trang có cuộn bắt buộc phải có khoảng đệm đáy **`112px – 128px` (`pb-28` đến `pb-32`)** để nội dung không bao giờ bị thanh dock che khuất.

---

## 5. Hệ Thống Biểu Tượng & Hình Ảnh Thực Tế (Photo-First & Icons)

### 5.1. Photo-First Squircle Thumbnails
- Các danh mục dịch vụ (Sửa máy lạnh, Thông nghẹt cống, Sửa điện nước, Vệ sinh nhà cửa) **bắt buộc ưu tiên sử dụng ảnh chụp thao tác thực tế** đặt trong khung vuông bo góc mềm (**Squircle Photo Cards**).
- Khách hàng nhận diện nhu cầu thị giác chỉ trong **0.5 giây**, loại bỏ cảm giác trừu tượng của icon phẳng.

### 5.2. Biểu tượng Điều hướng & Chức năng (Functional Icons)
- Sử dụng nét mảnh (**Hairline stroke 1.25px – 1.5px**), kích thước chuẩn `20px` hoặc `24px`.
- Màu xám trung tính Slate (`#94A3B8` / `#475569`), không bọc khung tròn/vuông đóng hộp cồng kềnh.
- Tuyệt đối không biến tất cả icon trên màn hình thành màu Teal.

---

## 6. Cấu Trúc Ứng Dụng & Phân Vai Trò (Dual-Role Architecture)

Một ứng dụng duy nhất, điều hướng tự động dựa trên vai trò tài khoản:

```
Splash (01) ──► Onboarding (02-06) ──► Cổng chọn vai trò (07) ──► Đăng nhập / OTP (08-11)
                                      ├── Role = CUSTOMER ──► Trang chủ Khách (Home Dock)
                                      └── Role = WORKER   ──► Sảnh tìm việc Thợ (Worker Dock)
```

### 6.1. Quy tắc Xác thực & Phân quyền (Auth Rules)
- **Đăng nhập Khách:** Nhập SĐT hoặc Email (điền sẵn mẫu `0901 234 567`).
- **Đăng nhập Thợ:** Chỉ dùng Số điện thoại (điền sẵn mẫu `0912 345 678`).
- **OTP dùng chung (Shared OTP Flow):**
  - Bàn phím số tự động, 6 ô nhập mã.
  - Tự động xác thực ngay khi đủ 6 số, hiển thị dòng gợi ý "Từ tin nhắn" 1 chạm.
  - Đếm lùi 60 giây gửi lại mã. Nhập sai mã: 6 ô chuyển viền đỏ kèm dòng báo lỗi thân thiện.
- **Quên mật khẩu:** SĐT $\to$ OTP $\to$ Mật khẩu mới $\to$ Thành công $\to$ Quay lại Đăng nhập giữ nguyên vai trò.

### 6.2. Quy trình 6 Bước Đăng Ký Thợ (Worker KYC — UC-W-10)
Tiến trình hiển thị rõ ràng: *"Bước n/6"*:
1. **Bước 1 (Xác thực SĐT):** Nhập SĐT và xác thực mã OTP SMS.
2. **Bước 2 (Thông tin cá nhân & Bán kính nhận việc):** Họ tên, ngày sinh, chọn nhóm nghề, cài đặt bán kính GPS (km).
3. **Bước 3 (Định danh CCCD):** Chụp mặt trước và mặt sau CCCD (Nút tiếp tục chỉ mở khi đủ 2 mặt).
4. **Bước 4 (Xác thực khuôn mặt):** Chụp ảnh selfie chân dung đối chiếu.
5. **Bước 5 (Chứng chỉ hành nghề):** Bắt buộc đối với dịch vụ Sửa máy lạnh hoặc Lắp đặt tầng cao (Chứng chỉ an toàn lao động); CTA chỉ mở khi đã tải ảnh chứng chỉ.
6. **Bước 6 (Tài khoản ngân hàng rút tiền):** Tên chủ tài khoản phải khớp với tên trên CCCD.
- **Trạng thái phê duyệt (Status Review):**
  - *Đang xét duyệt (Pending):* Nút *"Kiểm tra trạng thái"*.
  - *Cần bổ sung (Needs Info):* Báo rõ lý do kèm nút *"Bổ sung ảnh CCCD"* quay lại bước 3.
  - *Đã duyệt (Approved):* Chúc mừng kèm nút *"Bắt đầu nhận việc"* mở ra Sảnh việc Thợ.

---

## 7. Cơ Chế Đặt Lịch & Minh Bạch Chi Phí (Booking & Pricing Engine)

> [!IMPORTANT]
> **Định giá theo Phân loại Công việc & Ngữ cảnh mặt bằng (PRD v2.3):**  
> Tuyệt đối **KHÔNG tính tiền theo quãng đường di chuyển**.  
> `Dự toán chi phí = Công thợ (Gói cơ bản) + Dịch vụ kèm theo (Add-ons) + Phụ phí mặt bằng`.

### 7.1. Bảng Kê Minh Bạch Chi Phí (Itemized Price Summary)
Ví dụ thực tế cho đơn dịch vụ Vệ sinh nhà cửa:
- **Công thợ cơ bản (Gói Căn hộ dưới 70m²):** `350.000đ`
- **Dịch vụ đi kèm (Add-on: Thu gom rác thải mang xuống):** `30.000đ`
- **Phụ phí mặt bằng (Chung cư tầng 12, có thang máy):** `20.000đ`
- **👉 Tổng dự kiến Khách trả:** **`400.000đ`**
- **👉 Thực nhận về ví Thợ (Sau khấu trừ 15% phí sàn 60.000đ):** **`340.000đ`**

*Quy định phụ phí mặt bằng:* Nhà phố/nhà đất `0đ` · Chung cư có thang máy `20.000đ` · Chung cư thang bộ tầng cao `50.000đ`.

### 7.2. Luồng Đặt Lịch 4 Bước Tinh Gọn (Customer Booking Flow)
1. **Bước 1 (Chọn gói dịch vụ & Add-ons):** Chọn phân loại thiết bị, số lượng, bấm chọn thêm các gói Add-on cần thiết.
2. **Bước 2 (Thời gian & Địa điểm):** Lưới chọn ngày/khung giờ thợ đến (khung 2h tiêu chuẩn), xác nhận địa chỉ GPS, chọn loại nhà (nhà đất / chung cư tầng), tải tối đa 5 ảnh hiện trường.
3. **Bước 3 (Xác nhận & Chốt đơn):** Tóm tắt dự toán từng dòng, cam kết *"Bạn chỉ thanh toán sau khi nghiệm thu dịch vụ"*, chọn phương thức thanh toán (VietQR / VNPay / Tiền mặt), nút **Amber "Xác nhận đặt lịch · 400.000đ"** (chốt giá, chưa trừ tiền).
4. **Bước 4 (Sảnh tìm thợ - Matching Radar):** Vòng quét radar tự động tìm thợ trong 6 giây. Báo tên thợ nhận việc hoặc tùy chọn đổi giờ / hủy đơn miễn phí nếu chưa có thợ nhận.

---

## 8. Vòng Đời Thực Hiện Đơn & Thanh Toán (Service Execution & Payment)

Vòng đời 7 trạng thái được đồng bộ tên gọi và sự kiện giữa ứng dụng Khách hàng và Thợ (qua STOMP topic `/topic/booking/{id}`):

| STT | Trạng thái (OST) | Màn hình Khách hàng thấy | Màn hình Thợ thấy | Hành động chính |
| :---: | :--- | :--- | :--- | :--- |
| **0** | **Đã nhận việc** | Tracking: *"Anh Hùng đã nhận việc"* | Sảnh việc: Xem chi tiết đơn vừa nhận | Thợ chuẩn bị đồ nghề di chuyển |
| **1** | **Thợ đang đến** | Bản đồ GPS: *"Còn 8 phút · 2,4 km"*, Gọi / Chat | Bản đồ dẫn đường: Nút *"Mở Google Maps"*, Gọi khách | Nút Teal **"Tôi đã đến"** |
| **2** | **Thợ đã đến** | Tracking: Báo thợ đã check-in tại hiện trường | Màn hình check-in: Xác thực GPS | Nút Teal **"Bắt đầu làm"** |
| **3** | **Đang thực hiện** | Đồng hồ đếm giờ làm việc, checklist hạng mục | Danh sách 5 việc cần làm (Checklist 5/5) | Tích chọn công việc hoàn tất |
| **4** | **Chờ nghiệm thu** | Thông báo kèm ảnh chụp trước/sau nghiệm thu | Màn hình chờ: *"Chờ khách nghiệm thu"* | Khách bấm **"Xác nhận hoàn tất"** |
| **5** | **Chờ thanh toán** | Bảng hóa đơn điện tử cuối cùng, chọn hình thức | Màn hình chờ: *"Chờ khách thanh toán"* | Khách bấm **"Thanh toán 400.000đ"** |
| **6** | **Hoàn tất** | Hóa đơn điện tử + Đánh giá sao & Tip | Nhận thông báo: **"+340.000đ vào ví"** | Tiền cộng ngay vào ví Thợ |
| **7** | **Đang xem xét** | Màn hình khiếu nại (Dispute Under Review) | Thông báo đơn đang kiểm tra, giữ tiền tạm thời | Chăm sóc khách hàng hỗ trợ |

---

## 9. Phân Hệ Ngôi Nhà Của Bạn (Your Home & Device Management)

Module tạo sự khác biệt cốt lõi giữ chân khách hàng (Retention Flywheel):
- **Tab Thiết bị gia đình (Devices):** Quản lý hồ sơ thiết bị (Máy lạnh Daikin, Máy giặt LG, Tủ lạnh Samsung, Bình nước nóng Ariston). Hiển thị 2 trạng thái: *Hoạt động tốt (Xanh)* và *Cần bảo dưỡng (Đỏ)*.
- **Tab Lịch bảo trì định kỳ (Maintenance Schedule):** Sắp xếp theo thứ tự ngày cần bảo dưỡng kèm vạch màu cảnh báo (Đỏ: quá hạn, Vàng: sắp tới hạn, Xanh ngọc: định kỳ).
- **Hồ sơ sửa chữa trọn đời:** Lưu trữ toàn bộ linh kiện đã thay thế, Add-ons đã dùng và thợ từng làm, giúp thợ mới chẩn đoán lỗi tức thì khi tới nhà.

---

## 10. Trí Tuệ Nhân Tạo Hỗ Trợ (Role of AI Assistant)

- AI đóng vai trò **trợ lý tiện ích**, không làm gián đoạn luồng chính của khách hàng.
- Mở khung chat bằng lời chào thân thiện kèm **5 gợi ý tác vụ 1 chạm** (*"Vệ sinh máy lạnh"*, *"Kiểm tra rò rỉ nước"*, *"Báo giá thay kính"*).
- Gợi ý dịch vụ thông minh luôn kèm lý do dữ liệu cụ thể: *"Đã 4 tháng kể từ lần cuối bảo dưỡng máy lạnh phòng ngủ, bạn có muốn thợ kiểm tra gas không?"*.

---

## 11. Chuẩn Hóa Ngôn Ngữ Bản Địa (Copywriting Guidelines)

- **Ngôn ngữ đời thường, gần gũi:** Nói về công việc và lợi ích trực tiếp cho gia đình, không dùng thuật ngữ kỹ thuật khô cứng.
  - *Nên dùng:* *"Nhà sạch, sống khỏe hơn"* · *"Không còn lo muỗi, gián"*.
  - *Tránh dùng:* *"Dịch vụ vệ sinh tổng thể căn hộ diện tích vừa"*.
- **Minh bạch tài chính cho Thợ:** Luôn hiển thị rõ cụm từ **"thực nhận về ví"** đi kèm con số sau khi đã trừ phí sàn (ví dụ: `340.000đ`). Con số thực nhận luôn là con số lớn nhất ở dòng cuối cùng.
- **Thời gian cụ thể:** Thông báo trạng thái luôn đi kèm mốc giờ dự kiến: *"Kỹ thuật viên đang thực hiện, dự kiến hoàn tất lúc 16:30"*.

---

## 12. Danh Sách Dữ Liệu Mẫu Thống Nhất (Consistent Sample Data)

Một bộ dữ liệu mẫu xuyên suốt để toàn bộ các màn hình và kịch bản demo kể chung một câu chuyện liền mạch:

| Thực thể | Thông tin mẫu chuẩn |
| :--- | :--- |
| **Khách hàng** | Nguyễn Thị Mai · `0901 234 567` · `mainguyen@gmail.com` |
| **Địa chỉ phục vụ** | Căn hộ Riverside, 123 Nguyễn Thị Minh Khai, Quận 1 (Tầng 12, có thang máy) |
| **Đối tác Thợ** | Trần Văn Hùng · `0912 345 678` · Đánh giá 4.9⭐ (128 lượt) · 3 năm kinh nghiệm |
| **Đơn hàng mẫu** | Mã `#HS20250425-0012` · Vệ sinh nhà cửa · Hôm nay 14:00–17:00 |
| **Chi phí đơn hàng** | Công thợ 350.000đ + Dọn rác 30.000đ + Tầng lầu 20.000đ = Tổng 400.000đ |
| **Thực nhận thợ** | 400.000đ − 15% phí sàn (60.000đ) = **340.000đ về ví** |
| **Thiết bị nhà** | Máy lạnh Daikin (Tốt) · Máy giặt LG (Tốt) · Bình nước nóng Ariston (**Quá hạn bảo dưỡng**) |