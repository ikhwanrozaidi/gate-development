// lib/features/topup/notifier/topup_notifier.dart

import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'topup_state.dart';
import '../repository/service/topup_service.dart';

final topupNotifierProvider =
    NotifierProvider.autoDispose<TopupNotifier, TopupState>(TopupNotifier.new);

class TopupNotifier extends AutoDisposeNotifier<TopupState> {
  @override
  TopupState build() {
    loadDefaultAccount();
    return TopupLoading();
  }

  TopupApiService get topupApiService => ref.read(topupApiServiceProvider);

  Future<void> loadDefaultAccount() async {
    try {
      state = TopupLoading();
      final account = await topupApiService.getDefaultAccount();

      if (account != null) {
        state = TopupLoaded(account);
      } else {
        state = TopupError('No account found');
      }
    } catch (e) {
      log('Error loadDefaultAccount: $e');
      state = TopupError(e.toString());
    }
  }

  Future<void> processTopup(double amount) async {
    try {
      if (state is TopupLoaded) {
        final currentState = state as TopupLoaded;
        state = TopupProcessing();

        await topupApiService.updateBalance(
          currentState.account.accountId,
          amount,
        );

        state = TopupSuccess(currentState.account.balance + amount);
      } else {
        state = TopupError('Invalid state for topup');
      }
    } catch (e) {
      log('Error processTopup: $e');
      state = TopupError(e.toString());
    }
  }
}
