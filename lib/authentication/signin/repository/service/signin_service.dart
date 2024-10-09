import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../shared/services/api/api.dart';
import '../../../../shared/services/api/dio/dio_api.dart';
import '../../../../shared/services/api/dio/dio_config.dart';
import '../../../../shared/services/storage/storage.dart';

final signInApiServiceProvider = Provider.autoDispose(
  (ref) {
    return SignInApiService(
      ref: ref,
      apiService: DioApiService(dio),
      auth: FirebaseAuth.instance,
      storageService: ref.read(storageServiceProvider),
    );
  },
);

abstract class SignInService {}

class SignInApiService extends SignInService {
  final Ref ref;
  final ApiService apiService;
  final FirebaseAuth auth;
  final StorageService storageService;

  SignInApiService({
    required this.ref,
    required this.apiService,
    required this.auth,
    required this.storageService,
  });

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String? accessToken = await userCredential.user?.getIdToken();

      if (accessToken != null) {
        await storageService.setAccessToken(accessToken);

        // You might want to fetch and store additional user data here
        final userData = {
          'uid': userCredential.user?.uid,
          'email': userCredential.user?.email,
          // Add any other user data you want to store
        };
        await storageService.setUserData(userData);

        print('Sign in successful. Access token stored securely.');
        return {'success': true, 'accessToken': accessToken};
      } else {
        print('Sign in failed: No access token received');
        return {'success': false, 'error': 'No access token received'};
      }
    } on FirebaseAuthException catch (e) {
      print('Sign in failed: ${e.message}');
      return {'success': false, 'error': e.message};
    } catch (e) {
      print('Sign in failed: $e');
      return {'success': false, 'error': 'An unexpected error occurred'};
    }
  }
}
