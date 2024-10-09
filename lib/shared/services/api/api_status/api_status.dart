import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_status.freezed.dart';

@freezed
abstract class ApiStatus with _$ApiStatus {
  const factory ApiStatus.loading() = ApiLoading;
  const factory ApiStatus.loaded() = ApiLoaded;
  const factory ApiStatus.serverError() = ApiServerError;
  const factory ApiStatus.otherException() = ApiOtherException;
}
