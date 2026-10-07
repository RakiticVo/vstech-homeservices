// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserProfile {

 String get id; UserRole get role; String get fullName; String? get email; String? get phoneNumber; String? get avatarUrl; String? get bio; String? get locale; String? get defaultAddress; double? get lat; double? get lng; double? get rating; int? get totalJobs; String? get verificationStatus; String? get kycApprovalStatus; int? get completedJobs; double? get cancellationRate; String? get badgeTier;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UserProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.fullName, _this.fullName) || other.fullName == _this.fullName)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.bio, _this.bio) || other.bio == _this.bio)&&(identical(other.locale, _this.locale) || other.locale == _this.locale)&&(identical(other.defaultAddress, _this.defaultAddress) || other.defaultAddress == _this.defaultAddress)&&(identical(other.lat, _this.lat) || other.lat == _this.lat)&&(identical(other.lng, _this.lng) || other.lng == _this.lng)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.totalJobs, _this.totalJobs) || other.totalJobs == _this.totalJobs)&&(identical(other.verificationStatus, _this.verificationStatus) || other.verificationStatus == _this.verificationStatus)&&(identical(other.kycApprovalStatus, _this.kycApprovalStatus) || other.kycApprovalStatus == _this.kycApprovalStatus)&&(identical(other.completedJobs, _this.completedJobs) || other.completedJobs == _this.completedJobs)&&(identical(other.cancellationRate, _this.cancellationRate) || other.cancellationRate == _this.cancellationRate)&&(identical(other.badgeTier, _this.badgeTier) || other.badgeTier == _this.badgeTier));
}


@override
int get hashCode {
  final _this = this as UserProfile;
  return Object.hash(runtimeType,_this.id,_this.role,_this.fullName,_this.email,_this.phoneNumber,_this.avatarUrl,_this.bio,_this.locale,_this.defaultAddress,_this.lat,_this.lng,_this.rating,_this.totalJobs,_this.verificationStatus,_this.kycApprovalStatus,_this.completedJobs,_this.cancellationRate,_this.badgeTier);
}

@override
String toString() {
  final _this = this as UserProfile;
  return 'UserProfile(id: ${_this.id}, role: ${_this.role}, fullName: ${_this.fullName}, email: ${_this.email}, phoneNumber: ${_this.phoneNumber}, avatarUrl: ${_this.avatarUrl}, bio: ${_this.bio}, locale: ${_this.locale}, defaultAddress: ${_this.defaultAddress}, lat: ${_this.lat}, lng: ${_this.lng}, rating: ${_this.rating}, totalJobs: ${_this.totalJobs}, verificationStatus: ${_this.verificationStatus}, kycApprovalStatus: ${_this.kycApprovalStatus}, completedJobs: ${_this.completedJobs}, cancellationRate: ${_this.cancellationRate}, badgeTier: ${_this.badgeTier})';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String id, UserRole role, String fullName, String? email, String? phoneNumber, String? avatarUrl, String? bio, String? locale, String? defaultAddress, double? lat, double? lng, double? rating, int? totalJobs, String? verificationStatus, String? kycApprovalStatus, int? completedJobs, double? cancellationRate, String? badgeTier
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? role = null,Object? fullName = null,Object? email = freezed,Object? phoneNumber = freezed,Object? avatarUrl = freezed,Object? bio = freezed,Object? locale = freezed,Object? defaultAddress = freezed,Object? lat = freezed,Object? lng = freezed,Object? rating = freezed,Object? totalJobs = freezed,Object? verificationStatus = freezed,Object? kycApprovalStatus = freezed,Object? completedJobs = freezed,Object? cancellationRate = freezed,Object? badgeTier = freezed,}) {
  return _then(UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,defaultAddress: freezed == defaultAddress ? _self.defaultAddress : defaultAddress // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,totalJobs: freezed == totalJobs ? _self.totalJobs : totalJobs // ignore: cast_nullable_to_non_nullable
as int?,verificationStatus: freezed == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as String?,kycApprovalStatus: freezed == kycApprovalStatus ? _self.kycApprovalStatus : kycApprovalStatus // ignore: cast_nullable_to_non_nullable
as String?,completedJobs: freezed == completedJobs ? _self.completedJobs : completedJobs // ignore: cast_nullable_to_non_nullable
as int?,cancellationRate: freezed == cancellationRate ? _self.cancellationRate : cancellationRate // ignore: cast_nullable_to_non_nullable
as double?,badgeTier: freezed == badgeTier ? _self.badgeTier : badgeTier // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  UserRole role,  String fullName,  String? email,  String? phoneNumber,  String? avatarUrl,  String? bio,  String? locale,  String? defaultAddress,  double? lat,  double? lng,  double? rating,  int? totalJobs,  String? verificationStatus,  String? kycApprovalStatus,  int? completedJobs,  double? cancellationRate,  String? badgeTier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.role,_that.fullName,_that.email,_that.phoneNumber,_that.avatarUrl,_that.bio,_that.locale,_that.defaultAddress,_that.lat,_that.lng,_that.rating,_that.totalJobs,_that.verificationStatus,_that.kycApprovalStatus,_that.completedJobs,_that.cancellationRate,_that.badgeTier);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  UserRole role,  String fullName,  String? email,  String? phoneNumber,  String? avatarUrl,  String? bio,  String? locale,  String? defaultAddress,  double? lat,  double? lng,  double? rating,  int? totalJobs,  String? verificationStatus,  String? kycApprovalStatus,  int? completedJobs,  double? cancellationRate,  String? badgeTier)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.id,_that.role,_that.fullName,_that.email,_that.phoneNumber,_that.avatarUrl,_that.bio,_that.locale,_that.defaultAddress,_that.lat,_that.lng,_that.rating,_that.totalJobs,_that.verificationStatus,_that.kycApprovalStatus,_that.completedJobs,_that.cancellationRate,_that.badgeTier);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  UserRole role,  String fullName,  String? email,  String? phoneNumber,  String? avatarUrl,  String? bio,  String? locale,  String? defaultAddress,  double? lat,  double? lng,  double? rating,  int? totalJobs,  String? verificationStatus,  String? kycApprovalStatus,  int? completedJobs,  double? cancellationRate,  String? badgeTier)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.role,_that.fullName,_that.email,_that.phoneNumber,_that.avatarUrl,_that.bio,_that.locale,_that.defaultAddress,_that.lat,_that.lng,_that.rating,_that.totalJobs,_that.verificationStatus,_that.kycApprovalStatus,_that.completedJobs,_that.cancellationRate,_that.badgeTier);case _:
  return null;

}
}

}

/// @nodoc


class _UserProfile extends UserProfile {
  const _UserProfile({required this.id, required this.role, this.fullName = '', this.email, this.phoneNumber, this.avatarUrl, this.bio, this.locale, this.defaultAddress, this.lat, this.lng, this.rating, this.totalJobs, this.verificationStatus, this.kycApprovalStatus, this.completedJobs, this.cancellationRate, this.badgeTier}): super._();
  

@override final  String id;
@override final  UserRole role;
@override@JsonKey() final  String fullName;
@override final  String? email;
@override final  String? phoneNumber;
@override final  String? avatarUrl;
@override final  String? bio;
@override final  String? locale;
@override final  String? defaultAddress;
@override final  double? lat;
@override final  double? lng;
@override final  double? rating;
@override final  int? totalJobs;
@override final  String? verificationStatus;
@override final  String? kycApprovalStatus;
@override final  int? completedJobs;
@override final  double? cancellationRate;
@override final  String? badgeTier;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.role, role) || other.role == role)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.defaultAddress, defaultAddress) || other.defaultAddress == defaultAddress)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.totalJobs, totalJobs) || other.totalJobs == totalJobs)&&(identical(other.verificationStatus, verificationStatus) || other.verificationStatus == verificationStatus)&&(identical(other.kycApprovalStatus, kycApprovalStatus) || other.kycApprovalStatus == kycApprovalStatus)&&(identical(other.completedJobs, completedJobs) || other.completedJobs == completedJobs)&&(identical(other.cancellationRate, cancellationRate) || other.cancellationRate == cancellationRate)&&(identical(other.badgeTier, badgeTier) || other.badgeTier == badgeTier));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,role,fullName,email,phoneNumber,avatarUrl,bio,locale,defaultAddress,lat,lng,rating,totalJobs,verificationStatus,kycApprovalStatus,completedJobs,cancellationRate,badgeTier);
}

@override
String toString() {
    return 'UserProfile(id: $id, role: $role, fullName: $fullName, email: $email, phoneNumber: $phoneNumber, avatarUrl: $avatarUrl, bio: $bio, locale: $locale, defaultAddress: $defaultAddress, lat: $lat, lng: $lng, rating: $rating, totalJobs: $totalJobs, verificationStatus: $verificationStatus, kycApprovalStatus: $kycApprovalStatus, completedJobs: $completedJobs, cancellationRate: $cancellationRate, badgeTier: $badgeTier)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, UserRole role, String fullName, String? email, String? phoneNumber, String? avatarUrl, String? bio, String? locale, String? defaultAddress, double? lat, double? lng, double? rating, int? totalJobs, String? verificationStatus, String? kycApprovalStatus, int? completedJobs, double? cancellationRate, String? badgeTier
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? role = null,Object? fullName = null,Object? email = freezed,Object? phoneNumber = freezed,Object? avatarUrl = freezed,Object? bio = freezed,Object? locale = freezed,Object? defaultAddress = freezed,Object? lat = freezed,Object? lng = freezed,Object? rating = freezed,Object? totalJobs = freezed,Object? verificationStatus = freezed,Object? kycApprovalStatus = freezed,Object? completedJobs = freezed,Object? cancellationRate = freezed,Object? badgeTier = freezed,}) {
  return _then(_UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,defaultAddress: freezed == defaultAddress ? _self.defaultAddress : defaultAddress // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,totalJobs: freezed == totalJobs ? _self.totalJobs : totalJobs // ignore: cast_nullable_to_non_nullable
as int?,verificationStatus: freezed == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as String?,kycApprovalStatus: freezed == kycApprovalStatus ? _self.kycApprovalStatus : kycApprovalStatus // ignore: cast_nullable_to_non_nullable
as String?,completedJobs: freezed == completedJobs ? _self.completedJobs : completedJobs // ignore: cast_nullable_to_non_nullable
as int?,cancellationRate: freezed == cancellationRate ? _self.cancellationRate : cancellationRate // ignore: cast_nullable_to_non_nullable
as double?,badgeTier: freezed == badgeTier ? _self.badgeTier : badgeTier // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
