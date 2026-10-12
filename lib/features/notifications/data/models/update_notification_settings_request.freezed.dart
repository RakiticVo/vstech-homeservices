// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_notification_settings_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateNotificationSettingsRequest {

 bool get systemEnabled; bool get bookingEnabled; bool get promoEnabled;
/// Create a copy of UpdateNotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateNotificationSettingsRequestCopyWith<UpdateNotificationSettingsRequest> get copyWith => _$UpdateNotificationSettingsRequestCopyWithImpl<UpdateNotificationSettingsRequest>(this as UpdateNotificationSettingsRequest, _$identity);

  /// Serializes this UpdateNotificationSettingsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UpdateNotificationSettingsRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateNotificationSettingsRequest&&(identical(other.systemEnabled, _this.systemEnabled) || other.systemEnabled == _this.systemEnabled)&&(identical(other.bookingEnabled, _this.bookingEnabled) || other.bookingEnabled == _this.bookingEnabled)&&(identical(other.promoEnabled, _this.promoEnabled) || other.promoEnabled == _this.promoEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UpdateNotificationSettingsRequest;
  return Object.hash(runtimeType,_this.systemEnabled,_this.bookingEnabled,_this.promoEnabled);
}

@override
String toString() {
  final _this = this as UpdateNotificationSettingsRequest;
  return 'UpdateNotificationSettingsRequest(systemEnabled: ${_this.systemEnabled}, bookingEnabled: ${_this.bookingEnabled}, promoEnabled: ${_this.promoEnabled})';
}


}

/// @nodoc
abstract mixin class $UpdateNotificationSettingsRequestCopyWith<$Res>  {
  factory $UpdateNotificationSettingsRequestCopyWith(UpdateNotificationSettingsRequest value, $Res Function(UpdateNotificationSettingsRequest) _then) = _$UpdateNotificationSettingsRequestCopyWithImpl;
@useResult
$Res call({
 bool systemEnabled, bool bookingEnabled, bool promoEnabled
});




}
/// @nodoc
class _$UpdateNotificationSettingsRequestCopyWithImpl<$Res>
    implements $UpdateNotificationSettingsRequestCopyWith<$Res> {
  _$UpdateNotificationSettingsRequestCopyWithImpl(this._self, this._then);

  final UpdateNotificationSettingsRequest _self;
  final $Res Function(UpdateNotificationSettingsRequest) _then;

/// Create a copy of UpdateNotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? systemEnabled = null,Object? bookingEnabled = null,Object? promoEnabled = null,}) {
  return _then(UpdateNotificationSettingsRequest(
systemEnabled: null == systemEnabled ? _self.systemEnabled : systemEnabled // ignore: cast_nullable_to_non_nullable
as bool,bookingEnabled: null == bookingEnabled ? _self.bookingEnabled : bookingEnabled // ignore: cast_nullable_to_non_nullable
as bool,promoEnabled: null == promoEnabled ? _self.promoEnabled : promoEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateNotificationSettingsRequest].
extension UpdateNotificationSettingsRequestPatterns on UpdateNotificationSettingsRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateNotificationSettingsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateNotificationSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateNotificationSettingsRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateNotificationSettingsRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateNotificationSettingsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateNotificationSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool systemEnabled,  bool bookingEnabled,  bool promoEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateNotificationSettingsRequest() when $default != null:
return $default(_that.systemEnabled,_that.bookingEnabled,_that.promoEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool systemEnabled,  bool bookingEnabled,  bool promoEnabled)  $default,) {final _that = this;
switch (_that) {
case _UpdateNotificationSettingsRequest():
return $default(_that.systemEnabled,_that.bookingEnabled,_that.promoEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool systemEnabled,  bool bookingEnabled,  bool promoEnabled)?  $default,) {final _that = this;
switch (_that) {
case _UpdateNotificationSettingsRequest() when $default != null:
return $default(_that.systemEnabled,_that.bookingEnabled,_that.promoEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateNotificationSettingsRequest implements UpdateNotificationSettingsRequest {
  const _UpdateNotificationSettingsRequest({required this.systemEnabled, required this.bookingEnabled, required this.promoEnabled});
  factory _UpdateNotificationSettingsRequest.fromJson(Map<String, dynamic> json) => _$UpdateNotificationSettingsRequestFromJson(json);

@override final  bool systemEnabled;
@override final  bool bookingEnabled;
@override final  bool promoEnabled;

/// Create a copy of UpdateNotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateNotificationSettingsRequestCopyWith<_UpdateNotificationSettingsRequest> get copyWith => __$UpdateNotificationSettingsRequestCopyWithImpl<_UpdateNotificationSettingsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateNotificationSettingsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateNotificationSettingsRequest&&(identical(other.systemEnabled, systemEnabled) || other.systemEnabled == systemEnabled)&&(identical(other.bookingEnabled, bookingEnabled) || other.bookingEnabled == bookingEnabled)&&(identical(other.promoEnabled, promoEnabled) || other.promoEnabled == promoEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,systemEnabled,bookingEnabled,promoEnabled);
}

@override
String toString() {
    return 'UpdateNotificationSettingsRequest(systemEnabled: $systemEnabled, bookingEnabled: $bookingEnabled, promoEnabled: $promoEnabled)';
}


}

/// @nodoc
abstract mixin class _$UpdateNotificationSettingsRequestCopyWith<$Res> implements $UpdateNotificationSettingsRequestCopyWith<$Res> {
  factory _$UpdateNotificationSettingsRequestCopyWith(_UpdateNotificationSettingsRequest value, $Res Function(_UpdateNotificationSettingsRequest) _then) = __$UpdateNotificationSettingsRequestCopyWithImpl;
@override @useResult
$Res call({
 bool systemEnabled, bool bookingEnabled, bool promoEnabled
});




}
/// @nodoc
class __$UpdateNotificationSettingsRequestCopyWithImpl<$Res>
    implements _$UpdateNotificationSettingsRequestCopyWith<$Res> {
  __$UpdateNotificationSettingsRequestCopyWithImpl(this._self, this._then);

  final _UpdateNotificationSettingsRequest _self;
  final $Res Function(_UpdateNotificationSettingsRequest) _then;

/// Create a copy of UpdateNotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? systemEnabled = null,Object? bookingEnabled = null,Object? promoEnabled = null,}) {
  return _then(_UpdateNotificationSettingsRequest(
systemEnabled: null == systemEnabled ? _self.systemEnabled : systemEnabled // ignore: cast_nullable_to_non_nullable
as bool,bookingEnabled: null == bookingEnabled ? _self.bookingEnabled : bookingEnabled // ignore: cast_nullable_to_non_nullable
as bool,promoEnabled: null == promoEnabled ? _self.promoEnabled : promoEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
