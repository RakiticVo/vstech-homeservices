// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_chat_room_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateChatRoomRequest {

@IdConverter() String get bookingId;
/// Create a copy of CreateChatRoomRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateChatRoomRequestCopyWith<CreateChatRoomRequest> get copyWith => _$CreateChatRoomRequestCopyWithImpl<CreateChatRoomRequest>(this as CreateChatRoomRequest, _$identity);

  /// Serializes this CreateChatRoomRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreateChatRoomRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateChatRoomRequest&&(identical(other.bookingId, _this.bookingId) || other.bookingId == _this.bookingId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreateChatRoomRequest;
  return Object.hash(runtimeType,_this.bookingId);
}

@override
String toString() {
  final _this = this as CreateChatRoomRequest;
  return 'CreateChatRoomRequest(bookingId: ${_this.bookingId})';
}


}

/// @nodoc
abstract mixin class $CreateChatRoomRequestCopyWith<$Res>  {
  factory $CreateChatRoomRequestCopyWith(CreateChatRoomRequest value, $Res Function(CreateChatRoomRequest) _then) = _$CreateChatRoomRequestCopyWithImpl;
@useResult
$Res call({
@IdConverter() String bookingId
});




}
/// @nodoc
class _$CreateChatRoomRequestCopyWithImpl<$Res>
    implements $CreateChatRoomRequestCopyWith<$Res> {
  _$CreateChatRoomRequestCopyWithImpl(this._self, this._then);

  final CreateChatRoomRequest _self;
  final $Res Function(CreateChatRoomRequest) _then;

/// Create a copy of CreateChatRoomRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookingId = null,}) {
  return _then(CreateChatRoomRequest(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateChatRoomRequest].
extension CreateChatRoomRequestPatterns on CreateChatRoomRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateChatRoomRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateChatRoomRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateChatRoomRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateChatRoomRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateChatRoomRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateChatRoomRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdConverter()  String bookingId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateChatRoomRequest() when $default != null:
return $default(_that.bookingId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdConverter()  String bookingId)  $default,) {final _that = this;
switch (_that) {
case _CreateChatRoomRequest():
return $default(_that.bookingId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdConverter()  String bookingId)?  $default,) {final _that = this;
switch (_that) {
case _CreateChatRoomRequest() when $default != null:
return $default(_that.bookingId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateChatRoomRequest implements CreateChatRoomRequest {
  const _CreateChatRoomRequest({@IdConverter() required this.bookingId});
  factory _CreateChatRoomRequest.fromJson(Map<String, dynamic> json) => _$CreateChatRoomRequestFromJson(json);

@override@IdConverter() final  String bookingId;

/// Create a copy of CreateChatRoomRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateChatRoomRequestCopyWith<_CreateChatRoomRequest> get copyWith => __$CreateChatRoomRequestCopyWithImpl<_CreateChatRoomRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateChatRoomRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateChatRoomRequest&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,bookingId);
}

@override
String toString() {
    return 'CreateChatRoomRequest(bookingId: $bookingId)';
}


}

/// @nodoc
abstract mixin class _$CreateChatRoomRequestCopyWith<$Res> implements $CreateChatRoomRequestCopyWith<$Res> {
  factory _$CreateChatRoomRequestCopyWith(_CreateChatRoomRequest value, $Res Function(_CreateChatRoomRequest) _then) = __$CreateChatRoomRequestCopyWithImpl;
@override @useResult
$Res call({
@IdConverter() String bookingId
});




}
/// @nodoc
class __$CreateChatRoomRequestCopyWithImpl<$Res>
    implements _$CreateChatRoomRequestCopyWith<$Res> {
  __$CreateChatRoomRequestCopyWithImpl(this._self, this._then);

  final _CreateChatRoomRequest _self;
  final $Res Function(_CreateChatRoomRequest) _then;

/// Create a copy of CreateChatRoomRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookingId = null,}) {
  return _then(_CreateChatRoomRequest(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
