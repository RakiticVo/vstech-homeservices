// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_update_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileUpdateRequest {

 String? get fullName; String? get avatarUrl; String? get bio; String? get locale; String? get phoneNumber; String? get email; String? get defaultAddress; double? get lat; double? get lng; String? get idCardFrontUrl; String? get idCardBackUrl;
/// Create a copy of UserProfileUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileUpdateRequestCopyWith<UserProfileUpdateRequest> get copyWith => _$UserProfileUpdateRequestCopyWithImpl<UserProfileUpdateRequest>(this as UserProfileUpdateRequest, _$identity);

  /// Serializes this UserProfileUpdateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserProfileUpdateRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileUpdateRequest&&(identical(other.fullName, _this.fullName) || other.fullName == _this.fullName)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.bio, _this.bio) || other.bio == _this.bio)&&(identical(other.locale, _this.locale) || other.locale == _this.locale)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.defaultAddress, _this.defaultAddress) || other.defaultAddress == _this.defaultAddress)&&(identical(other.lat, _this.lat) || other.lat == _this.lat)&&(identical(other.lng, _this.lng) || other.lng == _this.lng)&&(identical(other.idCardFrontUrl, _this.idCardFrontUrl) || other.idCardFrontUrl == _this.idCardFrontUrl)&&(identical(other.idCardBackUrl, _this.idCardBackUrl) || other.idCardBackUrl == _this.idCardBackUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserProfileUpdateRequest;
  return Object.hash(runtimeType,_this.fullName,_this.avatarUrl,_this.bio,_this.locale,_this.phoneNumber,_this.email,_this.defaultAddress,_this.lat,_this.lng,_this.idCardFrontUrl,_this.idCardBackUrl);
}

@override
String toString() {
  final _this = this as UserProfileUpdateRequest;
  return 'UserProfileUpdateRequest(fullName: ${_this.fullName}, avatarUrl: ${_this.avatarUrl}, bio: ${_this.bio}, locale: ${_this.locale}, phoneNumber: ${_this.phoneNumber}, email: ${_this.email}, defaultAddress: ${_this.defaultAddress}, lat: ${_this.lat}, lng: ${_this.lng}, idCardFrontUrl: ${_this.idCardFrontUrl}, idCardBackUrl: ${_this.idCardBackUrl})';
}


}

/// @nodoc
abstract mixin class $UserProfileUpdateRequestCopyWith<$Res>  {
  factory $UserProfileUpdateRequestCopyWith(UserProfileUpdateRequest value, $Res Function(UserProfileUpdateRequest) _then) = _$UserProfileUpdateRequestCopyWithImpl;
@useResult
$Res call({
 String? fullName, String? avatarUrl, String? bio, String? locale, String? phoneNumber, String? email, String? defaultAddress, double? lat, double? lng, String? idCardFrontUrl, String? idCardBackUrl
});




}
/// @nodoc
class _$UserProfileUpdateRequestCopyWithImpl<$Res>
    implements $UserProfileUpdateRequestCopyWith<$Res> {
  _$UserProfileUpdateRequestCopyWithImpl(this._self, this._then);

  final UserProfileUpdateRequest _self;
  final $Res Function(UserProfileUpdateRequest) _then;

/// Create a copy of UserProfileUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = freezed,Object? avatarUrl = freezed,Object? bio = freezed,Object? locale = freezed,Object? phoneNumber = freezed,Object? email = freezed,Object? defaultAddress = freezed,Object? lat = freezed,Object? lng = freezed,Object? idCardFrontUrl = freezed,Object? idCardBackUrl = freezed,}) {
  return _then(UserProfileUpdateRequest(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,defaultAddress: freezed == defaultAddress ? _self.defaultAddress : defaultAddress // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,idCardFrontUrl: freezed == idCardFrontUrl ? _self.idCardFrontUrl : idCardFrontUrl // ignore: cast_nullable_to_non_nullable
as String?,idCardBackUrl: freezed == idCardBackUrl ? _self.idCardBackUrl : idCardBackUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfileUpdateRequest].
extension UserProfileUpdateRequestPatterns on UserProfileUpdateRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileUpdateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileUpdateRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileUpdateRequest value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileUpdateRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileUpdateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileUpdateRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? fullName,  String? avatarUrl,  String? bio,  String? locale,  String? phoneNumber,  String? email,  String? defaultAddress,  double? lat,  double? lng,  String? idCardFrontUrl,  String? idCardBackUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileUpdateRequest() when $default != null:
return $default(_that.fullName,_that.avatarUrl,_that.bio,_that.locale,_that.phoneNumber,_that.email,_that.defaultAddress,_that.lat,_that.lng,_that.idCardFrontUrl,_that.idCardBackUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? fullName,  String? avatarUrl,  String? bio,  String? locale,  String? phoneNumber,  String? email,  String? defaultAddress,  double? lat,  double? lng,  String? idCardFrontUrl,  String? idCardBackUrl)  $default,) {final _that = this;
switch (_that) {
case _UserProfileUpdateRequest():
return $default(_that.fullName,_that.avatarUrl,_that.bio,_that.locale,_that.phoneNumber,_that.email,_that.defaultAddress,_that.lat,_that.lng,_that.idCardFrontUrl,_that.idCardBackUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? fullName,  String? avatarUrl,  String? bio,  String? locale,  String? phoneNumber,  String? email,  String? defaultAddress,  double? lat,  double? lng,  String? idCardFrontUrl,  String? idCardBackUrl)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileUpdateRequest() when $default != null:
return $default(_that.fullName,_that.avatarUrl,_that.bio,_that.locale,_that.phoneNumber,_that.email,_that.defaultAddress,_that.lat,_that.lng,_that.idCardFrontUrl,_that.idCardBackUrl);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _UserProfileUpdateRequest implements UserProfileUpdateRequest {
  const _UserProfileUpdateRequest({this.fullName, this.avatarUrl, this.bio, this.locale, this.phoneNumber, this.email, this.defaultAddress, this.lat, this.lng, this.idCardFrontUrl, this.idCardBackUrl});
  factory _UserProfileUpdateRequest.fromJson(Map<String, dynamic> json) => _$UserProfileUpdateRequestFromJson(json);

@override final  String? fullName;
@override final  String? avatarUrl;
@override final  String? bio;
@override final  String? locale;
@override final  String? phoneNumber;
@override final  String? email;
@override final  String? defaultAddress;
@override final  double? lat;
@override final  double? lng;
@override final  String? idCardFrontUrl;
@override final  String? idCardBackUrl;

/// Create a copy of UserProfileUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileUpdateRequestCopyWith<_UserProfileUpdateRequest> get copyWith => __$UserProfileUpdateRequestCopyWithImpl<_UserProfileUpdateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileUpdateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileUpdateRequest&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.defaultAddress, defaultAddress) || other.defaultAddress == defaultAddress)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.idCardFrontUrl, idCardFrontUrl) || other.idCardFrontUrl == idCardFrontUrl)&&(identical(other.idCardBackUrl, idCardBackUrl) || other.idCardBackUrl == idCardBackUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,fullName,avatarUrl,bio,locale,phoneNumber,email,defaultAddress,lat,lng,idCardFrontUrl,idCardBackUrl);
}

@override
String toString() {
    return 'UserProfileUpdateRequest(fullName: $fullName, avatarUrl: $avatarUrl, bio: $bio, locale: $locale, phoneNumber: $phoneNumber, email: $email, defaultAddress: $defaultAddress, lat: $lat, lng: $lng, idCardFrontUrl: $idCardFrontUrl, idCardBackUrl: $idCardBackUrl)';
}


}

/// @nodoc
abstract mixin class _$UserProfileUpdateRequestCopyWith<$Res> implements $UserProfileUpdateRequestCopyWith<$Res> {
  factory _$UserProfileUpdateRequestCopyWith(_UserProfileUpdateRequest value, $Res Function(_UserProfileUpdateRequest) _then) = __$UserProfileUpdateRequestCopyWithImpl;
@override @useResult
$Res call({
 String? fullName, String? avatarUrl, String? bio, String? locale, String? phoneNumber, String? email, String? defaultAddress, double? lat, double? lng, String? idCardFrontUrl, String? idCardBackUrl
});




}
/// @nodoc
class __$UserProfileUpdateRequestCopyWithImpl<$Res>
    implements _$UserProfileUpdateRequestCopyWith<$Res> {
  __$UserProfileUpdateRequestCopyWithImpl(this._self, this._then);

  final _UserProfileUpdateRequest _self;
  final $Res Function(_UserProfileUpdateRequest) _then;

/// Create a copy of UserProfileUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = freezed,Object? avatarUrl = freezed,Object? bio = freezed,Object? locale = freezed,Object? phoneNumber = freezed,Object? email = freezed,Object? defaultAddress = freezed,Object? lat = freezed,Object? lng = freezed,Object? idCardFrontUrl = freezed,Object? idCardBackUrl = freezed,}) {
  return _then(_UserProfileUpdateRequest(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,defaultAddress: freezed == defaultAddress ? _self.defaultAddress : defaultAddress // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,idCardFrontUrl: freezed == idCardFrontUrl ? _self.idCardFrontUrl : idCardFrontUrl // ignore: cast_nullable_to_non_nullable
as String?,idCardBackUrl: freezed == idCardBackUrl ? _self.idCardBackUrl : idCardBackUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
