// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voip_call.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VoipCall {

 String get id; String? get bookingId; String? get callerId; String? get receiverId; int? get durationSeconds; DateTime? get startedAt; DateTime? get endedAt;
/// Create a copy of VoipCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoipCallCopyWith<VoipCall> get copyWith => _$VoipCallCopyWithImpl<VoipCall>(this as VoipCall, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as VoipCall;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoipCall&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.bookingId, _this.bookingId) || other.bookingId == _this.bookingId)&&(identical(other.callerId, _this.callerId) || other.callerId == _this.callerId)&&(identical(other.receiverId, _this.receiverId) || other.receiverId == _this.receiverId)&&(identical(other.durationSeconds, _this.durationSeconds) || other.durationSeconds == _this.durationSeconds)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.endedAt, _this.endedAt) || other.endedAt == _this.endedAt));
}


@override
int get hashCode {
  final _this = this as VoipCall;
  return Object.hash(runtimeType,_this.id,_this.bookingId,_this.callerId,_this.receiverId,_this.durationSeconds,_this.startedAt,_this.endedAt);
}

@override
String toString() {
  final _this = this as VoipCall;
  return 'VoipCall(id: ${_this.id}, bookingId: ${_this.bookingId}, callerId: ${_this.callerId}, receiverId: ${_this.receiverId}, durationSeconds: ${_this.durationSeconds}, startedAt: ${_this.startedAt}, endedAt: ${_this.endedAt})';
}


}

/// @nodoc
abstract mixin class $VoipCallCopyWith<$Res>  {
  factory $VoipCallCopyWith(VoipCall value, $Res Function(VoipCall) _then) = _$VoipCallCopyWithImpl;
@useResult
$Res call({
 String id, String? bookingId, String? callerId, String? receiverId, int? durationSeconds, DateTime? startedAt, DateTime? endedAt
});




}
/// @nodoc
class _$VoipCallCopyWithImpl<$Res>
    implements $VoipCallCopyWith<$Res> {
  _$VoipCallCopyWithImpl(this._self, this._then);

  final VoipCall _self;
  final $Res Function(VoipCall) _then;

/// Create a copy of VoipCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookingId = freezed,Object? callerId = freezed,Object? receiverId = freezed,Object? durationSeconds = freezed,Object? startedAt = freezed,Object? endedAt = freezed,}) {
  return _then(VoipCall(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,callerId: freezed == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as String?,receiverId: freezed == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [VoipCall].
extension VoipCallPatterns on VoipCall {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoipCall value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoipCall() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoipCall value)  $default,){
final _that = this;
switch (_that) {
case _VoipCall():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoipCall value)?  $default,){
final _that = this;
switch (_that) {
case _VoipCall() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? bookingId,  String? callerId,  String? receiverId,  int? durationSeconds,  DateTime? startedAt,  DateTime? endedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoipCall() when $default != null:
return $default(_that.id,_that.bookingId,_that.callerId,_that.receiverId,_that.durationSeconds,_that.startedAt,_that.endedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? bookingId,  String? callerId,  String? receiverId,  int? durationSeconds,  DateTime? startedAt,  DateTime? endedAt)  $default,) {final _that = this;
switch (_that) {
case _VoipCall():
return $default(_that.id,_that.bookingId,_that.callerId,_that.receiverId,_that.durationSeconds,_that.startedAt,_that.endedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? bookingId,  String? callerId,  String? receiverId,  int? durationSeconds,  DateTime? startedAt,  DateTime? endedAt)?  $default,) {final _that = this;
switch (_that) {
case _VoipCall() when $default != null:
return $default(_that.id,_that.bookingId,_that.callerId,_that.receiverId,_that.durationSeconds,_that.startedAt,_that.endedAt);case _:
  return null;

}
}

}

/// @nodoc


class _VoipCall extends VoipCall {
  const _VoipCall({required this.id, this.bookingId, this.callerId, this.receiverId, this.durationSeconds, this.startedAt, this.endedAt}): super._();
  

@override final  String id;
@override final  String? bookingId;
@override final  String? callerId;
@override final  String? receiverId;
@override final  int? durationSeconds;
@override final  DateTime? startedAt;
@override final  DateTime? endedAt;

/// Create a copy of VoipCall
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoipCallCopyWith<_VoipCall> get copyWith => __$VoipCallCopyWithImpl<_VoipCall>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoipCall&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,bookingId,callerId,receiverId,durationSeconds,startedAt,endedAt);
}

@override
String toString() {
    return 'VoipCall(id: $id, bookingId: $bookingId, callerId: $callerId, receiverId: $receiverId, durationSeconds: $durationSeconds, startedAt: $startedAt, endedAt: $endedAt)';
}


}

/// @nodoc
abstract mixin class _$VoipCallCopyWith<$Res> implements $VoipCallCopyWith<$Res> {
  factory _$VoipCallCopyWith(_VoipCall value, $Res Function(_VoipCall) _then) = __$VoipCallCopyWithImpl;
@override @useResult
$Res call({
 String id, String? bookingId, String? callerId, String? receiverId, int? durationSeconds, DateTime? startedAt, DateTime? endedAt
});




}
/// @nodoc
class __$VoipCallCopyWithImpl<$Res>
    implements _$VoipCallCopyWith<$Res> {
  __$VoipCallCopyWithImpl(this._self, this._then);

  final _VoipCall _self;
  final $Res Function(_VoipCall) _then;

/// Create a copy of VoipCall
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookingId = freezed,Object? callerId = freezed,Object? receiverId = freezed,Object? durationSeconds = freezed,Object? startedAt = freezed,Object? endedAt = freezed,}) {
  return _then(_VoipCall(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,callerId: freezed == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as String?,receiverId: freezed == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
