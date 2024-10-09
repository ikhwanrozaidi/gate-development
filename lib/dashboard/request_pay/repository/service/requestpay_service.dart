import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../shared/services/api/api.dart';
import '../../../../../../shared/services/api/dio/dio_api.dart';
import '../../../../../../shared/services/api/dio/dio_config.dart';

final requestpayApiServiceProvider = Provider.autoDispose(
  (ref) {
    // ref.keepAlive();
    return RequestpayApiService(
      ref: ref,
      apiService: DioApiService(dio),
    );
  },
);

abstract class RequestpayService {}

class RequestpayApiService extends RequestpayService {
  final Ref ref;
  final ApiService apiService;

  RequestpayApiService({
    required this.ref,
    required this.apiService,
  });
}
