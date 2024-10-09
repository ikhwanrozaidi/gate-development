import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../shared/services/api/api.dart';
import '../../../../../../shared/services/api/dio/dio_api.dart';
import '../../../../../../shared/services/api/dio/dio_config.dart';

final escrowpayApiServiceProvider = Provider.autoDispose(
  (ref) {
    // ref.keepAlive();
    return EscrowpayApiService(
      ref: ref,
      apiService: DioApiService(dio),
    );
  },
);

abstract class EscrowpayService {}

class EscrowpayApiService extends EscrowpayService {
  final Ref ref;
  final ApiService apiService;

  EscrowpayApiService({
    required this.ref,
    required this.apiService,
  });
}
