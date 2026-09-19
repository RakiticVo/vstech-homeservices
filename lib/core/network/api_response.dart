/// Standard response envelope every API endpoint returns (`docs/reference/api/00-foundation.md`).
/// Always parse through this — never read `json['field']` directly in a datasource.
class ApiResponse<T> {
  const ApiResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.errorCode,
    required this.timestamp,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromDataJson,
  ) {
    final rawData = json['data'];
    return ApiResponse<T>(
      status: json['status'] as int,
      message: json['message'] as String? ?? '',
      data: rawData == null ? null : fromDataJson(rawData),
      errorCode: json['errorCode'] as String?,
      timestamp: json['timestamp'] as String?,
    );
  }

  final int status;
  final String message;
  final T? data;
  final String? errorCode;
  final String? timestamp;

  bool get isSuccess => errorCode == null && status >= 200 && status < 300;
}

/// Pagination envelope used by most list endpoints. Chat and Notifications are the documented
/// exceptions (bare `{messages:[...]}` / `{notifications:[...]}`, no pagination metadata) — do not
/// use this class for those two, implement manual "load more" instead.
class PagedResponse<T> {
  const PagedResponse({
    required this.content,
    required this.page,
    required this.size,
    required this.totalItems,
    required this.totalPages,
  });

  factory PagedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromItemJson,
  ) {
    return PagedResponse<T>(
      content: (json['content'] as List<dynamic>).map(fromItemJson).toList(),
      page: json['page'] as int,
      size: json['size'] as int,
      totalItems: json['totalItems'] as int,
      totalPages: json['totalPages'] as int,
    );
  }

  final List<T> content;
  final int page;
  final int size;
  final int totalItems;
  final int totalPages;
}
