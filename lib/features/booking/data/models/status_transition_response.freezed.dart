// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'status_transition_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StatusTransitionResponse {

@NullableIdConverter() String? get requestId; String? get previousStatus; String? get newStatus;@NullableUtcDateTimeConverter() DateTime? get timestamp;
/// Create a copy of StatusTransitionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatusTransitionResponseCopyWith<StatusTransitionResponse> get copyWith => _$StatusTransitionResponseCopyWithImpl<StatusTransitionResponse>(this as StatusTransitionResponse, _$identity);

  /// Serializes this StatusTransitionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StatusTransitionResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatusTransitionResponse&&(identical(other.requestId, _this.requestId) || other.requestId == _this.requestId)&&(identical(other.previousStatus, _this.previousStatus) || other.previousStatus == _this.previousStatus)&&(identical(other.newStatus, _this.newStatus) || other.newStatus == _this.newStatus)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StatusTransitionResponse;
  return Object.hash(runtimeType,_this.requestId,_this.previousStatus,_this.newStatus,_this.timestamp);
}

@override
String toString() {
  final _this = this as StatusTransitionResponse;
  return 'StatusTransitionResponse(requestId: ${_this.requestId}, previousStatus: ${_this.previousStatus}, newStatus: ${_this.newStatus}, timestamp: ${_this.timestamp})';
}


}

/// @nodoc
abstract mixin class $StatusTransitionResponseCopyWith<$Res>  {
  factory $StatusTransitionResponseCopyWith(StatusTransitionResponse value, $Res Function(StatusTransitionResponse) _then) = _$StatusTransitionResponseCopyWithImpl;
@useResult
$Res call({
@NullableIdConverter() String? requestId, String? previousStatus, String? newStatus,@NullableUtcDateTimeConverter() DateTime? timestamp
});




}
/// @nodoc
class _$StatusTransitionResponseCopyWithImpl<$Res>
    implements $StatusTransitionResponseCopyWith<$Res> {
  _$StatusTransitionResponseCopyWithImpl(this._self, this._then);

  final StatusTransitionResponse _self;
  final $Res Function(StatusTransitionResponse) _then;

/// Create a copy of StatusTransitionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requestId = freezed,Object? previousStatus = freezed,Object? newStatus = freezed,Object? timestamp = freezed,}) {
  return _then(StatusTransitionResponse(
requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,previousStatus: freezed == previousStatus ? _self.previousStatus : previousStatus // ignore: cast_nullable_to_non_nullable
as String?,newStatus: freezed == newStatus ? _self.newStatus : newStatus // ignore: cast_nullable_to_non_nullable
as String?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [StatusTransitionResponse].
extension StatusTransitionResponsePatterns on StatusTransitionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatusTransitionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatusTransitionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatusTransitionResponse value)  $default,){
final _that = this;
switch (_that) {
case _StatusTransitionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatusTransitionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _StatusTransitionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@NullableIdConverter()  String? requestId,  String? previousStatus,  String? newStatus, @NullableUtcDateTimeConverter()  DateTime? timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatusTransitionResponse() when $default != null:
return $default(_that.requestId,_that.previousStatus,_that.newStatus,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@NullableIdConverter()  String? requestId,  String? previousStatus,  String? newStatus, @NullableUtcDateTimeConverter()  DateTime? timestamp)  $default,) {final _that = this;
switch (_that) {
case _StatusTransitionResponse():
return $default(_that.requestId,_that.previousStatus,_that.newStatus,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@NullableIdConverter()  String? requestId,  String? previousStatus,  String? newStatus, @NullableUtcDateTimeConverter()  DateTime? timestamp)?  $default,) {final _that = this;
switch (_that) {
case _StatusTransitionResponse() when $default != null:
return $default(_that.requestId,_that.previousStatus,_that.newStatus,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatusTransitionResponse implements StatusTransitionResponse {
  const _StatusTransitionResponse({@NullableIdConverter() this.requestId, this.previousStatus, this.newStatus, @NullableUtcDateTimeConverter() this.timestamp});
  factory _StatusTransitionResponse.fromJson(Map<String, dynamic> json) => _$StatusTransitionResponseFromJson(json);

@override@NullableIdConverter() final  String? requestId;
@override final  String? previousStatus;
@override final  String? newStatus;
@override@NullableUtcDateTimeConverter() final  DateTime? timestamp;

/// Create a copy of StatusTransitionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatusTransitionResponseCopyWith<_StatusTransitionResponse> get copyWith => __$StatusTransitionResponseCopyWithImpl<_StatusTransitionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatusTransitionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatusTransitionResponse&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.previousStatus, previousStatus) || other.previousStatus == previousStatus)&&(identical(other.newStatus, newStatus) || other.newStatus == newStatus)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,requestId,previousStatus,newStatus,timestamp);
}

@override
String toString() {
    return 'StatusTransitionResponse(requestId: $requestId, previousStatus: $previousStatus, newStatus: $newStatus, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$StatusTransitionResponseCopyWith<$Res> implements $StatusTransitionResponseCopyWith<$Res> {
  factory _$StatusTransitionResponseCopyWith(_StatusTransitionResponse value, $Res Function(_StatusTransitionResponse) _then) = __$StatusTransitionResponseCopyWithImpl;
@override @useResult
$Res call({
@NullableIdConverter() String? requestId, String? previousStatus, String? newStatus,@NullableUtcDateTimeConverter() DateTime? timestamp
});




}
/// @nodoc
class __$StatusTransitionResponseCopyWithImpl<$Res>
    implements _$StatusTransitionResponseCopyWith<$Res> {
  __$StatusTransitionResponseCopyWithImpl(this._self, this._then);

  final _StatusTransitionResponse _self;
  final $Res Function(_StatusTransitionResponse) _then;

/// Create a copy of StatusTransitionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requestId = freezed,Object? previousStatus = freezed,Object? newStatus = freezed,Object? timestamp = freezed,}) {
  return _then(_StatusTransitionResponse(
requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,previousStatus: freezed == previousStatus ? _self.previousStatus : previousStatus // ignore: cast_nullable_to_non_nullable
as String?,newStatus: freezed == newStatus ? _self.newStatus : newStatus // ignore: cast_nullable_to_non_nullable
as String?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
