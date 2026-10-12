# Prompt Claude Design — Bổ sung UI cho các API chưa có màn hình

> Nguồn: đối chiếu `docs/api/openapi.yaml` với 81 màn hiện có (2026-10-07).
> Đánh số tiếp theo ma trận Concept 02 (ô cuối hiện tại: Cell 131) → bắt đầu từ **Cell 132**.
>
> **Cập nhật 2026-10-12:** Batch 14–15 đã sửa lại cho khớp API thật sau Pha 2–5 (mã đơn dạng số `#502`, API không trả tên/ảnh thợ, chưa có API upload ảnh, ví có "có thể rút" + "đang tạm giữ"). Batch 16–17 đã làm xong trong app — bỏ qua.
>
> **Cách dùng:** mỗi phiên Claude Design, dán **Khối ngữ cảnh chung** trước, rồi dán prompt của batch.
> Mỗi batch nên làm trong một phiên riêng để giữ chất lượng.

| Batch | Nội dung | Cells | API phục vụ |
| :--- | :--- | :--- | :--- |
| 14 | Báo giá chi tiết (thợ gửi, khách duyệt) | 132–135 | `POST /bookings/{id}/quote`, `/quote/approve`, `/quote/reject` |
| 15 | Nạp tiền vào ví thợ | 136–138 | `POST /wallets/payments/deposit`, `GET /wallets/me` |
| ~~16~~ | ~~Thông báo: đọc tất cả + cài đặt thông báo thợ~~ — **đã làm ở Pha 5, không cần dán** | 139–140 | `POST /notifications/read-all`, `GET/PUT /notifications/settings` |
| ~~17~~ | ~~Lịch sử cuộc gọi của đơn~~ — **đã làm ở Pha 5 (hiện trong khung chat), không cần dán** | 141 | `GET /voip/calls?bookingId=` |

**Không có prompt:**
- `POST /wallets/payments/withdraw`: trùng chức năng với `/wallets/withdrawals` (đã có UI). Chờ backend xác nhận mục đích.
- `/assets` (5 API): đã có màn My Home Devices nhưng thuộc post-MVP theo CLAUDE.md.
- API admin: không thuộc app mobile.

---

## Khối ngữ cảnh chung (dán đầu mỗi phiên)

```
Bạn đang thiết kế tiếp cho app VSTech Home Services (Concept 02) — app gọi thợ sửa chữa/vệ sinh tại nhà ở Việt Nam, một app chung cho 2 vai trò: Khách hàng và Thợ. Ngôn ngữ giao diện: tiếng Việt. Thiết bị chuẩn: iPhone 390×844, hiển thị viewport thuần (không vẽ vỏ máy).

Design system "Eco-Clean Sanctuary v9.0" — BẮT BUỘC:
- Màu: primary #0D9488 (chỉ 1 CTA chính/màn hoặc tab active), pressed #0F766E, chữ trên primary #FFFFFF, secondary #CCFBF1 (badge nhạt), secondarySurface #F0FDFA (nền chip/card đang chọn, luôn kèm viền primary), nền app #FAF9F6 (ngà ấm, không trắng tinh), surface card #FFFFFF, chữ chính #0F172A, chữ phụ #475569, chữ mờ #94A3B8, viền hairline #E2E8F0, success #10B981/#059669, warning #F59E0B, error #EF4444.
- TUYỆT ĐỐI không dùng màu đen #000000, không đổ bóng (shadow/elevation) — dùng viền hairline 1px #E2E8F0 thay thế.
- Tỷ lệ màu 60-30-10: nền/surface 60%, chữ/viền 30%, teal là điểm nhấn duy nhất 10%.
- Trạng thái chọn = nền #F0FDFA + viền #0D9488 + icon check, không bao giờ tô đặc tối.
- Font: Source Sans 3 toàn app. Nhãn trường ≥14–15px, chữ nhập ≥16px, tiêu đề card ≥18px, nút chính 16–17px, đậm rõ.
- Bo góc: 8px chip/badge, 12px ô nhập & nút CTA, 16px card/sheet, full chỉ cho dock đáy và nút tròn đặc biệt.
- Lưới khoảng cách 4/8/16/24/32, lề trang 16px.
- Icon: nét mảnh 1.25–1.5px, 20–24px, màu xám slate (#94A3B8/#475569), không bọc trong ô tròn/vuông, không tô teal hàng loạt.
- Trạng thái luôn thể hiện bằng Icon + Nhãn + Màu cùng lúc, không chỉ dùng màu.
- Mọi hành động quan trọng là Icon + Nhãn, không ẩn sau cử chỉ hay nút chỉ có icon. Vùng chạm tối thiểu 44×44, ưu tiên 48×48. Nút CTA chính cao 48–52px.
- Mỗi màn 1 mục tiêu, 1 CTA chính. Người dùng có thể tới ~50 tuổi: rõ ràng, quen thuộc hơn là mới lạ. Tương phản chữ WCAG AAA.
- Tiền tệ hiển thị dạng "4.860.000đ". Thời gian dạng "14:30 · 07/10/2026".
- Ảnh thật dạng squircle bo mềm thay cho icon trừu tượng khi minh hoạ dịch vụ/hoá đơn.
- Màn nào có dock điều hướng đáy (viên nang trắng nổi, viền hairline) thì nội dung cuộn phải chừa đệm đáy 112–128px.

Với mỗi màn, hãy vẽ đầy đủ các trạng thái được liệt kê, ghi rõ số Cell trên khung, và giữ phong cách nhất quán với các màn Concept 02 đã có (Cell 1–131).
```

---

## Batch 14 — Báo giá chi tiết (Cells 132–135)

**Bối cảnh API (đã đối chiếu 2026-10-12):**
- Thợ gửi `POST /bookings/{id}/quote` gồm nhiều dòng (`itemName`, `amount`, `receiptUrl` tuỳ chọn) + `evidencePhotoUrls`; server trả `totalAmount`, `status`, `submittedAt`. Khách chỉ có **Duyệt** / **Từ chối** (`/quote/approve`, `/quote/reject`), không gửi lý do.
- **Chưa có API upload ảnh** → ảnh hoá đơn / ảnh bằng chứng phải thiết kế sao cho màn vẫn trọn vẹn khi **không có ảnh** (app sẽ ẩn khu ảnh tới khi backend có upload).
- **Khách chưa có API đọc báo giá** (`BookingResponse` không chứa báo giá) — đã báo backend (NOTES L12). Vẫn thiết kế màn khách để sẵn sàng.
- API **không trả tên / ảnh / đánh giá của thợ** → dùng nhãn vai trò "Thợ phụ trách", không vẽ avatar thật.
- Mã đơn là số: hiển thị `#502`. Không có push → khách vào màn duyệt từ **Chi tiết đơn**.
- Hiện app: thợ gửi qua một hộp thoại 1 tên + 1 giá ở màn Đang thực hiện — Batch này thay hộp thoại đó.

```
Batch 14 — Báo giá chi phí phát sinh. Thiết kế 4 màn (Cell 132–135). Lưu ý dữ liệu: mã đơn dạng "#502"; app KHÔNG có tên/ảnh/đánh giá của thợ, chỉ ghi vai trò "Thợ phụ trách"; tính năng ảnh có thể chưa có ở bản đầu nên mỗi màn có khu ảnh phải vẽ thêm biến thể KHÔNG có khu ảnh mà vẫn cân đối.

Cell 132 — [Thợ] Lập báo giá phát sinh (full-screen, mở từ nút "+ Báo giá phát sinh" ở màn Đang thực hiện).
- Header: nút Quay lại (icon + nhãn), tiêu đề "Báo giá phát sinh", dòng phụ "Đơn #502 · Vệ sinh máy lạnh".
- Thẻ đối chiếu: "Giá ước tính ban đầu 350.000đ" + ghi chú nhỏ "Tổng tiền đơn không được vượt 1,5 lần giá ước tính".
- Danh sách hạng mục (tối thiểu 1, tối đa 10), mỗi hạng mục là 1 card: ô "Tên vật tư / hạng mục" (VD "Gas R32 bổ sung"), ô "Số tiền" hậu tố đ, ô ảnh hoá đơn tuỳ chọn (squircle viền đứt "+ Ảnh hoá đơn"; có ảnh thì thumbnail + nút "Xoá ảnh" có nhãn), nút "Xoá hạng mục" (icon thùng rác + nhãn, màu error) — ẩn khi chỉ còn 1 hạng mục.
- Nút phụ viền "+ Thêm hạng mục".
- Khu "Ảnh hiện trường" (tuỳ chọn): lưới 3 cột squircle, ô đầu "+ Chụp / Chọn ảnh", tối đa 6 ảnh, ghi chú "Ảnh giúp khách duyệt nhanh hơn".
- Thanh tổng cố định ngay trên CTA: "Tổng phát sinh" + số tiền lớn đậm; dòng phụ "Khách trả thêm khoản này sau khi duyệt".
- CTA chính teal full-width: "Gửi báo giá cho khách".
- Trạng thái: (a) trống — CTA khoá; (b) 2 hạng mục hợp lệ (biến thể có ảnh và biến thể không có khu ảnh) — CTA bật; (c) lỗi: hạng mục thiếu tên hoặc số tiền 0 → viền error + icon + chữ lỗi dưới ô; vượt 1,5 lần giá ước tính → banner lỗi trên thanh tổng (icon + chữ); (d) đang gửi — spinner trong CTA, khoá thao tác.

Cell 133 — [Thợ] Trạng thái báo giá (thẻ trong màn Đang thực hiện).
- (a) "Đang chờ khách duyệt": icon đồng hồ + nhãn + màu warning, tổng phát sinh, số hạng mục, giờ gửi "14:30 · 12/10/2026", nút phụ "Xem lại báo giá".
- (b) "Khách đã duyệt": icon check + nhãn + màu success, "Tổng mới của đơn" = giá ban đầu + phát sinh.
- (c) "Khách đã từ chối": icon X + nhãn + màu error, gợi ý "Tiếp tục theo giá ban đầu hoặc nhắn tin với khách", 2 nút: "Nhắn tin" (phụ, icon + nhãn) và "Tiếp tục công việc" (chính).

Cell 134 — [Khách] Duyệt báo giá phát sinh (full-screen, mở từ banner "Thợ gửi báo giá phát sinh — Xem & duyệt" ở màn Chi tiết đơn; vẽ luôn banner này ở đầu màn Chi tiết đơn).
- Header: Quay lại + tiêu đề "Báo giá phát sinh", dòng phụ "Đơn #502 · Thợ phụ trách".
- Danh sách hạng mục dạng bảng gọn: tên, số tiền, thumbnail hoá đơn nếu có (chạm để phóng to).
- Lưới ảnh hiện trường nếu có (chạm để xem toàn màn).
- Bảng tổng: Giá ban đầu / Chi phí phát sinh / Tổng mới (đậm nhất). Ghi chú: "Bạn chỉ thanh toán sau khi nghiệm thu".
- Hai nút: "Từ chối" (viền, chữ error) và "Duyệt báo giá" (CTA teal duy nhất).
- Hộp xác nhận khi bấm Từ chối: "Từ chối báo giá?" / "Thợ sẽ tiếp tục theo giá ban đầu." / nút "Quay lại" và "Từ chối báo giá" (error).
- Trạng thái: (a) mặc định có ảnh; (b) không có khu ảnh; (c) đang xử lý — spinner trong nút; (d) lỗi mạng — SnackBar "Không có kết nối mạng…" + Thử lại; (e) báo giá đã xử lý trước đó — banner thông tin (icon + nhãn), ẩn 2 nút.

Cell 135 — [Khách] Kết quả sau khi duyệt / từ chối (màn xác nhận ngắn).
- (a) Đã duyệt: icon check lớn (success) + "Đã duyệt chi phí phát sinh" + tổng mới; CTA "Về chi tiết đơn".
- (b) Đã từ chối: icon thông tin (slate) + "Đã từ chối báo giá" + "Thợ tiếp tục theo giá ban đầu 350.000đ"; CTA "Về chi tiết đơn".
```

---

## Batch 15 — Nạp tiền vào ví thợ (Cells 136–138)

**Bối cảnh API (đã đối chiếu 2026-10-12):**
- `POST /wallets/payments/deposit` nhận `amount` (> 0), `gateway`, `gatewayTxId` (mã giao dịch **do cổng thanh toán trả về** — app gửi sau khi người dùng trả tiền xong ở VNPay/ZaloPay); trả về giao dịch có `status` PENDING / COMPLETED / FAILED. Giao dịch hiện trong sổ ví với loại `DEPOSIT`.
- Màn Ví thợ hiện tại (Cell 117, đã nối API) có: thẻ số dư **"Có thể rút"** + dòng **"Đang tạm giữ"**, nút "Rút tiền", 4 chip lọc giao dịch (Tất cả / Thu nhập / Rút tiền / Tạm giữ). Không còn "Tổng thu nhập / Đã rút".
- ⚠ **Chưa chốt nạp vào ví nào** (đang giả định ví thợ, dùng bù phí nền tảng cho đơn khách trả tiền mặt) — chờ BA. Mức tối thiểu 50.000đ là quy tắc app đề xuất (API không ghi).

```
Batch 15 — Nạp tiền vào ví của Thợ. Thẻ số dư ở màn Ví (Cell 117) hiện có "Có thể rút" (số lớn) + dòng "Đang tạm giữ" và nút chính "Rút tiền". Bổ sung nút phụ viền "Nạp tiền" (icon + nhãn) cạnh "Rút tiền" — giữ "Rút tiền" là CTA chính duy nhất. Thiết kế 3 màn (Cell 136–138):

Cell 136 — [Thợ] Nạp tiền vào ví.
- Header: Quay lại + tiêu đề "Nạp tiền vào ví".
- Thẻ số dư "Có thể rút 4.860.000đ" + dòng phụ "Sau khi nạp: 5.360.000đ" cập nhật theo số tiền nhập.
- Ô nhập số tiền lớn (chữ nhập ≥16px, hiển thị "500.000đ"), ghi chú "Tối thiểu 50.000đ".
- 4 chip chọn nhanh: 100.000đ, 200.000đ, 500.000đ, 1.000.000đ (đang chọn = nền #F0FDFA + viền teal + check).
- Chọn cổng thanh toán: 2 card VNPay và ZaloPay (logo dạng ảnh squircle + tên + mô tả "Thẻ ATM / QR ngân hàng", "Ví ZaloPay"); card đang chọn viền teal + check.
- Ghi chú minh bạch (icon thông tin + chữ): "Miễn phí nạp tiền. Tiền vào ví khi cổng thanh toán xác nhận."
- CTA chính: "Nạp 500.000đ" (số tiền động).
- Trạng thái: (a) trống — CTA khoá; (b) đã chọn 500.000đ + VNPay; (c) lỗi dưới mức tối thiểu (icon + chữ lỗi dưới ô).

Cell 137 — [Thợ] Đang xác nhận giao dịch (sau khi quay lại từ cổng thanh toán).
- Loader + tiêu đề "Đang xác nhận giao dịch", số tiền, cổng thanh toán, mã giao dịch cổng (VD "VNP-14220931"), ghi chú "Thường mất dưới 1 phút. Bạn có thể rời màn hình này."
- Nút phụ "Về ví".

Cell 138 — [Thợ] Kết quả nạp tiền.
- (a) Thành công: icon check success, "Nạp tiền thành công", "+500.000đ" (màu success), số dư mới, mã giao dịch, thời gian "14:30 · 12/10/2026"; CTA "Về ví".
- (b) Thất bại: icon X error, "Nạp tiền không thành công", lý do ngắn "Giao dịch bị huỷ hoặc hết hạn", trấn an "Bạn chưa bị trừ tiền"; CTA "Thử lại", nút phụ "Đổi cổng thanh toán".
- (c) Xử lý lâu (vẫn PENDING sau 5 phút): icon warning, "Giao dịch đang được đối soát", nút "Gọi hỗ trợ" (icon + nhãn).
- Kèm: dòng giao dịch "Nạp tiền" trong sổ ví (Cell 117) với icon mũi tên vào, số tiền +, trạng thái Hoàn tất / Đang xử lý / Thất bại (icon + nhãn + màu).
```

---

## Batch 16 — Thông báo (Cells 139–140) — ✅ đã làm ở Pha 5, không cần dán

**Bối cảnh API:** `POST /notifications/read-all`; settings gồm 3 cờ bắt buộc: `systemEnabled`, `bookingEnabled`, `promoEnabled`. Thông báo của khách (Cell 64) chưa có nút đọc tất cả. Thợ chưa có màn cài đặt thông báo (khách đã có).

```
Batch 16 — Thông báo. Thiết kế 2 màn (Cell 139–140):

Cell 139 — [Khách] Trung tâm thông báo — bổ sung "Đánh dấu đã đọc tất cả" (cập nhật màn Cell 64, giữ 4 tab Tất cả / Đơn hàng / Khuyến mãi / Hệ thống và nhóm Hôm nay / Trước đó).
- Ở header bên phải: nút chữ có icon "✓✓ Đọc tất cả" (icon + nhãn, không chỉ icon). Ẩn/khoá khi không còn thông báo chưa đọc.
- Thông báo chưa đọc: nền #F0FDFA nhạt + chấm teal nhỏ + tiêu đề đậm; đã đọc: nền trắng, tiêu đề thường.
- Badge số chưa đọc trên từng tab (badge #CCFBF1 chữ teal đậm).
- Trạng thái: (a) có 3 chưa đọc; (b) sau khi bấm Đọc tất cả — SnackBar "Đã đánh dấu tất cả là đã đọc"; (c) rỗng — minh hoạ nhẹ + "Bạn chưa có thông báo nào"; (d) đang tải thêm ở cuối danh sách (nút "Xem thêm thông báo" — danh sách không có phân trang tự động).

Cell 140 — [Thợ] Cài đặt thông báo (mở từ Hồ sơ Thợ — Cell 106 — mục "Cài đặt thông báo").
- Header: Quay lại + "Cài đặt thông báo".
- 3 hàng cài đặt dạng card, mỗi hàng: icon slate, tiêu đề, mô tả 1–2 dòng, công tắc bật/tắt (bật = teal):
  1. "Việc mới & đơn hàng" — "Yêu cầu việc mới, khách huỷ, thay đổi lịch hẹn." (bookingEnabled)
  2. "Hệ thống & ví" — "Duyệt hồ sơ, tiền về ví, rút tiền." (systemEnabled)
  3. "Khuyến mãi & tin tức" — "Chương trình thưởng, ưu đãi cho đối tác." (promoEnabled)
- Khi tắt "Việc mới & đơn hàng": hiện hộp cảnh báo (icon warning + nhãn + màu) "Bạn có thể bỏ lỡ việc mới khi đang Online" và yêu cầu xác nhận.
- Trạng thái: (a) đang tải (skeleton 3 hàng); (b) mặc định tất cả bật; (c) đang lưu một công tắc (spinner nhỏ tại công tắc); (d) lưu thất bại — công tắc trả về trạng thái cũ + SnackBar lỗi có nút Thử lại.
- Không có nút Lưu riêng — mỗi công tắc lưu ngay.
```

---

## Batch 17 — Lịch sử cuộc gọi của đơn (Cell 141) — ✅ đã làm ở Pha 5, không cần dán

**Bối cảnh API:** `GET /voip/calls?bookingId=` trả danh sách gồm `callerId`, `receiverId`, `durationSeconds`, `startedAt`, `endedAt`. `recordingUrl` chỉ dành cho admin, không hiển thị trong app. Cuộc gọi là ẩn số (masked).

```
Batch 17 — Lịch sử cuộc gọi ẩn số của một đơn. Thiết kế 1 màn (Cell 141), dùng chung cho Khách và Thợ.

Cell 141 — Lịch sử cuộc gọi (mở từ Chi tiết đơn — Cell 62–63, 94 — mục "Lịch sử liên lạc", và từ menu màn Chat — Cell 80–81).
- Header: Quay lại + "Lịch sử cuộc gọi", dòng phụ "#HS-24817 · Vệ sinh máy lạnh".
- Banner bảo mật nhỏ (icon khiên + nhãn): "Số điện thoại hai bên luôn được ẩn. Cuộc gọi có thể được ghi âm để giải quyết khiếu nại."
- Danh sách nhóm theo ngày; mỗi dòng: icon chiều gọi (gọi đi ↗ / gọi đến ↙ / nhỡ), tên người kia (VD "Thợ Nguyễn Văn Hùng" hoặc "Khách hàng"), giờ bắt đầu "14:30", thời lượng "3 phút 12 giây"; cuộc gọi nhỡ/0 giây dùng icon + nhãn "Cuộc gọi nhỡ" + màu error.
- Nút "Gọi lại" ở mỗi dòng (icon điện thoại + nhãn, viền) — chỉ hiện khi đơn còn đang hoạt động.
- CTA chính cố định cuối màn: "Gọi ẩn số cho thợ" (hoặc "cho khách" ở vai Thợ) — ẩn khi đơn đã hoàn tất/huỷ, thay bằng ghi chú "Đơn đã kết thúc, không thể gọi".
- Trạng thái: (a) có 4 cuộc gọi (1 nhỡ); (b) rỗng — "Chưa có cuộc gọi nào cho đơn này"; (c) đang tải (skeleton); (d) lỗi không có quyền xem — thông điệp "Bạn không có quyền xem thông tin cuộc gọi" + nút Quay lại.
```
