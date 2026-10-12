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
- **Network & Realtime**: `dio` (kèm `ApiResponse<T>`, `X-Idempotency-Key`) + WebSocket STOMP (`stomp_dart_client`)

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
