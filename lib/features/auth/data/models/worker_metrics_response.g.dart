// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_metrics_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkerMetricsResponse _$WorkerMetricsResponseFromJson(
  Map<String, dynamic> json,
) => _WorkerMetricsResponse(
  totalCompletedJobs: (json['totalCompletedJobs'] as num?)?.toInt(),
  averageRating: (json['averageRating'] as num?)?.toDouble(),
  cancellationRate: (json['cancellationRate'] as num?)?.toDouble(),
  badgeTier: json['badgeTier'] as String?,
);

Map<String, dynamic> _$WorkerMetricsResponseToJson(
  _WorkerMetricsResponse instance,
) => <String, dynamic>{
  'totalCompletedJobs': instance.totalCompletedJobs,
  'averageRating': instance.averageRating,
  'cancellationRate': instance.cancellationRate,
  'badgeTier': instance.badgeTier,
};
