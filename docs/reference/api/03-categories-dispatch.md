# Categories & Dispatch — API Reference

## Tổng quan
Module quản lý danh mục dịch vụ và hệ thống phân công thợ (dispatch).

---

## 1. Service Categories

### 1.1. Lấy Danh Sách Danh Mục
**GET** `/api/v1/service-categories`

| Thuộc tính | Giá trị |
|---|---|
| **Auth** | Bearer JWT |
| **Query Params** | page, size |
| **Success** | 200 + `ApiResponse<PagedResponse<ServiceCategoryResponse>>` |

**Response:**
```json
{
  "status": 200,
  "data": {
    "content": [
      {
        "id": "uuid",
        "name": "Sửa máy lạnh",
        "description": "Dịch vụ sửa chữa máy lạnh các loại",
        "basePrice": "200000",
        "commissionRate": "0.1",
        "isActive": true,
        "imageUrl": "https://..."
      }
    ],
    "page": 0,
    "size": 20,
    "totalItems": 1,
    "totalPages": 1
  }
}
```

---

### 1.2. Lấy Chi Tiết Danh Mục
**GET** `/api/v1/service-categories/{id}`

| Thuộc tính | Giá trị |
|---|---|
| **Auth** | Bearer JWT |
| **Success** | 200 + `ApiResponse<ServiceCategoryResponse>` |
| **Errors** | HS-404-0003 |

**Response:**
```json
{
  "status": 200,
  "data": {
    "id": "uuid",
    "name": "Sửa máy lạnh",
    "description": "Dịch vụ sửa chữa máy lạnh các loại",
    "basePrice": "200000",
    "commissionRate": "0.1",
    "isActive": true,
    "imageUrl": "https://..."
  }
}
```

---

### 1.3. Tạo Danh Mục (Admin)
**POST** `/api/v1/service-categories`

| Thuộc tính | Giá trị |
|---|---|
| **Auth** | Bearer JWT (ADMIN) |
| **Request** | `CreateServiceCategoryRequest` |
| **Success** | 201 + `ApiResponse<ServiceCategoryResponse>` |
| **Errors** | HS-409-0006 |

**Request Body:**
```json
{
  "name": "Sửa máy lạnh",           // required
  "description": "Mô tả",           // required
  "basePrice": "200000",            // required
  "commissionRate": "0.1",          // required (0-1)
  "imageUrl": "https://..."        // optional
}
```

---

### 1.4. Cập Nhật Danh Mục (Admin)
**PUT** `/api/v1/service-categories/{id}`

| Thuộc tính | Giá trị |
|---|---|
| **Auth** | Bearer JWT (ADMIN) |
| **Request** | `UpdateServiceCategoryRequest` |
| **Success** | 200 + `ApiResponse<ServiceCategoryResponse>` |
| **Errors** | HS-404-0003, HS-409-0006 |

---

### 1.5. Xóa Danh Mục (Admin)
**DELETE** `/api/v1/service-categories/{id}`

| Thuộc tính | Giá trị |
|---|---|
| **Auth** | Bearer JWT (ADMIN) |
| **Success** | 204 (No Content) |
| **Errors** | HS-404-0003, HS-409-0007 |

**Lưu ý:**
- Không thể xóa danh mục đang có booking → `HS-409-0007`

---

## 2. Dispatch

### 2.1. Lấy Manual Queue
**GET** `/api/v1/dispatch/manual-queue`

| Thuộc tính | Giá trị |
|---|---|
| **Auth** | Bearer JWT (ADMIN) |
| **Query Params** | page, pageSize |
| **Success** | 200 + `ApiResponse<List<Map<String, Object>>>` |

**Response:**
```json
{
  "status": 200,
  "data": [
    {
      "bookingId": "uuid",
      "customerId": "uuid",
      "categoryId": "uuid",
      "status": "PENDING",
      "scheduledTime": "2026-08-15T09:00:00Z",
      "addressDetail": "123 Đường ABC"
    }
  ]
}
```

**Lưu ý:**
- Endpoint trả về `List<Map<String, Object>>` thay vì typed DTO
- Cần parse thủ công hoặc tạo model riêng

---

### 2.2. Manual Assign
**POST** `/api/v1/dispatch/manual-queue/{bookingId}/assign`

| Thuộc tính | Giá trị |
|---|---|
| **Auth** | Bearer JWT (ADMIN) |
| **Request** | `ManualAssignRequest` |
| **Success** | 200 + `ApiResponse<Map<String, Object>>` |
| **Errors** | HS-404-0011, HS-503-0001 |

**Request Body:**
```json
{
  "technicianId": "uuid"  // required
}
```

**Response:**
```json
{
  "status": 200,
  "data": {
    "bookingId": "uuid",
    "technicianId": "uuid",
    "status": "ACCEPTED"
  }
}
```

---

## 3. DTO Summary

### 3.1. ServiceCategoryResponse
```dart
class ServiceCategoryResponse {
  final String id;
  final String name;
  final String description;
  final num basePrice;
  final num commissionRate;
  final bool isActive;
  final String? imageUrl;
}
```

### 3.2. CreateServiceCategoryRequest
```dart
class CreateServiceCategoryRequest {
  final String name;
  final String description;
  final num basePrice;
  final num commissionRate;
  final String? imageUrl;
}
```

### 3.3. UpdateServiceCategoryRequest
```dart
class UpdateServiceCategoryRequest {
  final String? name;
  final String? description;
  final num? basePrice;
  final num? commissionRate;
  final String? imageUrl;
}
```

### 3.4. ManualAssignRequest
```dart
class ManualAssignRequest {
  final String technicianId;
}
```

---

## 4. Cạm Bẫy và Lưu Ý

1. **Manual Queue là untyped:** Response trả về `List<Map<String, Object>>` cần parse thủ công
2. **Commission Rate là decimal:** 0.1 = 10%, không phải 10
3. **Base Price là BigDecimal:** Luôn parse từ string, không dùng int
4. **Category Name Duplicate:** Tên trùng → `HS-409-0006`
5. **Category In Use:** Đang có booking → không xóa được → `HS-409-0007`
6. **Dispatch Unavailable:** Hệ thống phân công gặp sự cố → `HS-503-0001`

---

## 5. Ví Dụ Dart Code

### 5.1. Lấy Danh Sách Danh Mục
```dart
class CategoryRepository {
  final ApiClient _api;
  
  Future<PagedResponse<ServiceCategoryResponse>> getCategories({
    int page = 0,
    int size = 20,
  }) async {
    final response = await _api.get(
      '/service-categories',
      queryParameters: {'page': page, 'size': size},
    );
    
    return PagedResponse<ServiceCategoryResponse>.fromJson(
      response.data,
      (json) => ServiceCategoryResponse.fromJson(json),
    );
  }
}
```

### 5.2. Parse Manual Queue
```dart
class ManualQueueItem {
  final String bookingId;
  final String customerId;
  final String categoryId;
  final String status;
  final DateTime scheduledTime;
  final String addressDetail;
  
  factory ManualQueueItem.fromMap(Map<String, dynamic> map) {
    return ManualQueueItem(
      bookingId: map['bookingId'],
      customerId: map['customerId'],
      categoryId: map['categoryId'],
      status: map['status'],
      scheduledTime: DateTime.parse(map['scheduledTime']),
      addressDetail: map['addressDetail'],
    );
  }
}
```

---

## Tài liệu liên quan
- [00-foundation.md](./00-foundation.md) — ApiResponse, Error Codes
- [02-bookings.md](./02-bookings.md) — Booking sử dụng Categories