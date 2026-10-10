// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WalletResponse {

@NullableIdConverter() String? get walletId;@NullableIdConverter() String? get ownerId;@NullableMoneyConverter() num? get balance;@NullableMoneyConverter() num? get frozenBalance; String? get currency; String? get walletType;@NullableUtcDateTimeConverter() DateTime? get createdAt;
/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletResponseCopyWith<WalletResponse> get copyWith => _$WalletResponseCopyWithImpl<WalletResponse>(this as WalletResponse, _$identity);

  /// Serializes this WalletResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WalletResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletResponse&&(identical(other.walletId, _this.walletId) || other.walletId == _this.walletId)&&(identical(other.ownerId, _this.ownerId) || other.ownerId == _this.ownerId)&&(identical(other.balance, _this.balance) || other.balance == _this.balance)&&(identical(other.frozenBalance, _this.frozenBalance) || other.frozenBalance == _this.frozenBalance)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.walletType, _this.walletType) || other.walletType == _this.walletType)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WalletResponse;
  return Object.hash(runtimeType,_this.walletId,_this.ownerId,_this.balance,_this.frozenBalance,_this.currency,_this.walletType,_this.createdAt);
}

@override
String toString() {
  final _this = this as WalletResponse;
  return 'WalletResponse(walletId: ${_this.walletId}, ownerId: ${_this.ownerId}, balance: ${_this.balance}, frozenBalance: ${_this.frozenBalance}, currency: ${_this.currency}, walletType: ${_this.walletType}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $WalletResponseCopyWith<$Res>  {
  factory $WalletResponseCopyWith(WalletResponse value, $Res Function(WalletResponse) _then) = _$WalletResponseCopyWithImpl;
@useResult
$Res call({
@NullableIdConverter() String? walletId,@NullableIdConverter() String? ownerId,@NullableMoneyConverter() num? balance,@NullableMoneyConverter() num? frozenBalance, String? currency, String? walletType,@NullableUtcDateTimeConverter() DateTime? createdAt
});




}
/// @nodoc
class _$WalletResponseCopyWithImpl<$Res>
    implements $WalletResponseCopyWith<$Res> {
  _$WalletResponseCopyWithImpl(this._self, this._then);

  final WalletResponse _self;
  final $Res Function(WalletResponse) _then;

/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? walletId = freezed,Object? ownerId = freezed,Object? balance = freezed,Object? frozenBalance = freezed,Object? currency = freezed,Object? walletType = freezed,Object? createdAt = freezed,}) {
  return _then(WalletResponse(
walletId: freezed == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String?,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,balance: freezed == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as num?,frozenBalance: freezed == frozenBalance ? _self.frozenBalance : frozenBalance // ignore: cast_nullable_to_non_nullable
as num?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,walletType: freezed == walletType ? _self.walletType : walletType // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletResponse].
extension WalletResponsePatterns on WalletResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletResponse value)  $default,){
final _that = this;
switch (_that) {
case _WalletResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletResponse value)?  $default,){
final _that = this;
switch (_that) {
case _WalletResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@NullableIdConverter()  String? walletId, @NullableIdConverter()  String? ownerId, @NullableMoneyConverter()  num? balance, @NullableMoneyConverter()  num? frozenBalance,  String? currency,  String? walletType, @NullableUtcDateTimeConverter()  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletResponse() when $default != null:
return $default(_that.walletId,_that.ownerId,_that.balance,_that.frozenBalance,_that.currency,_that.walletType,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@NullableIdConverter()  String? walletId, @NullableIdConverter()  String? ownerId, @NullableMoneyConverter()  num? balance, @NullableMoneyConverter()  num? frozenBalance,  String? currency,  String? walletType, @NullableUtcDateTimeConverter()  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _WalletResponse():
return $default(_that.walletId,_that.ownerId,_that.balance,_that.frozenBalance,_that.currency,_that.walletType,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@NullableIdConverter()  String? walletId, @NullableIdConverter()  String? ownerId, @NullableMoneyConverter()  num? balance, @NullableMoneyConverter()  num? frozenBalance,  String? currency,  String? walletType, @NullableUtcDateTimeConverter()  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _WalletResponse() when $default != null:
return $default(_that.walletId,_that.ownerId,_that.balance,_that.frozenBalance,_that.currency,_that.walletType,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletResponse implements WalletResponse {
  const _WalletResponse({@NullableIdConverter() this.walletId, @NullableIdConverter() this.ownerId, @NullableMoneyConverter() this.balance, @NullableMoneyConverter() this.frozenBalance, this.currency, this.walletType, @NullableUtcDateTimeConverter() this.createdAt});
  factory _WalletResponse.fromJson(Map<String, dynamic> json) => _$WalletResponseFromJson(json);

@override@NullableIdConverter() final  String? walletId;
@override@NullableIdConverter() final  String? ownerId;
@override@NullableMoneyConverter() final  num? balance;
@override@NullableMoneyConverter() final  num? frozenBalance;
@override final  String? currency;
@override final  String? walletType;
@override@NullableUtcDateTimeConverter() final  DateTime? createdAt;

/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletResponseCopyWith<_WalletResponse> get copyWith => __$WalletResponseCopyWithImpl<_WalletResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletResponse&&(identical(other.walletId, walletId) || other.walletId == walletId)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.frozenBalance, frozenBalance) || other.frozenBalance == frozenBalance)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.walletType, walletType) || other.walletType == walletType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,walletId,ownerId,balance,frozenBalance,currency,walletType,createdAt);
}

@override
String toString() {
    return 'WalletResponse(walletId: $walletId, ownerId: $ownerId, balance: $balance, frozenBalance: $frozenBalance, currency: $currency, walletType: $walletType, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WalletResponseCopyWith<$Res> implements $WalletResponseCopyWith<$Res> {
  factory _$WalletResponseCopyWith(_WalletResponse value, $Res Function(_WalletResponse) _then) = __$WalletResponseCopyWithImpl;
@override @useResult
$Res call({
@NullableIdConverter() String? walletId,@NullableIdConverter() String? ownerId,@NullableMoneyConverter() num? balance,@NullableMoneyConverter() num? frozenBalance, String? currency, String? walletType,@NullableUtcDateTimeConverter() DateTime? createdAt
});




}
/// @nodoc
class __$WalletResponseCopyWithImpl<$Res>
    implements _$WalletResponseCopyWith<$Res> {
  __$WalletResponseCopyWithImpl(this._self, this._then);

  final _WalletResponse _self;
  final $Res Function(_WalletResponse) _then;

/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? walletId = freezed,Object? ownerId = freezed,Object? balance = freezed,Object? frozenBalance = freezed,Object? currency = freezed,Object? walletType = freezed,Object? createdAt = freezed,}) {
  return _then(_WalletResponse(
walletId: freezed == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String?,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,balance: freezed == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as num?,frozenBalance: freezed == frozenBalance ? _self.frozenBalance : frozenBalance // ignore: cast_nullable_to_non_nullable
as num?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,walletType: freezed == walletType ? _self.walletType : walletType // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
