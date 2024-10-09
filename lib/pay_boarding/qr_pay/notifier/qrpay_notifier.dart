import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/service/Qrpay_service.dart';
import 'Qrpay_state.dart';

final qrpayNotifierProvider =
    NotifierProvider.autoDispose<QrpayNotifier, QrpayState>(QrpayNotifier.new);

class QrpayNotifier extends AutoDisposeNotifier<QrpayState> {
  @override
  QrpayState build() {
    // getQrpay();
    return QrpayLoaded();
  }

  QrpayApiService get qrpayApiService => ref.read(qrpayApiServiceProvider);
}
