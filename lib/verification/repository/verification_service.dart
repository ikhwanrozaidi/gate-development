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
}
