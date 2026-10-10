// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_item_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuoteItemRequest {

 String get itemName;@MoneyConverter() num get amount; String? get receiptUrl;
/// Create a copy of QuoteItemRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteItemRequestCopyWith<QuoteItemRequest> get copyWith => _$QuoteItemRequestCopyWithImpl<QuoteItemRequest>(this as QuoteItemRequest, _$identity);

  /// Serializes this QuoteItemRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as QuoteItemRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteItemRequest&&(identical(other.itemName, _this.itemName) || other.itemName == _this.itemName)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.receiptUrl, _this.receiptUrl) || other.receiptUrl == _this.receiptUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as QuoteItemRequest;
  return Object.hash(runtimeType,_this.itemName,_this.amount,_this.receiptUrl);
}

@override
String toString() {
  final _this = this as QuoteItemRequest;
  return 'QuoteItemRequest(itemName: ${_this.itemName}, amount: ${_this.amount}, receiptUrl: ${_this.receiptUrl})';
}


}

/// @nodoc
abstract mixin class $QuoteItemRequestCopyWith<$Res>  {
  factory $QuoteItemRequestCopyWith(QuoteItemRequest value, $Res Function(QuoteItemRequest) _then) = _$QuoteItemRequestCopyWithImpl;
@useResult
$Res call({
 String itemName,@MoneyConverter() num amount, String? receiptUrl
});




}
/// @nodoc
class _$QuoteItemRequestCopyWithImpl<$Res>
    implements $QuoteItemRequestCopyWith<$Res> {
  _$QuoteItemRequestCopyWithImpl(this._self, this._then);

  final QuoteItemRequest _self;
  final $Res Function(QuoteItemRequest) _then;

/// Create a copy of QuoteItemRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? itemName = null,Object? amount = null,Object? receiptUrl = freezed,}) {
  return _then(QuoteItemRequest(
itemName: null == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,receiptUrl: freezed == receiptUrl ? _self.receiptUrl : receiptUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuoteItemRequest].
extension QuoteItemRequestPatterns on QuoteItemRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuoteItemRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuoteItemRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuoteItemRequest value)  $default,){
final _that = this;
switch (_that) {
case _QuoteItemRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuoteItemRequest value)?  $default,){
final _that = this;
switch (_that) {
case _QuoteItemRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String itemName, @MoneyConverter()  num amount,  String? receiptUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteItemRequest() when $default != null:
return $default(_that.itemName,_that.amount,_that.receiptUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String itemName, @MoneyConverter()  num amount,  String? receiptUrl)  $default,) {final _that = this;
switch (_that) {
case _QuoteItemRequest():
return $default(_that.itemName,_that.amount,_that.receiptUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String itemName, @MoneyConverter()  num amount,  String? receiptUrl)?  $default,) {final _that = this;
switch (_that) {
case _QuoteItemRequest() when $default != null:
return $default(_that.itemName,_that.amount,_that.receiptUrl);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _QuoteItemRequest implements QuoteItemRequest {
  const _QuoteItemRequest({required this.itemName, @MoneyConverter() required this.amount, this.receiptUrl});
  factory _QuoteItemRequest.fromJson(Map<String, dynamic> json) => _$QuoteItemRequestFromJson(json);

@override final  String itemName;
@override@MoneyConverter() final  num amount;
@override final  String? receiptUrl;

/// Create a copy of QuoteItemRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteItemRequestCopyWith<_QuoteItemRequest> get copyWith => __$QuoteItemRequestCopyWithImpl<_QuoteItemRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteItemRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteItemRequest&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.receiptUrl, receiptUrl) || other.receiptUrl == receiptUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,itemName,amount,receiptUrl);
}

@override
String toString() {
    return 'QuoteItemRequest(itemName: $itemName, amount: $amount, receiptUrl: $receiptUrl)';
}


}

/// @nodoc
abstract mixin class _$QuoteItemRequestCopyWith<$Res> implements $QuoteItemRequestCopyWith<$Res> {
  factory _$QuoteItemRequestCopyWith(_QuoteItemRequest value, $Res Function(_QuoteItemRequest) _then) = __$QuoteItemRequestCopyWithImpl;
@override @useResult
$Res call({
 String itemName,@MoneyConverter() num amount, String? receiptUrl
});




}
/// @nodoc
class __$QuoteItemRequestCopyWithImpl<$Res>
    implements _$QuoteItemRequestCopyWith<$Res> {
  __$QuoteItemRequestCopyWithImpl(this._self, this._then);

  final _QuoteItemRequest _self;
  final $Res Function(_QuoteItemRequest) _then;

/// Create a copy of QuoteItemRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? itemName = null,Object? amount = null,Object? receiptUrl = freezed,}) {
  return _then(_QuoteItemRequest(
itemName: null == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,receiptUrl: freezed == receiptUrl ? _self.receiptUrl : receiptUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
