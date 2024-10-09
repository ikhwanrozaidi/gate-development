import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider((ref) => AuthService(ref: ref));

class AuthService {
  final Ref ref;
  AuthService({required this.ref});

  final auth = StreamController<bool>.broadcast();

  Stream get stream => auth.stream;

  bool isLoggedin = false;

  Future<void> updateLogInStatus() async {
    // final token = await ref.read(storageServiceProvider).loadAccessToken;

    // if (token != null) {
    //   isLoggedin = true;
    //   auth.sink.add(true);
    // } else {
    //   isLoggedin = false;
    //   auth.sink.add(false);
    // }
  }
}
