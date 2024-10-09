import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../shared/services/api/api.dart';
import '../../../../../../shared/services/api/dio/dio_api.dart';
import '../../../../../../shared/services/api/dio/dio_config.dart';

final inboxApiServiceProvider = Provider.autoDispose(
  (ref) {
    // ref.keepAlive();
    return InboxApiService(
      ref: ref,
      apiService: DioApiService(dio),
    );
  },
);

abstract class InboxService {}

class InboxApiService extends InboxService {
  final Ref ref;
  final ApiService apiService;

  InboxApiService({
    required this.ref,
    required this.apiService,
  });
}
