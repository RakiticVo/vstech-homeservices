// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracking_subscribe_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrackingSubscribeRequest {

@IdConverter() String get bookingId; String get action;
/// Create a copy of TrackingSubscribeRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackingSubscribeRequestCopyWith<TrackingSubscribeRequest> get copyWith => _$TrackingSubscribeRequestCopyWithImpl<TrackingSubscribeRequest>(this as TrackingSubscribeRequest, _$identity);

  /// Serializes this TrackingSubscribeRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TrackingSubscribeRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackingSubscribeRequest&&(identical(other.bookingId, _this.bookingId) || other.bookingId == _this.bookingId)&&(identical(other.action, _this.action) || other.action == _this.action));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TrackingSubscribeRequest;
  return Object.hash(runtimeType,_this.bookingId,_this.action);
}

@override
String toString() {
  final _this = this as TrackingSubscribeRequest;
  return 'TrackingSubscribeRequest(bookingId: ${_this.bookingId}, action: ${_this.action})';
}


}

/// @nodoc
abstract mixin class $TrackingSubscribeRequestCopyWith<$Res>  {
  factory $TrackingSubscribeRequestCopyWith(TrackingSubscribeRequest value, $Res Function(TrackingSubscribeRequest) _then) = _$TrackingSubscribeRequestCopyWithImpl;
@useResult
$Res call({
@IdConverter() String bookingId, String action
});




}
/// @nodoc
class _$TrackingSubscribeRequestCopyWithImpl<$Res>
    implements $TrackingSubscribeRequestCopyWith<$Res> {
  _$TrackingSubscribeRequestCopyWithImpl(this._self, this._then);

  final TrackingSubscribeRequest _self;
  final $Res Function(TrackingSubscribeRequest) _then;

/// Create a copy of TrackingSubscribeRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookingId = null,Object? action = null,}) {
  return _then(TrackingSubscribeRequest(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TrackingSubscribeRequest].
extension TrackingSubscribeRequestPatterns on TrackingSubscribeRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrackingSubscribeRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrackingSubscribeRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrackingSubscribeRequest value)  $default,){
final _that = this;
switch (_that) {
case _TrackingSubscribeRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrackingSubscribeRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TrackingSubscribeRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdConverter()  String bookingId,  String action)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrackingSubscribeRequest() when $default != null:
return $default(_that.bookingId,_that.action);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdConverter()  String bookingId,  String action)  $default,) {final _that = this;
switch (_that) {
case _TrackingSubscribeRequest():
return $default(_that.bookingId,_that.action);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdConverter()  String bookingId,  String action)?  $default,) {final _that = this;
switch (_that) {
case _TrackingSubscribeRequest() when $default != null:
return $default(_that.bookingId,_that.action);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrackingSubscribeRequest implements TrackingSubscribeRequest {
  const _TrackingSubscribeRequest({@IdConverter() required this.bookingId, this.action = 'SUBSCRIBE'});
  factory _TrackingSubscribeRequest.fromJson(Map<String, dynamic> json) => _$TrackingSubscribeRequestFromJson(json);

@override@IdConverter() final  String bookingId;
@override@JsonKey() final  String action;

/// Create a copy of TrackingSubscribeRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrackingSubscribeRequestCopyWith<_TrackingSubscribeRequest> get copyWith => __$TrackingSubscribeRequestCopyWithImpl<_TrackingSubscribeRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrackingSubscribeRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrackingSubscribeRequest&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.action, action) || other.action == action));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,bookingId,action);
}

@override
String toString() {
    return 'TrackingSubscribeRequest(bookingId: $bookingId, action: $action)';
}


}

/// @nodoc
abstract mixin class _$TrackingSubscribeRequestCopyWith<$Res> implements $TrackingSubscribeRequestCopyWith<$Res> {
  factory _$TrackingSubscribeRequestCopyWith(_TrackingSubscribeRequest value, $Res Function(_TrackingSubscribeRequest) _then) = __$TrackingSubscribeRequestCopyWithImpl;
@override @useResult
$Res call({
@IdConverter() String bookingId, String action
});




}
/// @nodoc
class __$TrackingSubscribeRequestCopyWithImpl<$Res>
    implements _$TrackingSubscribeRequestCopyWith<$Res> {
  __$TrackingSubscribeRequestCopyWithImpl(this._self, this._then);

  final _TrackingSubscribeRequest _self;
  final $Res Function(_TrackingSubscribeRequest) _then;

/// Create a copy of TrackingSubscribeRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookingId = null,Object? action = null,}) {
  return _then(_TrackingSubscribeRequest(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
