// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_transaction_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WalletTransactionResponse {

@NullableIdConverter() String? get id;@NullableIdConverter() String? get transactionId; String? get type; String? get txType;@NullableMoneyConverter() num? get amount;@NullableMoneyConverter() num? get delta; String? get status; String? get description;@NullableIdConverter() String? get referenceRequestId;@NullableUtcDateTimeConverter() DateTime? get createdAt;
/// Create a copy of WalletTransactionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletTransactionResponseCopyWith<WalletTransactionResponse> get copyWith => _$WalletTransactionResponseCopyWithImpl<WalletTransactionResponse>(this as WalletTransactionResponse, _$identity);

  /// Serializes this WalletTransactionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WalletTransactionResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletTransactionResponse&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.transactionId, _this.transactionId) || other.transactionId == _this.transactionId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.txType, _this.txType) || other.txType == _this.txType)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.delta, _this.delta) || other.delta == _this.delta)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.referenceRequestId, _this.referenceRequestId) || other.referenceRequestId == _this.referenceRequestId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WalletTransactionResponse;
  return Object.hash(runtimeType,_this.id,_this.transactionId,_this.type,_this.txType,_this.amount,_this.delta,_this.status,_this.description,_this.referenceRequestId,_this.createdAt);
}

@override
String toString() {
  final _this = this as WalletTransactionResponse;
  return 'WalletTransactionResponse(id: ${_this.id}, transactionId: ${_this.transactionId}, type: ${_this.type}, txType: ${_this.txType}, amount: ${_this.amount}, delta: ${_this.delta}, status: ${_this.status}, description: ${_this.description}, referenceRequestId: ${_this.referenceRequestId}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $WalletTransactionResponseCopyWith<$Res>  {
  factory $WalletTransactionResponseCopyWith(WalletTransactionResponse value, $Res Function(WalletTransactionResponse) _then) = _$WalletTransactionResponseCopyWithImpl;
@useResult
$Res call({
@NullableIdConverter() String? id,@NullableIdConverter() String? transactionId, String? type, String? txType,@NullableMoneyConverter() num? amount,@NullableMoneyConverter() num? delta, String? status, String? description,@NullableIdConverter() String? referenceRequestId,@NullableUtcDateTimeConverter() DateTime? createdAt
});




}
/// @nodoc
class _$WalletTransactionResponseCopyWithImpl<$Res>
    implements $WalletTransactionResponseCopyWith<$Res> {
  _$WalletTransactionResponseCopyWithImpl(this._self, this._then);

  final WalletTransactionResponse _self;
  final $Res Function(WalletTransactionResponse) _then;

/// Create a copy of WalletTransactionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? transactionId = freezed,Object? type = freezed,Object? txType = freezed,Object? amount = freezed,Object? delta = freezed,Object? status = freezed,Object? description = freezed,Object? referenceRequestId = freezed,Object? createdAt = freezed,}) {
  return _then(WalletTransactionResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,txType: freezed == txType ? _self.txType : txType // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num?,delta: freezed == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as num?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,referenceRequestId: freezed == referenceRequestId ? _self.referenceRequestId : referenceRequestId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletTransactionResponse].
extension WalletTransactionResponsePatterns on WalletTransactionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletTransactionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletTransactionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletTransactionResponse value)  $default,){
final _that = this;
switch (_that) {
case _WalletTransactionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletTransactionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _WalletTransactionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@NullableIdConverter()  String? id, @NullableIdConverter()  String? transactionId,  String? type,  String? txType, @NullableMoneyConverter()  num? amount, @NullableMoneyConverter()  num? delta,  String? status,  String? description, @NullableIdConverter()  String? referenceRequestId, @NullableUtcDateTimeConverter()  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletTransactionResponse() when $default != null:
return $default(_that.id,_that.transactionId,_that.type,_that.txType,_that.amount,_that.delta,_that.status,_that.description,_that.referenceRequestId,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@NullableIdConverter()  String? id, @NullableIdConverter()  String? transactionId,  String? type,  String? txType, @NullableMoneyConverter()  num? amount, @NullableMoneyConverter()  num? delta,  String? status,  String? description, @NullableIdConverter()  String? referenceRequestId, @NullableUtcDateTimeConverter()  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _WalletTransactionResponse():
return $default(_that.id,_that.transactionId,_that.type,_that.txType,_that.amount,_that.delta,_that.status,_that.description,_that.referenceRequestId,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@NullableIdConverter()  String? id, @NullableIdConverter()  String? transactionId,  String? type,  String? txType, @NullableMoneyConverter()  num? amount, @NullableMoneyConverter()  num? delta,  String? status,  String? description, @NullableIdConverter()  String? referenceRequestId, @NullableUtcDateTimeConverter()  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _WalletTransactionResponse() when $default != null:
return $default(_that.id,_that.transactionId,_that.type,_that.txType,_that.amount,_that.delta,_that.status,_that.description,_that.referenceRequestId,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletTransactionResponse extends WalletTransactionResponse {
  const _WalletTransactionResponse({@NullableIdConverter() this.id, @NullableIdConverter() this.transactionId, this.type, this.txType, @NullableMoneyConverter() this.amount, @NullableMoneyConverter() this.delta, this.status, this.description, @NullableIdConverter() this.referenceRequestId, @NullableUtcDateTimeConverter() this.createdAt}): super._();
  factory _WalletTransactionResponse.fromJson(Map<String, dynamic> json) => _$WalletTransactionResponseFromJson(json);

@override@NullableIdConverter() final  String? id;
@override@NullableIdConverter() final  String? transactionId;
@override final  String? type;
@override final  String? txType;
@override@NullableMoneyConverter() final  num? amount;
@override@NullableMoneyConverter() final  num? delta;
@override final  String? status;
@override final  String? description;
@override@NullableIdConverter() final  String? referenceRequestId;
@override@NullableUtcDateTimeConverter() final  DateTime? createdAt;

/// Create a copy of WalletTransactionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletTransactionResponseCopyWith<_WalletTransactionResponse> get copyWith => __$WalletTransactionResponseCopyWithImpl<_WalletTransactionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletTransactionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletTransactionResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.type, type) || other.type == type)&&(identical(other.txType, txType) || other.txType == txType)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.delta, delta) || other.delta == delta)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&(identical(other.referenceRequestId, referenceRequestId) || other.referenceRequestId == referenceRequestId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,transactionId,type,txType,amount,delta,status,description,referenceRequestId,createdAt);
}

@override
String toString() {
    return 'WalletTransactionResponse(id: $id, transactionId: $transactionId, type: $type, txType: $txType, amount: $amount, delta: $delta, status: $status, description: $description, referenceRequestId: $referenceRequestId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WalletTransactionResponseCopyWith<$Res> implements $WalletTransactionResponseCopyWith<$Res> {
  factory _$WalletTransactionResponseCopyWith(_WalletTransactionResponse value, $Res Function(_WalletTransactionResponse) _then) = __$WalletTransactionResponseCopyWithImpl;
@override @useResult
$Res call({
@NullableIdConverter() String? id,@NullableIdConverter() String? transactionId, String? type, String? txType,@NullableMoneyConverter() num? amount,@NullableMoneyConverter() num? delta, String? status, String? description,@NullableIdConverter() String? referenceRequestId,@NullableUtcDateTimeConverter() DateTime? createdAt
});




}
/// @nodoc
class __$WalletTransactionResponseCopyWithImpl<$Res>
    implements _$WalletTransactionResponseCopyWith<$Res> {
  __$WalletTransactionResponseCopyWithImpl(this._self, this._then);

  final _WalletTransactionResponse _self;
  final $Res Function(_WalletTransactionResponse) _then;

/// Create a copy of WalletTransactionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? transactionId = freezed,Object? type = freezed,Object? txType = freezed,Object? amount = freezed,Object? delta = freezed,Object? status = freezed,Object? description = freezed,Object? referenceRequestId = freezed,Object? createdAt = freezed,}) {
  return _then(_WalletTransactionResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,txType: freezed == txType ? _self.txType : txType // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num?,delta: freezed == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as num?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,referenceRequestId: freezed == referenceRequestId ? _self.referenceRequestId : referenceRequestId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
