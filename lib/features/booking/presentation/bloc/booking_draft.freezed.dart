// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingDraft {

 String get categoryId; ServiceCategory? get category; String get description; PriceEstimate? get estimate; String get address; GeoPoint? get location; DateTime? get scheduledTime; String get notes; Booking? get booking;
/// Create a copy of BookingDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingDraftCopyWith<BookingDraft> get copyWith => _$BookingDraftCopyWithImpl<BookingDraft>(this as BookingDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BookingDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDraft&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.estimate, _this.estimate) || other.estimate == _this.estimate)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.scheduledTime, _this.scheduledTime) || other.scheduledTime == _this.scheduledTime)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.booking, _this.booking) || other.booking == _this.booking));
}


@override
int get hashCode {
  final _this = this as BookingDraft;
  return Object.hash(runtimeType,_this.categoryId,_this.category,_this.description,_this.estimate,_this.address,_this.location,_this.scheduledTime,_this.notes,_this.booking);
}

@override
String toString() {
  final _this = this as BookingDraft;
  return 'BookingDraft(categoryId: ${_this.categoryId}, category: ${_this.category}, description: ${_this.description}, estimate: ${_this.estimate}, address: ${_this.address}, location: ${_this.location}, scheduledTime: ${_this.scheduledTime}, notes: ${_this.notes}, booking: ${_this.booking})';
}


}

/// @nodoc
abstract mixin class $BookingDraftCopyWith<$Res>  {
  factory $BookingDraftCopyWith(BookingDraft value, $Res Function(BookingDraft) _then) = _$BookingDraftCopyWithImpl;
@useResult
$Res call({
 String categoryId, ServiceCategory? category, String description, PriceEstimate? estimate, String address, GeoPoint? location, DateTime? scheduledTime, String notes, Booking? booking
});


$ServiceCategoryCopyWith<$Res>? get category;$PriceEstimateCopyWith<$Res>? get estimate;$BookingCopyWith<$Res>? get booking;

}
/// @nodoc
class _$BookingDraftCopyWithImpl<$Res>
    implements $BookingDraftCopyWith<$Res> {
  _$BookingDraftCopyWithImpl(this._self, this._then);

  final BookingDraft _self;
  final $Res Function(BookingDraft) _then;

/// Create a copy of BookingDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? category = freezed,Object? description = null,Object? estimate = freezed,Object? address = null,Object? location = freezed,Object? scheduledTime = freezed,Object? notes = null,Object? booking = freezed,}) {
  return _then(BookingDraft(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ServiceCategory?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,estimate: freezed == estimate ? _self.estimate : estimate // ignore: cast_nullable_to_non_nullable
as PriceEstimate?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint?,scheduledTime: freezed == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,booking: freezed == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as Booking?,
  ));
}
/// Create a copy of BookingDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceCategoryCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $ServiceCategoryCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}/// Create a copy of BookingDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceEstimateCopyWith<$Res>? get estimate {
    if (_self.estimate == null) {
    return null;
  }

  return $PriceEstimateCopyWith<$Res>(_self.estimate!, (value) {
    return _then(_self.copyWith(estimate: value));
  });
}/// Create a copy of BookingDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingCopyWith<$Res>? get booking {
    if (_self.booking == null) {
    return null;
  }

  return $BookingCopyWith<$Res>(_self.booking!, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookingDraft].
extension BookingDraftPatterns on BookingDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingDraft value)  $default,){
final _that = this;
switch (_that) {
case _BookingDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingDraft value)?  $default,){
final _that = this;
switch (_that) {
case _BookingDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String categoryId,  ServiceCategory? category,  String description,  PriceEstimate? estimate,  String address,  GeoPoint? location,  DateTime? scheduledTime,  String notes,  Booking? booking)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingDraft() when $default != null:
return $default(_that.categoryId,_that.category,_that.description,_that.estimate,_that.address,_that.location,_that.scheduledTime,_that.notes,_that.booking);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String categoryId,  ServiceCategory? category,  String description,  PriceEstimate? estimate,  String address,  GeoPoint? location,  DateTime? scheduledTime,  String notes,  Booking? booking)  $default,) {final _that = this;
switch (_that) {
case _BookingDraft():
return $default(_that.categoryId,_that.category,_that.description,_that.estimate,_that.address,_that.location,_that.scheduledTime,_that.notes,_that.booking);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String categoryId,  ServiceCategory? category,  String description,  PriceEstimate? estimate,  String address,  GeoPoint? location,  DateTime? scheduledTime,  String notes,  Booking? booking)?  $default,) {final _that = this;
switch (_that) {
case _BookingDraft() when $default != null:
return $default(_that.categoryId,_that.category,_that.description,_that.estimate,_that.address,_that.location,_that.scheduledTime,_that.notes,_that.booking);case _:
  return null;

}
}

}

/// @nodoc


class _BookingDraft extends BookingDraft {
  const _BookingDraft({this.categoryId = '', this.category, this.description = '', this.estimate, this.address = '', this.location, this.scheduledTime, this.notes = '', this.booking}): super._();
  

@override@JsonKey() final  String categoryId;
@override final  ServiceCategory? category;
@override@JsonKey() final  String description;
@override final  PriceEstimate? estimate;
@override@JsonKey() final  String address;
@override final  GeoPoint? location;
@override final  DateTime? scheduledTime;
@override@JsonKey() final  String notes;
@override final  Booking? booking;

/// Create a copy of BookingDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingDraftCopyWith<_BookingDraft> get copyWith => __$BookingDraftCopyWithImpl<_BookingDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingDraft&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.estimate, estimate) || other.estimate == estimate)&&(identical(other.address, address) || other.address == address)&&(identical(other.location, location) || other.location == location)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.booking, booking) || other.booking == booking));
}


@override
int get hashCode {
    return Object.hash(runtimeType,categoryId,category,description,estimate,address,location,scheduledTime,notes,booking);
}

@override
String toString() {
    return 'BookingDraft(categoryId: $categoryId, category: $category, description: $description, estimate: $estimate, address: $address, location: $location, scheduledTime: $scheduledTime, notes: $notes, booking: $booking)';
}


}

/// @nodoc
abstract mixin class _$BookingDraftCopyWith<$Res> implements $BookingDraftCopyWith<$Res> {
  factory _$BookingDraftCopyWith(_BookingDraft value, $Res Function(_BookingDraft) _then) = __$BookingDraftCopyWithImpl;
@override @useResult
$Res call({
 String categoryId, ServiceCategory? category, String description, PriceEstimate? estimate, String address, GeoPoint? location, DateTime? scheduledTime, String notes, Booking? booking
});


@override $ServiceCategoryCopyWith<$Res>? get category;@override $PriceEstimateCopyWith<$Res>? get estimate;@override $BookingCopyWith<$Res>? get booking;

}
/// @nodoc
class __$BookingDraftCopyWithImpl<$Res>
    implements _$BookingDraftCopyWith<$Res> {
  __$BookingDraftCopyWithImpl(this._self, this._then);

  final _BookingDraft _self;
  final $Res Function(_BookingDraft) _then;

/// Create a copy of BookingDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? category = freezed,Object? description = null,Object? estimate = freezed,Object? address = null,Object? location = freezed,Object? scheduledTime = freezed,Object? notes = null,Object? booking = freezed,}) {
  return _then(_BookingDraft(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ServiceCategory?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,estimate: freezed == estimate ? _self.estimate : estimate // ignore: cast_nullable_to_non_nullable
as PriceEstimate?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint?,scheduledTime: freezed == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,booking: freezed == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as Booking?,
  ));
}

/// Create a copy of BookingDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceCategoryCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $ServiceCategoryCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}/// Create a copy of BookingDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceEstimateCopyWith<$Res>? get estimate {
    if (_self.estimate == null) {
    return null;
  }

  return $PriceEstimateCopyWith<$Res>(_self.estimate!, (value) {
    return _then(_self.copyWith(estimate: value));
  });
}/// Create a copy of BookingDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingCopyWith<$Res>? get booking {
    if (_self.booking == null) {
    return null;
  }

  return $BookingCopyWith<$Res>(_self.booking!, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}

// dart format on
