// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_estimate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PriceEstimate {

 num get estimatedPrice; num get commissionFee; num get totalEstimated; String? get categoryName;
/// Create a copy of PriceEstimate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriceEstimateCopyWith<PriceEstimate> get copyWith => _$PriceEstimateCopyWithImpl<PriceEstimate>(this as PriceEstimate, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PriceEstimate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceEstimate&&(identical(other.estimatedPrice, _this.estimatedPrice) || other.estimatedPrice == _this.estimatedPrice)&&(identical(other.commissionFee, _this.commissionFee) || other.commissionFee == _this.commissionFee)&&(identical(other.totalEstimated, _this.totalEstimated) || other.totalEstimated == _this.totalEstimated)&&(identical(other.categoryName, _this.categoryName) || other.categoryName == _this.categoryName));
}


@override
int get hashCode {
  final _this = this as PriceEstimate;
  return Object.hash(runtimeType,_this.estimatedPrice,_this.commissionFee,_this.totalEstimated,_this.categoryName);
}

@override
String toString() {
  final _this = this as PriceEstimate;
  return 'PriceEstimate(estimatedPrice: ${_this.estimatedPrice}, commissionFee: ${_this.commissionFee}, totalEstimated: ${_this.totalEstimated}, categoryName: ${_this.categoryName})';
}


}

/// @nodoc
abstract mixin class $PriceEstimateCopyWith<$Res>  {
  factory $PriceEstimateCopyWith(PriceEstimate value, $Res Function(PriceEstimate) _then) = _$PriceEstimateCopyWithImpl;
@useResult
$Res call({
 num estimatedPrice, num commissionFee, num totalEstimated, String? categoryName
});




}
/// @nodoc
class _$PriceEstimateCopyWithImpl<$Res>
    implements $PriceEstimateCopyWith<$Res> {
  _$PriceEstimateCopyWithImpl(this._self, this._then);

  final PriceEstimate _self;
  final $Res Function(PriceEstimate) _then;

/// Create a copy of PriceEstimate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? estimatedPrice = null,Object? commissionFee = null,Object? totalEstimated = null,Object? categoryName = freezed,}) {
  return _then(PriceEstimate(
estimatedPrice: null == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as num,commissionFee: null == commissionFee ? _self.commissionFee : commissionFee // ignore: cast_nullable_to_non_nullable
as num,totalEstimated: null == totalEstimated ? _self.totalEstimated : totalEstimated // ignore: cast_nullable_to_non_nullable
as num,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PriceEstimate].
extension PriceEstimatePatterns on PriceEstimate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PriceEstimate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PriceEstimate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PriceEstimate value)  $default,){
final _that = this;
switch (_that) {
case _PriceEstimate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PriceEstimate value)?  $default,){
final _that = this;
switch (_that) {
case _PriceEstimate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num estimatedPrice,  num commissionFee,  num totalEstimated,  String? categoryName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PriceEstimate() when $default != null:
return $default(_that.estimatedPrice,_that.commissionFee,_that.totalEstimated,_that.categoryName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num estimatedPrice,  num commissionFee,  num totalEstimated,  String? categoryName)  $default,) {final _that = this;
switch (_that) {
case _PriceEstimate():
return $default(_that.estimatedPrice,_that.commissionFee,_that.totalEstimated,_that.categoryName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num estimatedPrice,  num commissionFee,  num totalEstimated,  String? categoryName)?  $default,) {final _that = this;
switch (_that) {
case _PriceEstimate() when $default != null:
return $default(_that.estimatedPrice,_that.commissionFee,_that.totalEstimated,_that.categoryName);case _:
  return null;

}
}

}

/// @nodoc


class _PriceEstimate implements PriceEstimate {
  const _PriceEstimate({required this.estimatedPrice, required this.commissionFee, required this.totalEstimated, this.categoryName});
  

@override final  num estimatedPrice;
@override final  num commissionFee;
@override final  num totalEstimated;
@override final  String? categoryName;

/// Create a copy of PriceEstimate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PriceEstimateCopyWith<_PriceEstimate> get copyWith => __$PriceEstimateCopyWithImpl<_PriceEstimate>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PriceEstimate&&(identical(other.estimatedPrice, estimatedPrice) || other.estimatedPrice == estimatedPrice)&&(identical(other.commissionFee, commissionFee) || other.commissionFee == commissionFee)&&(identical(other.totalEstimated, totalEstimated) || other.totalEstimated == totalEstimated)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName));
}


@override
int get hashCode {
    return Object.hash(runtimeType,estimatedPrice,commissionFee,totalEstimated,categoryName);
}

@override
String toString() {
    return 'PriceEstimate(estimatedPrice: $estimatedPrice, commissionFee: $commissionFee, totalEstimated: $totalEstimated, categoryName: $categoryName)';
}


}

/// @nodoc
abstract mixin class _$PriceEstimateCopyWith<$Res> implements $PriceEstimateCopyWith<$Res> {
  factory _$PriceEstimateCopyWith(_PriceEstimate value, $Res Function(_PriceEstimate) _then) = __$PriceEstimateCopyWithImpl;
@override @useResult
$Res call({
 num estimatedPrice, num commissionFee, num totalEstimated, String? categoryName
});




}
/// @nodoc
class __$PriceEstimateCopyWithImpl<$Res>
    implements _$PriceEstimateCopyWith<$Res> {
  __$PriceEstimateCopyWithImpl(this._self, this._then);

  final _PriceEstimate _self;
  final $Res Function(_PriceEstimate) _then;

/// Create a copy of PriceEstimate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? estimatedPrice = null,Object? commissionFee = null,Object? totalEstimated = null,Object? categoryName = freezed,}) {
  return _then(_PriceEstimate(
estimatedPrice: null == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as num,commissionFee: null == commissionFee ? _self.commissionFee : commissionFee // ignore: cast_nullable_to_non_nullable
as num,totalEstimated: null == totalEstimated ? _self.totalEstimated : totalEstimated // ignore: cast_nullable_to_non_nullable
as num,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
