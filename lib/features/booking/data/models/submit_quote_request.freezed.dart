// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'submit_quote_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubmitQuoteRequest {

 List<QuoteItemRequest> get items; List<String> get evidencePhotoUrls;
/// Create a copy of SubmitQuoteRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmitQuoteRequestCopyWith<SubmitQuoteRequest> get copyWith => _$SubmitQuoteRequestCopyWithImpl<SubmitQuoteRequest>(this as SubmitQuoteRequest, _$identity);

  /// Serializes this SubmitQuoteRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SubmitQuoteRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitQuoteRequest&&const DeepCollectionEquality().equals(other.items, _this.items)&&const DeepCollectionEquality().equals(other.evidencePhotoUrls, _this.evidencePhotoUrls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubmitQuoteRequest;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),const DeepCollectionEquality().hash(_this.evidencePhotoUrls));
}

@override
String toString() {
  final _this = this as SubmitQuoteRequest;
  return 'SubmitQuoteRequest(items: ${_this.items}, evidencePhotoUrls: ${_this.evidencePhotoUrls})';
}


}

/// @nodoc
abstract mixin class $SubmitQuoteRequestCopyWith<$Res>  {
  factory $SubmitQuoteRequestCopyWith(SubmitQuoteRequest value, $Res Function(SubmitQuoteRequest) _then) = _$SubmitQuoteRequestCopyWithImpl;
@useResult
$Res call({
 List<QuoteItemRequest> items, List<String> evidencePhotoUrls
});




}
/// @nodoc
class _$SubmitQuoteRequestCopyWithImpl<$Res>
    implements $SubmitQuoteRequestCopyWith<$Res> {
  _$SubmitQuoteRequestCopyWithImpl(this._self, this._then);

  final SubmitQuoteRequest _self;
  final $Res Function(SubmitQuoteRequest) _then;

/// Create a copy of SubmitQuoteRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? evidencePhotoUrls = null,}) {
  return _then(SubmitQuoteRequest(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<QuoteItemRequest>,evidencePhotoUrls: null == evidencePhotoUrls ? _self.evidencePhotoUrls : evidencePhotoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SubmitQuoteRequest].
extension SubmitQuoteRequestPatterns on SubmitQuoteRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubmitQuoteRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubmitQuoteRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubmitQuoteRequest value)  $default,){
final _that = this;
switch (_that) {
case _SubmitQuoteRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubmitQuoteRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SubmitQuoteRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<QuoteItemRequest> items,  List<String> evidencePhotoUrls)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubmitQuoteRequest() when $default != null:
return $default(_that.items,_that.evidencePhotoUrls);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<QuoteItemRequest> items,  List<String> evidencePhotoUrls)  $default,) {final _that = this;
switch (_that) {
case _SubmitQuoteRequest():
return $default(_that.items,_that.evidencePhotoUrls);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<QuoteItemRequest> items,  List<String> evidencePhotoUrls)?  $default,) {final _that = this;
switch (_that) {
case _SubmitQuoteRequest() when $default != null:
return $default(_that.items,_that.evidencePhotoUrls);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SubmitQuoteRequest implements SubmitQuoteRequest {
  const _SubmitQuoteRequest({required  List<QuoteItemRequest> items,  List<String> evidencePhotoUrls = const <String>[]}): _items = items,_evidencePhotoUrls = evidencePhotoUrls;
  factory _SubmitQuoteRequest.fromJson(Map<String, dynamic> json) => _$SubmitQuoteRequestFromJson(json);

 final  List<QuoteItemRequest> _items;
@override List<QuoteItemRequest> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  List<String> _evidencePhotoUrls;
@override@JsonKey() List<String> get evidencePhotoUrls {
  if (_evidencePhotoUrls is EqualUnmodifiableListView) return _evidencePhotoUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_evidencePhotoUrls);
}


/// Create a copy of SubmitQuoteRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitQuoteRequestCopyWith<_SubmitQuoteRequest> get copyWith => __$SubmitQuoteRequestCopyWithImpl<_SubmitQuoteRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubmitQuoteRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitQuoteRequest&&const DeepCollectionEquality().equals(other.items, _items)&&const DeepCollectionEquality().equals(other.evidencePhotoUrls, _evidencePhotoUrls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_evidencePhotoUrls));
}

@override
String toString() {
    return 'SubmitQuoteRequest(items: $items, evidencePhotoUrls: $evidencePhotoUrls)';
}


}

/// @nodoc
abstract mixin class _$SubmitQuoteRequestCopyWith<$Res> implements $SubmitQuoteRequestCopyWith<$Res> {
  factory _$SubmitQuoteRequestCopyWith(_SubmitQuoteRequest value, $Res Function(_SubmitQuoteRequest) _then) = __$SubmitQuoteRequestCopyWithImpl;
@override @useResult
$Res call({
 List<QuoteItemRequest> items, List<String> evidencePhotoUrls
});




}
/// @nodoc
class __$SubmitQuoteRequestCopyWithImpl<$Res>
    implements _$SubmitQuoteRequestCopyWith<$Res> {
  __$SubmitQuoteRequestCopyWithImpl(this._self, this._then);

  final _SubmitQuoteRequest _self;
  final $Res Function(_SubmitQuoteRequest) _then;

/// Create a copy of SubmitQuoteRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? evidencePhotoUrls = null,}) {
  return _then(_SubmitQuoteRequest(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<QuoteItemRequest>,evidencePhotoUrls: null == evidencePhotoUrls ? _self._evidencePhotoUrls : evidencePhotoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
