// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingResponse _$BookingResponseFromJson(Map<String, dynamic> json) =>
    _BookingResponse(
      requestId: const IdConverter().fromJson(json['requestId'] as Object),
      customerId: const NullableIdConverter().fromJson(json['customerId']),
      categoryId: const NullableIdConverter().fromJson(json['categoryId']),
      assignedWorkerId: const NullableIdConverter().fromJson(
        json['assignedWorkerId'],
      ),
      status: json['status'] as String?,
      estimatedPrice: const NullableMoneyConverter().fromJson(
        json['estimatedPrice'],
      ),
      finalPrice: const NullableMoneyConverter().fromJson(json['finalPrice']),
      description: json['description'] as String?,
      addressDetail: json['addressDetail'] as String?,
      scheduledTime: const NullableUtcDateTimeConverter().fromJson(
        json['scheduledTime'] as String?,
      ),
      createdAt: const NullableUtcDateTimeConverter().fromJson(
        json['createdAt'] as String?,
      ),
      updatedAt: const NullableUtcDateTimeConverter().fromJson(
        json['updatedAt'] as String?,
      ),
    );

Map<String, dynamic> _$BookingResponseToJson(
  _BookingResponse instance,
) => <String, dynamic>{
  'requestId': const IdConverter().toJson(instance.requestId),
  'customerId': const NullableIdConverter().toJson(instance.customerId),
  'categoryId': const NullableIdConverter().toJson(instance.categoryId),
  'assignedWorkerId': const NullableIdConverter().toJson(
    instance.assignedWorkerId,
  ),
  'status': instance.status,
  'estimatedPrice': const NullableMoneyConverter().toJson(
    instance.estimatedPrice,
  ),
  'finalPrice': const NullableMoneyConverter().toJson(instance.finalPrice),
  'description': instance.description,
  'addressDetail': instance.addressDetail,
  'scheduledTime': const NullableUtcDateTimeConverter().toJson(
    instance.scheduledTime,
  ),
  'createdAt': const NullableUtcDateTimeConverter().toJson(instance.createdAt),
  'updatedAt': const NullableUtcDateTimeConverter().toJson(instance.updatedAt),
};
