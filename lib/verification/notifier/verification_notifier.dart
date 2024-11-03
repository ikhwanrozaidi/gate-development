import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/verification_service.dart';
import 'verification_state.dart';

final verifyNotifierProvider =
    NotifierProvider.autoDispose<VerifyNotifier, VerifyState>(
        VerifyNotifier.new);

class VerifyNotifier extends AutoDisposeNotifier<VerifyState> {
  @override
  VerifyState build() {
    // userDetails();
    return VerifyLoaded();
  }

  VerifyApiService get verifyApiService => ref.read(verifyApiServiceProvider);

  Future<void> checkUsername(String username) async {
    if (username.isEmpty) {
      state = const VerifyLoaded(usernameStatus: UsernameStatus.none);
      return;
    }
    if (!_isValidUsername(username)) {
      state = const VerifyLoaded(usernameStatus: UsernameStatus.invalid);
      return;
    }

    try {
      state = const VerifyLoaded(usernameStatus: UsernameStatus.checking);

      bool isAvailable = await verifyApiService.isUsernameAvailable(username);

      state = VerifyLoaded(
          usernameStatus:
              isAvailable ? UsernameStatus.available : UsernameStatus.taken);
    } catch (e) {
      log('Error checking username: $e');
      state = VerifyError(e.toString());
    }
  }

  bool _isValidUsername(String username) {
    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
    return usernameRegex.hasMatch(username);
  }

  Future<void> updateVerification({
    required String username,
    required String phone,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      state =
          const VerifyLoaded(verificationStatus: VerificationStatus.processing);

      await verifyApiService.updateVerification(username, phone);

      state =
          const VerifyLoaded(verificationStatus: VerificationStatus.completed);
      onSuccess();
    } catch (e) {
      log('Error updating verification: $e');
      state = const VerifyLoaded(verificationStatus: VerificationStatus.failed);
      onError(e.toString());
    }
  }
}
