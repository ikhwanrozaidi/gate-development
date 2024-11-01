import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../authentication/signup/repository/data-classes/account_model.dart';
import '../../../shared/services/api/api.dart';
import '../../../shared/services/api/dio/dio_api.dart';
import '../../../shared/services/api/dio/dio_config.dart';
import '../../../shared/services/config.dart';

final withdrawApiServiceProvider = Provider.autoDispose(
  (ref) {
    return WithdrawApiService(
      ref: ref,
      apiService: DioApiService(dio),
      auth: FirebaseAuth.instance,
    );
  },
);

abstract class WithdrawService {}

class WithdrawApiService extends WithdrawService {
  final Ref ref;
  final ApiService apiService;
  final FirebaseAuth auth;

  WithdrawApiService({
    required this.ref,
    required this.apiService,
    required this.auth,
  });

  Future<AccountModel?> getDefaultAccount() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        QuerySnapshot accountQuery = await FirebaseFirestore.instance
            .collection(EnvironmentConfig.usersCollection)
            .doc(user.uid)
            .collection('account')
            .get();

        if (accountQuery.docs.isNotEmpty) {
          // Find the default account (non-business account)
          for (var doc in accountQuery.docs) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            if (data['businessDoc'] == null &&
                (data['businessName'] == null || data['businessName'] == '')) {
              return AccountModel.fromJson(data);
            }
          }

          // If no default account found, return the first account
          return AccountModel.fromJson(
              accountQuery.docs.first.data() as Map<String, dynamic>);
        }
      }
      return null;
    } catch (e) {
      log('Error getDefaultAccount: $e');
      throw e;
    }
  }

  Future<void> updateBalance(String accountId, double amount, String bankName,
      String recipientName, String accountNumber) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        // First get the account to update
        QuerySnapshot accountQuery = await FirebaseFirestore.instance
            .collection(EnvironmentConfig.usersCollection)
            .doc(user.uid)
            .collection('account')
            .where('accountId', isEqualTo: accountId)
            .get();

        if (accountQuery.docs.isEmpty) {
          throw Exception('Account not found');
        }

        DocumentReference accountRef = accountQuery.docs.first.reference;

        // Get current balance
        AccountModel currentAccount = AccountModel.fromJson(
            accountQuery.docs.first.data() as Map<String, dynamic>);

        // Calculate new balance
        double newBalance = currentAccount.balance - amount;

        // Update the balance
        await accountRef.update({
          'balance': newBalance,
          'updatedAt': DateTime.now(),
        });

        log('Balance updated successfully for account: $accountId');

        // Optionally: Create a transaction record
        await accountRef.collection('transactions').add({
          'type': 'withdraw',
          'amount': amount,
          'timestamp': DateTime.now(),
          'previousBalance': currentAccount.balance,
          'newBalance': newBalance,
          'status': 'completed',
          'recipientBank': bankName,
          'reciepientName': recipientName,
          'accountNumber': accountNumber,
        });
      } else {
        throw Exception('No user logged in');
      }
    } catch (e) {
      log('Error updateBalance: $e');
      throw e;
    }
  }
}
