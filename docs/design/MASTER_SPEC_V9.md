# TÀI LIỆU ĐẶC TẢ CHUẨN HÓA TOÀN DIỆN & QUY CHUẨN THIẾT KẾ TỐI CAO (MASTER SPEC V9.0 UNIFIED)
> **Hệ quy chiếu Tối cao:** Hệ thống Thiết kế *Eco-Clean Sanctuary 1* (`DESIGN_SYSTEM_1`), *10 Quy luật The Laws of Simplicity (John Maeda)*, *Nguyên lý Tiết lộ Thông tin Tịnh tiến (Progressive Disclosure)* & *Apple Human Interface Guidelines (HIG)*.  
> **Mô hình kiến trúc:** 1 Ứng dụng Hợp nhất (Unified Dual-Role: Khách hàng & Thợ).  
> **Khung hiển thị bất biến:** Mobile **390px × 844px** (`device_type: mobile`, tỷ lệ 19.5:9, Pure Native Viewport - 100% Không giả lập vỏ máy, không tai thỏ giả tạo).

---

## PHẦN 1: HỆ THỐNG QUẢN TRỊ MÀU SẮC CHUẨN HÓA & NGUYÊN TẮC 60 - 30 - 10

### 1.1. Nguyên tắc Cốt lõi: Tuyệt đối Không sử dụng Màu Đen Thuần (#000000)
Hệ thống thiết kế **Eco-Clean Sanctuary** được xây dựng nhằm mang lại cảm giác tinh tươm, thanh sạch, an tâm, thư thái và tự nhiên cho không gian sống gia đình.
- **Cấm kỵ tối cao:** Tuyệt đối không dùng màu đen thuần `#000000` hoặc các khối hộp đen sì nặng nề gây gắt mắt, tạo cảm giác áp lực, nặng trĩu hay mờ đục.
- **Màu văn bản tối:** Toàn bộ tiêu đề lớn, nhãn chính, thông số số tiền, số điện thoại sử dụng **Xanh đen mực sâu / Dark Slate `#0F172A`** (token `text_primary`). Màu này đạt độ tương phản tối cao chuẩn WCAG AAA, chống lóa khi thợ nhìn ngoài trời nắng và dịu mắt khi khách dùng ban đêm. **Tuyệt đối không dùng `#0F172A` làm màu nền mảng lớn gây biến dạng phong cách**.

### 1.2. Ma trận Mã Màu Khóa Cứng (Locked Design Tokens)

| Nhóm Token | Tên Token | Mã HEX | Vai trò & Quy định áp dụng bất biến |
| :--- | :--- | :--- | :--- |
| **Primary** | `primary` | `#0D9488` | **Màu Xanh Teal độc tôn:** Dành riêng cho **1 Nút hành động chính duy nhất (Primary CTA)** của màn hình (*"Đặt hẹn"*, *"Hoàn tất"*, *"Nhận việc"*) hoặc tab đang Active. Tuyệt đối không đổ bừa bãi vào icon phụ, badge hay viền. |
| **Primary Pressed** | `primary_pressed` | `#0F766E` | Trạng thái chạm giữ (Active / Pressed) của nút chính. |
| **Secondary Tint** | `secondary` | `#CCFBF1` | Xanh bạc hà nhạt cho badge nổi bật nhẹ, highlight an toàn. |
| **Secondary Surface**| `secondary_surface`| `#F0FDFA` | **Nền chọn lọc (Active Chip/Card):** Nền cho Chip ngành nghề đã chọn, thẻ đang kích hoạt khi kết hợp cùng viền Teal `#0D9488`. Tạo cảm giác thanh thoát, hiện đại, không bị đen đặc. |
| **App Background** | `background` | `#FAF9F6` | **Tone Ngà Ấm Tự Nhiên (Ivory Sanctuary):** Nền bao phủ toàn bộ ứng dụng, chống chói gắt, tạo không gian bảo vệ mắt. |
| **Card Surface** | `surface` | `#FFFFFF` | **Mặt thẻ trắng tinh khiết:** Tạo các khối Card nội dung nổi bật tự nhiên trên nền ngà ấm. |
| **Text Primary** | `text_primary` | `#0F172A` | **Đen mực Slate:** Tiêu đề lớn, nhãn trường chính, giá tiền, số điện thoại. Chuẩn tương phản tối cao WCAG AAA. |
| **Text Secondary** | `text_secondary` | `#475569` | Xám đá Slate trung tính cho mô tả dịch vụ, địa chỉ phụ, thông tin thứ cấp. |
| **Text Muted** | `text_muted` | `#94A3B8` | Xám bạc nhạt cho chú thích bảo mật, placeholder nhập liệu, thời gian phụ. |
| **Border Hairline** | `border` | `#E2E8F0` | **Viền siêu mảnh 1px thay cho đổ bóng:** Triệt tiêu 100% bóng mờ đục (**Zero Shadows**), giữ mặt phẳng tinh tế. |
| **Semantic Success** | `success` | `#10B981` / `#059669`| Huy hiệu đã xác thực OTP, cam kết phê duyệt tự động, tài khoản khả dụng. |
| **Semantic Warning** | `warning` | `#F59E0B` | Cảnh báo khẩn, đơn làm liền cần gấp, ghi chú hiện trường. |
| **Semantic Error** | `error` | `#EF4444` / `#F43F5E`| Dấu trường bắt buộc `*`, hủy đơn, cảnh báo rủi ro cao. |

### 1.3. Công thức Tỷ lệ Phối màu Vàng Bất biến: 60 - 30 - 10

```
 ┌──────────────────────────────────────────────────────────────┐
 │ 60% NỀN TẢNG (DOMINANT SURFACES)                             │
 │ • Nền ngà ấm #FAF9F6 + Bề mặt thẻ trắng #FFFFFF               │
 ├──────────────────────────────────────────────────────────────┤
 │ 30% CẤU TRÚC & NỘI DUNG (STRUCTURAL NEUTRALS)                │
 │ • Chữ đen mực #0F172A + Viền Hairline #E2E8F0 + Text #475569  │
 ├──────────────────────────────────────────────────────────────┤
 │ 10% ĐIỂM NHẤN ĐỘC TÔN (SINGLE DOMINANT ACCENT)               │
 │ • 1 Nút CTA chính duy nhất #0D9488 hoặc Tab Active           │
 └──────────────────────────────────────────────────────────────┘
```

### 1.4. Quy chuẩn Trạng thái Lựa chọn & Biểu tượng Ngữ cảnh (Semantic Context)
1. **Trạng thái Chip chọn nghề / Mức kinh nghiệm (Selection Controls):**
   - **Đã chọn:** Nền xanh ngọc nhạt `bg-[#F0FDFA]`, viền xanh Teal `border-[#0D9488]`, chữ đen mực `text-[#0F172A]` kèm icon tick xanh. **Tuyệt đối không dùng khối nền đen sì**.
   - **Chưa chọn:** Nền trắng `bg-[#FFFFFF]`, viền hairline `border-[#E2E8F0]`, chữ xám đá `text-[#475569]`.
2. **Hệ thống Biểu tượng Ngữ cảnh (Semantic Iconography):**
   - Icon định vị, nhập liệu, phụ trợ: Luôn dùng xám trung tính `text-slate-400` / `text-slate-500`.
   - Chuẩn icon viền mảnh (**Ultralight / Hairline stroke 1.25px - 1.5px**), dạng glyph trần thoáng đãng, kích thước chuẩn `20px × 20px` hoặc `24px × 24px`. Không bọc trong các khung tròn/vuông đóng hộp cúc áo cồng kềnh.
   - **Tuyệt đối không biến tất cả icon trên trang thành màu Teal `#0D9488`**.

---

## PHẦN 2: 10 QUY LUẬT CỦA SỰ ĐƠN GIẢN (THE LAWS OF SIMPLICITY — JOHN MAEDA) & MA TRẬN 3 TẦNG TIẾT LỘ THÔNG TIN TỊNH TIẾN (PROGRESSIVE DISCLOSURE)

### 2.1. Bảng Đối chiếu 10 Quy luật Thực thi trên Mọi Màn hình

| STT | Quy luật | Tên quy luật | Nguyên tắc Cốt lõi | Hiện thực hóa UI/UX Bất biến (Khách & Thợ) |
| :---: | :--- | :--- | :--- | :--- |
| **1** | **REDUCE** | **Thu giảm** | *Loại bỏ những thứ không cần thiết.* | Cắt bỏ 100% vỏ điện thoại giả lập, tai thỏ mô phỏng, đường viền dày và bóng mờ đục (**Zero Shadows**). Triệt tiêu câu chữ thừa; biểu mẫu chỉ giữ các trường thực sự cốt tử. |
| **2** | **ORGANIZE** | **Tổ chức** | *Tổ chức làm hệ thống trông như có ít thành phần hơn.* | Phân cụm thông tin theo khối thẻ rõ ràng (**Glanceable Cards**). Phân tách bằng khoảng trắng và viền hairline mỏng (`border-[#E2E8F0]`). Phân cấp thị giác: Tiêu đề ➔ Nội dung chính ➔ Thông tin phụ. |
| **3** | **TIME** | **Tiết kiệm thời gian**| *Làm cho người dùng thao tác nhanh nhất có thể.* | Tối ưu phản xạ 1 chạm: Nút bấm to (`min-h-[48px]`), điền sẵn giá trị mặc định hợp lý (*Smart defaults*), không bắt người dùng suy nghĩ hay đọc quá 3 giây trên một màn hình. |
| **4** | **LEARN** | **Học hỏi** | *Mượn kiến thức quen thuộc để dùng ngay không cần học.*| Dùng các mẫu UI chuẩn phổ quát (Bottom Nav, Segmented Control, Search Bar, Stepper). Kết hợp trực tiếp với **Progressive Disclosure** để giấu chi tiết phức tạp vào tầng thứ hai. |
| **5** | **DIFFERENCES**| **Khác biệt / Tương phản** | *Tương phản tạo nên sự nhận biết.* | **Single Dominant Accent:** Màu Teal `#0D9488` dành độc tôn cho **1 Nút hành động chính (Primary CTA)** hoặc Tab Active. Tiêu đề đen mực sâu `#0F172A` dứt khoát trên nền ngà ấm `#FAF9F6`. |
| **6** | **CONTEXT** | **Ngữ cảnh** | *Ngữ cảnh định hình trải nghiệm đúng lúc, đúng chỗ.* | Tự thích ứng theo tình huống: tương phản cao cho Thợ ngoài trời nắng, khi đang di chuyển chỉ hiện chỉ đường + gọi điện, khi đến nơi hiển thị nút check-in và ô chụp ảnh nghiệm thu. |
| **7** | **EMOTION** | **Cảm xúc** | *Cảm xúc giúp trải nghiệm gần gũi và an tâm hơn.* | Vi tương tác tinh tế (*Micro-interactions*): tick xanh xác thực, chuyển tab mượt mà. Ngôn ngữ đời thường, ấm áp, chăm sóc gia đình; không dùng từ ngữ gây hoang mang hay khô cứng. |
| **8** | **TRUST** | **Tin tưởng** | *Niềm tin bắt nguồn từ sự minh bạch.* | Minh bạch 100% chi phí, bảng giá niêm yết rõ ràng (*Từ 150k*), hiển thị dòng *"Thực nhận về ví"* cho Thợ (sau khấu trừ phí sàn), thẻ xác minh danh tính và bảo hành rõ ràng. |
| **9** | **FAILURE** | **Phòng ngừa lỗi** | *Thiết kế sẵn sàng cho sai sót thực tế.* | Chống chạm nhầm bằng nút trượt an toàn (*Slide-to-toggle*) hoặc hộp thoại xác nhận khi hủy đơn; thông báo lỗi luôn kèm nút hành động khắc phục tức thì (*Constructive recovery*). |
| **10**| **THE ONE** | **Một — Tinh hoa** | *Mỗi màn hình chỉ phục vụ một mục tiêu cốt tử duy nhất.*| **One Screen = One Dominant Goal:** Trang tìm việc chỉ để tìm việc; Trang thanh toán chỉ để thanh toán; Trang check-in chỉ để check-in. Không phân tán sự chú ý của người dùng. |

### 2.2. Ma trận 3 Tầng Thông tin Bất biến (Progressive Disclosure)

```
 ┌──────────────────────────────────────────────────────────────┐
 │ TẦNG 1: BỀ MẶT LƯỚT NHANH (Glanceable Surface - 0.5 Giây)   │
 │ • Tối đa 3-4 thông số sống còn (Tên việc, Cự ly, Tiền, Trạng thái)│
 │ • 1 Nút hành động chính dứt khoát (Primary CTA)              │
 └──────────────────────────────┬───────────────────────────────┘
                                │ Chạm vào thẻ (Tap)
                                ▼
 ┌──────────────────────────────────────────────────────────────┐
 │ TẦNG 2: BẢNG MỞ RỘNG THEO NGỮ CẢNH (Progressive Bottom Sheet)│
 │ • Bung lên khi người dùng chạm: Địa chỉ chi tiết, ghi chú    │
 │   gia chủ, ảnh chụp hiện trường, phân tích biểu phí linh kiện│
 └──────────────────────────────┬───────────────────────────────┘
                                │ Tra cứu sâu / Quản trị
                                ▼
 ┌──────────────────────────────────────────────────────────────┐
 │ TẦNG 3: THÔNG TIN CHUYÊN SÂU & QUẢN TRỊ (Deep System Context)│
 │ • Giấu vào menu hỗ trợ / cài đặt: Lịch sử đơn, điều khoản,  │
 │   chính sách bồi hoàn, trung tâm trợ giúp và khiếu nại      │
 └──────────────────────────────┘
```

---

## PHẦN 3: QUY CHUẨN GIAO DIỆN THUẦN TÚY, ẢNH THỰC TẾ & FIXED FLOATING NAVIGATION DOCK

### 3.1. Pure Native Viewport (Giao diện Thuần túy - Tuyệt đối Không Giả lập Vỏ máy)
- **Kích thước bất biến:** `Mobile 390px × 844px` (`device_type: mobile`, tỷ lệ 19.5:9).
- **Tuyệt đối không vẽ vỏ máy:** Cắt bỏ hoàn toàn khung viền bo ngoài, góc giả lập iPhone, viền bezel dày, vạch home ảo hay tai thỏ mô phỏng. Toàn bộ giao diện trải phẳng tự nhiên tràn cạnh với màu nền ngà ấm `#FAF9F6`.

### 3.2. Photo-First & Realistic Squircle Thumbnails (Ảnh Thực tế Thay Cho Icon Trừu tượng)
- **Danh mục Dịch vụ (Categories):** Sử dụng các ô thẻ ảnh chụp vuông bo góc mềm mại (**Squircle Photo Thumbnails**) ghi lại khoảnh khắc người thợ đang thao tác thực tế (sửa máy lạnh, vặn ống nước, vệ sinh máy, khoan mộc). Khách hàng nhận diện ngay nhu cầu sửa chữa chỉ trong **0.5 giây**.
- **Thẻ Dịch vụ Trực quan (Visual Photo Cards):** Ảnh chụp tình huống sắc nét, có chiều sâu, kết hợp badge trạng thái (*"Ưu đãi 15%"*, *"Nhanh 20p"*) tạo cảm giác tin cậy, tay nghề cao (Social Proof & Trust).

### 3.3. Fixed Floating Dock Navigation & Khoảng Đệm An Toàn (Scroll Clearance)
- **Vị trí bất biến:** Thanh điều hướng đáy (Bottom Nav Dock) luôn ghim cố định tuyệt đối ở chân màn hình (`fixed bottom-4 left-4 right-4 z-50`), dạng viên nang nổi (Floating Capsule Dock) với nền trắng `#FFFFFF`, viền hairline `#E2E8F0` và bo tròn tối đa (`rounded-full`).
- **Khoảng đệm an toàn bắt buộc (Scroll Clearance):** Vùng chứa nội dung trang bắt buộc phải có đệm đáy **`pb-28` đến `pb-32`** để đảm bảo khi cuộn đến kịch đáy, các thẻ dịch vụ và nút thao tác cuối cùng không bao giờ bị thanh dock đáy che khuất.
- **Trạng thái Tab Active:** Tab đang chọn đổi sang dạng viên thuốc màu Teal `#0D9488` chữ trắng sắc nét; các tab còn lại giữ icon xám trung tính `slate-500` kèm nhãn chữ rõ ràng.

### 3.4. Hệ thống Bo góc Tinh tế (Border Radius Hierarchy)
- Tránh lạm dụng bo góc quá khổ (chà bá `rounded-full` / `rounded-3xl`) cho các thẻ khối to.
- Chuẩn phân cấp:
  - `rounded-lg` (8px): Chip nhỏ, badge trạng thái, tag dịch vụ.
  - `rounded-xl` (12px - 14px): Ô nhập liệu (input), chip chọn nghề/kinh nghiệm, nút bấm chính (CTA).
  - `rounded-2xl` (16px): Thẻ Card khối nội dung chính.
  - `rounded-full` (999px): Duy nhất cho Thanh dock điều hướng đáy ghim nổi và nút tròn đặc biệt.

### 3.5. Tối ưu Công thái học U50 & Typography Sắc nét
- **Màu chữ:** Đen mực sâu `#0F172A` dứt khoát, font-weight chuẩn (`font-bold`, `font-semibold`), không chèn ép ký tự, không rớt dòng ngắt chữ ở các nhãn trường.
- **Kích thước chữ tối thiểu:** Nhãn trường ≥ `14px - 15px`; Văn bản nhập ≥ `16px` (chống iOS tự động zoom); Tiêu đề card ≥ `18px`; Nút bấm chính: `16px - 17px`. Toàn bộ giá niêm yết hiển thị rõ ràng (*Từ 150K*), minh bạch từng đồng.

---

## PHẦN 4: MA TRẬN TỔNG HỢP TOÀN BỘ CÁC MÀN HÌNH HỆ THỐNG (CUSTOMER & WORKER)

| Mã màn hình | Tên màn hình | Phân hệ | Chức năng cốt lõi & Hành động chính | Quy chuẩn Tối giản & Visual Áp dụng |
| :---: | :--- | :---: | :--- | :--- |
| **01** | **Splash Screen** | Chung | Thương hiệu Home Service kết hợp mô hình 3D Isometric diorama. Tối giản 100% chữ thừa. | Không viền giả lập, chuyển cảnh êm, logo & 3D tiệp nền ngà ấm `#FAF9F6`. |
| **02** | **Role Gateway** | Khách / Thợ | Cổng phân vai trò 50/50: *"Cần sửa chữa & Dịch vụ"* vs *"Đi làm & Tăng thu nhập"*. | Chuyển đổi nền tương ứng theo tab chọn; dẫn vào luồng Phone OTP; nút tối giản chữ. |
| **03** | **Phone OTP Auth (3A-3B)** | Khách / Thợ | Nhập số điện thoại 1 chạm, nhận mã OTP SMS. Tự động nhận diện tài khoản mới/cũ. | Bàn phím số tự động, đếm lùi gửi lại mã, nút CTA dứt khoát, không nhét chữ dài. |
| **04** | **Thông tin Khách (3C)** | Khách | Hoàn tất hồ sơ khách sau OTP: Họ tên, SĐT xác thực, Địa chỉ phục vụ. | **Zero shadows**, viền hairline, icon xám trung tính, Teal độc tôn tại nút Hoàn tất. |
| **05** | **Worker Onboarding** | Thợ | Hồ sơ thợ: Chọn nhóm nghề, cài đặt bán kính nhận việc GPS, giấy tờ định danh (CCCD). | Chip chọn `bg-[#F0FDFA]` + `border-[#0D9488]` (không nền đen), bo góc tinh tế `rounded-xl`. |
| **06** | **Trang chủ Khách (SCREEN_2 Master)** | Khách | **Đầy đủ 4 phân hệ** (*Khám phá, Hoạt động, Ưu đãi, Tài khoản*); danh mục ảnh Squircle thực tế; thẻ việc trực quan; nút chuyển Chế độ Thợ. | **Pure Native Viewport**, **Fixed Floating Dock Navigation (`z-50`)**, `pb-28` chống che khuất nội dung. |
| **07** | **Chi tiết Dịch vụ** | Khách | Phân loại chi tiết thiết bị (máy lạnh treo tường, âm trần...), thông số giá cố định minh bạch. | Chọn số lượng thiết bị, tính tiền trực tiếp, loại bỏ thuật ngữ kỹ thuật khó hiểu. |
| **08** | **Dịch vụ Kèm theo (Add-ons)** | Khách | Danh sách Add-ons (khử khuẩn Eco, vệ sinh quạt lồng sốc, kiểm tra gas). | Bố cục cuộn dọc tinh gọn; nút `(+)` / `(-)` thêm nhanh vào giỏ; tính tổng ở thanh đáy. |
| **09** | **Chọn Thời gian** | Khách | Lưới chọn ngày thông minh & khung giờ thợ đến (Khung 2 giờ tiêu chuẩn). | Chọn ngày/giờ 1 chạm; ghi chú nhanh cho thợ; khoảng cách thoáng đãng. |
| **10** | **Xác nhận & Chốt đơn** | Khách | Hợp nhất 2 phương thức: **"Thợ đến ngay"** & **"Đặt lịch hẹn"**. Tích hợp đổi địa chỉ GPS, bảng tóm tắt giá minh bạch. | Chuyển tab Đặt hẹn/Đến ngay; Bottom Sheet chọn địa chỉ; nút đặt hành động dứt khoát. |
| **11** | **Theo dõi đơn (7A-7D)** | Khách | Vòng đời đơn hàng 4 trạng thái đồng bộ Header & Stepper (Đang tìm thợ -> Đã nhận -> Đang di chuyển -> Đang thực hiện). | Stepper chữ đồng bộ; icon hairline ngữ cảnh; nút gọi thợ & trung tâm hỗ trợ rõ ràng. |
| **12** | **Khảo sát & Duyệt giá** | Khách | Nhận báo giá điều chỉnh khi thợ phát hiện linh kiện hỏng tại hiện trường kèm ảnh chụp thực tế. | Khách xem ảnh hỏng hóc, bấm *"Đồng ý sửa"* để thợ tiến hành; minh bạch chi phí. |
| **13** | **Nghiệm thu & Thanh toán** | Khách | Nghiệm thu chất lượng; hóa đơn điện tử; thanh toán chuẩn Grab (Tiền mặt hoặc VietQR). | Chọn phương thức tiền mặt / quét mã QR; nút "Thanh toán" dứt khoát; loại bỏ chữ thừa. |
| **14** | **Sảnh tìm việc Thợ** | Thợ | 4 tab đáy (*Sảnh việc, Đơn hàng, Thu nhập, Cá nhân*); Hợp nhất đơn làm liền & đặt lịch; thanh trượt an toàn bật/tắt nhận việc. | Chuyển đổi mượt giữa Bản đồ & Danh sách; bấm thẻ việc mở chi tiết; tối ưu cho thợ ngoài đường. |
| **15** | **Thực hiện đơn Thợ** | Thợ | Dẫn đường GPS ──► Bấm *"Check-in"* ──► Tùy chọn: Làm ngay hoặc Báo giá phát sinh 1 chạm kèm chụp ảnh hiện trường. | Nút mở Google Maps, gọi khách; form báo phát sinh siêu tốc kèm camera hiện trường. |
| **16** | **Quản lý Thu nhập Thợ** | Thợ | Báo cáo doanh thu ngày/tuần; số dư ví khả dụng; khấu trừ phí sàn tự động; nút Nạp tiền & Rút về ngân hàng. | Minh bạch lịch sử giao dịch từng đơn; giao dịch tài chính dứt khoát, an tâm. |

---

## PHẦN 5: CƠ CHẾ VẬN HÀNH NGHIỆP VỤ & TÀI CHÍNH TỔNG HỢP

1. **Cơ chế Ký quỹ Ví Thợ & Thu tiền Tự động (Mô hình chuẩn Grab):**
   - Thợ duy trì số dư ký quỹ tối thiểu trong ví để nhận đơn.
   - **Nếu khách trả tiền mặt:** Thợ nhận đủ 100% tiền mặt từ khách; hệ thống tự động khấu trừ % phí hoa hồng nền tảng trực tiếp từ Ví ký quỹ của Thợ.
   - **Nếu khách quét mã VietQR:** Tiền chuyển về cổng thanh toán trung tâm; hệ thống tự động cộng doanh thu (sau khi trừ phí sàn) vào Ví thợ ngay tức khắc.
   - Triệt tiêu 100% sự phức tạp của việc thu hồi công nợ thủ công ngoài đời thực.

2. **Cơ chế Check-in GPS & Báo giá Phát sinh Hiện trường (Change Order):**
   - Thợ đến vị trí khách bấm **"Check-in"** (hệ thống xác thực tọa độ GPS hiện trường).
   - Khảo sát thực tế: Nếu đúng hạng mục cam kết ──► tiến hành làm ngay. Nếu phát sinh lỗi linh kiện hỏng ──► Thợ chọn nhanh linh kiện từ danh mục gợi ý có sẵn đơn giá + chụp ảnh hiện trường gửi khách.
   - Khách nhận thông báo trên điện thoại và bấm xác nhận đồng ý thì đơn giá mới được cập nhật vào hóa đơn nghiệm thu cuối cùng.

---

## PHẦN 6: BẢNG CHECKLIST KIỂM ĐỊNH MÀN HÌNH TRƯỚC KHI XUẤT BẢN

Mọi màn hình được tạo mới hoặc chỉnh sửa bắt buộc phải đối chiếu và vượt qua **8 tiêu chuẩn kiểm định** sau:

- [ ] **1. Pure Native Viewport:** Đã loại bỏ hoàn toàn viền vỏ thiết bị giả lập, tai thỏ mô phỏng, vạch pin/sóng giả tạo chưa? Chiều rộng khóa cứng chuẩn **`390px`** (`device_type: mobile`) chưa?
- [ ] **2. Tuyệt đối không có màu đen `#000000`:** Đã kiểm tra không có bất kỳ mảng khối hay nút bấm nào dùng nền đen tuyền? Màu chữ tối đã dùng đúng Đen mực Slate `#0F172A` chưa?
- [ ] **3. Tỷ lệ Phối màu Vàng 60 - 30 - 10:** Nền ngà ấm `#FAF9F6` + thẻ trắng `#FFFFFF` chiếm 60%; Chữ `#0F172A` + viền `#E2E8F0` chiếm 30%; Nút CTA chính Teal `#0D9488` độc tôn chiếm 10% chưa?
- [ ] **4. Trạng thái Chip & Card đã chọn:** Đã dùng đúng cặp đôi `bg-[#F0FDFA]` + `border-[#0D9488]` kèm icon tick xanh thay cho các khối nền đen sì chưa?
- [ ] **5. Fixed Floating Navigation & Scroll Clearance:** Nếu có thanh dock đáy, đã ghim cố định (`fixed bottom-4 left-4 right-4 z-50`) chưa? Phần thân trang đã có khoảng đệm an toàn **`pb-28` đến `pb-32`** chống che khuất nội dung khi cuộn kịch đáy chưa?
- [ ] **6. Photo-First vs Icon:** Các mục danh mục dịch vụ chính đã ưu tiên dùng ảnh chụp thực tế bo góc vuông mềm (**Squircle Photo Thumbnails**) thay vì icon trừu tượng chưa?
- [ ] **7. Zero Shadows:** Toàn bộ bóng mờ đục (`box-shadow`, `drop-shadow`) đã được triệt tiêu 100% và thay thế hoàn toàn bằng viền hairline siêu mảnh `#E2E8F0` chưa?
- [ ] **8. Typography & Công thái học U50:** Tiêu đề & nhãn đã dùng màu đen mực sâu `#0F172A` dứt khoát chưa? Cỡ chữ đã đạt tối thiểu 14px cho nhãn và 16px cho nội dung chưa?

---
*Tài liệu này là Hệ Quy Chiếu Chuẩn Hóa Tối Cao Duy Nhất của toàn bộ dự án Home Service (Eco-Clean Sanctuary 1), hợp nhất hoàn toàn DOCUMENT_2, DOCUMENT_17 và DOCUMENT_42.*
