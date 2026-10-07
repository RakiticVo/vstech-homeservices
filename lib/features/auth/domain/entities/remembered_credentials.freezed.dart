// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remembered_credentials.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RememberedCredentials {

 String get identifier; String get password;
/// Create a copy of RememberedCredentials
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RememberedCredentialsCopyWith<RememberedCredentials> get copyWith => _$RememberedCredentialsCopyWithImpl<RememberedCredentials>(this as RememberedCredentials, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RememberedCredentials;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RememberedCredentials&&(identical(other.identifier, _this.identifier) || other.identifier == _this.identifier)&&(identical(other.password, _this.password) || other.password == _this.password));
}


@override
int get hashCode {
  final _this = this as RememberedCredentials;
  return Object.hash(runtimeType,_this.identifier,_this.password);
}

@override
String toString() {
  final _this = this as RememberedCredentials;
  return 'RememberedCredentials(identifier: ${_this.identifier}, password: ${_this.password})';
}


}

/// @nodoc
abstract mixin class $RememberedCredentialsCopyWith<$Res>  {
  factory $RememberedCredentialsCopyWith(RememberedCredentials value, $Res Function(RememberedCredentials) _then) = _$RememberedCredentialsCopyWithImpl;
@useResult
$Res call({
 String identifier, String password
});




}
/// @nodoc
class _$RememberedCredentialsCopyWithImpl<$Res>
    implements $RememberedCredentialsCopyWith<$Res> {
  _$RememberedCredentialsCopyWithImpl(this._self, this._then);

  final RememberedCredentials _self;
  final $Res Function(RememberedCredentials) _then;

/// Create a copy of RememberedCredentials
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? identifier = null,Object? password = null,}) {
  return _then(RememberedCredentials(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RememberedCredentials].
extension RememberedCredentialsPatterns on RememberedCredentials {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RememberedCredentials value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RememberedCredentials() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RememberedCredentials value)  $default,){
final _that = this;
switch (_that) {
case _RememberedCredentials():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RememberedCredentials value)?  $default,){
final _that = this;
switch (_that) {
case _RememberedCredentials() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String identifier,  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RememberedCredentials() when $default != null:
return $default(_that.identifier,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String identifier,  String password)  $default,) {final _that = this;
switch (_that) {
case _RememberedCredentials():
return $default(_that.identifier,_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String identifier,  String password)?  $default,) {final _that = this;
switch (_that) {
case _RememberedCredentials() when $default != null:
return $default(_that.identifier,_that.password);case _:
  return null;

}
}

}

/// @nodoc


class _RememberedCredentials implements RememberedCredentials {
  const _RememberedCredentials({required this.identifier, required this.password});
  

@override final  String identifier;
@override final  String password;

/// Create a copy of RememberedCredentials
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RememberedCredentialsCopyWith<_RememberedCredentials> get copyWith => __$RememberedCredentialsCopyWithImpl<_RememberedCredentials>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RememberedCredentials&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode {
    return Object.hash(runtimeType,identifier,password);
}

@override
String toString() {
    return 'RememberedCredentials(identifier: $identifier, password: $password)';
}


}

/// @nodoc
abstract mixin class _$RememberedCredentialsCopyWith<$Res> implements $RememberedCredentialsCopyWith<$Res> {
  factory _$RememberedCredentialsCopyWith(_RememberedCredentials value, $Res Function(_RememberedCredentials) _then) = __$RememberedCredentialsCopyWithImpl;
@override @useResult
$Res call({
 String identifier, String password
});




}
/// @nodoc
class __$RememberedCredentialsCopyWithImpl<$Res>
    implements _$RememberedCredentialsCopyWith<$Res> {
  __$RememberedCredentialsCopyWithImpl(this._self, this._then);

  final _RememberedCredentials _self;
  final $Res Function(_RememberedCredentials) _then;

/// Create a copy of RememberedCredentials
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? identifier = null,Object? password = null,}) {
  return _then(_RememberedCredentials(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
