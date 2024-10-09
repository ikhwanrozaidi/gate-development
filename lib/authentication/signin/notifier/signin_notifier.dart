import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/service/signin_service.dart';
import 'signin_state.dart';

final signInNotifierProvider =
    NotifierProvider.autoDispose<SignInNotifier, SignInState>(
        SignInNotifier.new);

class SignInNotifier extends AutoDisposeNotifier<SignInState> {
  @override
  SignInState build() {
    // getSignIn();
    return SignInLoaded();
  }

  SignInApiService get signInApiService => ref.read(signInApiServiceProvider);

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    log('running Signin NOTIFIER');

    state = SignInLoading();
    final result = await signInApiService.signIn(email, password);
    if (result['success']) {
      state = SignInLoaded();
    } else {
      state = SignInError();
    }
    return result;
  }
}
