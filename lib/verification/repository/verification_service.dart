import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/services/api/api.dart';
import '../../../shared/services/api/dio/dio_api.dart';
import '../../../shared/services/api/dio/dio_config.dart';
import '../../../shared/services/config.dart';
import '../../../shared/services/storage/storage.dart';

final verifyApiServiceProvider = Provider.autoDispose(
  (ref) {
    return VerifyApiService(
      ref: ref,
      apiService: DioApiService(dio),
      auth: FirebaseAuth.instance,
      storageService: ref.read(storageServiceProvider),
    );
  },
);

abstract class VerifyService {}

class VerifyApiService extends VerifyService {
  final Ref ref;
  final ApiService apiService;
  final FirebaseAuth auth;
  final StorageService storageService;

  VerifyApiService({
    required this.ref,
    required this.apiService,
    required this.auth,
    required this.storageService,
  });

  Future<bool> isUsernameAvailable(String username) async {
    try {
      if (username.isEmpty) return false;

      // Search in users collection
      QuerySnapshot usersQuery = await FirebaseFirestore.instance
          .collection(EnvironmentConfig.usersCollection)
          .where('username', isEqualTo: username.toLowerCase())
          .get();

      return usersQuery.docs.isEmpty;
    } catch (e) {
      log('Error checking username: $e');
      throw e;
    }
  }

  Future<void> updateUsername(String username) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        // Update the user's document with the new username
        await FirebaseFirestore.instance
            .collection(EnvironmentConfig.usersCollection)
            .doc(user.uid)
            .update({
          'username': username.toLowerCase(),
          'updatedAt': DateTime.now(),
        });

        log('Username updated successfully');
      }
    } catch (e) {
      log('Error updating username: $e');
      throw e;
    }
  }
}
