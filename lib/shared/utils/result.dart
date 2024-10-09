import 'package:dio/dio.dart';

class Result<T> {
  final ResultStatus? status;
  final String? message;
  final String? e;
  final DioExceptionType? type;
  final T? data;

  Result({
    this.status,
    this.message,
    this.e,
    this.type,
    this.data,
  });

  factory Result.loading() => Result(status: ResultStatus.loading);

  factory Result.idle() => Result(status: ResultStatus.idle);

  factory Result.exception({T? data, String? e, DioExceptionType? type}) =>
      Result(
        status: ResultStatus.exception,
        type: type,
        e: e,
      );

  factory Result.failure({T? data, dynamic message}) => Result(
        status: ResultStatus.failure,
        data: data,
        message: message.toString(),
      );

  factory Result.success(T? result) => Result(
        status: ResultStatus.success,
        data: result,
      );

  factory Result.empty() => Result(status: ResultStatus.empty);

  @override
  String toString() {
    return 'Result{status: $status, message: $message, data: $data}';
  }

  Result<T> copyWith({
    ResultStatus? status,
    String? message,
    String? e,
    T? data,
  }) {
    return Result<T>(
      status: status ?? this.status,
      message: message ?? this.message,
      e: e ?? this.e,
      data: data ?? this.data,
    );
  }

  bool get isLoading => status == ResultStatus.loading;
  bool get isSuccess => status == ResultStatus.success;
  bool get isFailure => status == ResultStatus.failure;
  bool get isException => status == ResultStatus.exception;
  bool get isIdle => status == ResultStatus.idle;
  bool get isEmpty => status == ResultStatus.empty;
}

enum ResultStatus {
  loading,
  exception,
  failure,
  success,
  idle,
  empty,
}
