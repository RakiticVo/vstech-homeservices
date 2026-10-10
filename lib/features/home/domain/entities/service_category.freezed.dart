// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServiceCategory {

 String get id; String get name; String? get description; num? get basePrice; String? get imageUrl;
/// Create a copy of ServiceCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceCategoryCopyWith<ServiceCategory> get copyWith => _$ServiceCategoryCopyWithImpl<ServiceCategory>(this as ServiceCategory, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ServiceCategory;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceCategory&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.basePrice, _this.basePrice) || other.basePrice == _this.basePrice)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl));
}


@override
int get hashCode {
  final _this = this as ServiceCategory;
  return Object.hash(runtimeType,_this.id,_this.name,_this.description,_this.basePrice,_this.imageUrl);
}

@override
String toString() {
  final _this = this as ServiceCategory;
  return 'ServiceCategory(id: ${_this.id}, name: ${_this.name}, description: ${_this.description}, basePrice: ${_this.basePrice}, imageUrl: ${_this.imageUrl})';
}


}

/// @nodoc
abstract mixin class $ServiceCategoryCopyWith<$Res>  {
  factory $ServiceCategoryCopyWith(ServiceCategory value, $Res Function(ServiceCategory) _then) = _$ServiceCategoryCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, num? basePrice, String? imageUrl
});




}
/// @nodoc
class _$ServiceCategoryCopyWithImpl<$Res>
    implements $ServiceCategoryCopyWith<$Res> {
  _$ServiceCategoryCopyWithImpl(this._self, this._then);

  final ServiceCategory _self;
  final $Res Function(ServiceCategory) _then;

/// Create a copy of ServiceCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? basePrice = freezed,Object? imageUrl = freezed,}) {
  return _then(ServiceCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,basePrice: freezed == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as num?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceCategory].
extension ServiceCategoryPatterns on ServiceCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceCategory value)  $default,){
final _that = this;
switch (_that) {
case _ServiceCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceCategory value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  num? basePrice,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceCategory() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.basePrice,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  num? basePrice,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _ServiceCategory():
return $default(_that.id,_that.name,_that.description,_that.basePrice,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  num? basePrice,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _ServiceCategory() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.basePrice,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc


class _ServiceCategory implements ServiceCategory {
  const _ServiceCategory({required this.id, required this.name, this.description, this.basePrice, this.imageUrl});
  

@override final  String id;
@override final  String name;
@override final  String? description;
@override final  num? basePrice;
@override final  String? imageUrl;

/// Create a copy of ServiceCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceCategoryCopyWith<_ServiceCategory> get copyWith => __$ServiceCategoryCopyWithImpl<_ServiceCategory>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,description,basePrice,imageUrl);
}

@override
String toString() {
    return 'ServiceCategory(id: $id, name: $name, description: $description, basePrice: $basePrice, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$ServiceCategoryCopyWith<$Res> implements $ServiceCategoryCopyWith<$Res> {
  factory _$ServiceCategoryCopyWith(_ServiceCategory value, $Res Function(_ServiceCategory) _then) = __$ServiceCategoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, num? basePrice, String? imageUrl
});




}
/// @nodoc
class __$ServiceCategoryCopyWithImpl<$Res>
    implements _$ServiceCategoryCopyWith<$Res> {
  __$ServiceCategoryCopyWithImpl(this._self, this._then);

  final _ServiceCategory _self;
  final $Res Function(_ServiceCategory) _then;

/// Create a copy of ServiceCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? basePrice = freezed,Object? imageUrl = freezed,}) {
  return _then(_ServiceCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,basePrice: freezed == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as num?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
