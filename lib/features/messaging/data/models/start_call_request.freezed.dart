// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'start_call_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StartCallRequest {

@IdConverter() String get bookingId;@IdConverter() String get callerId;@IdConverter() String get receiverId;
/// Create a copy of StartCallRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartCallRequestCopyWith<StartCallRequest> get copyWith => _$StartCallRequestCopyWithImpl<StartCallRequest>(this as StartCallRequest, _$identity);

  /// Serializes this StartCallRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StartCallRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartCallRequest&&(identical(other.bookingId, _this.bookingId) || other.bookingId == _this.bookingId)&&(identical(other.callerId, _this.callerId) || other.callerId == _this.callerId)&&(identical(other.receiverId, _this.receiverId) || other.receiverId == _this.receiverId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StartCallRequest;
  return Object.hash(runtimeType,_this.bookingId,_this.callerId,_this.receiverId);
}

@override
String toString() {
  final _this = this as StartCallRequest;
  return 'StartCallRequest(bookingId: ${_this.bookingId}, callerId: ${_this.callerId}, receiverId: ${_this.receiverId})';
}


}

/// @nodoc
abstract mixin class $StartCallRequestCopyWith<$Res>  {
  factory $StartCallRequestCopyWith(StartCallRequest value, $Res Function(StartCallRequest) _then) = _$StartCallRequestCopyWithImpl;
@useResult
$Res call({
@IdConverter() String bookingId,@IdConverter() String callerId,@IdConverter() String receiverId
});




}
/// @nodoc
class _$StartCallRequestCopyWithImpl<$Res>
    implements $StartCallRequestCopyWith<$Res> {
  _$StartCallRequestCopyWithImpl(this._self, this._then);

  final StartCallRequest _self;
  final $Res Function(StartCallRequest) _then;

/// Create a copy of StartCallRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookingId = null,Object? callerId = null,Object? receiverId = null,}) {
  return _then(StartCallRequest(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,callerId: null == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StartCallRequest].
extension StartCallRequestPatterns on StartCallRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StartCallRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StartCallRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StartCallRequest value)  $default,){
final _that = this;
switch (_that) {
case _StartCallRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StartCallRequest value)?  $default,){
final _that = this;
switch (_that) {
case _StartCallRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdConverter()  String bookingId, @IdConverter()  String callerId, @IdConverter()  String receiverId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StartCallRequest() when $default != null:
return $default(_that.bookingId,_that.callerId,_that.receiverId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdConverter()  String bookingId, @IdConverter()  String callerId, @IdConverter()  String receiverId)  $default,) {final _that = this;
switch (_that) {
case _StartCallRequest():
return $default(_that.bookingId,_that.callerId,_that.receiverId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdConverter()  String bookingId, @IdConverter()  String callerId, @IdConverter()  String receiverId)?  $default,) {final _that = this;
switch (_that) {
case _StartCallRequest() when $default != null:
return $default(_that.bookingId,_that.callerId,_that.receiverId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StartCallRequest implements StartCallRequest {
  const _StartCallRequest({@IdConverter() required this.bookingId, @IdConverter() required this.callerId, @IdConverter() required this.receiverId});
  factory _StartCallRequest.fromJson(Map<String, dynamic> json) => _$StartCallRequestFromJson(json);

@override@IdConverter() final  String bookingId;
@override@IdConverter() final  String callerId;
@override@IdConverter() final  String receiverId;

/// Create a copy of StartCallRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartCallRequestCopyWith<_StartCallRequest> get copyWith => __$StartCallRequestCopyWithImpl<_StartCallRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StartCallRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StartCallRequest&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,bookingId,callerId,receiverId);
}

@override
String toString() {
    return 'StartCallRequest(bookingId: $bookingId, callerId: $callerId, receiverId: $receiverId)';
}


}

/// @nodoc
abstract mixin class _$StartCallRequestCopyWith<$Res> implements $StartCallRequestCopyWith<$Res> {
  factory _$StartCallRequestCopyWith(_StartCallRequest value, $Res Function(_StartCallRequest) _then) = __$StartCallRequestCopyWithImpl;
@override @useResult
$Res call({
@IdConverter() String bookingId,@IdConverter() String callerId,@IdConverter() String receiverId
});




}
/// @nodoc
class __$StartCallRequestCopyWithImpl<$Res>
    implements _$StartCallRequestCopyWith<$Res> {
  __$StartCallRequestCopyWithImpl(this._self, this._then);

  final _StartCallRequest _self;
  final $Res Function(_StartCallRequest) _then;

/// Create a copy of StartCallRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookingId = null,Object? callerId = null,Object? receiverId = null,}) {
  return _then(_StartCallRequest(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,callerId: null == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
