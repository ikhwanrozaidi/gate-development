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

  VerifyApiService get verifyApiService =>
      ref.read(verifyApiServiceProvider);
}
