import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../shared/services/api/api.dart';
import '../../../../../../shared/services/api/dio/dio_api.dart';
import '../../../../../../shared/services/api/dio/dio_config.dart';

final ongoingApiServiceProvider = Provider.autoDispose(
  (ref) {
    // ref.keepAlive();
    return OngoingApiService(
      ref: ref,
      apiService: DioApiService(dio),
    );
  },
);

abstract class OngoingService {}

class OngoingApiService extends OngoingService {
  final Ref ref;
  final ApiService apiService;

  OngoingApiService({
    required this.ref,
    required this.apiService,
  });
}
