// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voip_call_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VoipCallResponse {

@IdConverter() String get id;@NullableIdConverter() String? get bookingId;@NullableIdConverter() String? get callerId;@NullableIdConverter() String? get receiverId; String? get status; int? get durationSeconds; String? get recordingUrl;@NullableUtcDateTimeConverter() DateTime? get startedAt;@NullableUtcDateTimeConverter() DateTime? get endedAt;
/// Create a copy of VoipCallResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoipCallResponseCopyWith<VoipCallResponse> get copyWith => _$VoipCallResponseCopyWithImpl<VoipCallResponse>(this as VoipCallResponse, _$identity);

  /// Serializes this VoipCallResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VoipCallResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoipCallResponse&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.bookingId, _this.bookingId) || other.bookingId == _this.bookingId)&&(identical(other.callerId, _this.callerId) || other.callerId == _this.callerId)&&(identical(other.receiverId, _this.receiverId) || other.receiverId == _this.receiverId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.durationSeconds, _this.durationSeconds) || other.durationSeconds == _this.durationSeconds)&&(identical(other.recordingUrl, _this.recordingUrl) || other.recordingUrl == _this.recordingUrl)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.endedAt, _this.endedAt) || other.endedAt == _this.endedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VoipCallResponse;
  return Object.hash(runtimeType,_this.id,_this.bookingId,_this.callerId,_this.receiverId,_this.status,_this.durationSeconds,_this.recordingUrl,_this.startedAt,_this.endedAt);
}

@override
String toString() {
  final _this = this as VoipCallResponse;
  return 'VoipCallResponse(id: ${_this.id}, bookingId: ${_this.bookingId}, callerId: ${_this.callerId}, receiverId: ${_this.receiverId}, status: ${_this.status}, durationSeconds: ${_this.durationSeconds}, recordingUrl: ${_this.recordingUrl}, startedAt: ${_this.startedAt}, endedAt: ${_this.endedAt})';
}


}

/// @nodoc
abstract mixin class $VoipCallResponseCopyWith<$Res>  {
  factory $VoipCallResponseCopyWith(VoipCallResponse value, $Res Function(VoipCallResponse) _then) = _$VoipCallResponseCopyWithImpl;
@useResult
$Res call({
@IdConverter() String id,@NullableIdConverter() String? bookingId,@NullableIdConverter() String? callerId,@NullableIdConverter() String? receiverId, String? status, int? durationSeconds, String? recordingUrl,@NullableUtcDateTimeConverter() DateTime? startedAt,@NullableUtcDateTimeConverter() DateTime? endedAt
});




}
/// @nodoc
class _$VoipCallResponseCopyWithImpl<$Res>
    implements $VoipCallResponseCopyWith<$Res> {
  _$VoipCallResponseCopyWithImpl(this._self, this._then);

  final VoipCallResponse _self;
  final $Res Function(VoipCallResponse) _then;

/// Create a copy of VoipCallResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookingId = freezed,Object? callerId = freezed,Object? receiverId = freezed,Object? status = freezed,Object? durationSeconds = freezed,Object? recordingUrl = freezed,Object? startedAt = freezed,Object? endedAt = freezed,}) {
  return _then(VoipCallResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,callerId: freezed == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as String?,receiverId: freezed == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,recordingUrl: freezed == recordingUrl ? _self.recordingUrl : recordingUrl // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [VoipCallResponse].
extension VoipCallResponsePatterns on VoipCallResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoipCallResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoipCallResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoipCallResponse value)  $default,){
final _that = this;
switch (_that) {
case _VoipCallResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoipCallResponse value)?  $default,){
final _that = this;
switch (_that) {
case _VoipCallResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdConverter()  String id, @NullableIdConverter()  String? bookingId, @NullableIdConverter()  String? callerId, @NullableIdConverter()  String? receiverId,  String? status,  int? durationSeconds,  String? recordingUrl, @NullableUtcDateTimeConverter()  DateTime? startedAt, @NullableUtcDateTimeConverter()  DateTime? endedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoipCallResponse() when $default != null:
return $default(_that.id,_that.bookingId,_that.callerId,_that.receiverId,_that.status,_that.durationSeconds,_that.recordingUrl,_that.startedAt,_that.endedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdConverter()  String id, @NullableIdConverter()  String? bookingId, @NullableIdConverter()  String? callerId, @NullableIdConverter()  String? receiverId,  String? status,  int? durationSeconds,  String? recordingUrl, @NullableUtcDateTimeConverter()  DateTime? startedAt, @NullableUtcDateTimeConverter()  DateTime? endedAt)  $default,) {final _that = this;
switch (_that) {
case _VoipCallResponse():
return $default(_that.id,_that.bookingId,_that.callerId,_that.receiverId,_that.status,_that.durationSeconds,_that.recordingUrl,_that.startedAt,_that.endedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdConverter()  String id, @NullableIdConverter()  String? bookingId, @NullableIdConverter()  String? callerId, @NullableIdConverter()  String? receiverId,  String? status,  int? durationSeconds,  String? recordingUrl, @NullableUtcDateTimeConverter()  DateTime? startedAt, @NullableUtcDateTimeConverter()  DateTime? endedAt)?  $default,) {final _that = this;
switch (_that) {
case _VoipCallResponse() when $default != null:
return $default(_that.id,_that.bookingId,_that.callerId,_that.receiverId,_that.status,_that.durationSeconds,_that.recordingUrl,_that.startedAt,_that.endedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VoipCallResponse implements VoipCallResponse {
  const _VoipCallResponse({@IdConverter() required this.id, @NullableIdConverter() this.bookingId, @NullableIdConverter() this.callerId, @NullableIdConverter() this.receiverId, this.status, this.durationSeconds, this.recordingUrl, @NullableUtcDateTimeConverter() this.startedAt, @NullableUtcDateTimeConverter() this.endedAt});
  factory _VoipCallResponse.fromJson(Map<String, dynamic> json) => _$VoipCallResponseFromJson(json);

@override@IdConverter() final  String id;
@override@NullableIdConverter() final  String? bookingId;
@override@NullableIdConverter() final  String? callerId;
@override@NullableIdConverter() final  String? receiverId;
@override final  String? status;
@override final  int? durationSeconds;
@override final  String? recordingUrl;
@override@NullableUtcDateTimeConverter() final  DateTime? startedAt;
@override@NullableUtcDateTimeConverter() final  DateTime? endedAt;

/// Create a copy of VoipCallResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoipCallResponseCopyWith<_VoipCallResponse> get copyWith => __$VoipCallResponseCopyWithImpl<_VoipCallResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoipCallResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoipCallResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.status, status) || other.status == status)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.recordingUrl, recordingUrl) || other.recordingUrl == recordingUrl)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,bookingId,callerId,receiverId,status,durationSeconds,recordingUrl,startedAt,endedAt);
}

@override
String toString() {
    return 'VoipCallResponse(id: $id, bookingId: $bookingId, callerId: $callerId, receiverId: $receiverId, status: $status, durationSeconds: $durationSeconds, recordingUrl: $recordingUrl, startedAt: $startedAt, endedAt: $endedAt)';
}


}

/// @nodoc
abstract mixin class _$VoipCallResponseCopyWith<$Res> implements $VoipCallResponseCopyWith<$Res> {
  factory _$VoipCallResponseCopyWith(_VoipCallResponse value, $Res Function(_VoipCallResponse) _then) = __$VoipCallResponseCopyWithImpl;
@override @useResult
$Res call({
@IdConverter() String id,@NullableIdConverter() String? bookingId,@NullableIdConverter() String? callerId,@NullableIdConverter() String? receiverId, String? status, int? durationSeconds, String? recordingUrl,@NullableUtcDateTimeConverter() DateTime? startedAt,@NullableUtcDateTimeConverter() DateTime? endedAt
});




}
/// @nodoc
class __$VoipCallResponseCopyWithImpl<$Res>
    implements _$VoipCallResponseCopyWith<$Res> {
  __$VoipCallResponseCopyWithImpl(this._self, this._then);

  final _VoipCallResponse _self;
  final $Res Function(_VoipCallResponse) _then;

/// Create a copy of VoipCallResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookingId = freezed,Object? callerId = freezed,Object? receiverId = freezed,Object? status = freezed,Object? durationSeconds = freezed,Object? recordingUrl = freezed,Object? startedAt = freezed,Object? endedAt = freezed,}) {
  return _then(_VoipCallResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,callerId: freezed == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as String?,receiverId: freezed == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,recordingUrl: freezed == recordingUrl ? _self.recordingUrl : recordingUrl // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
