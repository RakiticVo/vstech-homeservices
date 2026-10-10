// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'estimate_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EstimateResponse {

@MoneyConverter() num get estimatedPrice;@NullableIdConverter() String? get categoryId; String? get categoryName;@NullableMoneyConverter() num? get commissionFee;@NullableMoneyConverter() num? get totalEstimated;
/// Create a copy of EstimateResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstimateResponseCopyWith<EstimateResponse> get copyWith => _$EstimateResponseCopyWithImpl<EstimateResponse>(this as EstimateResponse, _$identity);

  /// Serializes this EstimateResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EstimateResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstimateResponse&&(identical(other.estimatedPrice, _this.estimatedPrice) || other.estimatedPrice == _this.estimatedPrice)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.categoryName, _this.categoryName) || other.categoryName == _this.categoryName)&&(identical(other.commissionFee, _this.commissionFee) || other.commissionFee == _this.commissionFee)&&(identical(other.totalEstimated, _this.totalEstimated) || other.totalEstimated == _this.totalEstimated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EstimateResponse;
  return Object.hash(runtimeType,_this.estimatedPrice,_this.categoryId,_this.categoryName,_this.commissionFee,_this.totalEstimated);
}

@override
String toString() {
  final _this = this as EstimateResponse;
  return 'EstimateResponse(estimatedPrice: ${_this.estimatedPrice}, categoryId: ${_this.categoryId}, categoryName: ${_this.categoryName}, commissionFee: ${_this.commissionFee}, totalEstimated: ${_this.totalEstimated})';
}


}

/// @nodoc
abstract mixin class $EstimateResponseCopyWith<$Res>  {
  factory $EstimateResponseCopyWith(EstimateResponse value, $Res Function(EstimateResponse) _then) = _$EstimateResponseCopyWithImpl;
@useResult
$Res call({
@MoneyConverter() num estimatedPrice,@NullableIdConverter() String? categoryId, String? categoryName,@NullableMoneyConverter() num? commissionFee,@NullableMoneyConverter() num? totalEstimated
});




}
/// @nodoc
class _$EstimateResponseCopyWithImpl<$Res>
    implements $EstimateResponseCopyWith<$Res> {
  _$EstimateResponseCopyWithImpl(this._self, this._then);

  final EstimateResponse _self;
  final $Res Function(EstimateResponse) _then;

/// Create a copy of EstimateResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? estimatedPrice = null,Object? categoryId = freezed,Object? categoryName = freezed,Object? commissionFee = freezed,Object? totalEstimated = freezed,}) {
  return _then(EstimateResponse(
estimatedPrice: null == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as num,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,commissionFee: freezed == commissionFee ? _self.commissionFee : commissionFee // ignore: cast_nullable_to_non_nullable
as num?,totalEstimated: freezed == totalEstimated ? _self.totalEstimated : totalEstimated // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [EstimateResponse].
extension EstimateResponsePatterns on EstimateResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstimateResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstimateResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstimateResponse value)  $default,){
final _that = this;
switch (_that) {
case _EstimateResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstimateResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EstimateResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@MoneyConverter()  num estimatedPrice, @NullableIdConverter()  String? categoryId,  String? categoryName, @NullableMoneyConverter()  num? commissionFee, @NullableMoneyConverter()  num? totalEstimated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstimateResponse() when $default != null:
return $default(_that.estimatedPrice,_that.categoryId,_that.categoryName,_that.commissionFee,_that.totalEstimated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@MoneyConverter()  num estimatedPrice, @NullableIdConverter()  String? categoryId,  String? categoryName, @NullableMoneyConverter()  num? commissionFee, @NullableMoneyConverter()  num? totalEstimated)  $default,) {final _that = this;
switch (_that) {
case _EstimateResponse():
return $default(_that.estimatedPrice,_that.categoryId,_that.categoryName,_that.commissionFee,_that.totalEstimated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@MoneyConverter()  num estimatedPrice, @NullableIdConverter()  String? categoryId,  String? categoryName, @NullableMoneyConverter()  num? commissionFee, @NullableMoneyConverter()  num? totalEstimated)?  $default,) {final _that = this;
switch (_that) {
case _EstimateResponse() when $default != null:
return $default(_that.estimatedPrice,_that.categoryId,_that.categoryName,_that.commissionFee,_that.totalEstimated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EstimateResponse implements EstimateResponse {
  const _EstimateResponse({@MoneyConverter() required this.estimatedPrice, @NullableIdConverter() this.categoryId, this.categoryName, @NullableMoneyConverter() this.commissionFee, @NullableMoneyConverter() this.totalEstimated});
  factory _EstimateResponse.fromJson(Map<String, dynamic> json) => _$EstimateResponseFromJson(json);

@override@MoneyConverter() final  num estimatedPrice;
@override@NullableIdConverter() final  String? categoryId;
@override final  String? categoryName;
@override@NullableMoneyConverter() final  num? commissionFee;
@override@NullableMoneyConverter() final  num? totalEstimated;

/// Create a copy of EstimateResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstimateResponseCopyWith<_EstimateResponse> get copyWith => __$EstimateResponseCopyWithImpl<_EstimateResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstimateResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstimateResponse&&(identical(other.estimatedPrice, estimatedPrice) || other.estimatedPrice == estimatedPrice)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.commissionFee, commissionFee) || other.commissionFee == commissionFee)&&(identical(other.totalEstimated, totalEstimated) || other.totalEstimated == totalEstimated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,estimatedPrice,categoryId,categoryName,commissionFee,totalEstimated);
}

@override
String toString() {
    return 'EstimateResponse(estimatedPrice: $estimatedPrice, categoryId: $categoryId, categoryName: $categoryName, commissionFee: $commissionFee, totalEstimated: $totalEstimated)';
}


}

/// @nodoc
abstract mixin class _$EstimateResponseCopyWith<$Res> implements $EstimateResponseCopyWith<$Res> {
  factory _$EstimateResponseCopyWith(_EstimateResponse value, $Res Function(_EstimateResponse) _then) = __$EstimateResponseCopyWithImpl;
@override @useResult
$Res call({
@MoneyConverter() num estimatedPrice,@NullableIdConverter() String? categoryId, String? categoryName,@NullableMoneyConverter() num? commissionFee,@NullableMoneyConverter() num? totalEstimated
});




}
/// @nodoc
class __$EstimateResponseCopyWithImpl<$Res>
    implements _$EstimateResponseCopyWith<$Res> {
  __$EstimateResponseCopyWithImpl(this._self, this._then);

  final _EstimateResponse _self;
  final $Res Function(_EstimateResponse) _then;

/// Create a copy of EstimateResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? estimatedPrice = null,Object? categoryId = freezed,Object? categoryName = freezed,Object? commissionFee = freezed,Object? totalEstimated = freezed,}) {
  return _then(_EstimateResponse(
estimatedPrice: null == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as num,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,commissionFee: freezed == commissionFee ? _self.commissionFee : commissionFee // ignore: cast_nullable_to_non_nullable
as num?,totalEstimated: freezed == totalEstimated ? _self.totalEstimated : totalEstimated // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

// dart format on
