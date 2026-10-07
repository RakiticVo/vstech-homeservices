// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'worker_skill_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkerSkillResponse {

 int? get categoryId; int? get experienceYears; String? get certificateUrl; bool? get isVerified;
/// Create a copy of WorkerSkillResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkerSkillResponseCopyWith<WorkerSkillResponse> get copyWith => _$WorkerSkillResponseCopyWithImpl<WorkerSkillResponse>(this as WorkerSkillResponse, _$identity);

  /// Serializes this WorkerSkillResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WorkerSkillResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkerSkillResponse&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.experienceYears, _this.experienceYears) || other.experienceYears == _this.experienceYears)&&(identical(other.certificateUrl, _this.certificateUrl) || other.certificateUrl == _this.certificateUrl)&&(identical(other.isVerified, _this.isVerified) || other.isVerified == _this.isVerified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WorkerSkillResponse;
  return Object.hash(runtimeType,_this.categoryId,_this.experienceYears,_this.certificateUrl,_this.isVerified);
}

@override
String toString() {
  final _this = this as WorkerSkillResponse;
  return 'WorkerSkillResponse(categoryId: ${_this.categoryId}, experienceYears: ${_this.experienceYears}, certificateUrl: ${_this.certificateUrl}, isVerified: ${_this.isVerified})';
}


}

/// @nodoc
abstract mixin class $WorkerSkillResponseCopyWith<$Res>  {
  factory $WorkerSkillResponseCopyWith(WorkerSkillResponse value, $Res Function(WorkerSkillResponse) _then) = _$WorkerSkillResponseCopyWithImpl;
@useResult
$Res call({
 int? categoryId, int? experienceYears, String? certificateUrl, bool? isVerified
});




}
/// @nodoc
class _$WorkerSkillResponseCopyWithImpl<$Res>
    implements $WorkerSkillResponseCopyWith<$Res> {
  _$WorkerSkillResponseCopyWithImpl(this._self, this._then);

  final WorkerSkillResponse _self;
  final $Res Function(WorkerSkillResponse) _then;

/// Create a copy of WorkerSkillResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = freezed,Object? experienceYears = freezed,Object? certificateUrl = freezed,Object? isVerified = freezed,}) {
  return _then(WorkerSkillResponse(
categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,experienceYears: freezed == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int?,certificateUrl: freezed == certificateUrl ? _self.certificateUrl : certificateUrl // ignore: cast_nullable_to_non_nullable
as String?,isVerified: freezed == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkerSkillResponse].
extension WorkerSkillResponsePatterns on WorkerSkillResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkerSkillResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkerSkillResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkerSkillResponse value)  $default,){
final _that = this;
switch (_that) {
case _WorkerSkillResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkerSkillResponse value)?  $default,){
final _that = this;
switch (_that) {
case _WorkerSkillResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? categoryId,  int? experienceYears,  String? certificateUrl,  bool? isVerified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkerSkillResponse() when $default != null:
return $default(_that.categoryId,_that.experienceYears,_that.certificateUrl,_that.isVerified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? categoryId,  int? experienceYears,  String? certificateUrl,  bool? isVerified)  $default,) {final _that = this;
switch (_that) {
case _WorkerSkillResponse():
return $default(_that.categoryId,_that.experienceYears,_that.certificateUrl,_that.isVerified);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? categoryId,  int? experienceYears,  String? certificateUrl,  bool? isVerified)?  $default,) {final _that = this;
switch (_that) {
case _WorkerSkillResponse() when $default != null:
return $default(_that.categoryId,_that.experienceYears,_that.certificateUrl,_that.isVerified);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkerSkillResponse implements WorkerSkillResponse {
  const _WorkerSkillResponse({this.categoryId, this.experienceYears, this.certificateUrl, this.isVerified});
  factory _WorkerSkillResponse.fromJson(Map<String, dynamic> json) => _$WorkerSkillResponseFromJson(json);

@override final  int? categoryId;
@override final  int? experienceYears;
@override final  String? certificateUrl;
@override final  bool? isVerified;

/// Create a copy of WorkerSkillResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkerSkillResponseCopyWith<_WorkerSkillResponse> get copyWith => __$WorkerSkillResponseCopyWithImpl<_WorkerSkillResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkerSkillResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkerSkillResponse&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.certificateUrl, certificateUrl) || other.certificateUrl == certificateUrl)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,categoryId,experienceYears,certificateUrl,isVerified);
}

@override
String toString() {
    return 'WorkerSkillResponse(categoryId: $categoryId, experienceYears: $experienceYears, certificateUrl: $certificateUrl, isVerified: $isVerified)';
}


}

/// @nodoc
abstract mixin class _$WorkerSkillResponseCopyWith<$Res> implements $WorkerSkillResponseCopyWith<$Res> {
  factory _$WorkerSkillResponseCopyWith(_WorkerSkillResponse value, $Res Function(_WorkerSkillResponse) _then) = __$WorkerSkillResponseCopyWithImpl;
@override @useResult
$Res call({
 int? categoryId, int? experienceYears, String? certificateUrl, bool? isVerified
});




}
/// @nodoc
class __$WorkerSkillResponseCopyWithImpl<$Res>
    implements _$WorkerSkillResponseCopyWith<$Res> {
  __$WorkerSkillResponseCopyWithImpl(this._self, this._then);

  final _WorkerSkillResponse _self;
  final $Res Function(_WorkerSkillResponse) _then;

/// Create a copy of WorkerSkillResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = freezed,Object? experienceYears = freezed,Object? certificateUrl = freezed,Object? isVerified = freezed,}) {
  return _then(_WorkerSkillResponse(
categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,experienceYears: freezed == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int?,certificateUrl: freezed == certificateUrl ? _self.certificateUrl : certificateUrl // ignore: cast_nullable_to_non_nullable
as String?,isVerified: freezed == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
