// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationSettingsResponse {

 bool? get systemEnabled; bool? get bookingEnabled; bool? get promoEnabled;
/// Create a copy of NotificationSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingsResponseCopyWith<NotificationSettingsResponse> get copyWith => _$NotificationSettingsResponseCopyWithImpl<NotificationSettingsResponse>(this as NotificationSettingsResponse, _$identity);

  /// Serializes this NotificationSettingsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NotificationSettingsResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettingsResponse&&(identical(other.systemEnabled, _this.systemEnabled) || other.systemEnabled == _this.systemEnabled)&&(identical(other.bookingEnabled, _this.bookingEnabled) || other.bookingEnabled == _this.bookingEnabled)&&(identical(other.promoEnabled, _this.promoEnabled) || other.promoEnabled == _this.promoEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NotificationSettingsResponse;
  return Object.hash(runtimeType,_this.systemEnabled,_this.bookingEnabled,_this.promoEnabled);
}

@override
String toString() {
  final _this = this as NotificationSettingsResponse;
  return 'NotificationSettingsResponse(systemEnabled: ${_this.systemEnabled}, bookingEnabled: ${_this.bookingEnabled}, promoEnabled: ${_this.promoEnabled})';
}


}

/// @nodoc
abstract mixin class $NotificationSettingsResponseCopyWith<$Res>  {
  factory $NotificationSettingsResponseCopyWith(NotificationSettingsResponse value, $Res Function(NotificationSettingsResponse) _then) = _$NotificationSettingsResponseCopyWithImpl;
@useResult
$Res call({
 bool? systemEnabled, bool? bookingEnabled, bool? promoEnabled
});




}
/// @nodoc
class _$NotificationSettingsResponseCopyWithImpl<$Res>
    implements $NotificationSettingsResponseCopyWith<$Res> {
  _$NotificationSettingsResponseCopyWithImpl(this._self, this._then);

  final NotificationSettingsResponse _self;
  final $Res Function(NotificationSettingsResponse) _then;

/// Create a copy of NotificationSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? systemEnabled = freezed,Object? bookingEnabled = freezed,Object? promoEnabled = freezed,}) {
  return _then(NotificationSettingsResponse(
systemEnabled: freezed == systemEnabled ? _self.systemEnabled : systemEnabled // ignore: cast_nullable_to_non_nullable
as bool?,bookingEnabled: freezed == bookingEnabled ? _self.bookingEnabled : bookingEnabled // ignore: cast_nullable_to_non_nullable
as bool?,promoEnabled: freezed == promoEnabled ? _self.promoEnabled : promoEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationSettingsResponse].
extension NotificationSettingsResponsePatterns on NotificationSettingsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationSettingsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationSettingsResponse value)  $default,){
final _that = this;
switch (_that) {
case _NotificationSettingsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationSettingsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? systemEnabled,  bool? bookingEnabled,  bool? promoEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? systemEnabled,  bool? bookingEnabled,  bool? promoEnabled)  $default,) {final _that = this;
switch (_that) {
case _NotificationSettingsResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? systemEnabled,  bool? bookingEnabled,  bool? promoEnabled)?  $default,) {final _that = this;
switch (_that) {
case _NotificationSettingsResponse() when $default != null:
return $default(_that.systemEnabled,_that.bookingEnabled,_that.promoEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationSettingsResponse implements NotificationSettingsResponse {
  const _NotificationSettingsResponse({this.systemEnabled, this.bookingEnabled, this.promoEnabled});
  factory _NotificationSettingsResponse.fromJson(Map<String, dynamic> json) => _$NotificationSettingsResponseFromJson(json);

@override final  bool? systemEnabled;
@override final  bool? bookingEnabled;
@override final  bool? promoEnabled;

/// Create a copy of NotificationSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingsResponseCopyWith<_NotificationSettingsResponse> get copyWith => __$NotificationSettingsResponseCopyWithImpl<_NotificationSettingsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationSettingsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettingsResponse&&(identical(other.systemEnabled, systemEnabled) || other.systemEnabled == systemEnabled)&&(identical(other.bookingEnabled, bookingEnabled) || other.bookingEnabled == bookingEnabled)&&(identical(other.promoEnabled, promoEnabled) || other.promoEnabled == promoEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,systemEnabled,bookingEnabled,promoEnabled);
}

@override
String toString() {
    return 'NotificationSettingsResponse(systemEnabled: $systemEnabled, bookingEnabled: $bookingEnabled, promoEnabled: $promoEnabled)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingsResponseCopyWith<$Res> implements $NotificationSettingsResponseCopyWith<$Res> {
  factory _$NotificationSettingsResponseCopyWith(_NotificationSettingsResponse value, $Res Function(_NotificationSettingsResponse) _then) = __$NotificationSettingsResponseCopyWithImpl;
@override @useResult
$Res call({
 bool? systemEnabled, bool? bookingEnabled, bool? promoEnabled
});




}
/// @nodoc
class __$NotificationSettingsResponseCopyWithImpl<$Res>
    implements _$NotificationSettingsResponseCopyWith<$Res> {
  __$NotificationSettingsResponseCopyWithImpl(this._self, this._then);

  final _NotificationSettingsResponse _self;
  final $Res Function(_NotificationSettingsResponse) _then;

/// Create a copy of NotificationSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? systemEnabled = freezed,Object? bookingEnabled = freezed,Object? promoEnabled = freezed,}) {
  return _then(_NotificationSettingsResponse(
systemEnabled: freezed == systemEnabled ? _self.systemEnabled : systemEnabled // ignore: cast_nullable_to_non_nullable
as bool?,bookingEnabled: freezed == bookingEnabled ? _self.bookingEnabled : bookingEnabled // ignore: cast_nullable_to_non_nullable
as bool?,promoEnabled: freezed == promoEnabled ? _self.promoEnabled : promoEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
