# Wallet & Payments — API Reference

## Tổng quan
Module quản lý ví tiền, giao dịch và thanh toán (deposit/withdraw).

---

## 1. Wallet Endpoints

### 1.1. Lấy Thông Tin Ví
**GET** `/api/v1/wallets/me`

| Thuộc tính | Giá trị |
|---|---|
| **Auth** | Bearer JWT |
| **Success** | 200 + `ApiResponse<WalletResponse>` |
| **Errors** | HS-401-0001, HS-404-0020 |

**Response:**
```json
{
  "status": 200,
  "data": {
    "walletId": "uuid",
    "ownerId": "uuid",
    "balance": "1000000",
    "frozenBalance": "500000",
    "currency": "VND",
    "walletType": "USER",
    "createdAt": "2026-08-11T10:30:00Z"
  }
}
```

**Dart Model:**
```dart
class WalletResponse {
  final String walletId;
  final String ownerId;
  final num balance;
  final num frozenBalance;
  final String currency;
  final WalletType walletType;
  final DateTime createdAt;
}
```

**Lưu ý:**
- `balance`: Số dư khả dụng
- `frozenBalance`: Số dư đang đóng băng (chờ xử lý)
- `currency`: Luôn là "VND"

---

### 1.2. Lấy Lịch Sử Giao Dịch
**GET** `/api/v1/wallets/me/transactions`

| Thuộc tính | Giá trị |
|---|---|
| **Auth** | Bearer JWT |
| **Query Params** | page, size, type, status |
| **Success** | 200 + `ApiResponse<PagedResponse<WalletTransactionResponse>>` |

**Query Parameters:**
- `page` (int, default 0)
- `size` (int, default 20)
- `type` (string, optional): DEPOSIT | COMMISSION | EARNING | TIP | WITHDRAWAL | REFUND
- `status` (string, optional): PENDING | COMPLETED | FAILED

**Response:**
```json
{
  "status": 200,
  "data": {
    "content": [
      {
        "id": "uuid",
        "type": "DEPOSIT",
        "amount": "500000",
        "delta": "500000",
        "status": "COMPLETED",
        "description": "Nạp tiền vào ví",
        "createdAt": "2026-08-11T10:30:00Z"
      }
    ],
    "page": 0,
    "size": 20,
    "totalItems": 1,
    "totalPages": 1
  }
}
```

**Dart Model:**
```dart
class WalletTransactionResponse {
  final String id;
  final TransactionType type;
  final num amount;
  final num delta;  // Dương = incoming, Âm = outgoing
  final TransactionStatus status;
  final String? description;
  final DateTime createdAt;
}
```

**Lưu ý về `delta`:**
- **Dương (+):** Tiền vào (deposit, earning, tip, refund)
- **Âm (-):** Tiền ra (withdrawal, commission)

---

## 2. Payments Endpoints

### 2.1. Deposit (Nạp Tiền)
**POST** `/api/v1/wallets/payments/deposit`

| Thuộc tính | Giá trị |
|---|---|
| **Auth** | Bearer JWT |
| **Request** | `PaymentDepositDTO` |
| **Success** | 200 + `ApiResponse<LedgerTransactionResponse>` |
| **Errors** | HS-400-0001, HS-409-0002 |

**Request Body:**
```json
{
  "amount": "500000",           // required
  "gateway": "VNPAY",          // required
  "gatewayTxId": "VNP123456"   // required
}
```

**Response:**
```json
{
  "status": 200,
  "data": {
    "id": "uuid",
    "type": "DEPOSIT",
    "amount": "500000",
    "status": "COMPLETED",
    "gateway": "VNPAY",
    "gatewayTxId": "VNP123456",
    "createdAt": "2026-08-11T10:30:00Z"
  }
}
```

---

### 2.2. Withdraw (Rút Tiền)
**POST** `/api/v1/wallets/payments/withdraw`

| Thuộc tính | Giá trị |
|---|---|
| **Auth** | Bearer JWT |
| **Request** | `PaymentWithdrawDTO` |
| **Success** | 200 + `ApiResponse<LedgerTransactionResponse>` |
| **Errors** | HS-400-0020, HS-400-0021, HS-409-0002 |

**Request Body:**
```json
{
  "amount": "200000",           // required
  "gateway": "BANK_TRANSFER",  // required
  "gatewayTxId": "BT123456"    // required
}
```

**Lưu ý:**
- `amount` không được vượt quá `balance` → `HS-400-0020`
- Nếu có withdrawal đang pending → `HS-400-0021`

---

## 3. DTO Summary

### 3.1. PaymentDepositDTO
```dart
class PaymentDepositDTO {
  final num amount;
  final String gateway;
  final String gatewayTxId;
}
```

### 3.2. PaymentWithdrawDTO
```dart
class PaymentWithdrawDTO {
  final num amount;
  final String gateway;
  final String gatewayTxId;
}
```

### 3.3. LedgerTransactionResponse
```dart
class LedgerTransactionResponse {
  final String id;
  final TransactionType type;
  final num amount;
  final TransactionStatus status;
  final String gateway;
  final String gatewayTxId;
  final DateTime createdAt;
}
```

---

## 4. BigDecimal Handling

### 4.1. Parse từ Response
```dart
// Backend trả về string-number: "500000"
final amount = num.parse(response.data.balance); // 500000

// Sử dụng decimal package cho chính xác hơn
import 'package:decimal/decimal.dart';
final balance = Decimal.parse(response.data.balance);
```

### 4.2. Hiển thị
```dart
import 'package:intl/intl.dart';

final formatter = NumberFormat.currency(
  locale: 'vi_VN',
  symbol: 'VNĐ',
  decimalDigits: 0,
);

String formatAmount(num amount) {
  return formatter.format(amount); // "500.000 VNĐ"
}
```

### 4.3. Gửi Request
```dart
// Luôn gửi dưới dạng string, KHÔNG có dấu phân cách
final request = PaymentDepositDTO(
  amount: "500000",  // ĐÚNG
  // amount: 500000,  // SAI - có thể bị parse sai
);
```

---

## 5. Cạm Bẫy và Lưu Ý

1. **KHÔNG có endpoint `POST /payments`:** Chỉ có `/deposit` và `/withdraw`
2. **Delta dương/âm:** Dương = tiền vào, Âm = tiền ra
3. **Currency luôn VND:** Backend chỉ hỗ trợ VND
4. **Frozen Balance:** Số dư đang chờ xử lý, không khả dụng
5. **Gateway là string:** Backend accept nhiều gateway (VNPAY, BANK_TRANSFER, etc.)
6. **Concurrent Update:** Nếu có giao dịch đồng thời → `HS-409-0002`

---

## 6. Ví Dụ Dart Code

### 6.1. Lấy Thông Tin Ví
```dart
class WalletRepository {
  final ApiClient _api;
  
  Future<WalletResponse> getMyWallet() async {
    final response = await _api.get('/wallets/me');
    
    final result = ApiResponse<WalletResponse>.fromJson(
      response.data,
      (json) => WalletResponse.fromJson(json),
    );
    
    return result.data!;
  }
}
```

### 6.2. Deposit
```dart
Future<LedgerTransactionResponse> deposit({
  required num amount,
  required String gateway,
  required String gatewayTxId,
}) async {
  final response = await _api.post(
    '/wallets/payments/deposit',
    data: {
      'amount': amount.toString(),
      'gateway': gateway,
      'gatewayTxId': gatewayTxId,
    },
  );
  
  final result = ApiResponse<LedgerTransactionResponse>.fromJson(
    response.data,
    (json) => LedgerTransactionResponse.fromJson(json),
  );
  
  return result.data!;
}
```

---

## Tài liệu liên quan
- [00-foundation.md](./00-foundation.md) — ApiResponse, Error Codes
- [06-withdrawals.md](./06-withdrawals.md) — Worker Withdrawal Flow