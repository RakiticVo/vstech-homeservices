# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Tên dự án:** Nền Tảng Dịch Vụ Sửa Chữa & Thương Mại Đa Bên (B2C & B2B Hybrid Ecosystem)  
**Phiên bản:** 2.3 (Bản Cập Nhật Contextual Services & Dynamic Add-ons Flywheel)  
**Trạng thái:** Đã phê duyệt nâng cấp (Bổ sung Phân cấp Không gian Trong/Ngoài nhà, Khối Dịch vụ Đi kèm và Cơ chế Làm giàu Dữ liệu AI)  
**Ngày cập nhật:** 2026-09-03  

---

## 1. Tầm Nhìn & Mục Tiêu (Vision & Goals)

Kiến tạo một hệ sinh thái liền mạch dành cho lĩnh vực bảo trì, sửa chữa và cung ứng vật tư thiết bị gia đình & thương mại.  
Nền tảng thay đổi mô hình định giá truyền thống: KHÔNG tính tiền dựa trên quãng đường, mà DỰA TRÊN chi phí sửa chữa theo hạng mục, ngữ cảnh mặt bằng và giá linh kiện do AI phân tích. 

**Tầm nhìn mở rộng (V2.2):** Nền tảng không chỉ là "trạm trung chuyển gọi thợ", mà là **"Sổ y bạ điện tử"** số hóa toàn bộ vòng đời thiết bị trong gia đình. Thông qua cơ chế Bảo hành tự động (Auto-Warranty), nền tảng tạo ra vòng lặp giữ chân người dùng (Retention Loop) vững chắc, triệt tiêu rủi ro "thợ đem con bỏ chợ".

**Tầm nhìn đột phá (V2.3):** 
* **Xóa bỏ danh mục dịch vụ phẳng (Flat Taxonomy):** Mô hình hóa dịch vụ thành 3 tầng phân cấp: Không gian (`INDOOR` - Trong nhà / `OUTDOOR` - Ngoài trời / `HYBRID`), Dịch vụ cốt lõi, và Ma trận Add-on/Phụ phí ngữ cảnh (loại nhà đất, chung cư tầng cao, thang bộ).
* **AI Scoping & Dynamic Data Enrichment Flywheel:** Đưa AI Kỹ sư ảo vào giai đoạn tiền đặt lịch (Pre-booking) để tự động tư vấn, chẩn đoán rủi ro mặt bằng và gợi ý Add-on đi kèm chuẩn xác. Đồng thời thiết lập vòng xoay tự học 5 kênh (Voice thợ tại hiện trường, Chat mining, Thời tiết/mùa vụ, Catalog nhà cung cấp, A/B Testing) để liên tục "làm giàu" kho dữ liệu Add-on theo biến động thị trường.

---

## 2. Phân Tích Chân Dung Người Dùng (User Personas)

*   **Khách hàng Cá nhân (B2C):** Yêu cầu dịch vụ nhanh chóng, giá minh bạch. Được AI tư vấn chuẩn chuyên môn trước khi thợ tới, không cần biết thuật ngữ kỹ thuật vẫn chọn đúng gói và Add-on (ví dụ: dọn phế thải kính vỡ, bắn silicone chống thấm). Quản lý danh sách tài sản trong nhà, bảo hành điện tử 0đ.
*   **Khách hàng Doanh nghiệp (B2B):** Quản lý tòa nhà, văn phòng. Yêu cầu quy trình phê duyệt nội bộ, mời thầu, đấu thầu, kiểm tra chứng chỉ an toàn thợ thi công ngoài trời/tầng cao và nghiệm thu theo tiến độ (Milestones).
*   **Đối tác Dịch vụ (Worker / Agency):** Cần nhận việc, tối ưu lộ trình. Được cung cấp đầy đủ thông tin mặt bằng (tầng cao, thang máy, đồ nghề bảo hộ cần mang) trước khi nhận việc. **Có công cụ "1 chạm ghi âm" (Voice-to-Task) để báo việc phát sinh ngay tại hiện trường**, được bảo lãnh nhận tiền qua ví sàn và thưởng điểm đóng góp tri thức.
*   **Nhà cung cấp/Nhà sản xuất (Supplier / Advertiser):** Cung ứng vật tư và linh kiện vào hệ thống. Đồng bộ catalog phụ kiện theo từng địa bàn. Tham gia đấu thầu vị trí hiển thị (Ad Engine).
*   **Quản trị viên (Admin):** Vận hành hệ thống, giải quyết tranh chấp, phê duyệt các Add-on mới do AI tự động phát hiện và đề xuất từ hiện trường.

---

## 3. Các Luồng Chức Năng Cốt Lõi (Core User Flows)

### 3.1. Phân Loại Không Gian & Ma Trận Dịch Vụ Đi Kèm (Contextual Services & Add-ons) - *[MỚI V2.3]*
*   **Cấu trúc 3 tầng (3-Tier Taxonomy):**
    *   *Tầng 1 (Scope):* Phân định rõ ràng `INDOOR` (Nội thất), `OUTDOOR` (Ngoại thất/Sân vườn/Mái/Ban công), `HYBRID`. Đánh dấu yêu cầu chứng chỉ an toàn lao động (`requires_safety_cert`).
    *   *Tầng 2 (Core Service):* Dịch vụ cụ thể (Ví dụ: Thay kính cửa sổ, Vệ sinh pin năng lượng mặt trời).
    *   *Tầng 3 (Add-on & Context Matrix):* Gói vật tư đi kèm, dịch vụ phụ trợ (Tháo dỡ, dọn phế thải nguy hại, thay gioăng, chống rung), và phụ phí ngữ cảnh (Chung cư không thang hàng, bốc vác tầng lầu, thời tiết cực đoan).

### 3.2. AI Pre-booking Scoping & Tư Vấn Đặt Lịch Thông Minh - *[MỚI V2.3]*
*   **Kỹ sư ảo tiền đặt lịch:** Khách hàng mô tả sự cố bằng ngôn ngữ tự nhiên hoặc hình ảnh $\to$ AI phân tích ngữ cảnh, địa chỉ (nhà phố hay chung cư) để hỏi thêm 1-2 câu hỏi làm rõ và gợi ý chính xác các gói Add-on cần thiết.
*   **Minh bạch dự toán trước khi thợ tới:** Tổng chi phí hiển thị rõ ràng từng mục (Công thợ + Vật tư + Add-ons + Phụ phí mặt bằng), triệt tiêu hoàn toàn tình trạng thợ "vẽ giá" hoặc bỏ việc do phát sinh bất ngờ.
*   **Cơ chế Phục vụ Ca lạ & Xử lý Zero-Data (Zero-Data Handling Engine) - *[MVP Blocker]*:**
    * Khi khách hàng yêu cầu dịch vụ hoặc mã lỗi chưa có sẵn trong danh mục:
      1. AI tận dụng năng lực suy luận tổng quát (General Reasoning) của Vision-Language Model để giải thích hiện tượng lâm sàng cho khách ngay trong 1.5 giây.
      2. Tự động chuyển đổi sang mô hình **Phí Khảo sát & Chẩn đoán tận nhà cơ sở (100.000đ)** (cam kết khấu trừ vào hóa đơn sửa chữa nếu khách đồng ý làm).
      3. Tự động gán nhãn tay nghề thợ (`worker_skills`) để hệ thống dispatch chính xác nhóm thợ chuyên môn đến kiểm tra thực tế, không từ chối đơn.
      4. Ngay khi thợ hoàn thành đơn và chốt bill thực tế, tri thức mới tự động được nạp vào hệ thống để phục vụ các khách hàng tiếp theo.

### 3.3. Cơ Chế Làm Giàu Dữ Liệu Add-on Động (Data Enrichment Flywheel) - *[MỚI V2.3]*
*   **Kênh Thợ tại hiện trường (Worker Voice-to-Action):** Thợ bấm mic trên app nói mô tả công việc phát sinh $\to$ AI bóc tách tự động thành hạng mục Add-on gửi khách duyệt trong 5 giây.
*   **Khai phá dữ liệu Chat & Khiếu nại (Conversational Mining):** Batch job AI quét log trao đổi giữa khách và thợ hàng đêm để phát hiện các nhu cầu lặp lại (Service Gaps) và tự động sinh bản thảo Add-on mới.
*   **Kích hoạt theo Thời tiết & Mùa vụ (Temporal Triggers):** Tự động gợi ý các gói Add-on tương ứng theo mùa (mưa bão, nồm ẩm, cận Tết).
*   **Quản trị thông minh (Human-in-the-loop):** Admin xem bảng đề xuất Add-on tự động từ AI (kèm bằng chứng chat/giá thị trường) và phê duyệt 1-click lên toàn sàn.

### 3.4. Luồng Khớp Lệnh & Thực Thi B2C/B2B Cơ Bản
*   **Khớp lệnh thông minh (Dispatch Engine):** Tự động gán việc dựa trên vị trí, đánh giá hoặc "phát sóng" k-ring. Kiểm tra chứng chỉ an toàn đối với các cuốc việc ngoài trời/tầng cao.
*   **Real-time Tracking:** Theo dõi vị trí thợ di chuyển trên bản đồ theo thời gian thực.

### 3.5. Cung Ứng Vật Tư & Định Giá Bằng AI (AI-Driven Pricing)
*   **Market Scanning:** AI tự động quét giá thị trường để niêm yết giá bán lẻ vật tư cạnh tranh và minh bạch.
*   **Logistics Vật tư:** Tự động điều phối giao nhận linh kiện tới công trình hoặc nhà khách.

### 3.6. Luồng Dự Án B2B (Khảo Sát, Mời Thầu & Hợp Đồng)
*   Quy trình Khảo sát -> Mở gói thầu -> Thợ nộp báo giá -> Sinh Hợp đồng e-Contract -> Thanh toán theo Giai đoạn (Milestones) & Quản lý Công nợ.

### 3.7. Hệ Thống Quảng Cáo (Ad Engine)
*   Cho phép Nhà cung cấp đấu thầu vị trí tìm kiếm vật tư. Thu phí CPC/CPM qua cơ chế RTB (Real-Time Bidding). Đảm bảo Price Parity chống xung đột kênh phân phối.

### 3.8. Cơ Chế Tài Chính & Ví Ảo (Financial Engine)
*   **Thanh toán Phân tách (Split Payment):** Tự tách tiền linh kiện (trả Supplier) và tiền công + Add-ons (trả Thợ).
*   **Ký quỹ & Sổ cái Bất biến (Escrow & Double-Entry Ledger):** Tiền phát sinh Add-on được ký quỹ tức thì qua app; hệ thống tự động đối soát và bảo lãnh thanh toán an toàn cho cả khách và thợ.

### 3.9. Quản Trị Tài Sản Khách Hàng & Hậu Mãi (Assets & Warranty Management)
*   **Hồ Sơ "Bệnh Án" Thiết Bị:** Số hóa danh mục thiết bị của khách. Lịch sử thay thế linh kiện và Add-on bảo dưỡng được lưu vĩnh viễn, giúp thợ chẩn đoán bệnh chính xác trước khi đến.
*   **Cơ Chế Bảo Hành Trói Chân (Auto-Warranty Enforcement):** Tự động kích hoạt chứng nhận bảo hành sau khi hoàn thành đơn. Tự động sinh cuốc Rework 0đ ép thợ cũ quay lại khắc phục nếu có sự cố; trường hợp từ chối sẽ điều phối thợ mới và trừ phạt từ ví thợ cũ.
