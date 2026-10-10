// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'withdrawal_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WithdrawalRequestBody {

@MoneyConverter() num get amount; String get bankCode; String get bankAccountNumber;
/// Create a copy of WithdrawalRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WithdrawalRequestBodyCopyWith<WithdrawalRequestBody> get copyWith => _$WithdrawalRequestBodyCopyWithImpl<WithdrawalRequestBody>(this as WithdrawalRequestBody, _$identity);

  /// Serializes this WithdrawalRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WithdrawalRequestBody;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WithdrawalRequestBody&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.bankCode, _this.bankCode) || other.bankCode == _this.bankCode)&&(identical(other.bankAccountNumber, _this.bankAccountNumber) || other.bankAccountNumber == _this.bankAccountNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WithdrawalRequestBody;
  return Object.hash(runtimeType,_this.amount,_this.bankCode,_this.bankAccountNumber);
}

@override
String toString() {
  final _this = this as WithdrawalRequestBody;
  return 'WithdrawalRequestBody(amount: ${_this.amount}, bankCode: ${_this.bankCode}, bankAccountNumber: ${_this.bankAccountNumber})';
}


}

/// @nodoc
abstract mixin class $WithdrawalRequestBodyCopyWith<$Res>  {
  factory $WithdrawalRequestBodyCopyWith(WithdrawalRequestBody value, $Res Function(WithdrawalRequestBody) _then) = _$WithdrawalRequestBodyCopyWithImpl;
@useResult
$Res call({
@MoneyConverter() num amount, String bankCode, String bankAccountNumber
});




}
/// @nodoc
class _$WithdrawalRequestBodyCopyWithImpl<$Res>
    implements $WithdrawalRequestBodyCopyWith<$Res> {
  _$WithdrawalRequestBodyCopyWithImpl(this._self, this._then);

  final WithdrawalRequestBody _self;
  final $Res Function(WithdrawalRequestBody) _then;

/// Create a copy of WithdrawalRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? bankCode = null,Object? bankAccountNumber = null,}) {
  return _then(WithdrawalRequestBody(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,bankCode: null == bankCode ? _self.bankCode : bankCode // ignore: cast_nullable_to_non_nullable
as String,bankAccountNumber: null == bankAccountNumber ? _self.bankAccountNumber : bankAccountNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WithdrawalRequestBody].
extension WithdrawalRequestBodyPatterns on WithdrawalRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WithdrawalRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WithdrawalRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WithdrawalRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _WithdrawalRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WithdrawalRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _WithdrawalRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@MoneyConverter()  num amount,  String bankCode,  String bankAccountNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WithdrawalRequestBody() when $default != null:
return $default(_that.amount,_that.bankCode,_that.bankAccountNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@MoneyConverter()  num amount,  String bankCode,  String bankAccountNumber)  $default,) {final _that = this;
switch (_that) {
case _WithdrawalRequestBody():
return $default(_that.amount,_that.bankCode,_that.bankAccountNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@MoneyConverter()  num amount,  String bankCode,  String bankAccountNumber)?  $default,) {final _that = this;
switch (_that) {
case _WithdrawalRequestBody() when $default != null:
return $default(_that.amount,_that.bankCode,_that.bankAccountNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WithdrawalRequestBody implements WithdrawalRequestBody {
  const _WithdrawalRequestBody({@MoneyConverter() required this.amount, required this.bankCode, required this.bankAccountNumber});
  factory _WithdrawalRequestBody.fromJson(Map<String, dynamic> json) => _$WithdrawalRequestBodyFromJson(json);

@override@MoneyConverter() final  num amount;
@override final  String bankCode;
@override final  String bankAccountNumber;

/// Create a copy of WithdrawalRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WithdrawalRequestBodyCopyWith<_WithdrawalRequestBody> get copyWith => __$WithdrawalRequestBodyCopyWithImpl<_WithdrawalRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WithdrawalRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WithdrawalRequestBody&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.bankCode, bankCode) || other.bankCode == bankCode)&&(identical(other.bankAccountNumber, bankAccountNumber) || other.bankAccountNumber == bankAccountNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,amount,bankCode,bankAccountNumber);
}

@override
String toString() {
    return 'WithdrawalRequestBody(amount: $amount, bankCode: $bankCode, bankAccountNumber: $bankAccountNumber)';
}


}

/// @nodoc
abstract mixin class _$WithdrawalRequestBodyCopyWith<$Res> implements $WithdrawalRequestBodyCopyWith<$Res> {
  factory _$WithdrawalRequestBodyCopyWith(_WithdrawalRequestBody value, $Res Function(_WithdrawalRequestBody) _then) = __$WithdrawalRequestBodyCopyWithImpl;
@override @useResult
$Res call({
@MoneyConverter() num amount, String bankCode, String bankAccountNumber
});




}
/// @nodoc
class __$WithdrawalRequestBodyCopyWithImpl<$Res>
    implements _$WithdrawalRequestBodyCopyWith<$Res> {
  __$WithdrawalRequestBodyCopyWithImpl(this._self, this._then);

  final _WithdrawalRequestBody _self;
  final $Res Function(_WithdrawalRequestBody) _then;

/// Create a copy of WithdrawalRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? bankCode = null,Object? bankAccountNumber = null,}) {
  return _then(_WithdrawalRequestBody(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,bankCode: null == bankCode ? _self.bankCode : bankCode // ignore: cast_nullable_to_non_nullable
as String,bankAccountNumber: null == bankAccountNumber ? _self.bankAccountNumber : bankAccountNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
