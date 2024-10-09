import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data-classes/account_model.dart';
import '../data-classes/user_model.dart';

final signUpApiServiceProvider = Provider.autoDispose(
  (ref) {
    return SignUpApiService(
      ref: ref,
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    );
  },
);

abstract class SignUpService {}

class SignUpApiService extends SignUpService {
  final Ref ref;
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  SignUpApiService({
    required this.ref,
    required this.auth,
    required this.firestore,
  });

  Future<bool> checkEmailExists(String email) async {
    try {
      var methods = await auth.fetchSignInMethodsForEmail(email);
      return methods.isNotEmpty;
    } catch (e) {
      log('Error checkEmailExists: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> signUp(String email, String password,
      Map<String, dynamic> additionalData) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await storeUserDetails(userCredential.user!.uid, additionalData);

        final String? accessToken = await userCredential.user?.getIdToken();
        if (accessToken != null) {
          log('Sign up successful. Access token generated.');
          return {'success': true, 'accessToken': accessToken};
        } else {
          log('Sign up failed: No access token received');
          return {'success': false, 'error': 'No access token received'};
        }
      } else {
        log('Sign up failed: User is null');
        return {'success': false, 'error': 'User creation failed'};
      }
    } catch (e) {
      log('Error signUp: $e');
      return {'success': false, 'error': e.toString()};
    }
  }

  Future<void> storeUserDetails(
      String uid, Map<String, dynamic> userDetails) async {
    try {
      final user = UserModel(
        userId: uid,
        title: userDetails['title'] ?? '',
        email: userDetails['email'] ?? '',
        firstName: userDetails['firstName'] ?? '',
        lastName: userDetails['lastName'] ?? '',
        country: userDetails['country'] ?? 'MYR',
        phone: userDetails['phone'] ?? '',
        nationality: userDetails['nationality'] ?? '',
        profilePic: userDetails['profilePic'] ?? '',
        username: userDetails['username'] ?? '',
        isVerify: false,
        fullName: userDetails['fullName'] ?? '',
        gateScore: 0,
        fcmToken: userDetails['fcmToken'] ?? '',
        directReferral: 0,
        customFields: userDetails['customFields'] ?? [],
        userReferral: userDetails['userReferral'] ?? [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final account = Account(
        accountId: FirebaseFirestore.instance
            .collection('staging')
            .doc('staging')
            .collection('users')
            .doc(uid)
            .collection('account')
            .doc()
            .id,
        createdAt: DateTime.now(),
        businessName: userDetails['businessName'] ?? '',
        username: userDetails['username'] ?? '',
        phone: userDetails['phone'] ?? '',
        accountNumber: userDetails['accountNumber'] ?? '',
        expiryDate: userDetails['expiryDate'] ?? '',
        currency: userDetails['currency'] ?? '',
        balance: 0.0,
        receivingTransaction: 0.0,
        payingTransaction: 0.0,
        totalTransactionDone: 0.0,
        receivedTransaction: 0.0,
        paidTransaction: 0.0,
        profilePic: userDetails['profilePic'] ?? '',
        gateScore: 0,
        isVerify: false,
        fcmToken: userDetails['fcmToken'] ?? '',
        customFields: userDetails['customFields'] ?? [],
      );

      DocumentReference userDocRef = firestore
          .collection('staging')
          .doc('staging')
          .collection('users')
          .doc(uid);

      await userDocRef.set(user.toJson());

      DocumentReference accountDocRef =
          userDocRef.collection('account').doc(account.accountId);
      await accountDocRef.set(account.toJson());

      log('User details stored successfully for UID: $uid');
    } catch (e) {
      log('Error storeUserDetails: $e');
      rethrow;
    }
  }
}
