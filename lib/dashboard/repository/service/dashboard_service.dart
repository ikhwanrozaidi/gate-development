import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../shared/services/api/api.dart';
import '../../../../../../shared/services/api/dio/dio_api.dart';
import '../../../../../../shared/services/api/dio/dio_config.dart';

final dashboardApiServiceProvider = Provider.autoDispose(
  (ref) {
    // ref.keepAlive();
    return DashboardApiService(
      ref: ref,
      apiService: DioApiService(dio),
    );
  },
);

abstract class DashboardService {}

class DashboardApiService extends DashboardService {
  final Ref ref;
  final ApiService apiService;

  DashboardApiService({
    required this.ref,
    required this.apiService,
  });
}
