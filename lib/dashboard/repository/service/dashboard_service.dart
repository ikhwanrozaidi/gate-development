import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../shared/services/api/api.dart';
import '../../../../../../shared/services/api/dio/dio_api.dart';
import '../../../../../../shared/services/api/dio/dio_config.dart';
import '../../../authentication/signup/repository/data-classes/account_model.dart';
import '../../../shared/services/config.dart';

final dashboardApiServiceProvider = Provider.autoDispose(
  (ref) {
    // ref.keepAlive();
    return DashboardApiService(
      ref: ref,
      apiService: DioApiService(dio),
      auth: FirebaseAuth.instance,
    );
  },
);

abstract class DashboardService {}

class DashboardApiService extends DashboardService {
  final Ref ref;
  final ApiService apiService;
  final FirebaseAuth auth;

  DashboardApiService({
    required this.ref,
    required this.apiService,
    required this.auth,
  });

  Future<List<AccountModel>> getAccountDetails() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        QuerySnapshot accountQuery = await FirebaseFirestore.instance
            .collection(EnvironmentConfig.usersCollection)
            .doc(user.uid)
            .collection('account')
            .get();

        if (accountQuery.docs.isNotEmpty) {
          List<AccountModel> accounts = accountQuery.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            log('Account Found - ID: ${doc.id}');
            return AccountModel.fromJson(data);
          }).toList();

          log('Total Accounts Found: ${accounts.length}');
          
          return accounts;
        } else {
          log('getAccountDetails: No accounts found');
          return [];
        }
      } else {
        throw Exception('No user logged in');
      }
    } catch (e) {
      log('Error getAccountDetails: $e');
      throw e;
    }
  }
}
