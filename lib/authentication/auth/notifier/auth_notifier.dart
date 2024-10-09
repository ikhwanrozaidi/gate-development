import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/utils/debounce.dart';
import '../services/auth_service.dart';
import 'auth_state.dart';

final authNotifierProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    checkLogin();
    return LoggedOut();
  }

  // StorageService get storageService => ref.read(storageServiceProvider);
  AuthService get authService => ref.read(authServiceProvider);

  Future<void> checkLogin() async {
    await debouncer();

    authService.updateLogInStatus();
    authService.auth.stream.listen((isLoggedin) async {
      if (isLoggedin) {
        state = LoggedIn();
      } else {
        state = LoggedOut();
      }
    });
  }
}
