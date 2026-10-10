// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_booking_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateBookingRequest {

@IdConverter() String get categoryId; String get description; String get addressDetail; double get locationLat; double get locationLng;@UtcDateTimeConverter() DateTime get scheduledTime;@NullableIdConverter() String? get applianceId; String? get deviceIp;
/// Create a copy of CreateBookingRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateBookingRequestCopyWith<CreateBookingRequest> get copyWith => _$CreateBookingRequestCopyWithImpl<CreateBookingRequest>(this as CreateBookingRequest, _$identity);

  /// Serializes this CreateBookingRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreateBookingRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateBookingRequest&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.addressDetail, _this.addressDetail) || other.addressDetail == _this.addressDetail)&&(identical(other.locationLat, _this.locationLat) || other.locationLat == _this.locationLat)&&(identical(other.locationLng, _this.locationLng) || other.locationLng == _this.locationLng)&&(identical(other.scheduledTime, _this.scheduledTime) || other.scheduledTime == _this.scheduledTime)&&(identical(other.applianceId, _this.applianceId) || other.applianceId == _this.applianceId)&&(identical(other.deviceIp, _this.deviceIp) || other.deviceIp == _this.deviceIp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreateBookingRequest;
  return Object.hash(runtimeType,_this.categoryId,_this.description,_this.addressDetail,_this.locationLat,_this.locationLng,_this.scheduledTime,_this.applianceId,_this.deviceIp);
}

@override
String toString() {
  final _this = this as CreateBookingRequest;
  return 'CreateBookingRequest(categoryId: ${_this.categoryId}, description: ${_this.description}, addressDetail: ${_this.addressDetail}, locationLat: ${_this.locationLat}, locationLng: ${_this.locationLng}, scheduledTime: ${_this.scheduledTime}, applianceId: ${_this.applianceId}, deviceIp: ${_this.deviceIp})';
}


}

/// @nodoc
abstract mixin class $CreateBookingRequestCopyWith<$Res>  {
  factory $CreateBookingRequestCopyWith(CreateBookingRequest value, $Res Function(CreateBookingRequest) _then) = _$CreateBookingRequestCopyWithImpl;
@useResult
$Res call({
@IdConverter() String categoryId, String description, String addressDetail, double locationLat, double locationLng,@UtcDateTimeConverter() DateTime scheduledTime,@NullableIdConverter() String? applianceId, String? deviceIp
});




}
/// @nodoc
class _$CreateBookingRequestCopyWithImpl<$Res>
    implements $CreateBookingRequestCopyWith<$Res> {
  _$CreateBookingRequestCopyWithImpl(this._self, this._then);

  final CreateBookingRequest _self;
  final $Res Function(CreateBookingRequest) _then;

/// Create a copy of CreateBookingRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? description = null,Object? addressDetail = null,Object? locationLat = null,Object? locationLng = null,Object? scheduledTime = null,Object? applianceId = freezed,Object? deviceIp = freezed,}) {
  return _then(CreateBookingRequest(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,addressDetail: null == addressDetail ? _self.addressDetail : addressDetail // ignore: cast_nullable_to_non_nullable
as String,locationLat: null == locationLat ? _self.locationLat : locationLat // ignore: cast_nullable_to_non_nullable
as double,locationLng: null == locationLng ? _self.locationLng : locationLng // ignore: cast_nullable_to_non_nullable
as double,scheduledTime: null == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime,applianceId: freezed == applianceId ? _self.applianceId : applianceId // ignore: cast_nullable_to_non_nullable
as String?,deviceIp: freezed == deviceIp ? _self.deviceIp : deviceIp // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateBookingRequest].
extension CreateBookingRequestPatterns on CreateBookingRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateBookingRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateBookingRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateBookingRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateBookingRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateBookingRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateBookingRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdConverter()  String categoryId,  String description,  String addressDetail,  double locationLat,  double locationLng, @UtcDateTimeConverter()  DateTime scheduledTime, @NullableIdConverter()  String? applianceId,  String? deviceIp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateBookingRequest() when $default != null:
return $default(_that.categoryId,_that.description,_that.addressDetail,_that.locationLat,_that.locationLng,_that.scheduledTime,_that.applianceId,_that.deviceIp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdConverter()  String categoryId,  String description,  String addressDetail,  double locationLat,  double locationLng, @UtcDateTimeConverter()  DateTime scheduledTime, @NullableIdConverter()  String? applianceId,  String? deviceIp)  $default,) {final _that = this;
switch (_that) {
case _CreateBookingRequest():
return $default(_that.categoryId,_that.description,_that.addressDetail,_that.locationLat,_that.locationLng,_that.scheduledTime,_that.applianceId,_that.deviceIp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdConverter()  String categoryId,  String description,  String addressDetail,  double locationLat,  double locationLng, @UtcDateTimeConverter()  DateTime scheduledTime, @NullableIdConverter()  String? applianceId,  String? deviceIp)?  $default,) {final _that = this;
switch (_that) {
case _CreateBookingRequest() when $default != null:
return $default(_that.categoryId,_that.description,_that.addressDetail,_that.locationLat,_that.locationLng,_that.scheduledTime,_that.applianceId,_that.deviceIp);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _CreateBookingRequest implements CreateBookingRequest {
  const _CreateBookingRequest({@IdConverter() required this.categoryId, required this.description, required this.addressDetail, required this.locationLat, required this.locationLng, @UtcDateTimeConverter() required this.scheduledTime, @NullableIdConverter() this.applianceId, this.deviceIp});
  factory _CreateBookingRequest.fromJson(Map<String, dynamic> json) => _$CreateBookingRequestFromJson(json);

@override@IdConverter() final  String categoryId;
@override final  String description;
@override final  String addressDetail;
@override final  double locationLat;
@override final  double locationLng;
@override@UtcDateTimeConverter() final  DateTime scheduledTime;
@override@NullableIdConverter() final  String? applianceId;
@override final  String? deviceIp;

/// Create a copy of CreateBookingRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateBookingRequestCopyWith<_CreateBookingRequest> get copyWith => __$CreateBookingRequestCopyWithImpl<_CreateBookingRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateBookingRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateBookingRequest&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.description, description) || other.description == description)&&(identical(other.addressDetail, addressDetail) || other.addressDetail == addressDetail)&&(identical(other.locationLat, locationLat) || other.locationLat == locationLat)&&(identical(other.locationLng, locationLng) || other.locationLng == locationLng)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.applianceId, applianceId) || other.applianceId == applianceId)&&(identical(other.deviceIp, deviceIp) || other.deviceIp == deviceIp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,categoryId,description,addressDetail,locationLat,locationLng,scheduledTime,applianceId,deviceIp);
}

@override
String toString() {
    return 'CreateBookingRequest(categoryId: $categoryId, description: $description, addressDetail: $addressDetail, locationLat: $locationLat, locationLng: $locationLng, scheduledTime: $scheduledTime, applianceId: $applianceId, deviceIp: $deviceIp)';
}


}

/// @nodoc
abstract mixin class _$CreateBookingRequestCopyWith<$Res> implements $CreateBookingRequestCopyWith<$Res> {
  factory _$CreateBookingRequestCopyWith(_CreateBookingRequest value, $Res Function(_CreateBookingRequest) _then) = __$CreateBookingRequestCopyWithImpl;
@override @useResult
$Res call({
@IdConverter() String categoryId, String description, String addressDetail, double locationLat, double locationLng,@UtcDateTimeConverter() DateTime scheduledTime,@NullableIdConverter() String? applianceId, String? deviceIp
});




}
/// @nodoc
class __$CreateBookingRequestCopyWithImpl<$Res>
    implements _$CreateBookingRequestCopyWith<$Res> {
  __$CreateBookingRequestCopyWithImpl(this._self, this._then);

  final _CreateBookingRequest _self;
  final $Res Function(_CreateBookingRequest) _then;

/// Create a copy of CreateBookingRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? description = null,Object? addressDetail = null,Object? locationLat = null,Object? locationLng = null,Object? scheduledTime = null,Object? applianceId = freezed,Object? deviceIp = freezed,}) {
  return _then(_CreateBookingRequest(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,addressDetail: null == addressDetail ? _self.addressDetail : addressDetail // ignore: cast_nullable_to_non_nullable
as String,locationLat: null == locationLat ? _self.locationLat : locationLat // ignore: cast_nullable_to_non_nullable
as double,locationLng: null == locationLng ? _self.locationLng : locationLng // ignore: cast_nullable_to_non_nullable
as double,scheduledTime: null == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime,applianceId: freezed == applianceId ? _self.applianceId : applianceId // ignore: cast_nullable_to_non_nullable
as String?,deviceIp: freezed == deviceIp ? _self.deviceIp : deviceIp // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
