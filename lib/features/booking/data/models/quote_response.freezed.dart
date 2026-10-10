// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuoteResponse {

 String? get status;@NullableMoneyConverter() num? get totalAmount;
/// Create a copy of QuoteResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteResponseCopyWith<QuoteResponse> get copyWith => _$QuoteResponseCopyWithImpl<QuoteResponse>(this as QuoteResponse, _$identity);

  /// Serializes this QuoteResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as QuoteResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteResponse&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.totalAmount, _this.totalAmount) || other.totalAmount == _this.totalAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as QuoteResponse;
  return Object.hash(runtimeType,_this.status,_this.totalAmount);
}

@override
String toString() {
  final _this = this as QuoteResponse;
  return 'QuoteResponse(status: ${_this.status}, totalAmount: ${_this.totalAmount})';
}


}

/// @nodoc
abstract mixin class $QuoteResponseCopyWith<$Res>  {
  factory $QuoteResponseCopyWith(QuoteResponse value, $Res Function(QuoteResponse) _then) = _$QuoteResponseCopyWithImpl;
@useResult
$Res call({
 String? status,@NullableMoneyConverter() num? totalAmount
});




}
/// @nodoc
class _$QuoteResponseCopyWithImpl<$Res>
    implements $QuoteResponseCopyWith<$Res> {
  _$QuoteResponseCopyWithImpl(this._self, this._then);

  final QuoteResponse _self;
  final $Res Function(QuoteResponse) _then;

/// Create a copy of QuoteResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? totalAmount = freezed,}) {
  return _then(QuoteResponse(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuoteResponse].
extension QuoteResponsePatterns on QuoteResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuoteResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuoteResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuoteResponse value)  $default,){
final _that = this;
switch (_that) {
case _QuoteResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuoteResponse value)?  $default,){
final _that = this;
switch (_that) {
case _QuoteResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? status, @NullableMoneyConverter()  num? totalAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteResponse() when $default != null:
return $default(_that.status,_that.totalAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? status, @NullableMoneyConverter()  num? totalAmount)  $default,) {final _that = this;
switch (_that) {
case _QuoteResponse():
return $default(_that.status,_that.totalAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? status, @NullableMoneyConverter()  num? totalAmount)?  $default,) {final _that = this;
switch (_that) {
case _QuoteResponse() when $default != null:
return $default(_that.status,_that.totalAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuoteResponse implements QuoteResponse {
  const _QuoteResponse({this.status, @NullableMoneyConverter() this.totalAmount});
  factory _QuoteResponse.fromJson(Map<String, dynamic> json) => _$QuoteResponseFromJson(json);

@override final  String? status;
@override@NullableMoneyConverter() final  num? totalAmount;

/// Create a copy of QuoteResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteResponseCopyWith<_QuoteResponse> get copyWith => __$QuoteResponseCopyWithImpl<_QuoteResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,totalAmount);
}

@override
String toString() {
    return 'QuoteResponse(status: $status, totalAmount: $totalAmount)';
}


}

/// @nodoc
abstract mixin class _$QuoteResponseCopyWith<$Res> implements $QuoteResponseCopyWith<$Res> {
  factory _$QuoteResponseCopyWith(_QuoteResponse value, $Res Function(_QuoteResponse) _then) = __$QuoteResponseCopyWithImpl;
@override @useResult
$Res call({
 String? status,@NullableMoneyConverter() num? totalAmount
});




}
/// @nodoc
class __$QuoteResponseCopyWithImpl<$Res>
    implements _$QuoteResponseCopyWith<$Res> {
  __$QuoteResponseCopyWithImpl(this._self, this._then);

  final _QuoteResponse _self;
  final $Res Function(_QuoteResponse) _then;

/// Create a copy of QuoteResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? totalAmount = freezed,}) {
  return _then(_QuoteResponse(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

// dart format on
