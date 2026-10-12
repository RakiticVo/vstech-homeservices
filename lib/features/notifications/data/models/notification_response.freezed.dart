// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationResponse {

@IdConverter() String get id;@NullableIdConverter() String? get userId; String? get title; String? get body; String? get type; bool? get isRead;@NullableUtcDateTimeConverter() DateTime? get createdAt;
/// Create a copy of NotificationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationResponseCopyWith<NotificationResponse> get copyWith => _$NotificationResponseCopyWithImpl<NotificationResponse>(this as NotificationResponse, _$identity);

  /// Serializes this NotificationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NotificationResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationResponse&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.isRead, _this.isRead) || other.isRead == _this.isRead)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NotificationResponse;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.title,_this.body,_this.type,_this.isRead,_this.createdAt);
}

@override
String toString() {
  final _this = this as NotificationResponse;
  return 'NotificationResponse(id: ${_this.id}, userId: ${_this.userId}, title: ${_this.title}, body: ${_this.body}, type: ${_this.type}, isRead: ${_this.isRead}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $NotificationResponseCopyWith<$Res>  {
  factory $NotificationResponseCopyWith(NotificationResponse value, $Res Function(NotificationResponse) _then) = _$NotificationResponseCopyWithImpl;
@useResult
$Res call({
@IdConverter() String id,@NullableIdConverter() String? userId, String? title, String? body, String? type, bool? isRead,@NullableUtcDateTimeConverter() DateTime? createdAt
});




}
/// @nodoc
class _$NotificationResponseCopyWithImpl<$Res>
    implements $NotificationResponseCopyWith<$Res> {
  _$NotificationResponseCopyWithImpl(this._self, this._then);

  final NotificationResponse _self;
  final $Res Function(NotificationResponse) _then;

/// Create a copy of NotificationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = freezed,Object? title = freezed,Object? body = freezed,Object? type = freezed,Object? isRead = freezed,Object? createdAt = freezed,}) {
  return _then(NotificationResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,isRead: freezed == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationResponse].
extension NotificationResponsePatterns on NotificationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationResponse value)  $default,){
final _that = this;
switch (_that) {
case _NotificationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdConverter()  String id, @NullableIdConverter()  String? userId,  String? title,  String? body,  String? type,  bool? isRead, @NullableUtcDateTimeConverter()  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationResponse() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.body,_that.type,_that.isRead,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdConverter()  String id, @NullableIdConverter()  String? userId,  String? title,  String? body,  String? type,  bool? isRead, @NullableUtcDateTimeConverter()  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _NotificationResponse():
return $default(_that.id,_that.userId,_that.title,_that.body,_that.type,_that.isRead,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdConverter()  String id, @NullableIdConverter()  String? userId,  String? title,  String? body,  String? type,  bool? isRead, @NullableUtcDateTimeConverter()  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _NotificationResponse() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.body,_that.type,_that.isRead,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationResponse implements NotificationResponse {
  const _NotificationResponse({@IdConverter() required this.id, @NullableIdConverter() this.userId, this.title, this.body, this.type, this.isRead, @NullableUtcDateTimeConverter() this.createdAt});
  factory _NotificationResponse.fromJson(Map<String, dynamic> json) => _$NotificationResponseFromJson(json);

@override@IdConverter() final  String id;
@override@NullableIdConverter() final  String? userId;
@override final  String? title;
@override final  String? body;
@override final  String? type;
@override final  bool? isRead;
@override@NullableUtcDateTimeConverter() final  DateTime? createdAt;

/// Create a copy of NotificationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationResponseCopyWith<_NotificationResponse> get copyWith => __$NotificationResponseCopyWithImpl<_NotificationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.type, type) || other.type == type)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,title,body,type,isRead,createdAt);
}

@override
String toString() {
    return 'NotificationResponse(id: $id, userId: $userId, title: $title, body: $body, type: $type, isRead: $isRead, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$NotificationResponseCopyWith<$Res> implements $NotificationResponseCopyWith<$Res> {
  factory _$NotificationResponseCopyWith(_NotificationResponse value, $Res Function(_NotificationResponse) _then) = __$NotificationResponseCopyWithImpl;
@override @useResult
$Res call({
@IdConverter() String id,@NullableIdConverter() String? userId, String? title, String? body, String? type, bool? isRead,@NullableUtcDateTimeConverter() DateTime? createdAt
});




}
/// @nodoc
class __$NotificationResponseCopyWithImpl<$Res>
    implements _$NotificationResponseCopyWith<$Res> {
  __$NotificationResponseCopyWithImpl(this._self, this._then);

  final _NotificationResponse _self;
  final $Res Function(_NotificationResponse) _then;

/// Create a copy of NotificationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = freezed,Object? title = freezed,Object? body = freezed,Object? type = freezed,Object? isRead = freezed,Object? createdAt = freezed,}) {
  return _then(_NotificationResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,isRead: freezed == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$NotificationPageResponse {

 List<NotificationResponse> get notifications;
/// Create a copy of NotificationPageResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPageResponseCopyWith<NotificationPageResponse> get copyWith => _$NotificationPageResponseCopyWithImpl<NotificationPageResponse>(this as NotificationPageResponse, _$identity);

  /// Serializes this NotificationPageResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NotificationPageResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPageResponse&&const DeepCollectionEquality().equals(other.notifications, _this.notifications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NotificationPageResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.notifications));
}

@override
String toString() {
  final _this = this as NotificationPageResponse;
  return 'NotificationPageResponse(notifications: ${_this.notifications})';
}


}

/// @nodoc
abstract mixin class $NotificationPageResponseCopyWith<$Res>  {
  factory $NotificationPageResponseCopyWith(NotificationPageResponse value, $Res Function(NotificationPageResponse) _then) = _$NotificationPageResponseCopyWithImpl;
@useResult
$Res call({
 List<NotificationResponse> notifications
});




}
/// @nodoc
class _$NotificationPageResponseCopyWithImpl<$Res>
    implements $NotificationPageResponseCopyWith<$Res> {
  _$NotificationPageResponseCopyWithImpl(this._self, this._then);

  final NotificationPageResponse _self;
  final $Res Function(NotificationPageResponse) _then;

/// Create a copy of NotificationPageResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notifications = null,}) {
  return _then(NotificationPageResponse(
notifications: null == notifications ? _self.notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<NotificationResponse>,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPageResponse].
extension NotificationPageResponsePatterns on NotificationPageResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPageResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPageResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPageResponse value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPageResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPageResponse value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPageResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<NotificationResponse> notifications)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPageResponse() when $default != null:
return $default(_that.notifications);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<NotificationResponse> notifications)  $default,) {final _that = this;
switch (_that) {
case _NotificationPageResponse():
return $default(_that.notifications);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<NotificationResponse> notifications)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPageResponse() when $default != null:
return $default(_that.notifications);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationPageResponse implements NotificationPageResponse {
  const _NotificationPageResponse({ List<NotificationResponse> notifications = const []}): _notifications = notifications;
  factory _NotificationPageResponse.fromJson(Map<String, dynamic> json) => _$NotificationPageResponseFromJson(json);

 final  List<NotificationResponse> _notifications;
@override@JsonKey() List<NotificationResponse> get notifications {
  if (_notifications is EqualUnmodifiableListView) return _notifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notifications);
}


/// Create a copy of NotificationPageResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPageResponseCopyWith<_NotificationPageResponse> get copyWith => __$NotificationPageResponseCopyWithImpl<_NotificationPageResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationPageResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPageResponse&&const DeepCollectionEquality().equals(other.notifications, _notifications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_notifications));
}

@override
String toString() {
    return 'NotificationPageResponse(notifications: $notifications)';
}


}

/// @nodoc
abstract mixin class _$NotificationPageResponseCopyWith<$Res> implements $NotificationPageResponseCopyWith<$Res> {
  factory _$NotificationPageResponseCopyWith(_NotificationPageResponse value, $Res Function(_NotificationPageResponse) _then) = __$NotificationPageResponseCopyWithImpl;
@override @useResult
$Res call({
 List<NotificationResponse> notifications
});




}
/// @nodoc
class __$NotificationPageResponseCopyWithImpl<$Res>
    implements _$NotificationPageResponseCopyWith<$Res> {
  __$NotificationPageResponseCopyWithImpl(this._self, this._then);

  final _NotificationPageResponse _self;
  final $Res Function(_NotificationPageResponse) _then;

/// Create a copy of NotificationPageResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notifications = null,}) {
  return _then(_NotificationPageResponse(
notifications: null == notifications ? _self._notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<NotificationResponse>,
  ));
}


}

// dart format on
