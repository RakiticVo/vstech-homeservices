// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'estimate_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EstimateRequest {

@IdConverter() String get categoryId; String get description;
/// Create a copy of EstimateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstimateRequestCopyWith<EstimateRequest> get copyWith => _$EstimateRequestCopyWithImpl<EstimateRequest>(this as EstimateRequest, _$identity);

  /// Serializes this EstimateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EstimateRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstimateRequest&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.description, _this.description) || other.description == _this.description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EstimateRequest;
  return Object.hash(runtimeType,_this.categoryId,_this.description);
}

@override
String toString() {
  final _this = this as EstimateRequest;
  return 'EstimateRequest(categoryId: ${_this.categoryId}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $EstimateRequestCopyWith<$Res>  {
  factory $EstimateRequestCopyWith(EstimateRequest value, $Res Function(EstimateRequest) _then) = _$EstimateRequestCopyWithImpl;
@useResult
$Res call({
@IdConverter() String categoryId, String description
});




}
/// @nodoc
class _$EstimateRequestCopyWithImpl<$Res>
    implements $EstimateRequestCopyWith<$Res> {
  _$EstimateRequestCopyWithImpl(this._self, this._then);

  final EstimateRequest _self;
  final $Res Function(EstimateRequest) _then;

/// Create a copy of EstimateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? description = null,}) {
  return _then(EstimateRequest(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EstimateRequest].
extension EstimateRequestPatterns on EstimateRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstimateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstimateRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstimateRequest value)  $default,){
final _that = this;
switch (_that) {
case _EstimateRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstimateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _EstimateRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdConverter()  String categoryId,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstimateRequest() when $default != null:
return $default(_that.categoryId,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdConverter()  String categoryId,  String description)  $default,) {final _that = this;
switch (_that) {
case _EstimateRequest():
return $default(_that.categoryId,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdConverter()  String categoryId,  String description)?  $default,) {final _that = this;
switch (_that) {
case _EstimateRequest() when $default != null:
return $default(_that.categoryId,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EstimateRequest implements EstimateRequest {
  const _EstimateRequest({@IdConverter() required this.categoryId, required this.description});
  factory _EstimateRequest.fromJson(Map<String, dynamic> json) => _$EstimateRequestFromJson(json);

@override@IdConverter() final  String categoryId;
@override final  String description;

/// Create a copy of EstimateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstimateRequestCopyWith<_EstimateRequest> get copyWith => __$EstimateRequestCopyWithImpl<_EstimateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstimateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstimateRequest&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,categoryId,description);
}

@override
String toString() {
    return 'EstimateRequest(categoryId: $categoryId, description: $description)';
}


}

/// @nodoc
abstract mixin class _$EstimateRequestCopyWith<$Res> implements $EstimateRequestCopyWith<$Res> {
  factory _$EstimateRequestCopyWith(_EstimateRequest value, $Res Function(_EstimateRequest) _then) = __$EstimateRequestCopyWithImpl;
@override @useResult
$Res call({
@IdConverter() String categoryId, String description
});




}
/// @nodoc
class __$EstimateRequestCopyWithImpl<$Res>
    implements _$EstimateRequestCopyWith<$Res> {
  __$EstimateRequestCopyWithImpl(this._self, this._then);

  final _EstimateRequest _self;
  final $Res Function(_EstimateRequest) _then;

/// Create a copy of EstimateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? description = null,}) {
  return _then(_EstimateRequest(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
