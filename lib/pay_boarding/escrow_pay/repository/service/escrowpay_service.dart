import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../shared/services/api/api.dart';
import '../../../../../../shared/services/api/dio/dio_api.dart';
import '../../../../../../shared/services/api/dio/dio_config.dart';
import '../../../../shared/services/config.dart';

final escrowpayApiServiceProvider = Provider.autoDispose(
  (ref) {
    // ref.keepAlive();
    return EscrowpayApiService(
      ref: ref,
      apiService: DioApiService(dio),
    );
  },
);

abstract class EscrowpayService {}

class EscrowpayApiService extends EscrowpayService {
  final Ref ref;
  final ApiService apiService;

  EscrowpayApiService({
    required this.ref,
    required this.apiService,
  });

  Future<bool> isUsernameValid(String username) async {
    try {
      if (username.isEmpty) return false;

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

  Future<void> createEscrowTransaction({
    required String productName,
    required String description,
    required double actualPrice,
    required double chargePrice,
    required String sellerUsername,
  }) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) throw Exception('No user logged in');

      // Get buyer's account document
      QuerySnapshot buyerAccountQuery = await FirebaseFirestore.instance
          .collection(EnvironmentConfig.usersCollection)
          .doc(currentUser.uid)
          .collection('account')
          .where('businessDoc', isNull: true)
          .limit(1)
          .get();

      if (buyerAccountQuery.docs.isEmpty) {
        throw Exception('No buyer account found');
      }
      DocumentReference buyerAccountRef =
          buyerAccountQuery.docs.first.reference;
      Map<String, dynamic> buyerAccountData =
          buyerAccountQuery.docs.first.data() as Map<String, dynamic>;

      // Check buyer's balance
      double buyerBalance = buyerAccountData['balance'] ?? 0.0;
      if (buyerBalance < chargePrice) {
        throw Exception('Insufficient balance');
      }

      // Get seller's user document
      QuerySnapshot sellerQuery = await FirebaseFirestore.instance
          .collection(EnvironmentConfig.usersCollection)
          .where('username', isEqualTo: sellerUsername.toLowerCase())
          .get();

      if (sellerQuery.docs.isEmpty) {
        throw Exception('Seller not found');
      }

      // Get seller's account document
      QuerySnapshot sellerAccountQuery = await FirebaseFirestore.instance
          .collection(EnvironmentConfig.usersCollection)
          .doc(sellerQuery.docs.first.id)
          .collection('account')
          .where('businessDoc', isNull: true)
          .limit(1)
          .get();

      if (sellerAccountQuery.docs.isEmpty) {
        throw Exception('No seller account found');
      }
      DocumentReference sellerAccountRef =
          sellerAccountQuery.docs.first.reference;

      // Start transaction
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Update buyer's account
        transaction.update(buyerAccountRef, {
          'balance': FieldValue.increment(-chargePrice),
          'payingTransaction': FieldValue.increment(chargePrice),
          'updatedAt': DateTime.now(),
        });

        // Update seller's account
        transaction.update(sellerAccountRef, {
          'receivingTransaction': FieldValue.increment(actualPrice),
          'updatedAt': DateTime.now(),
        });

        // Create order history for buyer
        DocumentReference buyerOrderRef =
            buyerAccountRef.collection('orderHistory').doc();
        transaction.set(buyerOrderRef, {
          'orderId': buyerOrderRef.id,
          'orderStatus': 'outgoing',
          'productName': productName,
          'description': description,
          'payerUsername': buyerAccountData['username'],
          'receipientUsername': sellerUsername,
          'actualPrice': actualPrice,
          'chargePrice': chargePrice,
          'payingCurrency': 'MYR',
          'receiveCurrency': 'MYR',
          'deliveryStatus': 0,
          'payingTransaction': chargePrice,
          'createdAt': DateTime.now(),
          'updatedAt': DateTime.now(),
        });

        // Create order history for seller
        DocumentReference sellerOrderRef =
            sellerAccountRef.collection('orderHistory').doc();
        transaction.set(sellerOrderRef, {
          'orderId': sellerOrderRef.id,
          'orderStatus': 'incoming',
          'productName': productName,
          'description': description,
          'payerUsername': buyerAccountData['username'],
          'receipientUsername': sellerUsername,
          'actualPrice': actualPrice,
          'chargePrice': chargePrice,
          'payingCurrency': 'MYR',
          'receiveCurrency': 'MYR',
          'deliveryStatus': 0,
          'payingTransaction': chargePrice,
          'createdAt': DateTime.now(),
          'updatedAt': DateTime.now(),
        });
      });

      log('Escrow transaction completed successfully');
    } catch (e) {
      log('Error creating escrow transaction: $e');
      throw e;
    }
  }
}
