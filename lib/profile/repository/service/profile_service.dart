import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../authentication/signup/repository/data-classes/user_model.dart';
import '../../../shared/services/api/api.dart';
import '../../../shared/services/api/dio/dio_api.dart';
import '../../../shared/services/api/dio/dio_config.dart';
import '../../../shared/services/config.dart';
import '../../../shared/services/storage/storage.dart';

final profileApiServiceProvider = Provider.autoDispose(
  (ref) {
    return ProfileApiService(
      ref: ref,
      apiService: DioApiService(dio),
      auth: FirebaseAuth.instance,
      storageService: ref.read(storageServiceProvider),
    );
  },
);

abstract class ProfileService {}

class ProfileApiService extends ProfileService {
  final Ref ref;
  final ApiService apiService;
  final FirebaseAuth auth;
  final StorageService storageService;

  ProfileApiService({
    required this.ref,
    required this.apiService,
    required this.auth,
    required this.storageService,
  });

  Future<UserModel?> getUserDetails() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection(EnvironmentConfig.usersCollection)
            .doc(user.uid)
            .get();

        if (userData.exists) {
          Map<String, dynamic> data = userData.data() as Map<String, dynamic>;
          data['userId'] = user.uid;

          // log('getUserDetails: $data');

          return UserModel.fromJson(data);
        } else {
          log('getUserDetails no userData');
        }
      } else {
        throw Exception('No user logged in');
      }
    } catch (e) {
      log('Error getUserDetails: $e');
      throw e;
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
      await storageService.logout();
      log('User signed out successfully');
    } catch (e) {
      log('Error signOut: $e');
      throw e;
    }
  }
}
