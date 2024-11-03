import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/service/signup_service.dart';
import 'signup_state.dart';

final signUpNotifierProvider =
    NotifierProvider.autoDispose<SignUpNotifier, SignUpState>(
        SignUpNotifier.new);

class SignUpNotifier extends AutoDisposeNotifier<SignUpState> {
  @override
  SignUpState build() {
    return SignUpLoaded();
  }

  SignUpApiService get signUpApiService => ref.read(signUpApiServiceProvider);

  Future<bool> checkEmailExists(String email) async {
    state = SignUpLoading();
    try {
      bool exists = await signUpApiService.checkEmailExists(email);
      state = SignUpLoaded();
      return exists;
    } catch (e) {
      state = SignUpError(e.toString());
      return false;
    }
  }

  Future<void> signUp(String email, String password,
      Map<String, dynamic> additionalData) async {
    state = SignUpLoading();

    String randomNumber = '';
    var rng = Random();
    for (int i = 0; i < 13; i++) {
      randomNumber += rng.nextInt(10).toString();
    }

    additionalData['accountNumber'] = randomNumber;

    try {
      final result =
          await signUpApiService.signUp(email, password, additionalData);
      if (result['success']) {
        state = SignUpSuccess(result['accessToken']);
      } else {
        state = SignUpError(result['error']);
      }
    } catch (e) {
      state = SignUpError(e.toString());
    }
  }
}
