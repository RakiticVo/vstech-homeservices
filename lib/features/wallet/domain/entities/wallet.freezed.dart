// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Wallet {

 num get balance; num get frozenBalance; String get currency;
/// Create a copy of Wallet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletCopyWith<Wallet> get copyWith => _$WalletCopyWithImpl<Wallet>(this as Wallet, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Wallet;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Wallet&&(identical(other.balance, _this.balance) || other.balance == _this.balance)&&(identical(other.frozenBalance, _this.frozenBalance) || other.frozenBalance == _this.frozenBalance)&&(identical(other.currency, _this.currency) || other.currency == _this.currency));
}


@override
int get hashCode {
  final _this = this as Wallet;
  return Object.hash(runtimeType,_this.balance,_this.frozenBalance,_this.currency);
}

@override
String toString() {
  final _this = this as Wallet;
  return 'Wallet(balance: ${_this.balance}, frozenBalance: ${_this.frozenBalance}, currency: ${_this.currency})';
}


}

/// @nodoc
abstract mixin class $WalletCopyWith<$Res>  {
  factory $WalletCopyWith(Wallet value, $Res Function(Wallet) _then) = _$WalletCopyWithImpl;
@useResult
$Res call({
 num balance, num frozenBalance, String currency
});




}
/// @nodoc
class _$WalletCopyWithImpl<$Res>
    implements $WalletCopyWith<$Res> {
  _$WalletCopyWithImpl(this._self, this._then);

  final Wallet _self;
  final $Res Function(Wallet) _then;

/// Create a copy of Wallet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? balance = null,Object? frozenBalance = null,Object? currency = null,}) {
  return _then(Wallet(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as num,frozenBalance: null == frozenBalance ? _self.frozenBalance : frozenBalance // ignore: cast_nullable_to_non_nullable
as num,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Wallet].
extension WalletPatterns on Wallet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Wallet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Wallet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Wallet value)  $default,){
final _that = this;
switch (_that) {
case _Wallet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Wallet value)?  $default,){
final _that = this;
switch (_that) {
case _Wallet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num balance,  num frozenBalance,  String currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Wallet() when $default != null:
return $default(_that.balance,_that.frozenBalance,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num balance,  num frozenBalance,  String currency)  $default,) {final _that = this;
switch (_that) {
case _Wallet():
return $default(_that.balance,_that.frozenBalance,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num balance,  num frozenBalance,  String currency)?  $default,) {final _that = this;
switch (_that) {
case _Wallet() when $default != null:
return $default(_that.balance,_that.frozenBalance,_that.currency);case _:
  return null;

}
}

}

/// @nodoc


class _Wallet implements Wallet {
  const _Wallet({required this.balance, this.frozenBalance = 0, this.currency = 'VND'});
  

@override final  num balance;
@override@JsonKey() final  num frozenBalance;
@override@JsonKey() final  String currency;

/// Create a copy of Wallet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletCopyWith<_Wallet> get copyWith => __$WalletCopyWithImpl<_Wallet>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Wallet&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.frozenBalance, frozenBalance) || other.frozenBalance == frozenBalance)&&(identical(other.currency, currency) || other.currency == currency));
}


@override
int get hashCode {
    return Object.hash(runtimeType,balance,frozenBalance,currency);
}

@override
String toString() {
    return 'Wallet(balance: $balance, frozenBalance: $frozenBalance, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$WalletCopyWith<$Res> implements $WalletCopyWith<$Res> {
  factory _$WalletCopyWith(_Wallet value, $Res Function(_Wallet) _then) = __$WalletCopyWithImpl;
@override @useResult
$Res call({
 num balance, num frozenBalance, String currency
});




}
/// @nodoc
class __$WalletCopyWithImpl<$Res>
    implements _$WalletCopyWith<$Res> {
  __$WalletCopyWithImpl(this._self, this._then);

  final _Wallet _self;
  final $Res Function(_Wallet) _then;

/// Create a copy of Wallet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? balance = null,Object? frozenBalance = null,Object? currency = null,}) {
  return _then(_Wallet(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as num,frozenBalance: null == frozenBalance ? _self.frozenBalance : frozenBalance // ignore: cast_nullable_to_non_nullable
as num,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$WalletTransaction {

 String get id; TransactionType get type; TransactionStatus get status; num get amount; num get delta; String? get description; String? get referenceRequestId; DateTime? get createdAt;
/// Create a copy of WalletTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletTransactionCopyWith<WalletTransaction> get copyWith => _$WalletTransactionCopyWithImpl<WalletTransaction>(this as WalletTransaction, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as WalletTransaction;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletTransaction&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.delta, _this.delta) || other.delta == _this.delta)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.referenceRequestId, _this.referenceRequestId) || other.referenceRequestId == _this.referenceRequestId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as WalletTransaction;
  return Object.hash(runtimeType,_this.id,_this.type,_this.status,_this.amount,_this.delta,_this.description,_this.referenceRequestId,_this.createdAt);
}

@override
String toString() {
  final _this = this as WalletTransaction;
  return 'WalletTransaction(id: ${_this.id}, type: ${_this.type}, status: ${_this.status}, amount: ${_this.amount}, delta: ${_this.delta}, description: ${_this.description}, referenceRequestId: ${_this.referenceRequestId}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $WalletTransactionCopyWith<$Res>  {
  factory $WalletTransactionCopyWith(WalletTransaction value, $Res Function(WalletTransaction) _then) = _$WalletTransactionCopyWithImpl;
@useResult
$Res call({
 String id, TransactionType type, TransactionStatus status, num amount, num delta, String? description, String? referenceRequestId, DateTime? createdAt
});




}
/// @nodoc
class _$WalletTransactionCopyWithImpl<$Res>
    implements $WalletTransactionCopyWith<$Res> {
  _$WalletTransactionCopyWithImpl(this._self, this._then);

  final WalletTransaction _self;
  final $Res Function(WalletTransaction) _then;

/// Create a copy of WalletTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? status = null,Object? amount = null,Object? delta = null,Object? description = freezed,Object? referenceRequestId = freezed,Object? createdAt = freezed,}) {
  return _then(WalletTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionStatus,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as num,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,referenceRequestId: freezed == referenceRequestId ? _self.referenceRequestId : referenceRequestId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletTransaction].
extension WalletTransactionPatterns on WalletTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletTransaction value)  $default,){
final _that = this;
switch (_that) {
case _WalletTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _WalletTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  TransactionType type,  TransactionStatus status,  num amount,  num delta,  String? description,  String? referenceRequestId,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletTransaction() when $default != null:
return $default(_that.id,_that.type,_that.status,_that.amount,_that.delta,_that.description,_that.referenceRequestId,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  TransactionType type,  TransactionStatus status,  num amount,  num delta,  String? description,  String? referenceRequestId,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _WalletTransaction():
return $default(_that.id,_that.type,_that.status,_that.amount,_that.delta,_that.description,_that.referenceRequestId,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  TransactionType type,  TransactionStatus status,  num amount,  num delta,  String? description,  String? referenceRequestId,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _WalletTransaction() when $default != null:
return $default(_that.id,_that.type,_that.status,_that.amount,_that.delta,_that.description,_that.referenceRequestId,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _WalletTransaction implements WalletTransaction {
  const _WalletTransaction({required this.id, required this.type, required this.status, required this.amount, required this.delta, this.description, this.referenceRequestId, this.createdAt});
  

@override final  String id;
@override final  TransactionType type;
@override final  TransactionStatus status;
@override final  num amount;
@override final  num delta;
@override final  String? description;
@override final  String? referenceRequestId;
@override final  DateTime? createdAt;

/// Create a copy of WalletTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletTransactionCopyWith<_WalletTransaction> get copyWith => __$WalletTransactionCopyWithImpl<_WalletTransaction>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.delta, delta) || other.delta == delta)&&(identical(other.description, description) || other.description == description)&&(identical(other.referenceRequestId, referenceRequestId) || other.referenceRequestId == referenceRequestId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,type,status,amount,delta,description,referenceRequestId,createdAt);
}

@override
String toString() {
    return 'WalletTransaction(id: $id, type: $type, status: $status, amount: $amount, delta: $delta, description: $description, referenceRequestId: $referenceRequestId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WalletTransactionCopyWith<$Res> implements $WalletTransactionCopyWith<$Res> {
  factory _$WalletTransactionCopyWith(_WalletTransaction value, $Res Function(_WalletTransaction) _then) = __$WalletTransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, TransactionType type, TransactionStatus status, num amount, num delta, String? description, String? referenceRequestId, DateTime? createdAt
});




}
/// @nodoc
class __$WalletTransactionCopyWithImpl<$Res>
    implements _$WalletTransactionCopyWith<$Res> {
  __$WalletTransactionCopyWithImpl(this._self, this._then);

  final _WalletTransaction _self;
  final $Res Function(_WalletTransaction) _then;

/// Create a copy of WalletTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? status = null,Object? amount = null,Object? delta = null,Object? description = freezed,Object? referenceRequestId = freezed,Object? createdAt = freezed,}) {
  return _then(_WalletTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionStatus,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as num,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,referenceRequestId: freezed == referenceRequestId ? _self.referenceRequestId : referenceRequestId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$Withdrawal {

 String get id; num get amount; WithdrawalStatus get status; String? get bankCode; String? get bankAccountNumber; String? get reason; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of Withdrawal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WithdrawalCopyWith<Withdrawal> get copyWith => _$WithdrawalCopyWithImpl<Withdrawal>(this as Withdrawal, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Withdrawal;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Withdrawal&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.bankCode, _this.bankCode) || other.bankCode == _this.bankCode)&&(identical(other.bankAccountNumber, _this.bankAccountNumber) || other.bankAccountNumber == _this.bankAccountNumber)&&(identical(other.reason, _this.reason) || other.reason == _this.reason)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as Withdrawal;
  return Object.hash(runtimeType,_this.id,_this.amount,_this.status,_this.bankCode,_this.bankAccountNumber,_this.reason,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Withdrawal;
  return 'Withdrawal(id: ${_this.id}, amount: ${_this.amount}, status: ${_this.status}, bankCode: ${_this.bankCode}, bankAccountNumber: ${_this.bankAccountNumber}, reason: ${_this.reason}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $WithdrawalCopyWith<$Res>  {
  factory $WithdrawalCopyWith(Withdrawal value, $Res Function(Withdrawal) _then) = _$WithdrawalCopyWithImpl;
@useResult
$Res call({
 String id, num amount, WithdrawalStatus status, String? bankCode, String? bankAccountNumber, String? reason, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$WithdrawalCopyWithImpl<$Res>
    implements $WithdrawalCopyWith<$Res> {
  _$WithdrawalCopyWithImpl(this._self, this._then);

  final Withdrawal _self;
  final $Res Function(Withdrawal) _then;

/// Create a copy of Withdrawal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = null,Object? status = null,Object? bankCode = freezed,Object? bankAccountNumber = freezed,Object? reason = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(Withdrawal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as WithdrawalStatus,bankCode: freezed == bankCode ? _self.bankCode : bankCode // ignore: cast_nullable_to_non_nullable
as String?,bankAccountNumber: freezed == bankAccountNumber ? _self.bankAccountNumber : bankAccountNumber // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Withdrawal].
extension WithdrawalPatterns on Withdrawal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Withdrawal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Withdrawal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Withdrawal value)  $default,){
final _that = this;
switch (_that) {
case _Withdrawal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Withdrawal value)?  $default,){
final _that = this;
switch (_that) {
case _Withdrawal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  num amount,  WithdrawalStatus status,  String? bankCode,  String? bankAccountNumber,  String? reason,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Withdrawal() when $default != null:
return $default(_that.id,_that.amount,_that.status,_that.bankCode,_that.bankAccountNumber,_that.reason,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  num amount,  WithdrawalStatus status,  String? bankCode,  String? bankAccountNumber,  String? reason,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Withdrawal():
return $default(_that.id,_that.amount,_that.status,_that.bankCode,_that.bankAccountNumber,_that.reason,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  num amount,  WithdrawalStatus status,  String? bankCode,  String? bankAccountNumber,  String? reason,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Withdrawal() when $default != null:
return $default(_that.id,_that.amount,_that.status,_that.bankCode,_that.bankAccountNumber,_that.reason,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Withdrawal implements Withdrawal {
  const _Withdrawal({required this.id, required this.amount, required this.status, this.bankCode, this.bankAccountNumber, this.reason, this.createdAt, this.updatedAt});
  

@override final  String id;
@override final  num amount;
@override final  WithdrawalStatus status;
@override final  String? bankCode;
@override final  String? bankAccountNumber;
@override final  String? reason;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of Withdrawal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WithdrawalCopyWith<_Withdrawal> get copyWith => __$WithdrawalCopyWithImpl<_Withdrawal>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Withdrawal&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.bankCode, bankCode) || other.bankCode == bankCode)&&(identical(other.bankAccountNumber, bankAccountNumber) || other.bankAccountNumber == bankAccountNumber)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,amount,status,bankCode,bankAccountNumber,reason,createdAt,updatedAt);
}

@override
String toString() {
    return 'Withdrawal(id: $id, amount: $amount, status: $status, bankCode: $bankCode, bankAccountNumber: $bankAccountNumber, reason: $reason, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$WithdrawalCopyWith<$Res> implements $WithdrawalCopyWith<$Res> {
  factory _$WithdrawalCopyWith(_Withdrawal value, $Res Function(_Withdrawal) _then) = __$WithdrawalCopyWithImpl;
@override @useResult
$Res call({
 String id, num amount, WithdrawalStatus status, String? bankCode, String? bankAccountNumber, String? reason, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$WithdrawalCopyWithImpl<$Res>
    implements _$WithdrawalCopyWith<$Res> {
  __$WithdrawalCopyWithImpl(this._self, this._then);

  final _Withdrawal _self;
  final $Res Function(_Withdrawal) _then;

/// Create a copy of Withdrawal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = null,Object? status = null,Object? bankCode = freezed,Object? bankAccountNumber = freezed,Object? reason = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Withdrawal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as WithdrawalStatus,bankCode: freezed == bankCode ? _self.bankCode : bankCode // ignore: cast_nullable_to_non_nullable
as String?,bankAccountNumber: freezed == bankAccountNumber ? _self.bankAccountNumber : bankAccountNumber // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
