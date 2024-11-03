import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../shared/services/api/api.dart';
import '../../../../../../shared/services/api/dio/dio_api.dart';
import '../../../../../../shared/services/api/dio/dio_config.dart';
import '../../../shared/services/config.dart';
import '../data-classes/order_history_model.dart';

final transactionboardApiServiceProvider = Provider.autoDispose(
  (ref) {
    // ref.keepAlive();
    return TransactionboardApiService(
      ref: ref,
      apiService: DioApiService(dio),
      auth: FirebaseAuth.instance,
    );
  },
);

abstract class TransactionboardService {}

class TransactionboardApiService extends TransactionboardService {
  final Ref ref;
  final ApiService apiService;
  final FirebaseAuth auth;

  TransactionboardApiService({
    required this.ref,
    required this.apiService,
    required this.auth,
  });

  Future<List<OrderHistory>> getOrderHistory() async {
    try {
      User? user = auth.currentUser;
      if (user == null) throw Exception('No user logged in');

      // Get user's default account
      QuerySnapshot accountQuery = await FirebaseFirestore.instance
          .collection(EnvironmentConfig.usersCollection)
          .doc(user.uid)
          .collection('account')
          .where('businessDoc', isNull: true)
          .limit(1)
          .get();

      if (accountQuery.docs.isEmpty) {
        throw Exception('No account found');
      }

      // Get all orderHistory documents
      QuerySnapshot orderHistoryQuery = await accountQuery.docs.first.reference
          .collection('orderHistory')
          .get();

      return orderHistoryQuery.docs
          .map((doc) =>
              OrderHistory.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('Error getting order history: $e');
      throw e;
    }
  }
}
