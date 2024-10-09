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
    var rng = Random();
    var randomNumber = (rng.nextInt(900000000) + 100000000);

    additionalData['accountNumber'] = randomNumber.toString();

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
