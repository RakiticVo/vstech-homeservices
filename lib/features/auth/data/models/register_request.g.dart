// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    _RegisterRequest(
      fullName: json['fullName'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(_RegisterRequest instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'phone': instance.phone,
      'password': instance.password,
      'role': instance.role,
      'email': instance.email,
    };
