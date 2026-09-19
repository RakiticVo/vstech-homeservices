# Appendices — Thông Tin Tham Khảo

## Tổng quan
Tài liệu tham khảo nhanh cho mobile developer.

---

## 1. OpenAPI Specification

### 1.1. URL Truy Cập
- **Swagger UI:** `http://localhost:8080/q/swagger-ui`
- **OpenAPI Spec:** `http://localhost:8080/q/openapi`

### 1.2. Lưu Ý
- Spec được sinh tự động từ code khi build
- `docs/openapi.yaml` là snapshot cũ, KHÔNG dùng làm nguồn chính
- Luôn lấy spec mới nhất từ server đang chạy

### 1.3. Internal Endpoints
- Các endpoint demo/test (`/api/v1/test*`, `/api/v1/demo-categories`, `/api/v1/secure`) bị ẩn bởi `InternalEndpointFilter`
- Bị tắt hẳn ở profile `%prod` qua property `homeservice.internal-endpoints.enabled=false`

---

## 2. Build & Test Commands

### 2.1. Backend Build
```bash
cd backend_api
./gradlew build
```

### 2.2. Backend Tests
```bash
cd backend_api
./gradlew test
```

### 2.3. Check Disabled Tests
```bash
cd backend_api
./gradlew checkNoDisabledTests
```

### 2.4. Development Mode
```bash
cd backend_api
./gradlew :homeservice-api:quarkusDev
# Server chạy trên port 8080
```

---

## 3. Mock Auth Token

### 3.1. Format
```
Bearer mock-token-<role>-<id>
```

### 3.2. Ví Dụ
| Role | ID | Token |
|---|---|---|
| CUSTOMER | 1 | `Bearer mock-token-customer-1` |
| WORKER | 9 | `Bearer mock-token-worker-9` |
| ADMIN | 1 | `Bearer mock-token-admin-1` |

### 3.3. Lưu Ý
- **CHỈ** dùng ở môi trường development/test
- **KHÔNG BAO GIỜ** dùng ở production
- Implement check environment để enforce

### 3.4. Dart Implementation
```dart
class MockAuthHelper {
  static String getMockToken(UserRole role, String id) {
    assert(kDebugMode, 'Mock auth chỉ dùng ở dev mode');
    return 'Bearer mock-token-${role.value}-$id';
  }
  
  static bool isMockToken(String token) {
    return token.startsWith('Bearer mock-token-');
  }
}
```

---

## 4. Tài Liệu Liên Quan

### 4.1. Backend Documentation
| File | Mô tả |
|---|---|
| `backend_api/GEMINI.md` | Luật tối cao khi làm việc với backend |
| `docs/rules/BACKEND_DEV_RULES.md` | Quy tắc phát triển backend |
| `docs/architecture/architecture.md` | Kiến trúc hệ thống |
| `docs/references/api-contracts.md` | API contracts |
| `docs/references/client-api-reference.md` | Client API reference |

### 4.2. Mobile Documentation
| File | Mô tả |
|---|---|
| `docs/rules/MOBILE_DEV_RULES.md` | Quy tắc phát triển mobile |
| `docs/mobile/README.md` | Trang chủ tài liệu mobile |
| `docs/mobile/00-foundation.md` | Quy ước chung |

### 4.3. Planning & Specs
| File | Mô tả |
|---|---|
| `docs/specs/PRODUCT_REQUIREMENTS_DOCUMENT_V2.2.md` | PRD |
| `docs/specs/Master_Specification_Plan.md` | Kế hoạch tổng thể |
| `docs/sprint-status.yaml` | Trạng thái sprint |

---

## 5. Quick Reference

### 5.1. Base URL
```
https://api.homeservice.dev/api/v1
```

### 5.2. Auth Header
```
Authorization: Bearer <access_token>
```

### 5.3. Idempotency Header
```
X-Idempotency-Key: <uuid>
```

### 5.4. Content Type
```
Content-Type: application/json
```

---

## 6. Error Code Quick Reference

### 4xx Errors
| Code | Mô tả | Xử lý |
|---|---|---|
| HS-400-0001 | Input invalid | Kiểm tra validation |
| HS-400-0011 | Missing idempotency | Thêm header X-Idempotency-Key |
| HS-401-0001 | Unauthorized | Refresh token hoặc login lại |
| HS-401-0002 | Invalid credentials | Kiểm tra email/password |
| HS-403-0001 | Forbidden | Kiểm tra role |
| HS-404-0001 | Not found | Kiểm tra ID |
| HS-409-0002 | Conflict | Retry hoặc chờ |

### 5xx Errors
| Code | Mô tả | Xử lý |
|---|---|---|
| HS-500-0001 | Internal error | Retry sau vài giây |
| HS-503-0001 | Dispatch unavailable | Retry sau vài phút |

---

## 7. Enums Quick Reference

### UserRole
```
CUSTOMER | B2B_CUSTOMER | WORKER | SUPPLIER | ADMIN
```

### BookingStatus
```
PENDING | ACCEPTED | IN_PROGRESS | COMPLETED | CANCELLED | DISPUTE | DISPATCH_FAILED
```

### TransactionType
```
DEPOSIT | COMMISSION | EARNING | TIP | WITHDRAWAL | REFUND
```

### TransactionStatus
```
PENDING | COMPLETED | FAILED
```

### WalletType
```
USER | PLATFORM | SUPPLIER
```

### WithdrawalStatus
```
PENDING_APPROVAL | APPROVED | REJECTED | CANCELLED
```

### ApplianceType
```
AIR_CONDITIONER | REFRIGERATOR | WASHING_MACHINE | DISHWASHER | 
WATER_HEATER | ELECTRIC_STOVE | MICROWAVE | OTHER
```

### NotificationType
```
SYSTEM | BOOKING | PROMO
```

---

## 8. WebSocket Endpoints

| Endpoint | Auth | Mô tả |
|---|---|---|
| `/ws/tracking` | WORKER | Worker push GPS |
| `/ws/tracking/customer` | CUSTOMER | Customer subscribe tracking |
| `/ws/dispatch` | WORKER | Worker nhận ping booking mới |
| `/ws/chat/{roomId}` | Participant | Chat real-time |

**Lưu ý:**
- Tất cả WebSocket endpoints yêu cầu header `Authorization` khi handshake
- Không dùng subprotocol

---

## 9. Cạm Bẫy Tổng Hợp

1. **`/profiles` không phải `/users`**
2. **`/wallets/payments` không tồn tại**, chỉ có `/deposit` và `/withdraw`
3. **Chat roomId là Long**, dùng chung cho cả REST (`/api/v1/chat/rooms/{roomId}/messages`) và WebSocket (`/ws/chat/{roomId}`)
4. **technicianId bị server ignore** ở REST location
5. **ChatMessagePage/NotificationPage** không có pagination metadata
6. **Backend chưa có FCM** - mobile tự xử lý Firebase
7. **Mock auth chỉ dev/test** - production bắt buộc JWT thật

---

## 10. Checklist Khi Bắt Đầu

### Thiết lập môi trường
- [ ] Clone repo
- [ ] Cài Flutter SDK
- [ ] Chạy `flutter pub get`
- [ ] Kết nối Firebase (flutterfire configure)
- [ ] Cấu hình base URL

### Kiến trúc
- [ ] Chọn state management
- [ ] Thiết lập DI
- [ ] Tạo API client
- [ ] Tạo models

### Bảo mật
- [ ] Cài flutter_secure_storage
- [ ] Implement auth flow
- [ ] Xử lý mock auth

### Tích hợp
- [ ] Implement REST APIs
- [ ] Implement WebSocket chat
- [ ] Implement location tracking
- [ ] Xử lý FCM

### Testing
- [ ] Unit tests
- [ ] Integration tests
- [ ] Test trên iOS và Android

---

## Tài liệu liên quan
- [README.md](./README.md) — Trang chủ tài liệu mobile
- [00-foundation.md](./00-foundation.md) — Quy ước chung