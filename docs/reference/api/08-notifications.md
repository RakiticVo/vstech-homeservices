# Notifications — API Reference

## Tổng quan
Module quản lý thông báo trong ứng dụng. Bao gồm REST API và thông tin về FCM Push Notification.

---

## 1. REST API Endpoints

### 1.1. Lấy Danh Sách Thông Báo
**GET** `/api/v1/notifications`

| Thuộc tính | Giá trị |
|---|---|
| **Auth** | Bearer JWT |
| **Query Params** | type, page, size |
| **Success** | 200 + `ApiResponse<NotificationPage>` |
| **Errors** | HS-403-0006 |

**Query Parameters:**
- `type` (string, optional): SYSTEM | BOOKING | PROMO
- `page` (int, default 0)
- `size` (int, default 20)

**Response:**
```json
{
  "status": 200,
  "data": {
    "notifications": [
      {
        "id": "uuid",
        "userId": "uuid",
        "title": "Đặt lịch mới",
        "body": "Bạn có đặt lịch mới từ Nguyễn Văn A",
        "type": "BOOKING",
        "isRead": false,
        "createdAt": "2026-08-11T10:30:00Z"
      }
    ]
  }
}
```

**Dart Model:**
```dart
class NotificationResponse {
  final String id;
  final String userId;
  final String title;
  final String body;
  final NotificationType type;
  final bool isRead;
  final DateTime createdAt;
}
```

**LƯU Ý QUAN TRỌNG:**
- Response là `NotificationPage` (KHÔNG phải `PagedResponse`)
- Chỉ có `notifications` array, KHÔNG có `page`, `size`, `totalItems`, `totalPages`
- Client cần implement "load more" thủ công

---

### 1.2. Đánh Dấu Đã Đọc
**POST** `/api/v1/notifications/{id}/read`

| Thuộc tính | Giá trị |
|---|---|
| **Auth** | Bearer JWT |
| **Success** | 200 + `ApiResponse<Void>` |
| **Errors** | HS-403-0006, HS-404-0001 |

---

### 1.3. Đánh Dấu Tất Cả Đã Đọc
**POST** `/api/v1/notifications/read-all`

| Thuộc tính | Giá trị |
|---|---|
| **Auth** | Bearer JWT |
| **Success** | 200 + `ApiResponse<Void>` |

---

### 1.4. Lấy Cài Đặt Thông Báo
**GET** `/api/v1/notifications/settings`

| Thuộc tính | Giá trị |
|---|---|
| **Auth** | Bearer JWT |
| **Success** | 200 + `ApiResponse<NotificationSettingsResponse>` |

**Response:**
```json
{
  "status": 200,
  "data": {
    "systemEnabled": true,
    "bookingEnabled": true,
    "promoEnabled": false
  }
}
```

**Dart Model:**
```dart
class NotificationSettingsResponse {
  final bool systemEnabled;
  final bool bookingEnabled;
  final bool promoEnabled;
}
```

---

### 1.5. Cập Nhật Cài Đặt Thông Báo
**PUT** `/api/v1/notifications/settings`

| Thuộc tính | Giá trị |
|---|---|
| **Auth** | Bearer JWT |
| **Request** | `UpdateNotificationSettingsRequest` |
| **Success** | 200 + `ApiResponse<NotificationSettingsResponse>` |

**Request Body:**
```json
{
  "systemEnabled": true,    // required
  "bookingEnabled": true,   // required
  "promoEnabled": false     // required
}
```

**Dart Model:**
```dart
class UpdateNotificationSettingsRequest {
  final bool systemEnabled;
  final bool bookingEnabled;
  final bool promoEnabled;
}
```

**Lưu ý:**
- Tất cả 3 field đều required
- Nếu thiếu field → `HS-400-0001`

---

## 2. Notification Type

```dart
enum NotificationType {
  system('SYSTEM'),
  booking('BOOKING'),
  promo('PROMO');
  
  final String value;
  const NotificationType(this.value);
}
```

### Mô tả
- **SYSTEM:** Thông báo hệ thống (bảo trì, cập nhật, etc.)
- **BOOKING:** Thông báo liên quan đến đặt lịch (mới, xác nhận, hoàn thành, etc.)
- **PROMO:** Thông báo khuyến mãi, ưu đãi

---

## 3. FCM Push Notification

### 3.1. Trạng Thái Thật
**⚠️ BACKEND CHƯA CÓ FCM SERVICE**

- Backend **CHỈ** persist notification trong database
- Backend **KHÔNG** gửi push notification qua FCM
- Mobile **TỰ XỬ LÝ** Firebase client-side

### 3.2. Điều Này Có Nghĩa Là Gì?
1. **Mobile dev phải:**
   - Tự tích hợp Firebase Messaging
   - Tự xử lý token registration
   - Tự hiển thị push notification
   - Map notification type sang UI

2. **Mobile dev KHÔNG nên:**
   - Giả định backend gửi push notification
   - Chờ backend tích hợp FCM
   - Block development vì thiếu FCM backend

### 3.3. Khuyến Nghị Implement

#### Firebase Setup
```dart
// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // Request permission
  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();
  
  // Get token
  final token = await messaging.getToken();
  // TODO: Gửi token lên backend (khi backend hỗ trợ)
  
  runApp(MyApp());
}
```

#### Handle Push Notification
```dart
// Notification Handler
class PushNotificationHandler {
  void initialize() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Foreground message
      _showLocalNotification(message);
    });
    
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // User taps notification
      _navigateToScreen(message);
    });
  }
  
  void _showLocalNotification(RemoteMessage message) {
    // Hiển thị notification local khi app đang mở
  }
  
  void _navigateToScreen(RemoteMessage message) {
    // Navigate đến màn hình tương ứng
    final type = message.data['type'];
    switch (type) {
      case 'BOOKING':
        // Navigate đến chi tiết booking
        break;
      case 'SYSTEM':
        // Navigate đến thông báo hệ thống
        break;
      case 'PROMO':
        // Navigate đến khuyến mãi
        break;
    }
  }
}
```

### 3.4. Tương Lai
- Backend sẽ tích hợp FCM service (chưa xác nhận thời gian)
- Khi backend hỗ trợ, mobile chỉ cần:
  - Gửi FCM token lên backend
  - Backend tự động gửi push notification

---

## 4. Cạm Bẫy và Lưu Ý

1. **NotificationPage vs PagedResponse:**
   - `NotificationPage` chỉ có `notifications` array
   - KHÔNG có pagination metadata
   - Client cần implement infinite scroll thủ công

2. **NotificationType là String:**
   - Backend trả về string ("SYSTEM", "BOOKING", "PROMO")
   - Client cần parse sang enum

3. **Settings required all fields:**
   - `PUT /notifications/settings` yêu cầu cả 3 field
   - Thiếu field → `HS-400-0001`

4. **Backend chưa có FCM:**
   - Notification chỉ persist trong DB
   - Mobile tự xử lý Firebase client-side
   - KHÔNG giả định backend hỗ trợ push

5. **isRead field:**
   - Chỉ có trong response, không có trong request
   - Backend tự cập nhật khi gọi `POST /{id}/read`

---

## 5. Ví Dụ Dart Code

### 5.1. Notification Repository
```dart
class NotificationRepository {
  final ApiClient _api;
  
  Future<List<NotificationResponse>> getNotifications({
    NotificationType? type,
    int page = 0,
    int size = 20,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'size': size,
    };
    
    if (type != null) {
      queryParams['type'] = type.value;
    }
    
    final response = await _api.get(
      '/notifications',
      queryParameters: queryParams,
    );
    
    final result = ApiResponse<NotificationPage>.fromJson(
      response.data,
      (json) => NotificationPage.fromJson(json),
    );
    
    return result.data!.notifications;
  }
  
  Future<void> markAsRead(String id) async {
    await _api.post('/notifications/$id/read');
  }
  
  Future<void> markAllAsRead() async {
    await _api.post('/notifications/read-all');
  }
  
  Future<NotificationSettingsResponse> getSettings() async {
    final response = await _api.get('/notifications/settings');
    
    final result = ApiResponse<NotificationSettingsResponse>.fromJson(
      response.data,
      (json) => NotificationSettingsResponse.fromJson(json),
    );
    
    return result.data!;
  }
  
  Future<NotificationSettingsResponse> updateSettings(
    UpdateNotificationSettingsRequest request,
  ) async {
    final response = await _api.put(
      '/notifications/settings',
      data: request.toJson(),
    );
    
    final result = ApiResponse<NotificationSettingsResponse>.fromJson(
      response.data,
      (json) => NotificationSettingsResponse.fromJson(json),
    );
    
    return result.data!;
  }
}
```

---

## 6. Tài Liệu Liên Quan
- [00-foundation.md](./00-foundation.md) — ApiResponse, Error Codes
- [07-chat.md](./07-chat.md) — Chat notifications
- [Mobile Dev Rules](../rules/MOBILE_DEV_RULES.md) — FCM integration