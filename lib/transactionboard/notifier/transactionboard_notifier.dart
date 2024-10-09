import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gatepay_convert/transactionboard/notifier/transactionboard_state.dart';

import '../repository/service/transactionboard_service.dart';

final transactionboardNotifierProvider = NotifierProvider.autoDispose<
    TransactionboardNotifier,
    TransactionboardState>(TransactionboardNotifier.new);

class TransactionboardNotifier
    extends AutoDisposeNotifier<TransactionboardState> {
  @override
  TransactionboardState build() {
    // getTransactionboard();
    return TransactionboardLoaded();
  }

  TransactionboardApiService get transactionboardApiService =>
      ref.read(transactionboardApiServiceProvider);
}
