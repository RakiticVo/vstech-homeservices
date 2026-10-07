// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_detail_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileDetailResponse {

 String? get defaultAddress; double? get lat; double? get lng;
/// Create a copy of UserProfileDetailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileDetailResponseCopyWith<UserProfileDetailResponse> get copyWith => _$UserProfileDetailResponseCopyWithImpl<UserProfileDetailResponse>(this as UserProfileDetailResponse, _$identity);

  /// Serializes this UserProfileDetailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserProfileDetailResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileDetailResponse&&(identical(other.defaultAddress, _this.defaultAddress) || other.defaultAddress == _this.defaultAddress)&&(identical(other.lat, _this.lat) || other.lat == _this.lat)&&(identical(other.lng, _this.lng) || other.lng == _this.lng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserProfileDetailResponse;
  return Object.hash(runtimeType,_this.defaultAddress,_this.lat,_this.lng);
}

@override
String toString() {
  final _this = this as UserProfileDetailResponse;
  return 'UserProfileDetailResponse(defaultAddress: ${_this.defaultAddress}, lat: ${_this.lat}, lng: ${_this.lng})';
}


}

/// @nodoc
abstract mixin class $UserProfileDetailResponseCopyWith<$Res>  {
  factory $UserProfileDetailResponseCopyWith(UserProfileDetailResponse value, $Res Function(UserProfileDetailResponse) _then) = _$UserProfileDetailResponseCopyWithImpl;
@useResult
$Res call({
 String? defaultAddress, double? lat, double? lng
});




}
/// @nodoc
class _$UserProfileDetailResponseCopyWithImpl<$Res>
    implements $UserProfileDetailResponseCopyWith<$Res> {
  _$UserProfileDetailResponseCopyWithImpl(this._self, this._then);

  final UserProfileDetailResponse _self;
  final $Res Function(UserProfileDetailResponse) _then;

/// Create a copy of UserProfileDetailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? defaultAddress = freezed,Object? lat = freezed,Object? lng = freezed,}) {
  return _then(UserProfileDetailResponse(
defaultAddress: freezed == defaultAddress ? _self.defaultAddress : defaultAddress // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfileDetailResponse].
extension UserProfileDetailResponsePatterns on UserProfileDetailResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileDetailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileDetailResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileDetailResponse value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileDetailResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileDetailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileDetailResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? defaultAddress,  double? lat,  double? lng)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileDetailResponse() when $default != null:
return $default(_that.defaultAddress,_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? defaultAddress,  double? lat,  double? lng)  $default,) {final _that = this;
switch (_that) {
case _UserProfileDetailResponse():
return $default(_that.defaultAddress,_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? defaultAddress,  double? lat,  double? lng)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileDetailResponse() when $default != null:
return $default(_that.defaultAddress,_that.lat,_that.lng);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileDetailResponse implements UserProfileDetailResponse {
  const _UserProfileDetailResponse({this.defaultAddress, this.lat, this.lng});
  factory _UserProfileDetailResponse.fromJson(Map<String, dynamic> json) => _$UserProfileDetailResponseFromJson(json);

@override final  String? defaultAddress;
@override final  double? lat;
@override final  double? lng;

/// Create a copy of UserProfileDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileDetailResponseCopyWith<_UserProfileDetailResponse> get copyWith => __$UserProfileDetailResponseCopyWithImpl<_UserProfileDetailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileDetailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileDetailResponse&&(identical(other.defaultAddress, defaultAddress) || other.defaultAddress == defaultAddress)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,defaultAddress,lat,lng);
}

@override
String toString() {
    return 'UserProfileDetailResponse(defaultAddress: $defaultAddress, lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class _$UserProfileDetailResponseCopyWith<$Res> implements $UserProfileDetailResponseCopyWith<$Res> {
  factory _$UserProfileDetailResponseCopyWith(_UserProfileDetailResponse value, $Res Function(_UserProfileDetailResponse) _then) = __$UserProfileDetailResponseCopyWithImpl;
@override @useResult
$Res call({
 String? defaultAddress, double? lat, double? lng
});




}
/// @nodoc
class __$UserProfileDetailResponseCopyWithImpl<$Res>
    implements _$UserProfileDetailResponseCopyWith<$Res> {
  __$UserProfileDetailResponseCopyWithImpl(this._self, this._then);

  final _UserProfileDetailResponse _self;
  final $Res Function(_UserProfileDetailResponse) _then;

/// Create a copy of UserProfileDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? defaultAddress = freezed,Object? lat = freezed,Object? lng = freezed,}) {
  return _then(_UserProfileDetailResponse(
defaultAddress: freezed == defaultAddress ? _self.defaultAddress : defaultAddress // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
