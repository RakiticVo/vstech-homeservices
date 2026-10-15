// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracking_message_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrackingMessageResponse {

 String? get type; String? get status;@NullableIdConverter() String? get technicianId;@NullableIdConverter() String? get bookingId; double? get latitude; double? get longitude; double? get heading;@NullableUtcDateTimeConverter() DateTime? get lastUpdated; String? get reason; String? get message; String? get errorCode;
/// Create a copy of TrackingMessageResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackingMessageResponseCopyWith<TrackingMessageResponse> get copyWith => _$TrackingMessageResponseCopyWithImpl<TrackingMessageResponse>(this as TrackingMessageResponse, _$identity);

  /// Serializes this TrackingMessageResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TrackingMessageResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackingMessageResponse&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.technicianId, _this.technicianId) || other.technicianId == _this.technicianId)&&(identical(other.bookingId, _this.bookingId) || other.bookingId == _this.bookingId)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.heading, _this.heading) || other.heading == _this.heading)&&(identical(other.lastUpdated, _this.lastUpdated) || other.lastUpdated == _this.lastUpdated)&&(identical(other.reason, _this.reason) || other.reason == _this.reason)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TrackingMessageResponse;
  return Object.hash(runtimeType,_this.type,_this.status,_this.technicianId,_this.bookingId,_this.latitude,_this.longitude,_this.heading,_this.lastUpdated,_this.reason,_this.message,_this.errorCode);
}

@override
String toString() {
  final _this = this as TrackingMessageResponse;
  return 'TrackingMessageResponse(type: ${_this.type}, status: ${_this.status}, technicianId: ${_this.technicianId}, bookingId: ${_this.bookingId}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, heading: ${_this.heading}, lastUpdated: ${_this.lastUpdated}, reason: ${_this.reason}, message: ${_this.message}, errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $TrackingMessageResponseCopyWith<$Res>  {
  factory $TrackingMessageResponseCopyWith(TrackingMessageResponse value, $Res Function(TrackingMessageResponse) _then) = _$TrackingMessageResponseCopyWithImpl;
@useResult
$Res call({
 String? type, String? status,@NullableIdConverter() String? technicianId,@NullableIdConverter() String? bookingId, double? latitude, double? longitude, double? heading,@NullableUtcDateTimeConverter() DateTime? lastUpdated, String? reason, String? message, String? errorCode
});




}
/// @nodoc
class _$TrackingMessageResponseCopyWithImpl<$Res>
    implements $TrackingMessageResponseCopyWith<$Res> {
  _$TrackingMessageResponseCopyWithImpl(this._self, this._then);

  final TrackingMessageResponse _self;
  final $Res Function(TrackingMessageResponse) _then;

/// Create a copy of TrackingMessageResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? status = freezed,Object? technicianId = freezed,Object? bookingId = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? heading = freezed,Object? lastUpdated = freezed,Object? reason = freezed,Object? message = freezed,Object? errorCode = freezed,}) {
  return _then(TrackingMessageResponse(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,technicianId: freezed == technicianId ? _self.technicianId : technicianId // ignore: cast_nullable_to_non_nullable
as String?,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,heading: freezed == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as double?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrackingMessageResponse].
extension TrackingMessageResponsePatterns on TrackingMessageResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrackingMessageResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrackingMessageResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrackingMessageResponse value)  $default,){
final _that = this;
switch (_that) {
case _TrackingMessageResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrackingMessageResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TrackingMessageResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? type,  String? status, @NullableIdConverter()  String? technicianId, @NullableIdConverter()  String? bookingId,  double? latitude,  double? longitude,  double? heading, @NullableUtcDateTimeConverter()  DateTime? lastUpdated,  String? reason,  String? message,  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrackingMessageResponse() when $default != null:
return $default(_that.type,_that.status,_that.technicianId,_that.bookingId,_that.latitude,_that.longitude,_that.heading,_that.lastUpdated,_that.reason,_that.message,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? type,  String? status, @NullableIdConverter()  String? technicianId, @NullableIdConverter()  String? bookingId,  double? latitude,  double? longitude,  double? heading, @NullableUtcDateTimeConverter()  DateTime? lastUpdated,  String? reason,  String? message,  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _TrackingMessageResponse():
return $default(_that.type,_that.status,_that.technicianId,_that.bookingId,_that.latitude,_that.longitude,_that.heading,_that.lastUpdated,_that.reason,_that.message,_that.errorCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? type,  String? status, @NullableIdConverter()  String? technicianId, @NullableIdConverter()  String? bookingId,  double? latitude,  double? longitude,  double? heading, @NullableUtcDateTimeConverter()  DateTime? lastUpdated,  String? reason,  String? message,  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _TrackingMessageResponse() when $default != null:
return $default(_that.type,_that.status,_that.technicianId,_that.bookingId,_that.latitude,_that.longitude,_that.heading,_that.lastUpdated,_that.reason,_that.message,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrackingMessageResponse implements TrackingMessageResponse {
  const _TrackingMessageResponse({this.type, this.status, @NullableIdConverter() this.technicianId, @NullableIdConverter() this.bookingId, this.latitude, this.longitude, this.heading, @NullableUtcDateTimeConverter() this.lastUpdated, this.reason, this.message, this.errorCode});
  factory _TrackingMessageResponse.fromJson(Map<String, dynamic> json) => _$TrackingMessageResponseFromJson(json);

@override final  String? type;
@override final  String? status;
@override@NullableIdConverter() final  String? technicianId;
@override@NullableIdConverter() final  String? bookingId;
@override final  double? latitude;
@override final  double? longitude;
@override final  double? heading;
@override@NullableUtcDateTimeConverter() final  DateTime? lastUpdated;
@override final  String? reason;
@override final  String? message;
@override final  String? errorCode;

/// Create a copy of TrackingMessageResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrackingMessageResponseCopyWith<_TrackingMessageResponse> get copyWith => __$TrackingMessageResponseCopyWithImpl<_TrackingMessageResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrackingMessageResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrackingMessageResponse&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.technicianId, technicianId) || other.technicianId == technicianId)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.heading, heading) || other.heading == heading)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,type,status,technicianId,bookingId,latitude,longitude,heading,lastUpdated,reason,message,errorCode);
}

@override
String toString() {
    return 'TrackingMessageResponse(type: $type, status: $status, technicianId: $technicianId, bookingId: $bookingId, latitude: $latitude, longitude: $longitude, heading: $heading, lastUpdated: $lastUpdated, reason: $reason, message: $message, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$TrackingMessageResponseCopyWith<$Res> implements $TrackingMessageResponseCopyWith<$Res> {
  factory _$TrackingMessageResponseCopyWith(_TrackingMessageResponse value, $Res Function(_TrackingMessageResponse) _then) = __$TrackingMessageResponseCopyWithImpl;
@override @useResult
$Res call({
 String? type, String? status,@NullableIdConverter() String? technicianId,@NullableIdConverter() String? bookingId, double? latitude, double? longitude, double? heading,@NullableUtcDateTimeConverter() DateTime? lastUpdated, String? reason, String? message, String? errorCode
});




}
/// @nodoc
class __$TrackingMessageResponseCopyWithImpl<$Res>
    implements _$TrackingMessageResponseCopyWith<$Res> {
  __$TrackingMessageResponseCopyWithImpl(this._self, this._then);

  final _TrackingMessageResponse _self;
  final $Res Function(_TrackingMessageResponse) _then;

/// Create a copy of TrackingMessageResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? status = freezed,Object? technicianId = freezed,Object? bookingId = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? heading = freezed,Object? lastUpdated = freezed,Object? reason = freezed,Object? message = freezed,Object? errorCode = freezed,}) {
  return _then(_TrackingMessageResponse(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,technicianId: freezed == technicianId ? _self.technicianId : technicianId // ignore: cast_nullable_to_non_nullable
as String?,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,heading: freezed == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as double?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
