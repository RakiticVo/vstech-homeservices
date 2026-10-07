// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'worker_kyc_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkerKycResponse {

 String? get approvalStatus; String? get idCardNumber; String? get idCardFrontUrl; String? get idCardBackUrl;
/// Create a copy of WorkerKycResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkerKycResponseCopyWith<WorkerKycResponse> get copyWith => _$WorkerKycResponseCopyWithImpl<WorkerKycResponse>(this as WorkerKycResponse, _$identity);

  /// Serializes this WorkerKycResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WorkerKycResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkerKycResponse&&(identical(other.approvalStatus, _this.approvalStatus) || other.approvalStatus == _this.approvalStatus)&&(identical(other.idCardNumber, _this.idCardNumber) || other.idCardNumber == _this.idCardNumber)&&(identical(other.idCardFrontUrl, _this.idCardFrontUrl) || other.idCardFrontUrl == _this.idCardFrontUrl)&&(identical(other.idCardBackUrl, _this.idCardBackUrl) || other.idCardBackUrl == _this.idCardBackUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WorkerKycResponse;
  return Object.hash(runtimeType,_this.approvalStatus,_this.idCardNumber,_this.idCardFrontUrl,_this.idCardBackUrl);
}

@override
String toString() {
  final _this = this as WorkerKycResponse;
  return 'WorkerKycResponse(approvalStatus: ${_this.approvalStatus}, idCardNumber: ${_this.idCardNumber}, idCardFrontUrl: ${_this.idCardFrontUrl}, idCardBackUrl: ${_this.idCardBackUrl})';
}


}

/// @nodoc
abstract mixin class $WorkerKycResponseCopyWith<$Res>  {
  factory $WorkerKycResponseCopyWith(WorkerKycResponse value, $Res Function(WorkerKycResponse) _then) = _$WorkerKycResponseCopyWithImpl;
@useResult
$Res call({
 String? approvalStatus, String? idCardNumber, String? idCardFrontUrl, String? idCardBackUrl
});




}
/// @nodoc
class _$WorkerKycResponseCopyWithImpl<$Res>
    implements $WorkerKycResponseCopyWith<$Res> {
  _$WorkerKycResponseCopyWithImpl(this._self, this._then);

  final WorkerKycResponse _self;
  final $Res Function(WorkerKycResponse) _then;

/// Create a copy of WorkerKycResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? approvalStatus = freezed,Object? idCardNumber = freezed,Object? idCardFrontUrl = freezed,Object? idCardBackUrl = freezed,}) {
  return _then(WorkerKycResponse(
approvalStatus: freezed == approvalStatus ? _self.approvalStatus : approvalStatus // ignore: cast_nullable_to_non_nullable
as String?,idCardNumber: freezed == idCardNumber ? _self.idCardNumber : idCardNumber // ignore: cast_nullable_to_non_nullable
as String?,idCardFrontUrl: freezed == idCardFrontUrl ? _self.idCardFrontUrl : idCardFrontUrl // ignore: cast_nullable_to_non_nullable
as String?,idCardBackUrl: freezed == idCardBackUrl ? _self.idCardBackUrl : idCardBackUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkerKycResponse].
extension WorkerKycResponsePatterns on WorkerKycResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkerKycResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkerKycResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkerKycResponse value)  $default,){
final _that = this;
switch (_that) {
case _WorkerKycResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkerKycResponse value)?  $default,){
final _that = this;
switch (_that) {
case _WorkerKycResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? approvalStatus,  String? idCardNumber,  String? idCardFrontUrl,  String? idCardBackUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkerKycResponse() when $default != null:
return $default(_that.approvalStatus,_that.idCardNumber,_that.idCardFrontUrl,_that.idCardBackUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? approvalStatus,  String? idCardNumber,  String? idCardFrontUrl,  String? idCardBackUrl)  $default,) {final _that = this;
switch (_that) {
case _WorkerKycResponse():
return $default(_that.approvalStatus,_that.idCardNumber,_that.idCardFrontUrl,_that.idCardBackUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? approvalStatus,  String? idCardNumber,  String? idCardFrontUrl,  String? idCardBackUrl)?  $default,) {final _that = this;
switch (_that) {
case _WorkerKycResponse() when $default != null:
return $default(_that.approvalStatus,_that.idCardNumber,_that.idCardFrontUrl,_that.idCardBackUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkerKycResponse implements WorkerKycResponse {
  const _WorkerKycResponse({this.approvalStatus, this.idCardNumber, this.idCardFrontUrl, this.idCardBackUrl});
  factory _WorkerKycResponse.fromJson(Map<String, dynamic> json) => _$WorkerKycResponseFromJson(json);

@override final  String? approvalStatus;
@override final  String? idCardNumber;
@override final  String? idCardFrontUrl;
@override final  String? idCardBackUrl;

/// Create a copy of WorkerKycResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkerKycResponseCopyWith<_WorkerKycResponse> get copyWith => __$WorkerKycResponseCopyWithImpl<_WorkerKycResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkerKycResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkerKycResponse&&(identical(other.approvalStatus, approvalStatus) || other.approvalStatus == approvalStatus)&&(identical(other.idCardNumber, idCardNumber) || other.idCardNumber == idCardNumber)&&(identical(other.idCardFrontUrl, idCardFrontUrl) || other.idCardFrontUrl == idCardFrontUrl)&&(identical(other.idCardBackUrl, idCardBackUrl) || other.idCardBackUrl == idCardBackUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,approvalStatus,idCardNumber,idCardFrontUrl,idCardBackUrl);
}

@override
String toString() {
    return 'WorkerKycResponse(approvalStatus: $approvalStatus, idCardNumber: $idCardNumber, idCardFrontUrl: $idCardFrontUrl, idCardBackUrl: $idCardBackUrl)';
}


}

/// @nodoc
abstract mixin class _$WorkerKycResponseCopyWith<$Res> implements $WorkerKycResponseCopyWith<$Res> {
  factory _$WorkerKycResponseCopyWith(_WorkerKycResponse value, $Res Function(_WorkerKycResponse) _then) = __$WorkerKycResponseCopyWithImpl;
@override @useResult
$Res call({
 String? approvalStatus, String? idCardNumber, String? idCardFrontUrl, String? idCardBackUrl
});




}
/// @nodoc
class __$WorkerKycResponseCopyWithImpl<$Res>
    implements _$WorkerKycResponseCopyWith<$Res> {
  __$WorkerKycResponseCopyWithImpl(this._self, this._then);

  final _WorkerKycResponse _self;
  final $Res Function(_WorkerKycResponse) _then;

/// Create a copy of WorkerKycResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? approvalStatus = freezed,Object? idCardNumber = freezed,Object? idCardFrontUrl = freezed,Object? idCardBackUrl = freezed,}) {
  return _then(_WorkerKycResponse(
approvalStatus: freezed == approvalStatus ? _self.approvalStatus : approvalStatus // ignore: cast_nullable_to_non_nullable
as String?,idCardNumber: freezed == idCardNumber ? _self.idCardNumber : idCardNumber // ignore: cast_nullable_to_non_nullable
as String?,idCardFrontUrl: freezed == idCardFrontUrl ? _self.idCardFrontUrl : idCardFrontUrl // ignore: cast_nullable_to_non_nullable
as String?,idCardBackUrl: freezed == idCardBackUrl ? _self.idCardBackUrl : idCardBackUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
