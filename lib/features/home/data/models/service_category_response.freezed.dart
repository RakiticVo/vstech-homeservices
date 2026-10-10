// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_category_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceCategoryResponse {

@IdConverter() String get id; String get name; String? get description;@NullableMoneyConverter() num? get basePrice;@NullableMoneyConverter() num? get commissionRate; bool? get isActive; String? get imageUrl;
/// Create a copy of ServiceCategoryResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceCategoryResponseCopyWith<ServiceCategoryResponse> get copyWith => _$ServiceCategoryResponseCopyWithImpl<ServiceCategoryResponse>(this as ServiceCategoryResponse, _$identity);

  /// Serializes this ServiceCategoryResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ServiceCategoryResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceCategoryResponse&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.basePrice, _this.basePrice) || other.basePrice == _this.basePrice)&&(identical(other.commissionRate, _this.commissionRate) || other.commissionRate == _this.commissionRate)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ServiceCategoryResponse;
  return Object.hash(runtimeType,_this.id,_this.name,_this.description,_this.basePrice,_this.commissionRate,_this.isActive,_this.imageUrl);
}

@override
String toString() {
  final _this = this as ServiceCategoryResponse;
  return 'ServiceCategoryResponse(id: ${_this.id}, name: ${_this.name}, description: ${_this.description}, basePrice: ${_this.basePrice}, commissionRate: ${_this.commissionRate}, isActive: ${_this.isActive}, imageUrl: ${_this.imageUrl})';
}


}

/// @nodoc
abstract mixin class $ServiceCategoryResponseCopyWith<$Res>  {
  factory $ServiceCategoryResponseCopyWith(ServiceCategoryResponse value, $Res Function(ServiceCategoryResponse) _then) = _$ServiceCategoryResponseCopyWithImpl;
@useResult
$Res call({
@IdConverter() String id, String name, String? description,@NullableMoneyConverter() num? basePrice,@NullableMoneyConverter() num? commissionRate, bool? isActive, String? imageUrl
});




}
/// @nodoc
class _$ServiceCategoryResponseCopyWithImpl<$Res>
    implements $ServiceCategoryResponseCopyWith<$Res> {
  _$ServiceCategoryResponseCopyWithImpl(this._self, this._then);

  final ServiceCategoryResponse _self;
  final $Res Function(ServiceCategoryResponse) _then;

/// Create a copy of ServiceCategoryResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? basePrice = freezed,Object? commissionRate = freezed,Object? isActive = freezed,Object? imageUrl = freezed,}) {
  return _then(ServiceCategoryResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,basePrice: freezed == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as num?,commissionRate: freezed == commissionRate ? _self.commissionRate : commissionRate // ignore: cast_nullable_to_non_nullable
as num?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceCategoryResponse].
extension ServiceCategoryResponsePatterns on ServiceCategoryResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceCategoryResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceCategoryResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceCategoryResponse value)  $default,){
final _that = this;
switch (_that) {
case _ServiceCategoryResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceCategoryResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceCategoryResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdConverter()  String id,  String name,  String? description, @NullableMoneyConverter()  num? basePrice, @NullableMoneyConverter()  num? commissionRate,  bool? isActive,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceCategoryResponse() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.basePrice,_that.commissionRate,_that.isActive,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdConverter()  String id,  String name,  String? description, @NullableMoneyConverter()  num? basePrice, @NullableMoneyConverter()  num? commissionRate,  bool? isActive,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _ServiceCategoryResponse():
return $default(_that.id,_that.name,_that.description,_that.basePrice,_that.commissionRate,_that.isActive,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdConverter()  String id,  String name,  String? description, @NullableMoneyConverter()  num? basePrice, @NullableMoneyConverter()  num? commissionRate,  bool? isActive,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _ServiceCategoryResponse() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.basePrice,_that.commissionRate,_that.isActive,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceCategoryResponse implements ServiceCategoryResponse {
  const _ServiceCategoryResponse({@IdConverter() required this.id, required this.name, this.description, @NullableMoneyConverter() this.basePrice, @NullableMoneyConverter() this.commissionRate, this.isActive, this.imageUrl});
  factory _ServiceCategoryResponse.fromJson(Map<String, dynamic> json) => _$ServiceCategoryResponseFromJson(json);

@override@IdConverter() final  String id;
@override final  String name;
@override final  String? description;
@override@NullableMoneyConverter() final  num? basePrice;
@override@NullableMoneyConverter() final  num? commissionRate;
@override final  bool? isActive;
@override final  String? imageUrl;

/// Create a copy of ServiceCategoryResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceCategoryResponseCopyWith<_ServiceCategoryResponse> get copyWith => __$ServiceCategoryResponseCopyWithImpl<_ServiceCategoryResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceCategoryResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceCategoryResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.commissionRate, commissionRate) || other.commissionRate == commissionRate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,description,basePrice,commissionRate,isActive,imageUrl);
}

@override
String toString() {
    return 'ServiceCategoryResponse(id: $id, name: $name, description: $description, basePrice: $basePrice, commissionRate: $commissionRate, isActive: $isActive, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$ServiceCategoryResponseCopyWith<$Res> implements $ServiceCategoryResponseCopyWith<$Res> {
  factory _$ServiceCategoryResponseCopyWith(_ServiceCategoryResponse value, $Res Function(_ServiceCategoryResponse) _then) = __$ServiceCategoryResponseCopyWithImpl;
@override @useResult
$Res call({
@IdConverter() String id, String name, String? description,@NullableMoneyConverter() num? basePrice,@NullableMoneyConverter() num? commissionRate, bool? isActive, String? imageUrl
});




}
/// @nodoc
class __$ServiceCategoryResponseCopyWithImpl<$Res>
    implements _$ServiceCategoryResponseCopyWith<$Res> {
  __$ServiceCategoryResponseCopyWithImpl(this._self, this._then);

  final _ServiceCategoryResponse _self;
  final $Res Function(_ServiceCategoryResponse) _then;

/// Create a copy of ServiceCategoryResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? basePrice = freezed,Object? commissionRate = freezed,Object? isActive = freezed,Object? imageUrl = freezed,}) {
  return _then(_ServiceCategoryResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,basePrice: freezed == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as num?,commissionRate: freezed == commissionRate ? _self.commissionRate : commissionRate // ignore: cast_nullable_to_non_nullable
as num?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
