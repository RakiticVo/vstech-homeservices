# Hướng dẫn tạo GitHub Secrets cho CI/CD release (UAT)

> Áp dụng cho `.github/workflows/release.yml` trên repo `V-STECH/home_services_mobile`.
> Tag `v*-uat` (vd. `v1.0.0-uat`) chạy: **test → Android UAT (Firebase App Distribution) + iOS UAT (TestFlight) → báo phiên bản cho backend**.
> Nhập secret tại: repo → **Settings → Secrets and variables → Actions → New repository secret**, hoặc `gh secret set TEN_SECRET -R V-STECH/home_services_mobile` rồi dán giá trị.
>
> ⚠️ Mọi file khoá (`.jks`, `.p8`, `.json`, SSH key) **không bao giờ commit vào repo** — lưu trong trình quản lý mật khẩu của công ty.

---

## Phần A — Android UAT

### A1. Keystore ký app → `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD`

Keystore là "con dấu" của app Android. **Mất keystore = không cập nhật được app trên Google Play**, nên tạo một lần và cất kỹ.

1. Tạo keystore (máy có Java / Android Studio):

   ```bash
   keytool -genkeypair -v -keystore upload_keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

   - Nhập mật khẩu keystore (≥ 6 ký tự, nên dài và ngẫu nhiên) và các thông tin công ty.
   - Keystore kiểu PKCS12 (mặc định) dùng **cùng một mật khẩu** cho keystore và key.

2. Tạo secret:

   | Secret | Giá trị |
   | :--- | :--- |
   | `ANDROID_KEYSTORE_BASE64` | Chạy `base64 -i upload_keystore.jks \| pbcopy` rồi dán |
   | `ANDROID_KEYSTORE_PASSWORD` | Mật khẩu vừa đặt |
   | `ANDROID_KEY_ALIAS` | `upload` (alias ở lệnh trên) |
   | `ANDROID_KEY_PASSWORD` | Cùng mật khẩu với keystore |

3. (Tuỳ chọn) Build release ký thật ở máy: tạo `android/key.properties` (đã gitignore)

   ```properties
   storeFile=../upload_keystore.jks
   storePassword=...
   keyAlias=upload
   keyPassword=...
   ```

   Không có file này thì bản release ở máy tự ký bằng key debug.

### A2. App Android trên Firebase → `FIREBASE_ANDROID_APP_ID`

1. Vào <https://console.firebase.google.com> → tạo (hoặc chọn) project, vd. **VSTech Home Services**.
2. **Add app → Android**:
   - Package name: **`com.vstech.vstech_home_services`** (phải đúng y hệt).
   - App nickname: `VSTech Home Services Android`.
   - SHA-1 (tuỳ chọn, cần sau này cho đăng nhập Google): `keytool -list -v -keystore upload_keystore.jks -alias upload`.
   - Bước tải `google-services.json` có thể bỏ qua lúc này (app chưa khởi tạo Firebase). Lưu ý `android/.gitignore` đang chặn mọi `*.json` — khi cần thêm file này phải sửa lại `.gitignore`.
3. **Project settings → General → Your apps** → chọn app Android → copy **App ID** dạng `1:123456789012:android:abc123…` → secret `FIREBASE_ANDROID_APP_ID`.

### A3. Bật App Distribution + nhóm tester

1. Firebase Console → **Release & Monitor → App Distribution → Get started** (chọn app Android).
2. Tab **Testers & Groups → Add group**, đặt tên **`internal-testers`** (Fastfile gửi bản build cho đúng alias này — kiểm tra alias hiển thị là `internal-testers`).
3. Thêm email các tester. Tester sẽ nhận email mời cài app qua Firebase App Tester.

### A4. Service account cho CI → `FIREBASE_APP_DISTRIBUTION_CREDENTIALS`

1. Firebase **Project settings → Service accounts → Manage service account permissions** (mở Google Cloud Console).
2. **Create service account**: tên `github-ci-app-distribution` → **Create and continue**.
3. Role: **Firebase App Distribution Admin** → **Done**.
4. Mở service account vừa tạo → tab **Keys → Add key → Create new key → JSON** → tải file về.
5. Copy **toàn bộ nội dung** file: `pbcopy < ten-file.json` → dán vào secret `FIREBASE_APP_DISTRIBUTION_CREDENTIALS`.
6. Cất file JSON vào kho mật khẩu rồi xoá khỏi máy.

✅ Checklist Android: `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD`, `FIREBASE_ANDROID_APP_ID`, `FIREBASE_APP_DISTRIBUTION_CREDENTIALS`, `API_BASE_URL_UAT`.

---

## Phần B — iOS UAT (TestFlight)

**Cần có:** tài khoản **Apple Developer Program** (trả phí, loại Organization) với quyền **Admin** hoặc **Account Holder**, và một máy Mac để tạo chứng chỉ lần đầu (bước B5).

### B1. `APPLE_ID`, `APPLE_TEAM_ID`

1. `APPLE_ID`: email đăng nhập tài khoản Apple Developer.
2. <https://developer.apple.com/account> → **Membership details** → copy **Team ID** (10 ký tự) → `APPLE_TEAM_ID`.

### B2. Đăng ký Bundle ID và tạo app

1. developer.apple.com → **Certificates, Identifiers & Profiles → Identifiers → +** → **App IDs → App**:
   - Bundle ID **Explicit**: **`com.vstech.vstechHomeServices`** (đúng y hệt).
   - Capabilities: tick **Push Notifications** (để sau này dùng FCM).
2. <https://appstoreconnect.apple.com> → **Apps → + → New App**:
   - Platform iOS, Name `VSTech Home Services` (tên phải chưa ai dùng trên App Store), Primary language Vietnamese, Bundle ID chọn cái vừa tạo, SKU vd. `vstech-home-services`.

### B3. App Store Connect API key → `APP_STORE_CONNECT_KEY_ID`, `APP_STORE_CONNECT_ISSUER_ID`, `APP_STORE_CONNECT_API_KEY_P8`

1. App Store Connect → **Users and Access → Integrations → App Store Connect API → Team Keys** (lần đầu Account Holder phải bấm *Request Access*).
2. **Generate API Key**: tên `GitHub CI`, quyền **App Manager** → tải file `AuthKey_XXXXXXXXXX.p8` (**chỉ tải được một lần**).
3. Tạo secret:

   | Secret | Giá trị |
   | :--- | :--- |
   | `APP_STORE_CONNECT_KEY_ID` | Cột **Key ID** |
   | `APP_STORE_CONNECT_ISSUER_ID` | **Issuer ID** ở đầu trang |
   | `APP_STORE_CONNECT_API_KEY_P8` | `pbcopy < AuthKey_XXXXXXXXXX.p8` — dán nguyên nội dung, gồm cả dòng `-----BEGIN PRIVATE KEY-----` / `-----END PRIVATE KEY-----` |

### B4. Repo chứa chứng chỉ (Fastlane Match) → `MATCH_GIT_URL`, `MATCH_SSH_KEY`

Fastlane Match lưu chứng chỉ + provisioning profile (đã mã hoá) trong một repo git riêng để CI dùng chung.

1. Tạo repo GitHub **riêng tư, trống**, vd. `V-STECH/ios-certificates`.
2. `MATCH_GIT_URL` = `git@github.com:V-STECH/ios-certificates.git` (dạng **SSH** — workflow đọc repo bằng SSH key).
3. Tạo SSH key riêng cho CI:

   ```bash
   ssh-keygen -t ed25519 -C "github-ci-match" -f ~/.ssh/match_deploy_key -N ""
   ```

4. Repo `ios-certificates` → **Settings → Deploy keys → Add deploy key** → dán nội dung `~/.ssh/match_deploy_key.pub` (chỉ cần quyền đọc).
5. `MATCH_SSH_KEY` = nội dung **private key**: `pbcopy < ~/.ssh/match_deploy_key`.

### B5. Tạo chứng chỉ lần đầu trên Mac → `MATCH_PASSWORD`

CI chạy Match ở chế độ chỉ-đọc, nên phải tạo chứng chỉ một lần trên máy Mac:

1. Cài fastlane (cần Ruby ≥ 3.0 — Ruby có sẵn của macOS 2.6 quá cũ):

   ```bash
   brew install fastlane
   ```

   (Nếu Homebrew báo lỗi quyền thư mục, chạy lệnh `sudo chown -R …` mà Homebrew in ra rồi thử lại.)

2. Chọn một passphrase mạnh — dùng để mã hoá chứng chỉ trong repo → đây là secret `MATCH_PASSWORD`.
3. Chạy (Mac phải clone được repo Match bằng SSH key của chính bạn):

   ```bash
   MATCH_PASSWORD='passphrase-vừa-chọn' fastlane match appstore \
     --git_url git@github.com:V-STECH/ios-certificates.git \
     --app_identifier com.vstech.vstechHomeServices \
     --team_id <APPLE_TEAM_ID> \
     --username <APPLE_ID>
   ```

   - Đăng nhập Apple ID + mã 2FA khi được hỏi.
   - Match tạo **Apple Distribution certificate** và profile **`match AppStore com.vstech.vstechHomeServices`**, mã hoá rồi đẩy vào repo.
   - Apple giới hạn số chứng chỉ Distribution mỗi team (thường 3). Nếu báo đầy, **hỏi team trước khi thu hồi** chứng chỉ cũ — thu hồi có thể ảnh hưởng app khác.

✅ Checklist iOS: `APPLE_ID`, `APPLE_TEAM_ID`, `APP_STORE_CONNECT_KEY_ID`, `APP_STORE_CONNECT_ISSUER_ID`, `APP_STORE_CONNECT_API_KEY_P8`, `MATCH_GIT_URL`, `MATCH_SSH_KEY`, `MATCH_PASSWORD`, `API_BASE_URL_UAT`.

---

## Phần C — Lưu ý khi phát hành

- **Số build tăng mỗi lần lên TestFlight**: App Store Connect từ chối bản trùng build number. Tăng `version: 1.0.0+N` trong `pubspec.yaml` (số sau dấu `+`) trước mỗi tag.
- Tag chỉ được tạo trên commit thuộc nhánh **`dev`** (UAT) hoặc **`prod`**.
- Job iOS chạy trên máy macOS của GitHub — repo riêng tư bị tính phút ×10.
- `APP_VERSION_CI_TOKEN` (tuỳ chọn): token để CI báo phiên bản cho backend (`POST /app-version`); thiếu thì bước này tự bỏ qua.
