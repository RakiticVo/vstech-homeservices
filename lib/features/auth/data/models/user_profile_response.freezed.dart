// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileResponse {

@IdConverter() String get id; String? get identityId; String? get email; String? get phoneNumber; String? get fullName; String? get avatarUrl; String? get bio; String? get role; String? get verificationStatus; double? get rating; int? get totalJobs; String? get locale; bool? get isActive; String? get createdAt; UserProfileDetailResponse? get userProfile; WorkerKycResponse? get workerKyc; WorkerMetricsResponse? get workerMetrics; List<WorkerSkillResponse> get workerSkills;
/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileResponseCopyWith<UserProfileResponse> get copyWith => _$UserProfileResponseCopyWithImpl<UserProfileResponse>(this as UserProfileResponse, _$identity);

  /// Serializes this UserProfileResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserProfileResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileResponse&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.identityId, _this.identityId) || other.identityId == _this.identityId)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.fullName, _this.fullName) || other.fullName == _this.fullName)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.bio, _this.bio) || other.bio == _this.bio)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.verificationStatus, _this.verificationStatus) || other.verificationStatus == _this.verificationStatus)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.totalJobs, _this.totalJobs) || other.totalJobs == _this.totalJobs)&&(identical(other.locale, _this.locale) || other.locale == _this.locale)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.userProfile, _this.userProfile) || other.userProfile == _this.userProfile)&&(identical(other.workerKyc, _this.workerKyc) || other.workerKyc == _this.workerKyc)&&(identical(other.workerMetrics, _this.workerMetrics) || other.workerMetrics == _this.workerMetrics)&&const DeepCollectionEquality().equals(other.workerSkills, _this.workerSkills));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserProfileResponse;
  return Object.hash(runtimeType,_this.id,_this.identityId,_this.email,_this.phoneNumber,_this.fullName,_this.avatarUrl,_this.bio,_this.role,_this.verificationStatus,_this.rating,_this.totalJobs,_this.locale,_this.isActive,_this.createdAt,_this.userProfile,_this.workerKyc,_this.workerMetrics,const DeepCollectionEquality().hash(_this.workerSkills));
}

@override
String toString() {
  final _this = this as UserProfileResponse;
  return 'UserProfileResponse(id: ${_this.id}, identityId: ${_this.identityId}, email: ${_this.email}, phoneNumber: ${_this.phoneNumber}, fullName: ${_this.fullName}, avatarUrl: ${_this.avatarUrl}, bio: ${_this.bio}, role: ${_this.role}, verificationStatus: ${_this.verificationStatus}, rating: ${_this.rating}, totalJobs: ${_this.totalJobs}, locale: ${_this.locale}, isActive: ${_this.isActive}, createdAt: ${_this.createdAt}, userProfile: ${_this.userProfile}, workerKyc: ${_this.workerKyc}, workerMetrics: ${_this.workerMetrics}, workerSkills: ${_this.workerSkills})';
}


}

/// @nodoc
abstract mixin class $UserProfileResponseCopyWith<$Res>  {
  factory $UserProfileResponseCopyWith(UserProfileResponse value, $Res Function(UserProfileResponse) _then) = _$UserProfileResponseCopyWithImpl;
@useResult
$Res call({
@IdConverter() String id, String? identityId, String? email, String? phoneNumber, String? fullName, String? avatarUrl, String? bio, String? role, String? verificationStatus, double? rating, int? totalJobs, String? locale, bool? isActive, String? createdAt, UserProfileDetailResponse? userProfile, WorkerKycResponse? workerKyc, WorkerMetricsResponse? workerMetrics, List<WorkerSkillResponse> workerSkills
});


$UserProfileDetailResponseCopyWith<$Res>? get userProfile;$WorkerKycResponseCopyWith<$Res>? get workerKyc;$WorkerMetricsResponseCopyWith<$Res>? get workerMetrics;

}
/// @nodoc
class _$UserProfileResponseCopyWithImpl<$Res>
    implements $UserProfileResponseCopyWith<$Res> {
  _$UserProfileResponseCopyWithImpl(this._self, this._then);

  final UserProfileResponse _self;
  final $Res Function(UserProfileResponse) _then;

/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? identityId = freezed,Object? email = freezed,Object? phoneNumber = freezed,Object? fullName = freezed,Object? avatarUrl = freezed,Object? bio = freezed,Object? role = freezed,Object? verificationStatus = freezed,Object? rating = freezed,Object? totalJobs = freezed,Object? locale = freezed,Object? isActive = freezed,Object? createdAt = freezed,Object? userProfile = freezed,Object? workerKyc = freezed,Object? workerMetrics = freezed,Object? workerSkills = null,}) {
  return _then(UserProfileResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,identityId: freezed == identityId ? _self.identityId : identityId // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,verificationStatus: freezed == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,totalJobs: freezed == totalJobs ? _self.totalJobs : totalJobs // ignore: cast_nullable_to_non_nullable
as int?,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,userProfile: freezed == userProfile ? _self.userProfile : userProfile // ignore: cast_nullable_to_non_nullable
as UserProfileDetailResponse?,workerKyc: freezed == workerKyc ? _self.workerKyc : workerKyc // ignore: cast_nullable_to_non_nullable
as WorkerKycResponse?,workerMetrics: freezed == workerMetrics ? _self.workerMetrics : workerMetrics // ignore: cast_nullable_to_non_nullable
as WorkerMetricsResponse?,workerSkills: null == workerSkills ? _self.workerSkills : workerSkills // ignore: cast_nullable_to_non_nullable
as List<WorkerSkillResponse>,
  ));
}
/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileDetailResponseCopyWith<$Res>? get userProfile {
    if (_self.userProfile == null) {
    return null;
  }

  return $UserProfileDetailResponseCopyWith<$Res>(_self.userProfile!, (value) {
    return _then(_self.copyWith(userProfile: value));
  });
}/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkerKycResponseCopyWith<$Res>? get workerKyc {
    if (_self.workerKyc == null) {
    return null;
  }

  return $WorkerKycResponseCopyWith<$Res>(_self.workerKyc!, (value) {
    return _then(_self.copyWith(workerKyc: value));
  });
}/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkerMetricsResponseCopyWith<$Res>? get workerMetrics {
    if (_self.workerMetrics == null) {
    return null;
  }

  return $WorkerMetricsResponseCopyWith<$Res>(_self.workerMetrics!, (value) {
    return _then(_self.copyWith(workerMetrics: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserProfileResponse].
extension UserProfileResponsePatterns on UserProfileResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileResponse value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdConverter()  String id,  String? identityId,  String? email,  String? phoneNumber,  String? fullName,  String? avatarUrl,  String? bio,  String? role,  String? verificationStatus,  double? rating,  int? totalJobs,  String? locale,  bool? isActive,  String? createdAt,  UserProfileDetailResponse? userProfile,  WorkerKycResponse? workerKyc,  WorkerMetricsResponse? workerMetrics,  List<WorkerSkillResponse> workerSkills)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileResponse() when $default != null:
return $default(_that.id,_that.identityId,_that.email,_that.phoneNumber,_that.fullName,_that.avatarUrl,_that.bio,_that.role,_that.verificationStatus,_that.rating,_that.totalJobs,_that.locale,_that.isActive,_that.createdAt,_that.userProfile,_that.workerKyc,_that.workerMetrics,_that.workerSkills);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdConverter()  String id,  String? identityId,  String? email,  String? phoneNumber,  String? fullName,  String? avatarUrl,  String? bio,  String? role,  String? verificationStatus,  double? rating,  int? totalJobs,  String? locale,  bool? isActive,  String? createdAt,  UserProfileDetailResponse? userProfile,  WorkerKycResponse? workerKyc,  WorkerMetricsResponse? workerMetrics,  List<WorkerSkillResponse> workerSkills)  $default,) {final _that = this;
switch (_that) {
case _UserProfileResponse():
return $default(_that.id,_that.identityId,_that.email,_that.phoneNumber,_that.fullName,_that.avatarUrl,_that.bio,_that.role,_that.verificationStatus,_that.rating,_that.totalJobs,_that.locale,_that.isActive,_that.createdAt,_that.userProfile,_that.workerKyc,_that.workerMetrics,_that.workerSkills);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdConverter()  String id,  String? identityId,  String? email,  String? phoneNumber,  String? fullName,  String? avatarUrl,  String? bio,  String? role,  String? verificationStatus,  double? rating,  int? totalJobs,  String? locale,  bool? isActive,  String? createdAt,  UserProfileDetailResponse? userProfile,  WorkerKycResponse? workerKyc,  WorkerMetricsResponse? workerMetrics,  List<WorkerSkillResponse> workerSkills)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileResponse() when $default != null:
return $default(_that.id,_that.identityId,_that.email,_that.phoneNumber,_that.fullName,_that.avatarUrl,_that.bio,_that.role,_that.verificationStatus,_that.rating,_that.totalJobs,_that.locale,_that.isActive,_that.createdAt,_that.userProfile,_that.workerKyc,_that.workerMetrics,_that.workerSkills);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileResponse implements UserProfileResponse {
  const _UserProfileResponse({@IdConverter() required this.id, this.identityId, this.email, this.phoneNumber, this.fullName, this.avatarUrl, this.bio, this.role, this.verificationStatus, this.rating, this.totalJobs, this.locale, this.isActive, this.createdAt, this.userProfile, this.workerKyc, this.workerMetrics,  List<WorkerSkillResponse> workerSkills = const <WorkerSkillResponse>[]}): _workerSkills = workerSkills;
  factory _UserProfileResponse.fromJson(Map<String, dynamic> json) => _$UserProfileResponseFromJson(json);

@override@IdConverter() final  String id;
@override final  String? identityId;
@override final  String? email;
@override final  String? phoneNumber;
@override final  String? fullName;
@override final  String? avatarUrl;
@override final  String? bio;
@override final  String? role;
@override final  String? verificationStatus;
@override final  double? rating;
@override final  int? totalJobs;
@override final  String? locale;
@override final  bool? isActive;
@override final  String? createdAt;
@override final  UserProfileDetailResponse? userProfile;
@override final  WorkerKycResponse? workerKyc;
@override final  WorkerMetricsResponse? workerMetrics;
 final  List<WorkerSkillResponse> _workerSkills;
@override@JsonKey() List<WorkerSkillResponse> get workerSkills {
  if (_workerSkills is EqualUnmodifiableListView) return _workerSkills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workerSkills);
}


/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileResponseCopyWith<_UserProfileResponse> get copyWith => __$UserProfileResponseCopyWithImpl<_UserProfileResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.identityId, identityId) || other.identityId == identityId)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.role, role) || other.role == role)&&(identical(other.verificationStatus, verificationStatus) || other.verificationStatus == verificationStatus)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.totalJobs, totalJobs) || other.totalJobs == totalJobs)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.userProfile, userProfile) || other.userProfile == userProfile)&&(identical(other.workerKyc, workerKyc) || other.workerKyc == workerKyc)&&(identical(other.workerMetrics, workerMetrics) || other.workerMetrics == workerMetrics)&&const DeepCollectionEquality().equals(other.workerSkills, _workerSkills));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,identityId,email,phoneNumber,fullName,avatarUrl,bio,role,verificationStatus,rating,totalJobs,locale,isActive,createdAt,userProfile,workerKyc,workerMetrics,const DeepCollectionEquality().hash(_workerSkills));
}

@override
String toString() {
    return 'UserProfileResponse(id: $id, identityId: $identityId, email: $email, phoneNumber: $phoneNumber, fullName: $fullName, avatarUrl: $avatarUrl, bio: $bio, role: $role, verificationStatus: $verificationStatus, rating: $rating, totalJobs: $totalJobs, locale: $locale, isActive: $isActive, createdAt: $createdAt, userProfile: $userProfile, workerKyc: $workerKyc, workerMetrics: $workerMetrics, workerSkills: $workerSkills)';
}


}

/// @nodoc
abstract mixin class _$UserProfileResponseCopyWith<$Res> implements $UserProfileResponseCopyWith<$Res> {
  factory _$UserProfileResponseCopyWith(_UserProfileResponse value, $Res Function(_UserProfileResponse) _then) = __$UserProfileResponseCopyWithImpl;
@override @useResult
$Res call({
@IdConverter() String id, String? identityId, String? email, String? phoneNumber, String? fullName, String? avatarUrl, String? bio, String? role, String? verificationStatus, double? rating, int? totalJobs, String? locale, bool? isActive, String? createdAt, UserProfileDetailResponse? userProfile, WorkerKycResponse? workerKyc, WorkerMetricsResponse? workerMetrics, List<WorkerSkillResponse> workerSkills
});


@override $UserProfileDetailResponseCopyWith<$Res>? get userProfile;@override $WorkerKycResponseCopyWith<$Res>? get workerKyc;@override $WorkerMetricsResponseCopyWith<$Res>? get workerMetrics;

}
/// @nodoc
class __$UserProfileResponseCopyWithImpl<$Res>
    implements _$UserProfileResponseCopyWith<$Res> {
  __$UserProfileResponseCopyWithImpl(this._self, this._then);

  final _UserProfileResponse _self;
  final $Res Function(_UserProfileResponse) _then;

/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? identityId = freezed,Object? email = freezed,Object? phoneNumber = freezed,Object? fullName = freezed,Object? avatarUrl = freezed,Object? bio = freezed,Object? role = freezed,Object? verificationStatus = freezed,Object? rating = freezed,Object? totalJobs = freezed,Object? locale = freezed,Object? isActive = freezed,Object? createdAt = freezed,Object? userProfile = freezed,Object? workerKyc = freezed,Object? workerMetrics = freezed,Object? workerSkills = null,}) {
  return _then(_UserProfileResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,identityId: freezed == identityId ? _self.identityId : identityId // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,verificationStatus: freezed == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,totalJobs: freezed == totalJobs ? _self.totalJobs : totalJobs // ignore: cast_nullable_to_non_nullable
as int?,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,userProfile: freezed == userProfile ? _self.userProfile : userProfile // ignore: cast_nullable_to_non_nullable
as UserProfileDetailResponse?,workerKyc: freezed == workerKyc ? _self.workerKyc : workerKyc // ignore: cast_nullable_to_non_nullable
as WorkerKycResponse?,workerMetrics: freezed == workerMetrics ? _self.workerMetrics : workerMetrics // ignore: cast_nullable_to_non_nullable
as WorkerMetricsResponse?,workerSkills: null == workerSkills ? _self._workerSkills : workerSkills // ignore: cast_nullable_to_non_nullable
as List<WorkerSkillResponse>,
  ));
}

/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileDetailResponseCopyWith<$Res>? get userProfile {
    if (_self.userProfile == null) {
    return null;
  }

  return $UserProfileDetailResponseCopyWith<$Res>(_self.userProfile!, (value) {
    return _then(_self.copyWith(userProfile: value));
  });
}/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkerKycResponseCopyWith<$Res>? get workerKyc {
    if (_self.workerKyc == null) {
    return null;
  }

  return $WorkerKycResponseCopyWith<$Res>(_self.workerKyc!, (value) {
    return _then(_self.copyWith(workerKyc: value));
  });
}/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkerMetricsResponseCopyWith<$Res>? get workerMetrics {
    if (_self.workerMetrics == null) {
    return null;
  }

  return $WorkerMetricsResponseCopyWith<$Res>(_self.workerMetrics!, (value) {
    return _then(_self.copyWith(workerMetrics: value));
  });
}
}

// dart format on
