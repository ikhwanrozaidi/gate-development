import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/service/CurrencyWallet_service.dart';
import 'currencywallet_state.dart';

final currencyWalletNotifierProvider =
    NotifierProvider.autoDispose<CurrencyWalletNotifier, CurrencyWalletState>(
        CurrencyWalletNotifier.new);

class CurrencyWalletNotifier extends AutoDisposeNotifier<CurrencyWalletState> {
  @override
  CurrencyWalletState build() {
    // getCurrencyWallet();
    return CurrencyWalletLoaded();
  }

  CurrencyWalletApiService get currencyWalletApiService =>
      ref.read(currencyWalletApiServiceProvider);
}
