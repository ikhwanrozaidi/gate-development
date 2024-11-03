import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/service/escrowpay_service.dart';
import 'escrowpay_state.dart';

final escrowpayNotifierProvider =
    NotifierProvider.autoDispose<EscrowpayNotifier, EscrowpayState>(
        EscrowpayNotifier.new);

class EscrowpayNotifier extends AutoDisposeNotifier<EscrowpayState> {
  @override
  EscrowpayState build() {
    // getEscrowpay();
    return EscrowpayLoaded();
  }

  EscrowpayApiService get escrowpayApiService =>
      ref.read(escrowpayApiServiceProvider);

  Future<void> checkUsername(String username) async {
    if (username.isEmpty) {
      state = const EscrowpayLoaded(usernameStatus: UsernameStatus.none);
      return;
    }
    if (!_isValidUsername(username)) {
      state = const EscrowpayLoaded(usernameStatus: UsernameStatus.invalid);
      return;
    }

    try {
      state = const EscrowpayLoaded(usernameStatus: UsernameStatus.checking);

      bool isAvailable = await escrowpayApiService.isUsernameValid(username);

      state = EscrowpayLoaded(
          usernameStatus:
              isAvailable ? UsernameStatus.nouser : UsernameStatus.valid);
    } catch (e) {
      log('Error checking username: $e');
      state = EscrowpayError(e.toString());
    }
  }

  bool _isValidUsername(String username) {
    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
    return usernameRegex.hasMatch(username);
  }

  Future<void> createTransaction({
    required String productName,
    required String description,
    required double actualPrice,
    required double chargePrice,
    required String sellerUsername,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      state = const EscrowpayLoaded(
          verificationStatus: VerificationStatus.processing);

      await escrowpayApiService.createEscrowTransaction(
        productName: productName,
        description: description,
        actualPrice: actualPrice,
        chargePrice: chargePrice,
        sellerUsername: sellerUsername,
      );

      state = const EscrowpayLoaded(
          verificationStatus: VerificationStatus.completed);
      onSuccess();
    } catch (e) {
      log('Error creating transaction: $e');
      state =
          const EscrowpayLoaded(verificationStatus: VerificationStatus.failed);
      onError(e.toString());
    }
  }
}
