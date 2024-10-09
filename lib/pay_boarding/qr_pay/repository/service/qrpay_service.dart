import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../shared/services/api/api.dart';
import '../../../../../../shared/services/api/dio/dio_api.dart';
import '../../../../../../shared/services/api/dio/dio_config.dart';

final qrpayApiServiceProvider = Provider.autoDispose(
  (ref) {
    // ref.keepAlive();
    return QrpayApiService(
      ref: ref,
      apiService: DioApiService(dio),
    );
  },
);

abstract class QrpayService {}

class QrpayApiService extends QrpayService {
  final Ref ref;
  final ApiService apiService;

  QrpayApiService({
    required this.ref,
    required this.apiService,
  });
}
