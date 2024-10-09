import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../shared/services/api/api.dart';
import '../../../../../../shared/services/api/dio/dio_api.dart';
import '../../../../../../shared/services/api/dio/dio_config.dart';

final currencyWalletApiServiceProvider = Provider.autoDispose(
  (ref) {
    // ref.keepAlive();
    return CurrencyWalletApiService(
      ref: ref,
      apiService: DioApiService(dio),
    );
  },
);

abstract class CurrencyWalletService {}

class CurrencyWalletApiService extends CurrencyWalletService {
  final Ref ref;
  final ApiService apiService;

  CurrencyWalletApiService({
    required this.ref,
    required this.apiService,
  });
}
