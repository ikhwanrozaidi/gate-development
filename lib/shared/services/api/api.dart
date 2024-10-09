import 'package:dio/dio.dart';
import 'dio/dio_config.dart';

abstract class ApiService {
  Future<Response> makeRequest(
    RequestMethod method,
    String path, {
    Map<String, dynamic>? body,
  });

  // Future<Response> socialMakeRequest(
  //   RequestMethod method,
  //   String path, {
  //   Map<String, dynamic>? body,
  //   Object? data,
  // });
}
