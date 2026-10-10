// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'withdrawal_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WithdrawalResponse {

@NullableIdConverter() String? get id;@NullableIdConverter() String? get requestId;@NullableMoneyConverter() num? get amount; String? get bankCode; String? get bankAccountNumber; String? get status; String? get reason; String? get rejectionReason;@NullableUtcDateTimeConverter() DateTime? get createdAt;@NullableUtcDateTimeConverter() DateTime? get updatedAt;
/// Create a copy of WithdrawalResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WithdrawalResponseCopyWith<WithdrawalResponse> get copyWith => _$WithdrawalResponseCopyWithImpl<WithdrawalResponse>(this as WithdrawalResponse, _$identity);

  /// Serializes this WithdrawalResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WithdrawalResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WithdrawalResponse&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.requestId, _this.requestId) || other.requestId == _this.requestId)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.bankCode, _this.bankCode) || other.bankCode == _this.bankCode)&&(identical(other.bankAccountNumber, _this.bankAccountNumber) || other.bankAccountNumber == _this.bankAccountNumber)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.reason, _this.reason) || other.reason == _this.reason)&&(identical(other.rejectionReason, _this.rejectionReason) || other.rejectionReason == _this.rejectionReason)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WithdrawalResponse;
  return Object.hash(runtimeType,_this.id,_this.requestId,_this.amount,_this.bankCode,_this.bankAccountNumber,_this.status,_this.reason,_this.rejectionReason,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as WithdrawalResponse;
  return 'WithdrawalResponse(id: ${_this.id}, requestId: ${_this.requestId}, amount: ${_this.amount}, bankCode: ${_this.bankCode}, bankAccountNumber: ${_this.bankAccountNumber}, status: ${_this.status}, reason: ${_this.reason}, rejectionReason: ${_this.rejectionReason}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $WithdrawalResponseCopyWith<$Res>  {
  factory $WithdrawalResponseCopyWith(WithdrawalResponse value, $Res Function(WithdrawalResponse) _then) = _$WithdrawalResponseCopyWithImpl;
@useResult
$Res call({
@NullableIdConverter() String? id,@NullableIdConverter() String? requestId,@NullableMoneyConverter() num? amount, String? bankCode, String? bankAccountNumber, String? status, String? reason, String? rejectionReason,@NullableUtcDateTimeConverter() DateTime? createdAt,@NullableUtcDateTimeConverter() DateTime? updatedAt
});




}
/// @nodoc
class _$WithdrawalResponseCopyWithImpl<$Res>
    implements $WithdrawalResponseCopyWith<$Res> {
  _$WithdrawalResponseCopyWithImpl(this._self, this._then);

  final WithdrawalResponse _self;
  final $Res Function(WithdrawalResponse) _then;

/// Create a copy of WithdrawalResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? requestId = freezed,Object? amount = freezed,Object? bankCode = freezed,Object? bankAccountNumber = freezed,Object? status = freezed,Object? reason = freezed,Object? rejectionReason = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(WithdrawalResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num?,bankCode: freezed == bankCode ? _self.bankCode : bankCode // ignore: cast_nullable_to_non_nullable
as String?,bankAccountNumber: freezed == bankAccountNumber ? _self.bankAccountNumber : bankAccountNumber // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WithdrawalResponse].
extension WithdrawalResponsePatterns on WithdrawalResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WithdrawalResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WithdrawalResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WithdrawalResponse value)  $default,){
final _that = this;
switch (_that) {
case _WithdrawalResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WithdrawalResponse value)?  $default,){
final _that = this;
switch (_that) {
case _WithdrawalResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@NullableIdConverter()  String? id, @NullableIdConverter()  String? requestId, @NullableMoneyConverter()  num? amount,  String? bankCode,  String? bankAccountNumber,  String? status,  String? reason,  String? rejectionReason, @NullableUtcDateTimeConverter()  DateTime? createdAt, @NullableUtcDateTimeConverter()  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WithdrawalResponse() when $default != null:
return $default(_that.id,_that.requestId,_that.amount,_that.bankCode,_that.bankAccountNumber,_that.status,_that.reason,_that.rejectionReason,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@NullableIdConverter()  String? id, @NullableIdConverter()  String? requestId, @NullableMoneyConverter()  num? amount,  String? bankCode,  String? bankAccountNumber,  String? status,  String? reason,  String? rejectionReason, @NullableUtcDateTimeConverter()  DateTime? createdAt, @NullableUtcDateTimeConverter()  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _WithdrawalResponse():
return $default(_that.id,_that.requestId,_that.amount,_that.bankCode,_that.bankAccountNumber,_that.status,_that.reason,_that.rejectionReason,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@NullableIdConverter()  String? id, @NullableIdConverter()  String? requestId, @NullableMoneyConverter()  num? amount,  String? bankCode,  String? bankAccountNumber,  String? status,  String? reason,  String? rejectionReason, @NullableUtcDateTimeConverter()  DateTime? createdAt, @NullableUtcDateTimeConverter()  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _WithdrawalResponse() when $default != null:
return $default(_that.id,_that.requestId,_that.amount,_that.bankCode,_that.bankAccountNumber,_that.status,_that.reason,_that.rejectionReason,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WithdrawalResponse extends WithdrawalResponse {
  const _WithdrawalResponse({@NullableIdConverter() this.id, @NullableIdConverter() this.requestId, @NullableMoneyConverter() this.amount, this.bankCode, this.bankAccountNumber, this.status, this.reason, this.rejectionReason, @NullableUtcDateTimeConverter() this.createdAt, @NullableUtcDateTimeConverter() this.updatedAt}): super._();
  factory _WithdrawalResponse.fromJson(Map<String, dynamic> json) => _$WithdrawalResponseFromJson(json);

@override@NullableIdConverter() final  String? id;
@override@NullableIdConverter() final  String? requestId;
@override@NullableMoneyConverter() final  num? amount;
@override final  String? bankCode;
@override final  String? bankAccountNumber;
@override final  String? status;
@override final  String? reason;
@override final  String? rejectionReason;
@override@NullableUtcDateTimeConverter() final  DateTime? createdAt;
@override@NullableUtcDateTimeConverter() final  DateTime? updatedAt;

/// Create a copy of WithdrawalResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WithdrawalResponseCopyWith<_WithdrawalResponse> get copyWith => __$WithdrawalResponseCopyWithImpl<_WithdrawalResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WithdrawalResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WithdrawalResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.bankCode, bankCode) || other.bankCode == bankCode)&&(identical(other.bankAccountNumber, bankAccountNumber) || other.bankAccountNumber == bankAccountNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,requestId,amount,bankCode,bankAccountNumber,status,reason,rejectionReason,createdAt,updatedAt);
}

@override
String toString() {
    return 'WithdrawalResponse(id: $id, requestId: $requestId, amount: $amount, bankCode: $bankCode, bankAccountNumber: $bankAccountNumber, status: $status, reason: $reason, rejectionReason: $rejectionReason, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$WithdrawalResponseCopyWith<$Res> implements $WithdrawalResponseCopyWith<$Res> {
  factory _$WithdrawalResponseCopyWith(_WithdrawalResponse value, $Res Function(_WithdrawalResponse) _then) = __$WithdrawalResponseCopyWithImpl;
@override @useResult
$Res call({
@NullableIdConverter() String? id,@NullableIdConverter() String? requestId,@NullableMoneyConverter() num? amount, String? bankCode, String? bankAccountNumber, String? status, String? reason, String? rejectionReason,@NullableUtcDateTimeConverter() DateTime? createdAt,@NullableUtcDateTimeConverter() DateTime? updatedAt
});




}
/// @nodoc
class __$WithdrawalResponseCopyWithImpl<$Res>
    implements _$WithdrawalResponseCopyWith<$Res> {
  __$WithdrawalResponseCopyWithImpl(this._self, this._then);

  final _WithdrawalResponse _self;
  final $Res Function(_WithdrawalResponse) _then;

/// Create a copy of WithdrawalResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? requestId = freezed,Object? amount = freezed,Object? bankCode = freezed,Object? bankAccountNumber = freezed,Object? status = freezed,Object? reason = freezed,Object? rejectionReason = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_WithdrawalResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num?,bankCode: freezed == bankCode ? _self.bankCode : bankCode // ignore: cast_nullable_to_non_nullable
as String?,bankAccountNumber: freezed == bankAccountNumber ? _self.bankAccountNumber : bankAccountNumber // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
