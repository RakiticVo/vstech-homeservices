// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_room_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatRoomResponse {

@IdConverter() String get id;@NullableIdConverter() String? get bookingId;@NullableIdConverter() String? get customerId;@NullableIdConverter() String? get workerId; String? get status;
/// Create a copy of ChatRoomResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatRoomResponseCopyWith<ChatRoomResponse> get copyWith => _$ChatRoomResponseCopyWithImpl<ChatRoomResponse>(this as ChatRoomResponse, _$identity);

  /// Serializes this ChatRoomResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatRoomResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatRoomResponse&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.bookingId, _this.bookingId) || other.bookingId == _this.bookingId)&&(identical(other.customerId, _this.customerId) || other.customerId == _this.customerId)&&(identical(other.workerId, _this.workerId) || other.workerId == _this.workerId)&&(identical(other.status, _this.status) || other.status == _this.status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatRoomResponse;
  return Object.hash(runtimeType,_this.id,_this.bookingId,_this.customerId,_this.workerId,_this.status);
}

@override
String toString() {
  final _this = this as ChatRoomResponse;
  return 'ChatRoomResponse(id: ${_this.id}, bookingId: ${_this.bookingId}, customerId: ${_this.customerId}, workerId: ${_this.workerId}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $ChatRoomResponseCopyWith<$Res>  {
  factory $ChatRoomResponseCopyWith(ChatRoomResponse value, $Res Function(ChatRoomResponse) _then) = _$ChatRoomResponseCopyWithImpl;
@useResult
$Res call({
@IdConverter() String id,@NullableIdConverter() String? bookingId,@NullableIdConverter() String? customerId,@NullableIdConverter() String? workerId, String? status
});




}
/// @nodoc
class _$ChatRoomResponseCopyWithImpl<$Res>
    implements $ChatRoomResponseCopyWith<$Res> {
  _$ChatRoomResponseCopyWithImpl(this._self, this._then);

  final ChatRoomResponse _self;
  final $Res Function(ChatRoomResponse) _then;

/// Create a copy of ChatRoomResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookingId = freezed,Object? customerId = freezed,Object? workerId = freezed,Object? status = freezed,}) {
  return _then(ChatRoomResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,workerId: freezed == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatRoomResponse].
extension ChatRoomResponsePatterns on ChatRoomResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatRoomResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatRoomResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatRoomResponse value)  $default,){
final _that = this;
switch (_that) {
case _ChatRoomResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatRoomResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ChatRoomResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdConverter()  String id, @NullableIdConverter()  String? bookingId, @NullableIdConverter()  String? customerId, @NullableIdConverter()  String? workerId,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatRoomResponse() when $default != null:
return $default(_that.id,_that.bookingId,_that.customerId,_that.workerId,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdConverter()  String id, @NullableIdConverter()  String? bookingId, @NullableIdConverter()  String? customerId, @NullableIdConverter()  String? workerId,  String? status)  $default,) {final _that = this;
switch (_that) {
case _ChatRoomResponse():
return $default(_that.id,_that.bookingId,_that.customerId,_that.workerId,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdConverter()  String id, @NullableIdConverter()  String? bookingId, @NullableIdConverter()  String? customerId, @NullableIdConverter()  String? workerId,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _ChatRoomResponse() when $default != null:
return $default(_that.id,_that.bookingId,_that.customerId,_that.workerId,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatRoomResponse implements ChatRoomResponse {
  const _ChatRoomResponse({@IdConverter() required this.id, @NullableIdConverter() this.bookingId, @NullableIdConverter() this.customerId, @NullableIdConverter() this.workerId, this.status});
  factory _ChatRoomResponse.fromJson(Map<String, dynamic> json) => _$ChatRoomResponseFromJson(json);

@override@IdConverter() final  String id;
@override@NullableIdConverter() final  String? bookingId;
@override@NullableIdConverter() final  String? customerId;
@override@NullableIdConverter() final  String? workerId;
@override final  String? status;

/// Create a copy of ChatRoomResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatRoomResponseCopyWith<_ChatRoomResponse> get copyWith => __$ChatRoomResponseCopyWithImpl<_ChatRoomResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatRoomResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatRoomResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,bookingId,customerId,workerId,status);
}

@override
String toString() {
    return 'ChatRoomResponse(id: $id, bookingId: $bookingId, customerId: $customerId, workerId: $workerId, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ChatRoomResponseCopyWith<$Res> implements $ChatRoomResponseCopyWith<$Res> {
  factory _$ChatRoomResponseCopyWith(_ChatRoomResponse value, $Res Function(_ChatRoomResponse) _then) = __$ChatRoomResponseCopyWithImpl;
@override @useResult
$Res call({
@IdConverter() String id,@NullableIdConverter() String? bookingId,@NullableIdConverter() String? customerId,@NullableIdConverter() String? workerId, String? status
});




}
/// @nodoc
class __$ChatRoomResponseCopyWithImpl<$Res>
    implements _$ChatRoomResponseCopyWith<$Res> {
  __$ChatRoomResponseCopyWithImpl(this._self, this._then);

  final _ChatRoomResponse _self;
  final $Res Function(_ChatRoomResponse) _then;

/// Create a copy of ChatRoomResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookingId = freezed,Object? customerId = freezed,Object? workerId = freezed,Object? status = freezed,}) {
  return _then(_ChatRoomResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,workerId: freezed == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
