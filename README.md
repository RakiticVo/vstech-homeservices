# VSTech Home Services

Ứng dụng di động hợp nhất đa vai trò (B2C Khách hàng & Đối tác Thợ) cho nền tảng dịch vụ bảo trì, sửa chữa gia đình VSTech Home Services.

## 📌 Tổng Quan Kỹ Thuật

- **Platform**: Flutter (iOS & Android) — Dart SDK ≥ 3.0, Flutter ≥ 3.22
- **Kiến trúc**: Feature-First Clean Architecture (`data/`, `domain/`, `presentation/`) với **flutter_bloc / Cubit**
- **Design System**: **Eco-Clean Sanctuary v9.0** ([`docs/design/MASTER_SPEC_V9.md`](docs/design/MASTER_SPEC_V9.md))
  - Tỉ lệ màu 60-30-10: Nền ngà ấm `#FAF9F6` & Mặt thẻ `#FFFFFF` (60%), Chữ Slate `#0F172A` & Viền Hairline `#E2E8F0` (30%), Teal `#0D9488` (10% - Nút CTA chính)
  - **Zero Shadows**: Triệt tiêu 100% bóng mờ đục, sử dụng viền hairline 1px `#E2E8F0`
  - **Cấm màu đen thuần**: Tuyệt đối không dùng `#000000`
  - Typography: Google Fonts `Plus Jakarta Sans` (Tiêu đề/Button) & `Inter` (Nội dung/Giá)
- **Điều hướng & DI**: `go_router` (role-aware routing) + `get_it` / `injectable`
- **Network & Realtime**: `dio` (kèm `ApiResponse<T>`, `X-Idempotency-Key`) + WebSocket JSON thuần (`web_socket_channel`, `RealtimeSocket` — không dùng STOMP)

---

## 📚 Hệ Thống Tài Liệu Quy Chuẩn

| Danh mục | Tài liệu chính | Mô tả |
| :--- | :--- | :--- |
| **Quy chuẩn Agent & Dev** | [`AGENTS.md`](AGENTS.md) / [`CLAUDE.md`](CLAUDE.md) | Nguồn sự thật tối cao cho kỹ thuật, kiến trúc, tech stack, API rules |
| **Phạm vi MVP** | [`docs/reference/PHASE1_SCOPE.md`](docs/reference/PHASE1_SCOPE.md) | Khóa cứng phạm vi Phase 1 MVP (B2C + Worker) |
| **Yêu cầu sản phẩm** | [`docs/reference/PRD.md`](docs/reference/PRD.md) | PRD V2.3 (3-Tier Taxonomy, Contextual Services, Flywheel) |
| **Thiết kế UI/UX** | [`docs/design/MASTER_SPEC_V9.md`](docs/design/MASTER_SPEC_V9.md) | Quy chuẩn thiết kế tối cao, Ma trận 16 màn hình & 8 checklist kiểm định |
| **Backend API Contracts**| [`docs/reference/api/README.md`](docs/reference/api/README.md) | 10 modules API Quarkus backend (Auth, Bookings, Wallet, Chat, Tracking, VoIP) |

---

## 🛠️ Hướng Dẫn Bắt Đầu (Getting Started)

### 1. Cài đặt môi trường
Yêu cầu Flutter SDK ≥ 3.22 và Dart ≥ 3.0.

```bash
# Lấy packages
flutter pub get

# Kiểm tra mã nguồn & lint
flutter analyze

# Chạy unit & widget test
flutter test
```

### 2. Biến môi trường (file env — không đưa lên git)
Các biến nhạy cảm nằm trong 2 file ở thư mục gốc dự án, tách theo môi trường. Các biến gồm URL backend, Google Maps key và tài khoản test UAT.

| File | Môi trường | Lên git? |
| :--- | :--- | :--- |
| `.env.development` | Development (backend UAT, log `debug`, tài khoản test) | ❌ gitignore |
| `.env.production` | Production (URL thật, log `warning`, không có tài khoản test) | ❌ gitignore |
| `.env.development.example`, `.env.production.example` | File mẫu, không chứa giá trị thật | ✅ |

```bash
cp .env.development.example .env.development
```

```bash
cp .env.production.example .env.production
```

Điền giá trị thật vào file tương ứng, rồi chạy development:

```bash
flutter run --dart-define-from-file=.env.development
```

Build production:

```bash
flutter build apk --release --dart-define-from-file=.env.production
```

VS Code có sẵn 2 cấu hình chạy là "vstech (development)" và "vstech (production)" trong `.vscode/launch.json`. Với Android Studio,
thêm `--dart-define-from-file=.env.development` vào ô *Additional run args*. Trong code, đọc biến qua
`AppEnv` (`lib/core/config/app_env.dart`). Khi thêm biến mới, thêm vào cả 2 file `*.example` và vào `AppEnv`.

| Biến | Ý nghĩa |
| :--- | :--- |
| `APP_ENV` | `development` / `production` (`AppEnv.isProduction`) |
| `API_BASE_URL` | Gốc REST API (để trống = UAT, production sẽ log cảnh báo) |
| `WS_BASE_URL` | Gốc WebSocket (để trống = suy từ `API_BASE_URL`) |
| `LOG_LEVEL` | `trace`/`debug`/`info`/`warning`/`error`/`off` |
| `GOOGLE_MAPS_API_KEY` | Key bản đồ theo dõi (chưa gắn vào native) |
| `TEST_CUSTOMER_*`, `TEST_WORKER_*` | Tài khoản test UAT do backend cấp — chỉ có trong `.env.development` |
| `DEBUG_CONSOLE` | `true` = hiện nút **Debug** nổi trong app cho tester (development); `false` ở production |

#### Bảng debug cho tester

Khi `DEBUG_CONSOLE=true`, app có nút **Debug** nổi (kéo được) trên mọi màn. Bấm vào để xem:

- **Mạng**: từng request/response (mã trạng thái, thời gian, mã lỗi `HS-…`, header/body). Token và mật khẩu luôn được che `***`.
- **Log**: log app, chuyển trạng thái BLoC, lỗi không bắt được; lọc theo Tất cả / Cảnh báo trở lên / Chỉ lỗi.
- **Thông tin**: môi trường, URL API/WebSocket, chế độ build, thiết bị, ngôn ngữ, phiên đăng nhập.
- **Sao chép tất cả** → dán vào báo cáo lỗi; **Xoá** để làm sạch trước khi tái hiện lỗi.

Dữ liệu chỉ nằm trong bộ nhớ của app (tối đa 500 log, 200 request), mất khi tắt app. Bản cài cho tester build bằng `.env.development` (vd. `flutter build apk --release --dart-define-from-file=.env.development`) vẫn có nút này; bản production thì không.

### 3. Sinh mã tự động (Code Generation)
Dự án sử dụng `freezed`, `json_serializable`, và `injectable`. Khi tạo DTOs hoặc Repositories:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Khởi động phiên làm việc với AI Agents
Trong bất kỳ agentic IDE nào (Antigravity, Claude Code, Cursor,...), bạn có thể chạy:
```bash
/start-session
```
để tự động kiểm tra sức khỏe dự án và rà soát tiến độ theo ma trận 16 màn hình.

---

## 🤖 CI/CD

### Thông báo issue lên Telegram

Workflow `.github/workflows/issue-telegram.yml` gửi hoạt động issue vào nhóm Telegram (đúng topic nếu có):

Định dạng (chữ thường, không định dạng):

```
✅ Issue #100 closed (V-STECH/home_services_mobile)
Tiêu đề issue
by tvtrung206
https://github.com/V-STECH/home_services_mobile/issues/100
```

Icon theo hành động: 🆕 `opened` · 🔄 `reopened` · ✅ `closed` · 👤 `assigned`; và bình luận mới trên issue (không tính PR) với dạng `💬 Comment mới trên #100 (...)` + 300 ký tự đầu của bình luận.

Cần 3 GitHub Secrets: `TELEGRAM_BOT_TOKEN`, `TELEGRAM_CHAT_ID`, `TELEGRAM_MESSAGE_THREAD_ID` (bỏ trống nếu nhóm không dùng topic). Lưu ý: sự kiện issue luôn chạy workflow từ **nhánh mặc định** của repo (`main`), nên file phải có trên nhánh đó.

Thử script ở máy (không gửi tin):

```bash
DRY_RUN=1 TELEGRAM_CHAT_ID=-100123 EVENT_NAME=issues ACTION=opened REPO=org/repo ACTOR=me ISSUE_NUMBER=1 ISSUE_TITLE=Test ISSUE_URL=https://github.com/org/repo/issues/1 bash .github/scripts/telegram_issue_notify.sh
```

### Thông báo release lên Telegram

Khi pipeline release (`.github/workflows/release.yml`, chạy theo tag `v*`) kết thúc — thành công hay lỗi — job **Notify Telegram** gửi tin vào cùng nhóm / topic với tin issue:

```
🚀 Release v1.0.0-uat (V-STECH/home_services_mobile)
UAT · version 1.0.0 (build 1)
by RakiticVo
🤖 Android: ✅ Firebase App Distribution
🍎 iOS: ✅ TestFlight
📦 Artifacts: https://github.com/V-STECH/home_services_mobile/actions/runs/...
```

Có job lỗi thì dòng đầu là `❌ Release … lỗi` và nền tảng hỏng hiện ❌ (test lỗi thì hiện `🧪 Test: ❌`). Tag production (không có `-uat`) ghi `Production`, Google Play / App Store Connect. Dùng chung 3 secret Telegram. Thử ở máy:

```bash
DRY_RUN=1 TELEGRAM_CHAT_ID=-100123 TAG=v1.0.0-uat REPO=org/repo ACTOR=me RUN_URL=https://example.com APP_VERSION=1.0.0+1 TEST_RESULT=success ANDROID_RESULT=success IOS_RESULT=failure bash .github/scripts/telegram_release_notify.sh
```
