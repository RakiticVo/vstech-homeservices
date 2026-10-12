// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'end_call_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EndCallRequest {

@IdConverter() String get callId; int get durationSeconds; String? get recordingUrl;
/// Create a copy of EndCallRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EndCallRequestCopyWith<EndCallRequest> get copyWith => _$EndCallRequestCopyWithImpl<EndCallRequest>(this as EndCallRequest, _$identity);

  /// Serializes this EndCallRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EndCallRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EndCallRequest&&(identical(other.callId, _this.callId) || other.callId == _this.callId)&&(identical(other.durationSeconds, _this.durationSeconds) || other.durationSeconds == _this.durationSeconds)&&(identical(other.recordingUrl, _this.recordingUrl) || other.recordingUrl == _this.recordingUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EndCallRequest;
  return Object.hash(runtimeType,_this.callId,_this.durationSeconds,_this.recordingUrl);
}

@override
String toString() {
  final _this = this as EndCallRequest;
  return 'EndCallRequest(callId: ${_this.callId}, durationSeconds: ${_this.durationSeconds}, recordingUrl: ${_this.recordingUrl})';
}


}

/// @nodoc
abstract mixin class $EndCallRequestCopyWith<$Res>  {
  factory $EndCallRequestCopyWith(EndCallRequest value, $Res Function(EndCallRequest) _then) = _$EndCallRequestCopyWithImpl;
@useResult
$Res call({
@IdConverter() String callId, int durationSeconds, String? recordingUrl
});




}
/// @nodoc
class _$EndCallRequestCopyWithImpl<$Res>
    implements $EndCallRequestCopyWith<$Res> {
  _$EndCallRequestCopyWithImpl(this._self, this._then);

  final EndCallRequest _self;
  final $Res Function(EndCallRequest) _then;

/// Create a copy of EndCallRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? durationSeconds = null,Object? recordingUrl = freezed,}) {
  return _then(EndCallRequest(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,recordingUrl: freezed == recordingUrl ? _self.recordingUrl : recordingUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EndCallRequest].
extension EndCallRequestPatterns on EndCallRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EndCallRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EndCallRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EndCallRequest value)  $default,){
final _that = this;
switch (_that) {
case _EndCallRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EndCallRequest value)?  $default,){
final _that = this;
switch (_that) {
case _EndCallRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdConverter()  String callId,  int durationSeconds,  String? recordingUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EndCallRequest() when $default != null:
return $default(_that.callId,_that.durationSeconds,_that.recordingUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdConverter()  String callId,  int durationSeconds,  String? recordingUrl)  $default,) {final _that = this;
switch (_that) {
case _EndCallRequest():
return $default(_that.callId,_that.durationSeconds,_that.recordingUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdConverter()  String callId,  int durationSeconds,  String? recordingUrl)?  $default,) {final _that = this;
switch (_that) {
case _EndCallRequest() when $default != null:
return $default(_that.callId,_that.durationSeconds,_that.recordingUrl);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _EndCallRequest implements EndCallRequest {
  const _EndCallRequest({@IdConverter() required this.callId, required this.durationSeconds, this.recordingUrl});
  factory _EndCallRequest.fromJson(Map<String, dynamic> json) => _$EndCallRequestFromJson(json);

@override@IdConverter() final  String callId;
@override final  int durationSeconds;
@override final  String? recordingUrl;

/// Create a copy of EndCallRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EndCallRequestCopyWith<_EndCallRequest> get copyWith => __$EndCallRequestCopyWithImpl<_EndCallRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EndCallRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EndCallRequest&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.recordingUrl, recordingUrl) || other.recordingUrl == recordingUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,callId,durationSeconds,recordingUrl);
}

@override
String toString() {
    return 'EndCallRequest(callId: $callId, durationSeconds: $durationSeconds, recordingUrl: $recordingUrl)';
}


}

/// @nodoc
abstract mixin class _$EndCallRequestCopyWith<$Res> implements $EndCallRequestCopyWith<$Res> {
  factory _$EndCallRequestCopyWith(_EndCallRequest value, $Res Function(_EndCallRequest) _then) = __$EndCallRequestCopyWithImpl;
@override @useResult
$Res call({
@IdConverter() String callId, int durationSeconds, String? recordingUrl
});




}
/// @nodoc
class __$EndCallRequestCopyWithImpl<$Res>
    implements _$EndCallRequestCopyWith<$Res> {
  __$EndCallRequestCopyWithImpl(this._self, this._then);

  final _EndCallRequest _self;
  final $Res Function(_EndCallRequest) _then;

/// Create a copy of EndCallRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? durationSeconds = null,Object? recordingUrl = freezed,}) {
  return _then(_EndCallRequest(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,recordingUrl: freezed == recordingUrl ? _self.recordingUrl : recordingUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
