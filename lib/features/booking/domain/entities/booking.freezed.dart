// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Booking {

 String get id; BookingStatus get status; String? get categoryId; String? get assignedWorkerId; num? get estimatedPrice; num? get finalPrice; String? get description; String? get addressDetail; DateTime? get scheduledTime; DateTime? get createdAt;
/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingCopyWith<Booking> get copyWith => _$BookingCopyWithImpl<Booking>(this as Booking, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Booking;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Booking&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.assignedWorkerId, _this.assignedWorkerId) || other.assignedWorkerId == _this.assignedWorkerId)&&(identical(other.estimatedPrice, _this.estimatedPrice) || other.estimatedPrice == _this.estimatedPrice)&&(identical(other.finalPrice, _this.finalPrice) || other.finalPrice == _this.finalPrice)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.addressDetail, _this.addressDetail) || other.addressDetail == _this.addressDetail)&&(identical(other.scheduledTime, _this.scheduledTime) || other.scheduledTime == _this.scheduledTime)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as Booking;
  return Object.hash(runtimeType,_this.id,_this.status,_this.categoryId,_this.assignedWorkerId,_this.estimatedPrice,_this.finalPrice,_this.description,_this.addressDetail,_this.scheduledTime,_this.createdAt);
}

@override
String toString() {
  final _this = this as Booking;
  return 'Booking(id: ${_this.id}, status: ${_this.status}, categoryId: ${_this.categoryId}, assignedWorkerId: ${_this.assignedWorkerId}, estimatedPrice: ${_this.estimatedPrice}, finalPrice: ${_this.finalPrice}, description: ${_this.description}, addressDetail: ${_this.addressDetail}, scheduledTime: ${_this.scheduledTime}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $BookingCopyWith<$Res>  {
  factory $BookingCopyWith(Booking value, $Res Function(Booking) _then) = _$BookingCopyWithImpl;
@useResult
$Res call({
 String id, BookingStatus status, String? categoryId, String? assignedWorkerId, num? estimatedPrice, num? finalPrice, String? description, String? addressDetail, DateTime? scheduledTime, DateTime? createdAt
});




}
/// @nodoc
class _$BookingCopyWithImpl<$Res>
    implements $BookingCopyWith<$Res> {
  _$BookingCopyWithImpl(this._self, this._then);

  final Booking _self;
  final $Res Function(Booking) _then;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? categoryId = freezed,Object? assignedWorkerId = freezed,Object? estimatedPrice = freezed,Object? finalPrice = freezed,Object? description = freezed,Object? addressDetail = freezed,Object? scheduledTime = freezed,Object? createdAt = freezed,}) {
  return _then(Booking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,assignedWorkerId: freezed == assignedWorkerId ? _self.assignedWorkerId : assignedWorkerId // ignore: cast_nullable_to_non_nullable
as String?,estimatedPrice: freezed == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as num?,finalPrice: freezed == finalPrice ? _self.finalPrice : finalPrice // ignore: cast_nullable_to_non_nullable
as num?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,addressDetail: freezed == addressDetail ? _self.addressDetail : addressDetail // ignore: cast_nullable_to_non_nullable
as String?,scheduledTime: freezed == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Booking].
extension BookingPatterns on Booking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Booking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Booking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Booking value)  $default,){
final _that = this;
switch (_that) {
case _Booking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Booking value)?  $default,){
final _that = this;
switch (_that) {
case _Booking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  BookingStatus status,  String? categoryId,  String? assignedWorkerId,  num? estimatedPrice,  num? finalPrice,  String? description,  String? addressDetail,  DateTime? scheduledTime,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that.id,_that.status,_that.categoryId,_that.assignedWorkerId,_that.estimatedPrice,_that.finalPrice,_that.description,_that.addressDetail,_that.scheduledTime,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  BookingStatus status,  String? categoryId,  String? assignedWorkerId,  num? estimatedPrice,  num? finalPrice,  String? description,  String? addressDetail,  DateTime? scheduledTime,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Booking():
return $default(_that.id,_that.status,_that.categoryId,_that.assignedWorkerId,_that.estimatedPrice,_that.finalPrice,_that.description,_that.addressDetail,_that.scheduledTime,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  BookingStatus status,  String? categoryId,  String? assignedWorkerId,  num? estimatedPrice,  num? finalPrice,  String? description,  String? addressDetail,  DateTime? scheduledTime,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that.id,_that.status,_that.categoryId,_that.assignedWorkerId,_that.estimatedPrice,_that.finalPrice,_that.description,_that.addressDetail,_that.scheduledTime,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _Booking implements Booking {
  const _Booking({required this.id, required this.status, this.categoryId, this.assignedWorkerId, this.estimatedPrice, this.finalPrice, this.description, this.addressDetail, this.scheduledTime, this.createdAt});
  

@override final  String id;
@override final  BookingStatus status;
@override final  String? categoryId;
@override final  String? assignedWorkerId;
@override final  num? estimatedPrice;
@override final  num? finalPrice;
@override final  String? description;
@override final  String? addressDetail;
@override final  DateTime? scheduledTime;
@override final  DateTime? createdAt;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingCopyWith<_Booking> get copyWith => __$BookingCopyWithImpl<_Booking>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Booking&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.assignedWorkerId, assignedWorkerId) || other.assignedWorkerId == assignedWorkerId)&&(identical(other.estimatedPrice, estimatedPrice) || other.estimatedPrice == estimatedPrice)&&(identical(other.finalPrice, finalPrice) || other.finalPrice == finalPrice)&&(identical(other.description, description) || other.description == description)&&(identical(other.addressDetail, addressDetail) || other.addressDetail == addressDetail)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,status,categoryId,assignedWorkerId,estimatedPrice,finalPrice,description,addressDetail,scheduledTime,createdAt);
}

@override
String toString() {
    return 'Booking(id: $id, status: $status, categoryId: $categoryId, assignedWorkerId: $assignedWorkerId, estimatedPrice: $estimatedPrice, finalPrice: $finalPrice, description: $description, addressDetail: $addressDetail, scheduledTime: $scheduledTime, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BookingCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$BookingCopyWith(_Booking value, $Res Function(_Booking) _then) = __$BookingCopyWithImpl;
@override @useResult
$Res call({
 String id, BookingStatus status, String? categoryId, String? assignedWorkerId, num? estimatedPrice, num? finalPrice, String? description, String? addressDetail, DateTime? scheduledTime, DateTime? createdAt
});




}
/// @nodoc
class __$BookingCopyWithImpl<$Res>
    implements _$BookingCopyWith<$Res> {
  __$BookingCopyWithImpl(this._self, this._then);

  final _Booking _self;
  final $Res Function(_Booking) _then;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? categoryId = freezed,Object? assignedWorkerId = freezed,Object? estimatedPrice = freezed,Object? finalPrice = freezed,Object? description = freezed,Object? addressDetail = freezed,Object? scheduledTime = freezed,Object? createdAt = freezed,}) {
  return _then(_Booking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,assignedWorkerId: freezed == assignedWorkerId ? _self.assignedWorkerId : assignedWorkerId // ignore: cast_nullable_to_non_nullable
as String?,estimatedPrice: freezed == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as num?,finalPrice: freezed == finalPrice ? _self.finalPrice : finalPrice // ignore: cast_nullable_to_non_nullable
as num?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,addressDetail: freezed == addressDetail ? _self.addressDetail : addressDetail // ignore: cast_nullable_to_non_nullable
as String?,scheduledTime: freezed == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
