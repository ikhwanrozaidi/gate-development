import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/service/withdraw_service.dart';
import 'withdraw_state.dart';

final withdrawNotifierProvider =
    NotifierProvider.autoDispose<WithdrawNotifier, WithdrawState>(
        WithdrawNotifier.new);

class WithdrawNotifier extends AutoDisposeNotifier<WithdrawState> {
  @override
  WithdrawState build() {
    loadDefaultAccount();
    return WithdrawLoading();
  }

  WithdrawApiService get withdrawApiService =>
      ref.read(withdrawApiServiceProvider);

  Future<void> loadDefaultAccount() async {
    try {
      state = WithdrawLoading();
      final account = await withdrawApiService.getDefaultAccount();

      if (account != null) {
        state = WithdrawLoaded(account);
      } else {
        state = WithdrawError('No account found');
      }
    } catch (e) {
      log('Error loadDefaultAccount: $e');
      state = WithdrawError(e.toString());
    }
  }

  Future<void> processWithdraw(double amount, String bankName,
      String reciepientName, String accountNumber) async {
    try {
      if (state is WithdrawLoaded) {
        final currentState = state as WithdrawLoaded;
        state = WithdrawProcessing();

        await withdrawApiService.updateBalance(
          currentState.account.accountId,
          amount,
          bankName,
          reciepientName,
          accountNumber,
        );

        state = WithdrawSuccess(currentState.account.balance + amount);
      } else {
        state = WithdrawError('Invalid state for Withdraw');
      }
    } catch (e) {
      log('Error processWithdraw: $e');
      state = WithdrawError(e.toString());
    }
  }
}
