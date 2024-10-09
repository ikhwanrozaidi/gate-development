// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApiStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() serverError,
    required TResult Function() otherException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? serverError,
    TResult? Function()? otherException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? serverError,
    TResult Function()? otherException,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiLoading value) loading,
    required TResult Function(ApiLoaded value) loaded,
    required TResult Function(ApiServerError value) serverError,
    required TResult Function(ApiOtherException value) otherException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiLoading value)? loading,
    TResult? Function(ApiLoaded value)? loaded,
    TResult? Function(ApiServerError value)? serverError,
    TResult? Function(ApiOtherException value)? otherException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiLoading value)? loading,
    TResult Function(ApiLoaded value)? loaded,
    TResult Function(ApiServerError value)? serverError,
    TResult Function(ApiOtherException value)? otherException,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiStatusCopyWith<$Res> {
  factory $ApiStatusCopyWith(ApiStatus value, $Res Function(ApiStatus) then) =
      _$ApiStatusCopyWithImpl<$Res, ApiStatus>;
}

/// @nodoc
class _$ApiStatusCopyWithImpl<$Res, $Val extends ApiStatus>
    implements $ApiStatusCopyWith<$Res> {
  _$ApiStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ApiLoadingImplCopyWith<$Res> {
  factory _$$ApiLoadingImplCopyWith(
          _$ApiLoadingImpl value, $Res Function(_$ApiLoadingImpl) then) =
      __$$ApiLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ApiLoadingImplCopyWithImpl<$Res>
    extends _$ApiStatusCopyWithImpl<$Res, _$ApiLoadingImpl>
    implements _$$ApiLoadingImplCopyWith<$Res> {
  __$$ApiLoadingImplCopyWithImpl(
      _$ApiLoadingImpl _value, $Res Function(_$ApiLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ApiLoadingImpl implements ApiLoading {
  const _$ApiLoadingImpl();

  @override
  String toString() {
    return 'ApiStatus.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ApiLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() serverError,
    required TResult Function() otherException,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? serverError,
    TResult? Function()? otherException,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? serverError,
    TResult Function()? otherException,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiLoading value) loading,
    required TResult Function(ApiLoaded value) loaded,
    required TResult Function(ApiServerError value) serverError,
    required TResult Function(ApiOtherException value) otherException,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiLoading value)? loading,
    TResult? Function(ApiLoaded value)? loaded,
    TResult? Function(ApiServerError value)? serverError,
    TResult? Function(ApiOtherException value)? otherException,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiLoading value)? loading,
    TResult Function(ApiLoaded value)? loaded,
    TResult Function(ApiServerError value)? serverError,
    TResult Function(ApiOtherException value)? otherException,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ApiLoading implements ApiStatus {
  const factory ApiLoading() = _$ApiLoadingImpl;
}

/// @nodoc
abstract class _$$ApiLoadedImplCopyWith<$Res> {
  factory _$$ApiLoadedImplCopyWith(
          _$ApiLoadedImpl value, $Res Function(_$ApiLoadedImpl) then) =
      __$$ApiLoadedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ApiLoadedImplCopyWithImpl<$Res>
    extends _$ApiStatusCopyWithImpl<$Res, _$ApiLoadedImpl>
    implements _$$ApiLoadedImplCopyWith<$Res> {
  __$$ApiLoadedImplCopyWithImpl(
      _$ApiLoadedImpl _value, $Res Function(_$ApiLoadedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ApiLoadedImpl implements ApiLoaded {
  const _$ApiLoadedImpl();

  @override
  String toString() {
    return 'ApiStatus.loaded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ApiLoadedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() serverError,
    required TResult Function() otherException,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? serverError,
    TResult? Function()? otherException,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? serverError,
    TResult Function()? otherException,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiLoading value) loading,
    required TResult Function(ApiLoaded value) loaded,
    required TResult Function(ApiServerError value) serverError,
    required TResult Function(ApiOtherException value) otherException,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiLoading value)? loading,
    TResult? Function(ApiLoaded value)? loaded,
    TResult? Function(ApiServerError value)? serverError,
    TResult? Function(ApiOtherException value)? otherException,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiLoading value)? loading,
    TResult Function(ApiLoaded value)? loaded,
    TResult Function(ApiServerError value)? serverError,
    TResult Function(ApiOtherException value)? otherException,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ApiLoaded implements ApiStatus {
  const factory ApiLoaded() = _$ApiLoadedImpl;
}

/// @nodoc
abstract class _$$ApiServerErrorImplCopyWith<$Res> {
  factory _$$ApiServerErrorImplCopyWith(_$ApiServerErrorImpl value,
          $Res Function(_$ApiServerErrorImpl) then) =
      __$$ApiServerErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ApiServerErrorImplCopyWithImpl<$Res>
    extends _$ApiStatusCopyWithImpl<$Res, _$ApiServerErrorImpl>
    implements _$$ApiServerErrorImplCopyWith<$Res> {
  __$$ApiServerErrorImplCopyWithImpl(
      _$ApiServerErrorImpl _value, $Res Function(_$ApiServerErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ApiServerErrorImpl implements ApiServerError {
  const _$ApiServerErrorImpl();

  @override
  String toString() {
    return 'ApiStatus.serverError()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ApiServerErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() serverError,
    required TResult Function() otherException,
  }) {
    return serverError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? serverError,
    TResult? Function()? otherException,
  }) {
    return serverError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? serverError,
    TResult Function()? otherException,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiLoading value) loading,
    required TResult Function(ApiLoaded value) loaded,
    required TResult Function(ApiServerError value) serverError,
    required TResult Function(ApiOtherException value) otherException,
  }) {
    return serverError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiLoading value)? loading,
    TResult? Function(ApiLoaded value)? loaded,
    TResult? Function(ApiServerError value)? serverError,
    TResult? Function(ApiOtherException value)? otherException,
  }) {
    return serverError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiLoading value)? loading,
    TResult Function(ApiLoaded value)? loaded,
    TResult Function(ApiServerError value)? serverError,
    TResult Function(ApiOtherException value)? otherException,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(this);
    }
    return orElse();
  }
}

abstract class ApiServerError implements ApiStatus {
  const factory ApiServerError() = _$ApiServerErrorImpl;
}

/// @nodoc
abstract class _$$ApiOtherExceptionImplCopyWith<$Res> {
  factory _$$ApiOtherExceptionImplCopyWith(_$ApiOtherExceptionImpl value,
          $Res Function(_$ApiOtherExceptionImpl) then) =
      __$$ApiOtherExceptionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ApiOtherExceptionImplCopyWithImpl<$Res>
    extends _$ApiStatusCopyWithImpl<$Res, _$ApiOtherExceptionImpl>
    implements _$$ApiOtherExceptionImplCopyWith<$Res> {
  __$$ApiOtherExceptionImplCopyWithImpl(_$ApiOtherExceptionImpl _value,
      $Res Function(_$ApiOtherExceptionImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ApiOtherExceptionImpl implements ApiOtherException {
  const _$ApiOtherExceptionImpl();

  @override
  String toString() {
    return 'ApiStatus.otherException()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ApiOtherExceptionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() serverError,
    required TResult Function() otherException,
  }) {
    return otherException();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? serverError,
    TResult? Function()? otherException,
  }) {
    return otherException?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? serverError,
    TResult Function()? otherException,
    required TResult orElse(),
  }) {
    if (otherException != null) {
      return otherException();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiLoading value) loading,
    required TResult Function(ApiLoaded value) loaded,
    required TResult Function(ApiServerError value) serverError,
    required TResult Function(ApiOtherException value) otherException,
  }) {
    return otherException(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiLoading value)? loading,
    TResult? Function(ApiLoaded value)? loaded,
    TResult? Function(ApiServerError value)? serverError,
    TResult? Function(ApiOtherException value)? otherException,
  }) {
    return otherException?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiLoading value)? loading,
    TResult Function(ApiLoaded value)? loaded,
    TResult Function(ApiServerError value)? serverError,
    TResult Function(ApiOtherException value)? otherException,
    required TResult orElse(),
  }) {
    if (otherException != null) {
      return otherException(this);
    }
    return orElse();
  }
}

abstract class ApiOtherException implements ApiStatus {
  const factory ApiOtherException() = _$ApiOtherExceptionImpl;
}
