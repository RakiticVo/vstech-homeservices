// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'worker_metrics_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkerMetricsResponse {

 int? get totalCompletedJobs; double? get averageRating; double? get cancellationRate; String? get badgeTier;
/// Create a copy of WorkerMetricsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkerMetricsResponseCopyWith<WorkerMetricsResponse> get copyWith => _$WorkerMetricsResponseCopyWithImpl<WorkerMetricsResponse>(this as WorkerMetricsResponse, _$identity);

  /// Serializes this WorkerMetricsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WorkerMetricsResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkerMetricsResponse&&(identical(other.totalCompletedJobs, _this.totalCompletedJobs) || other.totalCompletedJobs == _this.totalCompletedJobs)&&(identical(other.averageRating, _this.averageRating) || other.averageRating == _this.averageRating)&&(identical(other.cancellationRate, _this.cancellationRate) || other.cancellationRate == _this.cancellationRate)&&(identical(other.badgeTier, _this.badgeTier) || other.badgeTier == _this.badgeTier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WorkerMetricsResponse;
  return Object.hash(runtimeType,_this.totalCompletedJobs,_this.averageRating,_this.cancellationRate,_this.badgeTier);
}

@override
String toString() {
  final _this = this as WorkerMetricsResponse;
  return 'WorkerMetricsResponse(totalCompletedJobs: ${_this.totalCompletedJobs}, averageRating: ${_this.averageRating}, cancellationRate: ${_this.cancellationRate}, badgeTier: ${_this.badgeTier})';
}


}

/// @nodoc
abstract mixin class $WorkerMetricsResponseCopyWith<$Res>  {
  factory $WorkerMetricsResponseCopyWith(WorkerMetricsResponse value, $Res Function(WorkerMetricsResponse) _then) = _$WorkerMetricsResponseCopyWithImpl;
@useResult
$Res call({
 int? totalCompletedJobs, double? averageRating, double? cancellationRate, String? badgeTier
});




}
/// @nodoc
class _$WorkerMetricsResponseCopyWithImpl<$Res>
    implements $WorkerMetricsResponseCopyWith<$Res> {
  _$WorkerMetricsResponseCopyWithImpl(this._self, this._then);

  final WorkerMetricsResponse _self;
  final $Res Function(WorkerMetricsResponse) _then;

/// Create a copy of WorkerMetricsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalCompletedJobs = freezed,Object? averageRating = freezed,Object? cancellationRate = freezed,Object? badgeTier = freezed,}) {
  return _then(WorkerMetricsResponse(
totalCompletedJobs: freezed == totalCompletedJobs ? _self.totalCompletedJobs : totalCompletedJobs // ignore: cast_nullable_to_non_nullable
as int?,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,cancellationRate: freezed == cancellationRate ? _self.cancellationRate : cancellationRate // ignore: cast_nullable_to_non_nullable
as double?,badgeTier: freezed == badgeTier ? _self.badgeTier : badgeTier // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkerMetricsResponse].
extension WorkerMetricsResponsePatterns on WorkerMetricsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkerMetricsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkerMetricsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkerMetricsResponse value)  $default,){
final _that = this;
switch (_that) {
case _WorkerMetricsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkerMetricsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _WorkerMetricsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? totalCompletedJobs,  double? averageRating,  double? cancellationRate,  String? badgeTier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkerMetricsResponse() when $default != null:
return $default(_that.totalCompletedJobs,_that.averageRating,_that.cancellationRate,_that.badgeTier);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? totalCompletedJobs,  double? averageRating,  double? cancellationRate,  String? badgeTier)  $default,) {final _that = this;
switch (_that) {
case _WorkerMetricsResponse():
return $default(_that.totalCompletedJobs,_that.averageRating,_that.cancellationRate,_that.badgeTier);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? totalCompletedJobs,  double? averageRating,  double? cancellationRate,  String? badgeTier)?  $default,) {final _that = this;
switch (_that) {
case _WorkerMetricsResponse() when $default != null:
return $default(_that.totalCompletedJobs,_that.averageRating,_that.cancellationRate,_that.badgeTier);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkerMetricsResponse implements WorkerMetricsResponse {
  const _WorkerMetricsResponse({this.totalCompletedJobs, this.averageRating, this.cancellationRate, this.badgeTier});
  factory _WorkerMetricsResponse.fromJson(Map<String, dynamic> json) => _$WorkerMetricsResponseFromJson(json);

@override final  int? totalCompletedJobs;
@override final  double? averageRating;
@override final  double? cancellationRate;
@override final  String? badgeTier;

/// Create a copy of WorkerMetricsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkerMetricsResponseCopyWith<_WorkerMetricsResponse> get copyWith => __$WorkerMetricsResponseCopyWithImpl<_WorkerMetricsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkerMetricsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkerMetricsResponse&&(identical(other.totalCompletedJobs, totalCompletedJobs) || other.totalCompletedJobs == totalCompletedJobs)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.cancellationRate, cancellationRate) || other.cancellationRate == cancellationRate)&&(identical(other.badgeTier, badgeTier) || other.badgeTier == badgeTier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,totalCompletedJobs,averageRating,cancellationRate,badgeTier);
}

@override
String toString() {
    return 'WorkerMetricsResponse(totalCompletedJobs: $totalCompletedJobs, averageRating: $averageRating, cancellationRate: $cancellationRate, badgeTier: $badgeTier)';
}


}

/// @nodoc
abstract mixin class _$WorkerMetricsResponseCopyWith<$Res> implements $WorkerMetricsResponseCopyWith<$Res> {
  factory _$WorkerMetricsResponseCopyWith(_WorkerMetricsResponse value, $Res Function(_WorkerMetricsResponse) _then) = __$WorkerMetricsResponseCopyWithImpl;
@override @useResult
$Res call({
 int? totalCompletedJobs, double? averageRating, double? cancellationRate, String? badgeTier
});




}
/// @nodoc
class __$WorkerMetricsResponseCopyWithImpl<$Res>
    implements _$WorkerMetricsResponseCopyWith<$Res> {
  __$WorkerMetricsResponseCopyWithImpl(this._self, this._then);

  final _WorkerMetricsResponse _self;
  final $Res Function(_WorkerMetricsResponse) _then;

/// Create a copy of WorkerMetricsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalCompletedJobs = freezed,Object? averageRating = freezed,Object? cancellationRate = freezed,Object? badgeTier = freezed,}) {
  return _then(_WorkerMetricsResponse(
totalCompletedJobs: freezed == totalCompletedJobs ? _self.totalCompletedJobs : totalCompletedJobs // ignore: cast_nullable_to_non_nullable
as int?,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,cancellationRate: freezed == cancellationRate ? _self.cancellationRate : cancellationRate // ignore: cast_nullable_to_non_nullable
as double?,badgeTier: freezed == badgeTier ? _self.badgeTier : badgeTier // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
