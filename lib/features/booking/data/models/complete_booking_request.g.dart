// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_booking_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompleteBookingRequest _$CompleteBookingRequestFromJson(
  Map<String, dynamic> json,
) => _CompleteBookingRequest(
  actualPrice: const MoneyConverter().fromJson(json['actualPrice'] as Object),
);

Map<String, dynamic> _$CompleteBookingRequestToJson(
  _CompleteBookingRequest instance,
) => <String, dynamic>{
  'actualPrice': const MoneyConverter().toJson(instance.actualPrice),
};
