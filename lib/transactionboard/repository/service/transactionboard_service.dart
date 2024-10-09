import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../shared/services/api/api.dart';
import '../../../../../../shared/services/api/dio/dio_api.dart';
import '../../../../../../shared/services/api/dio/dio_config.dart';

final transactionboardApiServiceProvider = Provider.autoDispose(
  (ref) {
    // ref.keepAlive();
    return TransactionboardApiService(
      ref: ref,
      apiService: DioApiService(dio),
    );
  },
);

abstract class TransactionboardService {}

class TransactionboardApiService extends TransactionboardService {
  final Ref ref;
  final ApiService apiService;

  TransactionboardApiService({
    required this.ref,
    required this.apiService,
  });
}
