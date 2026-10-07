// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_kyc_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkerKycResponse _$WorkerKycResponseFromJson(Map<String, dynamic> json) =>
    _WorkerKycResponse(
      approvalStatus: json['approvalStatus'] as String?,
      idCardNumber: json['idCardNumber'] as String?,
      idCardFrontUrl: json['idCardFrontUrl'] as String?,
      idCardBackUrl: json['idCardBackUrl'] as String?,
    );

Map<String, dynamic> _$WorkerKycResponseToJson(_WorkerKycResponse instance) =>
    <String, dynamic>{
      'approvalStatus': instance.approvalStatus,
      'idCardNumber': instance.idCardNumber,
      'idCardFrontUrl': instance.idCardFrontUrl,
      'idCardBackUrl': instance.idCardBackUrl,
    };
