import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../shared/services/api/api.dart';
import '../../../../shared/services/api/dio/dio_api.dart';
import '../../../../shared/services/api/dio/dio_config.dart';
import '../../../../shared/services/storage/storage.dart';
import '../../../authentication/signup/repository/data-classes/user_model.dart';

final profileApiServiceProvider = Provider.autoDispose(
  (ref) {
    // ref.keepAlive();
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

  Future<Map<String, dynamic>> getUserDetails() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('staging')
            .doc('staging')
            .collection('users')
            .doc(user.uid)
            .get();

        // log('getUserDetails ${userData.data()}');

        if (userData.exists) {
          return {
            'uid': user.uid,
            'email': user.email,
            'firstName': userData['firstName'] ?? '',
            'lastName': userData['lastName'] ?? '',
            'country': userData['country'] ?? '',
            // 'dob': userData['dob'] ?? '',
            'title': userData['title'] ?? '',
          };
        } else {
          return {
            'uid': user.uid,
            'email': user.email,
            'firstName': '',
            'lastName': '',
            'country': '',
            // 'dob': '',
            'title': '',
          };
        }
      } else {
        throw Exception('No user logged in');
      }
    } catch (e) {
      log('Error getUserDetails: $e');
      throw e;
    }
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
