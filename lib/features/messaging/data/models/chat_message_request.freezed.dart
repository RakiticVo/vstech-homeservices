// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatMessageRequest {

 String get messageText; List<String>? get mediaUrls;
/// Create a copy of ChatMessageRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageRequestCopyWith<ChatMessageRequest> get copyWith => _$ChatMessageRequestCopyWithImpl<ChatMessageRequest>(this as ChatMessageRequest, _$identity);

  /// Serializes this ChatMessageRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatMessageRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessageRequest&&(identical(other.messageText, _this.messageText) || other.messageText == _this.messageText)&&const DeepCollectionEquality().equals(other.mediaUrls, _this.mediaUrls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatMessageRequest;
  return Object.hash(runtimeType,_this.messageText,const DeepCollectionEquality().hash(_this.mediaUrls));
}

@override
String toString() {
  final _this = this as ChatMessageRequest;
  return 'ChatMessageRequest(messageText: ${_this.messageText}, mediaUrls: ${_this.mediaUrls})';
}


}

/// @nodoc
abstract mixin class $ChatMessageRequestCopyWith<$Res>  {
  factory $ChatMessageRequestCopyWith(ChatMessageRequest value, $Res Function(ChatMessageRequest) _then) = _$ChatMessageRequestCopyWithImpl;
@useResult
$Res call({
 String messageText, List<String>? mediaUrls
});




}
/// @nodoc
class _$ChatMessageRequestCopyWithImpl<$Res>
    implements $ChatMessageRequestCopyWith<$Res> {
  _$ChatMessageRequestCopyWithImpl(this._self, this._then);

  final ChatMessageRequest _self;
  final $Res Function(ChatMessageRequest) _then;

/// Create a copy of ChatMessageRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageText = null,Object? mediaUrls = freezed,}) {
  return _then(ChatMessageRequest(
messageText: null == messageText ? _self.messageText : messageText // ignore: cast_nullable_to_non_nullable
as String,mediaUrls: freezed == mediaUrls ? _self.mediaUrls : mediaUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessageRequest].
extension ChatMessageRequestPatterns on ChatMessageRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessageRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessageRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessageRequest value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessageRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessageRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessageRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String messageText,  List<String>? mediaUrls)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessageRequest() when $default != null:
return $default(_that.messageText,_that.mediaUrls);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String messageText,  List<String>? mediaUrls)  $default,) {final _that = this;
switch (_that) {
case _ChatMessageRequest():
return $default(_that.messageText,_that.mediaUrls);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String messageText,  List<String>? mediaUrls)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessageRequest() when $default != null:
return $default(_that.messageText,_that.mediaUrls);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _ChatMessageRequest implements ChatMessageRequest {
  const _ChatMessageRequest({required this.messageText,  List<String>? mediaUrls}): _mediaUrls = mediaUrls;
  factory _ChatMessageRequest.fromJson(Map<String, dynamic> json) => _$ChatMessageRequestFromJson(json);

@override final  String messageText;
 final  List<String>? _mediaUrls;
@override List<String>? get mediaUrls {
  final value = _mediaUrls;
  if (value == null) return null;
  if (_mediaUrls is EqualUnmodifiableListView) return _mediaUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ChatMessageRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageRequestCopyWith<_ChatMessageRequest> get copyWith => __$ChatMessageRequestCopyWithImpl<_ChatMessageRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessageRequest&&(identical(other.messageText, messageText) || other.messageText == messageText)&&const DeepCollectionEquality().equals(other.mediaUrls, _mediaUrls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,messageText,const DeepCollectionEquality().hash(_mediaUrls));
}

@override
String toString() {
    return 'ChatMessageRequest(messageText: $messageText, mediaUrls: $mediaUrls)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageRequestCopyWith<$Res> implements $ChatMessageRequestCopyWith<$Res> {
  factory _$ChatMessageRequestCopyWith(_ChatMessageRequest value, $Res Function(_ChatMessageRequest) _then) = __$ChatMessageRequestCopyWithImpl;
@override @useResult
$Res call({
 String messageText, List<String>? mediaUrls
});




}
/// @nodoc
class __$ChatMessageRequestCopyWithImpl<$Res>
    implements _$ChatMessageRequestCopyWith<$Res> {
  __$ChatMessageRequestCopyWithImpl(this._self, this._then);

  final _ChatMessageRequest _self;
  final $Res Function(_ChatMessageRequest) _then;

/// Create a copy of ChatMessageRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageText = null,Object? mediaUrls = freezed,}) {
  return _then(_ChatMessageRequest(
messageText: null == messageText ? _self.messageText : messageText // ignore: cast_nullable_to_non_nullable
as String,mediaUrls: freezed == mediaUrls ? _self._mediaUrls : mediaUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
