// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingResponse {

@IdConverter() String get requestId;@NullableIdConverter() String? get customerId;@NullableIdConverter() String? get categoryId;@NullableIdConverter() String? get assignedWorkerId; String? get status;@NullableMoneyConverter() num? get estimatedPrice;@NullableMoneyConverter() num? get finalPrice; String? get description; String? get addressDetail;@NullableUtcDateTimeConverter() DateTime? get scheduledTime;@NullableUtcDateTimeConverter() DateTime? get createdAt;@NullableUtcDateTimeConverter() DateTime? get updatedAt;
/// Create a copy of BookingResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingResponseCopyWith<BookingResponse> get copyWith => _$BookingResponseCopyWithImpl<BookingResponse>(this as BookingResponse, _$identity);

  /// Serializes this BookingResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BookingResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingResponse&&(identical(other.requestId, _this.requestId) || other.requestId == _this.requestId)&&(identical(other.customerId, _this.customerId) || other.customerId == _this.customerId)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.assignedWorkerId, _this.assignedWorkerId) || other.assignedWorkerId == _this.assignedWorkerId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.estimatedPrice, _this.estimatedPrice) || other.estimatedPrice == _this.estimatedPrice)&&(identical(other.finalPrice, _this.finalPrice) || other.finalPrice == _this.finalPrice)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.addressDetail, _this.addressDetail) || other.addressDetail == _this.addressDetail)&&(identical(other.scheduledTime, _this.scheduledTime) || other.scheduledTime == _this.scheduledTime)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BookingResponse;
  return Object.hash(runtimeType,_this.requestId,_this.customerId,_this.categoryId,_this.assignedWorkerId,_this.status,_this.estimatedPrice,_this.finalPrice,_this.description,_this.addressDetail,_this.scheduledTime,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as BookingResponse;
  return 'BookingResponse(requestId: ${_this.requestId}, customerId: ${_this.customerId}, categoryId: ${_this.categoryId}, assignedWorkerId: ${_this.assignedWorkerId}, status: ${_this.status}, estimatedPrice: ${_this.estimatedPrice}, finalPrice: ${_this.finalPrice}, description: ${_this.description}, addressDetail: ${_this.addressDetail}, scheduledTime: ${_this.scheduledTime}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $BookingResponseCopyWith<$Res>  {
  factory $BookingResponseCopyWith(BookingResponse value, $Res Function(BookingResponse) _then) = _$BookingResponseCopyWithImpl;
@useResult
$Res call({
@IdConverter() String requestId,@NullableIdConverter() String? customerId,@NullableIdConverter() String? categoryId,@NullableIdConverter() String? assignedWorkerId, String? status,@NullableMoneyConverter() num? estimatedPrice,@NullableMoneyConverter() num? finalPrice, String? description, String? addressDetail,@NullableUtcDateTimeConverter() DateTime? scheduledTime,@NullableUtcDateTimeConverter() DateTime? createdAt,@NullableUtcDateTimeConverter() DateTime? updatedAt
});




}
/// @nodoc
class _$BookingResponseCopyWithImpl<$Res>
    implements $BookingResponseCopyWith<$Res> {
  _$BookingResponseCopyWithImpl(this._self, this._then);

  final BookingResponse _self;
  final $Res Function(BookingResponse) _then;

/// Create a copy of BookingResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requestId = null,Object? customerId = freezed,Object? categoryId = freezed,Object? assignedWorkerId = freezed,Object? status = freezed,Object? estimatedPrice = freezed,Object? finalPrice = freezed,Object? description = freezed,Object? addressDetail = freezed,Object? scheduledTime = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(BookingResponse(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,assignedWorkerId: freezed == assignedWorkerId ? _self.assignedWorkerId : assignedWorkerId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,estimatedPrice: freezed == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as num?,finalPrice: freezed == finalPrice ? _self.finalPrice : finalPrice // ignore: cast_nullable_to_non_nullable
as num?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,addressDetail: freezed == addressDetail ? _self.addressDetail : addressDetail // ignore: cast_nullable_to_non_nullable
as String?,scheduledTime: freezed == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingResponse].
extension BookingResponsePatterns on BookingResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingResponse value)  $default,){
final _that = this;
switch (_that) {
case _BookingResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingResponse value)?  $default,){
final _that = this;
switch (_that) {
case _BookingResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdConverter()  String requestId, @NullableIdConverter()  String? customerId, @NullableIdConverter()  String? categoryId, @NullableIdConverter()  String? assignedWorkerId,  String? status, @NullableMoneyConverter()  num? estimatedPrice, @NullableMoneyConverter()  num? finalPrice,  String? description,  String? addressDetail, @NullableUtcDateTimeConverter()  DateTime? scheduledTime, @NullableUtcDateTimeConverter()  DateTime? createdAt, @NullableUtcDateTimeConverter()  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingResponse() when $default != null:
return $default(_that.requestId,_that.customerId,_that.categoryId,_that.assignedWorkerId,_that.status,_that.estimatedPrice,_that.finalPrice,_that.description,_that.addressDetail,_that.scheduledTime,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdConverter()  String requestId, @NullableIdConverter()  String? customerId, @NullableIdConverter()  String? categoryId, @NullableIdConverter()  String? assignedWorkerId,  String? status, @NullableMoneyConverter()  num? estimatedPrice, @NullableMoneyConverter()  num? finalPrice,  String? description,  String? addressDetail, @NullableUtcDateTimeConverter()  DateTime? scheduledTime, @NullableUtcDateTimeConverter()  DateTime? createdAt, @NullableUtcDateTimeConverter()  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _BookingResponse():
return $default(_that.requestId,_that.customerId,_that.categoryId,_that.assignedWorkerId,_that.status,_that.estimatedPrice,_that.finalPrice,_that.description,_that.addressDetail,_that.scheduledTime,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdConverter()  String requestId, @NullableIdConverter()  String? customerId, @NullableIdConverter()  String? categoryId, @NullableIdConverter()  String? assignedWorkerId,  String? status, @NullableMoneyConverter()  num? estimatedPrice, @NullableMoneyConverter()  num? finalPrice,  String? description,  String? addressDetail, @NullableUtcDateTimeConverter()  DateTime? scheduledTime, @NullableUtcDateTimeConverter()  DateTime? createdAt, @NullableUtcDateTimeConverter()  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _BookingResponse() when $default != null:
return $default(_that.requestId,_that.customerId,_that.categoryId,_that.assignedWorkerId,_that.status,_that.estimatedPrice,_that.finalPrice,_that.description,_that.addressDetail,_that.scheduledTime,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingResponse implements BookingResponse {
  const _BookingResponse({@IdConverter() required this.requestId, @NullableIdConverter() this.customerId, @NullableIdConverter() this.categoryId, @NullableIdConverter() this.assignedWorkerId, this.status, @NullableMoneyConverter() this.estimatedPrice, @NullableMoneyConverter() this.finalPrice, this.description, this.addressDetail, @NullableUtcDateTimeConverter() this.scheduledTime, @NullableUtcDateTimeConverter() this.createdAt, @NullableUtcDateTimeConverter() this.updatedAt});
  factory _BookingResponse.fromJson(Map<String, dynamic> json) => _$BookingResponseFromJson(json);

@override@IdConverter() final  String requestId;
@override@NullableIdConverter() final  String? customerId;
@override@NullableIdConverter() final  String? categoryId;
@override@NullableIdConverter() final  String? assignedWorkerId;
@override final  String? status;
@override@NullableMoneyConverter() final  num? estimatedPrice;
@override@NullableMoneyConverter() final  num? finalPrice;
@override final  String? description;
@override final  String? addressDetail;
@override@NullableUtcDateTimeConverter() final  DateTime? scheduledTime;
@override@NullableUtcDateTimeConverter() final  DateTime? createdAt;
@override@NullableUtcDateTimeConverter() final  DateTime? updatedAt;

/// Create a copy of BookingResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingResponseCopyWith<_BookingResponse> get copyWith => __$BookingResponseCopyWithImpl<_BookingResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingResponse&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.assignedWorkerId, assignedWorkerId) || other.assignedWorkerId == assignedWorkerId)&&(identical(other.status, status) || other.status == status)&&(identical(other.estimatedPrice, estimatedPrice) || other.estimatedPrice == estimatedPrice)&&(identical(other.finalPrice, finalPrice) || other.finalPrice == finalPrice)&&(identical(other.description, description) || other.description == description)&&(identical(other.addressDetail, addressDetail) || other.addressDetail == addressDetail)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,requestId,customerId,categoryId,assignedWorkerId,status,estimatedPrice,finalPrice,description,addressDetail,scheduledTime,createdAt,updatedAt);
}

@override
String toString() {
    return 'BookingResponse(requestId: $requestId, customerId: $customerId, categoryId: $categoryId, assignedWorkerId: $assignedWorkerId, status: $status, estimatedPrice: $estimatedPrice, finalPrice: $finalPrice, description: $description, addressDetail: $addressDetail, scheduledTime: $scheduledTime, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$BookingResponseCopyWith<$Res> implements $BookingResponseCopyWith<$Res> {
  factory _$BookingResponseCopyWith(_BookingResponse value, $Res Function(_BookingResponse) _then) = __$BookingResponseCopyWithImpl;
@override @useResult
$Res call({
@IdConverter() String requestId,@NullableIdConverter() String? customerId,@NullableIdConverter() String? categoryId,@NullableIdConverter() String? assignedWorkerId, String? status,@NullableMoneyConverter() num? estimatedPrice,@NullableMoneyConverter() num? finalPrice, String? description, String? addressDetail,@NullableUtcDateTimeConverter() DateTime? scheduledTime,@NullableUtcDateTimeConverter() DateTime? createdAt,@NullableUtcDateTimeConverter() DateTime? updatedAt
});




}
/// @nodoc
class __$BookingResponseCopyWithImpl<$Res>
    implements _$BookingResponseCopyWith<$Res> {
  __$BookingResponseCopyWithImpl(this._self, this._then);

  final _BookingResponse _self;
  final $Res Function(_BookingResponse) _then;

/// Create a copy of BookingResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requestId = null,Object? customerId = freezed,Object? categoryId = freezed,Object? assignedWorkerId = freezed,Object? status = freezed,Object? estimatedPrice = freezed,Object? finalPrice = freezed,Object? description = freezed,Object? addressDetail = freezed,Object? scheduledTime = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_BookingResponse(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,assignedWorkerId: freezed == assignedWorkerId ? _self.assignedWorkerId : assignedWorkerId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,estimatedPrice: freezed == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as num?,finalPrice: freezed == finalPrice ? _self.finalPrice : finalPrice // ignore: cast_nullable_to_non_nullable
as num?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,addressDetail: freezed == addressDetail ? _self.addressDetail : addressDetail // ignore: cast_nullable_to_non_nullable
as String?,scheduledTime: freezed == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
