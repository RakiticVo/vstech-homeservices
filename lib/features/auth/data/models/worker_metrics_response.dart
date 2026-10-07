import 'package:freezed_annotation/freezed_annotation.dart';

part 'worker_metrics_response.freezed.dart';
part 'worker_metrics_response.g.dart';

/// `WorkerMetricsDTO`.
@freezed
abstract class WorkerMetricsResponse with _$WorkerMetricsResponse {
  const factory WorkerMetricsResponse({
    int? totalCompletedJobs,
    double? averageRating,
    double? cancellationRate,
    String? badgeTier,
  }) = _WorkerMetricsResponse;

  factory WorkerMetricsResponse.fromJson(Map<String, dynamic> json) => _$WorkerMetricsResponseFromJson(json);
}
