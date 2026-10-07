// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserInfoResponse {

 int get id; String? get identityId; String? get email; String? get phoneNumber; String? get fullName; String? get role; String? get avatarUrl;
/// Create a copy of UserInfoResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserInfoResponseCopyWith<UserInfoResponse> get copyWith => _$UserInfoResponseCopyWithImpl<UserInfoResponse>(this as UserInfoResponse, _$identity);

  /// Serializes this UserInfoResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserInfoResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserInfoResponse&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.identityId, _this.identityId) || other.identityId == _this.identityId)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.fullName, _this.fullName) || other.fullName == _this.fullName)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserInfoResponse;
  return Object.hash(runtimeType,_this.id,_this.identityId,_this.email,_this.phoneNumber,_this.fullName,_this.role,_this.avatarUrl);
}

@override
String toString() {
  final _this = this as UserInfoResponse;
  return 'UserInfoResponse(id: ${_this.id}, identityId: ${_this.identityId}, email: ${_this.email}, phoneNumber: ${_this.phoneNumber}, fullName: ${_this.fullName}, role: ${_this.role}, avatarUrl: ${_this.avatarUrl})';
}


}

/// @nodoc
abstract mixin class $UserInfoResponseCopyWith<$Res>  {
  factory $UserInfoResponseCopyWith(UserInfoResponse value, $Res Function(UserInfoResponse) _then) = _$UserInfoResponseCopyWithImpl;
@useResult
$Res call({
 int id, String? identityId, String? email, String? phoneNumber, String? fullName, String? role, String? avatarUrl
});




}
/// @nodoc
class _$UserInfoResponseCopyWithImpl<$Res>
    implements $UserInfoResponseCopyWith<$Res> {
  _$UserInfoResponseCopyWithImpl(this._self, this._then);

  final UserInfoResponse _self;
  final $Res Function(UserInfoResponse) _then;

/// Create a copy of UserInfoResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? identityId = freezed,Object? email = freezed,Object? phoneNumber = freezed,Object? fullName = freezed,Object? role = freezed,Object? avatarUrl = freezed,}) {
  return _then(UserInfoResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,identityId: freezed == identityId ? _self.identityId : identityId // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserInfoResponse].
extension UserInfoResponsePatterns on UserInfoResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserInfoResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserInfoResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserInfoResponse value)  $default,){
final _that = this;
switch (_that) {
case _UserInfoResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserInfoResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UserInfoResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? identityId,  String? email,  String? phoneNumber,  String? fullName,  String? role,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserInfoResponse() when $default != null:
return $default(_that.id,_that.identityId,_that.email,_that.phoneNumber,_that.fullName,_that.role,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? identityId,  String? email,  String? phoneNumber,  String? fullName,  String? role,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _UserInfoResponse():
return $default(_that.id,_that.identityId,_that.email,_that.phoneNumber,_that.fullName,_that.role,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? identityId,  String? email,  String? phoneNumber,  String? fullName,  String? role,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _UserInfoResponse() when $default != null:
return $default(_that.id,_that.identityId,_that.email,_that.phoneNumber,_that.fullName,_that.role,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserInfoResponse implements UserInfoResponse {
  const _UserInfoResponse({required this.id, this.identityId, this.email, this.phoneNumber, this.fullName, this.role, this.avatarUrl});
  factory _UserInfoResponse.fromJson(Map<String, dynamic> json) => _$UserInfoResponseFromJson(json);

@override final  int id;
@override final  String? identityId;
@override final  String? email;
@override final  String? phoneNumber;
@override final  String? fullName;
@override final  String? role;
@override final  String? avatarUrl;

/// Create a copy of UserInfoResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserInfoResponseCopyWith<_UserInfoResponse> get copyWith => __$UserInfoResponseCopyWithImpl<_UserInfoResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserInfoResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserInfoResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.identityId, identityId) || other.identityId == identityId)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.role, role) || other.role == role)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,identityId,email,phoneNumber,fullName,role,avatarUrl);
}

@override
String toString() {
    return 'UserInfoResponse(id: $id, identityId: $identityId, email: $email, phoneNumber: $phoneNumber, fullName: $fullName, role: $role, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$UserInfoResponseCopyWith<$Res> implements $UserInfoResponseCopyWith<$Res> {
  factory _$UserInfoResponseCopyWith(_UserInfoResponse value, $Res Function(_UserInfoResponse) _then) = __$UserInfoResponseCopyWithImpl;
@override @useResult
$Res call({
 int id, String? identityId, String? email, String? phoneNumber, String? fullName, String? role, String? avatarUrl
});




}
/// @nodoc
class __$UserInfoResponseCopyWithImpl<$Res>
    implements _$UserInfoResponseCopyWith<$Res> {
  __$UserInfoResponseCopyWithImpl(this._self, this._then);

  final _UserInfoResponse _self;
  final $Res Function(_UserInfoResponse) _then;

/// Create a copy of UserInfoResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? identityId = freezed,Object? email = freezed,Object? phoneNumber = freezed,Object? fullName = freezed,Object? role = freezed,Object? avatarUrl = freezed,}) {
  return _then(_UserInfoResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,identityId: freezed == identityId ? _self.identityId : identityId // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
