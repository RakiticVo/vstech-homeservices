// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatMessageResponse {

@IdConverter() String get id;@NullableIdConverter() String? get roomId;@NullableIdConverter() String? get senderId; String? get messageText; List<String> get mediaUrls; bool? get isRead;@NullableUtcDateTimeConverter() DateTime? get sentAt;
/// Create a copy of ChatMessageResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageResponseCopyWith<ChatMessageResponse> get copyWith => _$ChatMessageResponseCopyWithImpl<ChatMessageResponse>(this as ChatMessageResponse, _$identity);

  /// Serializes this ChatMessageResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatMessageResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessageResponse&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.roomId, _this.roomId) || other.roomId == _this.roomId)&&(identical(other.senderId, _this.senderId) || other.senderId == _this.senderId)&&(identical(other.messageText, _this.messageText) || other.messageText == _this.messageText)&&const DeepCollectionEquality().equals(other.mediaUrls, _this.mediaUrls)&&(identical(other.isRead, _this.isRead) || other.isRead == _this.isRead)&&(identical(other.sentAt, _this.sentAt) || other.sentAt == _this.sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatMessageResponse;
  return Object.hash(runtimeType,_this.id,_this.roomId,_this.senderId,_this.messageText,const DeepCollectionEquality().hash(_this.mediaUrls),_this.isRead,_this.sentAt);
}

@override
String toString() {
  final _this = this as ChatMessageResponse;
  return 'ChatMessageResponse(id: ${_this.id}, roomId: ${_this.roomId}, senderId: ${_this.senderId}, messageText: ${_this.messageText}, mediaUrls: ${_this.mediaUrls}, isRead: ${_this.isRead}, sentAt: ${_this.sentAt})';
}


}

/// @nodoc
abstract mixin class $ChatMessageResponseCopyWith<$Res>  {
  factory $ChatMessageResponseCopyWith(ChatMessageResponse value, $Res Function(ChatMessageResponse) _then) = _$ChatMessageResponseCopyWithImpl;
@useResult
$Res call({
@IdConverter() String id,@NullableIdConverter() String? roomId,@NullableIdConverter() String? senderId, String? messageText, List<String> mediaUrls, bool? isRead,@NullableUtcDateTimeConverter() DateTime? sentAt
});




}
/// @nodoc
class _$ChatMessageResponseCopyWithImpl<$Res>
    implements $ChatMessageResponseCopyWith<$Res> {
  _$ChatMessageResponseCopyWithImpl(this._self, this._then);

  final ChatMessageResponse _self;
  final $Res Function(ChatMessageResponse) _then;

/// Create a copy of ChatMessageResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roomId = freezed,Object? senderId = freezed,Object? messageText = freezed,Object? mediaUrls = null,Object? isRead = freezed,Object? sentAt = freezed,}) {
  return _then(ChatMessageResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: freezed == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String?,senderId: freezed == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String?,messageText: freezed == messageText ? _self.messageText : messageText // ignore: cast_nullable_to_non_nullable
as String?,mediaUrls: null == mediaUrls ? _self.mediaUrls : mediaUrls // ignore: cast_nullable_to_non_nullable
as List<String>,isRead: freezed == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessageResponse].
extension ChatMessageResponsePatterns on ChatMessageResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessageResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessageResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessageResponse value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessageResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessageResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessageResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdConverter()  String id, @NullableIdConverter()  String? roomId, @NullableIdConverter()  String? senderId,  String? messageText,  List<String> mediaUrls,  bool? isRead, @NullableUtcDateTimeConverter()  DateTime? sentAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessageResponse() when $default != null:
return $default(_that.id,_that.roomId,_that.senderId,_that.messageText,_that.mediaUrls,_that.isRead,_that.sentAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdConverter()  String id, @NullableIdConverter()  String? roomId, @NullableIdConverter()  String? senderId,  String? messageText,  List<String> mediaUrls,  bool? isRead, @NullableUtcDateTimeConverter()  DateTime? sentAt)  $default,) {final _that = this;
switch (_that) {
case _ChatMessageResponse():
return $default(_that.id,_that.roomId,_that.senderId,_that.messageText,_that.mediaUrls,_that.isRead,_that.sentAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdConverter()  String id, @NullableIdConverter()  String? roomId, @NullableIdConverter()  String? senderId,  String? messageText,  List<String> mediaUrls,  bool? isRead, @NullableUtcDateTimeConverter()  DateTime? sentAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessageResponse() when $default != null:
return $default(_that.id,_that.roomId,_that.senderId,_that.messageText,_that.mediaUrls,_that.isRead,_that.sentAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessageResponse implements ChatMessageResponse {
  const _ChatMessageResponse({@IdConverter() required this.id, @NullableIdConverter() this.roomId, @NullableIdConverter() this.senderId, this.messageText,  List<String> mediaUrls = const [], this.isRead, @NullableUtcDateTimeConverter() this.sentAt}): _mediaUrls = mediaUrls;
  factory _ChatMessageResponse.fromJson(Map<String, dynamic> json) => _$ChatMessageResponseFromJson(json);

@override@IdConverter() final  String id;
@override@NullableIdConverter() final  String? roomId;
@override@NullableIdConverter() final  String? senderId;
@override final  String? messageText;
 final  List<String> _mediaUrls;
@override@JsonKey() List<String> get mediaUrls {
  if (_mediaUrls is EqualUnmodifiableListView) return _mediaUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mediaUrls);
}

@override final  bool? isRead;
@override@NullableUtcDateTimeConverter() final  DateTime? sentAt;

/// Create a copy of ChatMessageResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageResponseCopyWith<_ChatMessageResponse> get copyWith => __$ChatMessageResponseCopyWithImpl<_ChatMessageResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessageResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.messageText, messageText) || other.messageText == messageText)&&const DeepCollectionEquality().equals(other.mediaUrls, _mediaUrls)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,roomId,senderId,messageText,const DeepCollectionEquality().hash(_mediaUrls),isRead,sentAt);
}

@override
String toString() {
    return 'ChatMessageResponse(id: $id, roomId: $roomId, senderId: $senderId, messageText: $messageText, mediaUrls: $mediaUrls, isRead: $isRead, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageResponseCopyWith<$Res> implements $ChatMessageResponseCopyWith<$Res> {
  factory _$ChatMessageResponseCopyWith(_ChatMessageResponse value, $Res Function(_ChatMessageResponse) _then) = __$ChatMessageResponseCopyWithImpl;
@override @useResult
$Res call({
@IdConverter() String id,@NullableIdConverter() String? roomId,@NullableIdConverter() String? senderId, String? messageText, List<String> mediaUrls, bool? isRead,@NullableUtcDateTimeConverter() DateTime? sentAt
});




}
/// @nodoc
class __$ChatMessageResponseCopyWithImpl<$Res>
    implements _$ChatMessageResponseCopyWith<$Res> {
  __$ChatMessageResponseCopyWithImpl(this._self, this._then);

  final _ChatMessageResponse _self;
  final $Res Function(_ChatMessageResponse) _then;

/// Create a copy of ChatMessageResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roomId = freezed,Object? senderId = freezed,Object? messageText = freezed,Object? mediaUrls = null,Object? isRead = freezed,Object? sentAt = freezed,}) {
  return _then(_ChatMessageResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: freezed == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String?,senderId: freezed == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String?,messageText: freezed == messageText ? _self.messageText : messageText // ignore: cast_nullable_to_non_nullable
as String?,mediaUrls: null == mediaUrls ? _self._mediaUrls : mediaUrls // ignore: cast_nullable_to_non_nullable
as List<String>,isRead: freezed == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ChatMessagePageResponse {

 List<ChatMessageResponse> get messages;
/// Create a copy of ChatMessagePageResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessagePageResponseCopyWith<ChatMessagePageResponse> get copyWith => _$ChatMessagePageResponseCopyWithImpl<ChatMessagePageResponse>(this as ChatMessagePageResponse, _$identity);

  /// Serializes this ChatMessagePageResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatMessagePageResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessagePageResponse&&const DeepCollectionEquality().equals(other.messages, _this.messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatMessagePageResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.messages));
}

@override
String toString() {
  final _this = this as ChatMessagePageResponse;
  return 'ChatMessagePageResponse(messages: ${_this.messages})';
}


}

/// @nodoc
abstract mixin class $ChatMessagePageResponseCopyWith<$Res>  {
  factory $ChatMessagePageResponseCopyWith(ChatMessagePageResponse value, $Res Function(ChatMessagePageResponse) _then) = _$ChatMessagePageResponseCopyWithImpl;
@useResult
$Res call({
 List<ChatMessageResponse> messages
});




}
/// @nodoc
class _$ChatMessagePageResponseCopyWithImpl<$Res>
    implements $ChatMessagePageResponseCopyWith<$Res> {
  _$ChatMessagePageResponseCopyWithImpl(this._self, this._then);

  final ChatMessagePageResponse _self;
  final $Res Function(ChatMessagePageResponse) _then;

/// Create a copy of ChatMessagePageResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,}) {
  return _then(ChatMessagePageResponse(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageResponse>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessagePageResponse].
extension ChatMessagePageResponsePatterns on ChatMessagePageResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessagePageResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessagePageResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessagePageResponse value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessagePageResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessagePageResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessagePageResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChatMessageResponse> messages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessagePageResponse() when $default != null:
return $default(_that.messages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChatMessageResponse> messages)  $default,) {final _that = this;
switch (_that) {
case _ChatMessagePageResponse():
return $default(_that.messages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChatMessageResponse> messages)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessagePageResponse() when $default != null:
return $default(_that.messages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessagePageResponse implements ChatMessagePageResponse {
  const _ChatMessagePageResponse({ List<ChatMessageResponse> messages = const []}): _messages = messages;
  factory _ChatMessagePageResponse.fromJson(Map<String, dynamic> json) => _$ChatMessagePageResponseFromJson(json);

 final  List<ChatMessageResponse> _messages;
@override@JsonKey() List<ChatMessageResponse> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of ChatMessagePageResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessagePageResponseCopyWith<_ChatMessagePageResponse> get copyWith => __$ChatMessagePageResponseCopyWithImpl<_ChatMessagePageResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessagePageResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessagePageResponse&&const DeepCollectionEquality().equals(other.messages, _messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages));
}

@override
String toString() {
    return 'ChatMessagePageResponse(messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$ChatMessagePageResponseCopyWith<$Res> implements $ChatMessagePageResponseCopyWith<$Res> {
  factory _$ChatMessagePageResponseCopyWith(_ChatMessagePageResponse value, $Res Function(_ChatMessagePageResponse) _then) = __$ChatMessagePageResponseCopyWithImpl;
@override @useResult
$Res call({
 List<ChatMessageResponse> messages
});




}
/// @nodoc
class __$ChatMessagePageResponseCopyWithImpl<$Res>
    implements _$ChatMessagePageResponseCopyWith<$Res> {
  __$ChatMessagePageResponseCopyWithImpl(this._self, this._then);

  final _ChatMessagePageResponse _self;
  final $Res Function(_ChatMessagePageResponse) _then;

/// Create a copy of ChatMessagePageResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,}) {
  return _then(_ChatMessagePageResponse(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageResponse>,
  ));
}


}

// dart format on
