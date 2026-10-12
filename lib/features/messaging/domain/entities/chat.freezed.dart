// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatRoom {

 String get id; String? get bookingId; String? get customerId; String? get workerId; bool get isClosed;
/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatRoomCopyWith<ChatRoom> get copyWith => _$ChatRoomCopyWithImpl<ChatRoom>(this as ChatRoom, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatRoom;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatRoom&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.bookingId, _this.bookingId) || other.bookingId == _this.bookingId)&&(identical(other.customerId, _this.customerId) || other.customerId == _this.customerId)&&(identical(other.workerId, _this.workerId) || other.workerId == _this.workerId)&&(identical(other.isClosed, _this.isClosed) || other.isClosed == _this.isClosed));
}


@override
int get hashCode {
  final _this = this as ChatRoom;
  return Object.hash(runtimeType,_this.id,_this.bookingId,_this.customerId,_this.workerId,_this.isClosed);
}

@override
String toString() {
  final _this = this as ChatRoom;
  return 'ChatRoom(id: ${_this.id}, bookingId: ${_this.bookingId}, customerId: ${_this.customerId}, workerId: ${_this.workerId}, isClosed: ${_this.isClosed})';
}


}

/// @nodoc
abstract mixin class $ChatRoomCopyWith<$Res>  {
  factory $ChatRoomCopyWith(ChatRoom value, $Res Function(ChatRoom) _then) = _$ChatRoomCopyWithImpl;
@useResult
$Res call({
 String id, String? bookingId, String? customerId, String? workerId, bool isClosed
});




}
/// @nodoc
class _$ChatRoomCopyWithImpl<$Res>
    implements $ChatRoomCopyWith<$Res> {
  _$ChatRoomCopyWithImpl(this._self, this._then);

  final ChatRoom _self;
  final $Res Function(ChatRoom) _then;

/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookingId = freezed,Object? customerId = freezed,Object? workerId = freezed,Object? isClosed = null,}) {
  return _then(ChatRoom(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,workerId: freezed == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String?,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatRoom].
extension ChatRoomPatterns on ChatRoom {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatRoom value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatRoom value)  $default,){
final _that = this;
switch (_that) {
case _ChatRoom():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatRoom value)?  $default,){
final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? bookingId,  String? customerId,  String? workerId,  bool isClosed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
return $default(_that.id,_that.bookingId,_that.customerId,_that.workerId,_that.isClosed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? bookingId,  String? customerId,  String? workerId,  bool isClosed)  $default,) {final _that = this;
switch (_that) {
case _ChatRoom():
return $default(_that.id,_that.bookingId,_that.customerId,_that.workerId,_that.isClosed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? bookingId,  String? customerId,  String? workerId,  bool isClosed)?  $default,) {final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
return $default(_that.id,_that.bookingId,_that.customerId,_that.workerId,_that.isClosed);case _:
  return null;

}
}

}

/// @nodoc


class _ChatRoom implements ChatRoom {
  const _ChatRoom({required this.id, this.bookingId, this.customerId, this.workerId, this.isClosed = false});
  

@override final  String id;
@override final  String? bookingId;
@override final  String? customerId;
@override final  String? workerId;
@override@JsonKey() final  bool isClosed;

/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatRoomCopyWith<_ChatRoom> get copyWith => __$ChatRoomCopyWithImpl<_ChatRoom>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatRoom&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,bookingId,customerId,workerId,isClosed);
}

@override
String toString() {
    return 'ChatRoom(id: $id, bookingId: $bookingId, customerId: $customerId, workerId: $workerId, isClosed: $isClosed)';
}


}

/// @nodoc
abstract mixin class _$ChatRoomCopyWith<$Res> implements $ChatRoomCopyWith<$Res> {
  factory _$ChatRoomCopyWith(_ChatRoom value, $Res Function(_ChatRoom) _then) = __$ChatRoomCopyWithImpl;
@override @useResult
$Res call({
 String id, String? bookingId, String? customerId, String? workerId, bool isClosed
});




}
/// @nodoc
class __$ChatRoomCopyWithImpl<$Res>
    implements _$ChatRoomCopyWith<$Res> {
  __$ChatRoomCopyWithImpl(this._self, this._then);

  final _ChatRoom _self;
  final $Res Function(_ChatRoom) _then;

/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookingId = freezed,Object? customerId = freezed,Object? workerId = freezed,Object? isClosed = null,}) {
  return _then(_ChatRoom(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,workerId: freezed == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String?,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$ChatRoomMessage {

 String get id; String? get senderId; String get text; List<String> get mediaUrls; bool get isRead; DateTime? get sentAt;
/// Create a copy of ChatRoomMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatRoomMessageCopyWith<ChatRoomMessage> get copyWith => _$ChatRoomMessageCopyWithImpl<ChatRoomMessage>(this as ChatRoomMessage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatRoomMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatRoomMessage&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.senderId, _this.senderId) || other.senderId == _this.senderId)&&(identical(other.text, _this.text) || other.text == _this.text)&&const DeepCollectionEquality().equals(other.mediaUrls, _this.mediaUrls)&&(identical(other.isRead, _this.isRead) || other.isRead == _this.isRead)&&(identical(other.sentAt, _this.sentAt) || other.sentAt == _this.sentAt));
}


@override
int get hashCode {
  final _this = this as ChatRoomMessage;
  return Object.hash(runtimeType,_this.id,_this.senderId,_this.text,const DeepCollectionEquality().hash(_this.mediaUrls),_this.isRead,_this.sentAt);
}

@override
String toString() {
  final _this = this as ChatRoomMessage;
  return 'ChatRoomMessage(id: ${_this.id}, senderId: ${_this.senderId}, text: ${_this.text}, mediaUrls: ${_this.mediaUrls}, isRead: ${_this.isRead}, sentAt: ${_this.sentAt})';
}


}

/// @nodoc
abstract mixin class $ChatRoomMessageCopyWith<$Res>  {
  factory $ChatRoomMessageCopyWith(ChatRoomMessage value, $Res Function(ChatRoomMessage) _then) = _$ChatRoomMessageCopyWithImpl;
@useResult
$Res call({
 String id, String? senderId, String text, List<String> mediaUrls, bool isRead, DateTime? sentAt
});




}
/// @nodoc
class _$ChatRoomMessageCopyWithImpl<$Res>
    implements $ChatRoomMessageCopyWith<$Res> {
  _$ChatRoomMessageCopyWithImpl(this._self, this._then);

  final ChatRoomMessage _self;
  final $Res Function(ChatRoomMessage) _then;

/// Create a copy of ChatRoomMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? senderId = freezed,Object? text = null,Object? mediaUrls = null,Object? isRead = null,Object? sentAt = freezed,}) {
  return _then(ChatRoomMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: freezed == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,mediaUrls: null == mediaUrls ? _self.mediaUrls : mediaUrls // ignore: cast_nullable_to_non_nullable
as List<String>,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatRoomMessage].
extension ChatRoomMessagePatterns on ChatRoomMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatRoomMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatRoomMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatRoomMessage value)  $default,){
final _that = this;
switch (_that) {
case _ChatRoomMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatRoomMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ChatRoomMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? senderId,  String text,  List<String> mediaUrls,  bool isRead,  DateTime? sentAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatRoomMessage() when $default != null:
return $default(_that.id,_that.senderId,_that.text,_that.mediaUrls,_that.isRead,_that.sentAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? senderId,  String text,  List<String> mediaUrls,  bool isRead,  DateTime? sentAt)  $default,) {final _that = this;
switch (_that) {
case _ChatRoomMessage():
return $default(_that.id,_that.senderId,_that.text,_that.mediaUrls,_that.isRead,_that.sentAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? senderId,  String text,  List<String> mediaUrls,  bool isRead,  DateTime? sentAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatRoomMessage() when $default != null:
return $default(_that.id,_that.senderId,_that.text,_that.mediaUrls,_that.isRead,_that.sentAt);case _:
  return null;

}
}

}

/// @nodoc


class _ChatRoomMessage implements ChatRoomMessage {
  const _ChatRoomMessage({required this.id, this.senderId, this.text = '',  List<String> mediaUrls = const [], this.isRead = false, this.sentAt}): _mediaUrls = mediaUrls;
  

@override final  String id;
@override final  String? senderId;
@override@JsonKey() final  String text;
 final  List<String> _mediaUrls;
@override@JsonKey() List<String> get mediaUrls {
  if (_mediaUrls is EqualUnmodifiableListView) return _mediaUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mediaUrls);
}

@override@JsonKey() final  bool isRead;
@override final  DateTime? sentAt;

/// Create a copy of ChatRoomMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatRoomMessageCopyWith<_ChatRoomMessage> get copyWith => __$ChatRoomMessageCopyWithImpl<_ChatRoomMessage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatRoomMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.mediaUrls, _mediaUrls)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,senderId,text,const DeepCollectionEquality().hash(_mediaUrls),isRead,sentAt);
}

@override
String toString() {
    return 'ChatRoomMessage(id: $id, senderId: $senderId, text: $text, mediaUrls: $mediaUrls, isRead: $isRead, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class _$ChatRoomMessageCopyWith<$Res> implements $ChatRoomMessageCopyWith<$Res> {
  factory _$ChatRoomMessageCopyWith(_ChatRoomMessage value, $Res Function(_ChatRoomMessage) _then) = __$ChatRoomMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String? senderId, String text, List<String> mediaUrls, bool isRead, DateTime? sentAt
});




}
/// @nodoc
class __$ChatRoomMessageCopyWithImpl<$Res>
    implements _$ChatRoomMessageCopyWith<$Res> {
  __$ChatRoomMessageCopyWithImpl(this._self, this._then);

  final _ChatRoomMessage _self;
  final $Res Function(_ChatRoomMessage) _then;

/// Create a copy of ChatRoomMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderId = freezed,Object? text = null,Object? mediaUrls = null,Object? isRead = null,Object? sentAt = freezed,}) {
  return _then(_ChatRoomMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: freezed == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,mediaUrls: null == mediaUrls ? _self._mediaUrls : mediaUrls // ignore: cast_nullable_to_non_nullable
as List<String>,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$ChatHistoryPage {

 List<ChatRoomMessage> get items; int get page; bool get hasMore;
/// Create a copy of ChatHistoryPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatHistoryPageCopyWith<ChatHistoryPage> get copyWith => _$ChatHistoryPageCopyWithImpl<ChatHistoryPage>(this as ChatHistoryPage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatHistoryPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatHistoryPage&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.hasMore, _this.hasMore) || other.hasMore == _this.hasMore));
}


@override
int get hashCode {
  final _this = this as ChatHistoryPage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.page,_this.hasMore);
}

@override
String toString() {
  final _this = this as ChatHistoryPage;
  return 'ChatHistoryPage(items: ${_this.items}, page: ${_this.page}, hasMore: ${_this.hasMore})';
}


}

/// @nodoc
abstract mixin class $ChatHistoryPageCopyWith<$Res>  {
  factory $ChatHistoryPageCopyWith(ChatHistoryPage value, $Res Function(ChatHistoryPage) _then) = _$ChatHistoryPageCopyWithImpl;
@useResult
$Res call({
 List<ChatRoomMessage> items, int page, bool hasMore
});




}
/// @nodoc
class _$ChatHistoryPageCopyWithImpl<$Res>
    implements $ChatHistoryPageCopyWith<$Res> {
  _$ChatHistoryPageCopyWithImpl(this._self, this._then);

  final ChatHistoryPage _self;
  final $Res Function(ChatHistoryPage) _then;

/// Create a copy of ChatHistoryPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? page = null,Object? hasMore = null,}) {
  return _then(ChatHistoryPage(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ChatRoomMessage>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatHistoryPage].
extension ChatHistoryPagePatterns on ChatHistoryPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatHistoryPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatHistoryPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatHistoryPage value)  $default,){
final _that = this;
switch (_that) {
case _ChatHistoryPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatHistoryPage value)?  $default,){
final _that = this;
switch (_that) {
case _ChatHistoryPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChatRoomMessage> items,  int page,  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatHistoryPage() when $default != null:
return $default(_that.items,_that.page,_that.hasMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChatRoomMessage> items,  int page,  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _ChatHistoryPage():
return $default(_that.items,_that.page,_that.hasMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChatRoomMessage> items,  int page,  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _ChatHistoryPage() when $default != null:
return $default(_that.items,_that.page,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc


class _ChatHistoryPage implements ChatHistoryPage {
  const _ChatHistoryPage({required  List<ChatRoomMessage> items, required this.page, required this.hasMore}): _items = items;
  

 final  List<ChatRoomMessage> _items;
@override List<ChatRoomMessage> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int page;
@override final  bool hasMore;

/// Create a copy of ChatHistoryPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatHistoryPageCopyWith<_ChatHistoryPage> get copyWith => __$ChatHistoryPageCopyWithImpl<_ChatHistoryPage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatHistoryPage&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),page,hasMore);
}

@override
String toString() {
    return 'ChatHistoryPage(items: $items, page: $page, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$ChatHistoryPageCopyWith<$Res> implements $ChatHistoryPageCopyWith<$Res> {
  factory _$ChatHistoryPageCopyWith(_ChatHistoryPage value, $Res Function(_ChatHistoryPage) _then) = __$ChatHistoryPageCopyWithImpl;
@override @useResult
$Res call({
 List<ChatRoomMessage> items, int page, bool hasMore
});




}
/// @nodoc
class __$ChatHistoryPageCopyWithImpl<$Res>
    implements _$ChatHistoryPageCopyWith<$Res> {
  __$ChatHistoryPageCopyWithImpl(this._self, this._then);

  final _ChatHistoryPage _self;
  final $Res Function(_ChatHistoryPage) _then;

/// Create a copy of ChatHistoryPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? page = null,Object? hasMore = null,}) {
  return _then(_ChatHistoryPage(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ChatRoomMessage>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
