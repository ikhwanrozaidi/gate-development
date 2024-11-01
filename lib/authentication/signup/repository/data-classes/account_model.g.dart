// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) => AccountModel(
      accountId: json['accountId'] as String? ?? '',
      businessName: json['businessName'] as String? ?? '',
      username: json['username'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      accountNumber: json['accountNumber'] as String? ?? '',
      expiryDate: json['expiryDate'] as String? ?? '',
      currency: json['currency'] as String? ?? 'MYR',
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
      receivingTransaction:
          (json['receivingTransaction'] as num?)?.toDouble() ?? 0.0,
      payingTransaction: (json['payingTransaction'] as num?)?.toDouble() ?? 0.0,
      totalTransactionDone:
          (json['totalTransactionDone'] as num?)?.toDouble() ?? 0.0,
      receivedTransaction:
          (json['receivedTransaction'] as num?)?.toDouble() ?? 0.0,
      paidTransaction: (json['paidTransaction'] as num?)?.toDouble() ?? 0.0,
      profilePic: json['profilePic'] as String? ?? '',
      gateScore: (json['gateScore'] as num?)?.toInt() ?? 0,
      isVerify: json['isVerify'] as bool? ?? false,
      fcmToken: json['fcmToken'] as String? ?? '',
      customFields: (json['customFields'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          [],
      businessDoc: json['businessDoc'] == null
          ? null
          : BusinessDoc.fromJson(json['businessDoc'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AccountModelToJson(AccountModel instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'businessName': instance.businessName,
      'username': instance.username,
      'phone': instance.phone,
      'accountNumber': instance.accountNumber,
      'expiryDate': instance.expiryDate,
      'currency': instance.currency,
      'balance': instance.balance,
      'receivingTransaction': instance.receivingTransaction,
      'payingTransaction': instance.payingTransaction,
      'totalTransactionDone': instance.totalTransactionDone,
      'receivedTransaction': instance.receivedTransaction,
      'paidTransaction': instance.paidTransaction,
      'profilePic': instance.profilePic,
      'gateScore': instance.gateScore,
      'isVerify': instance.isVerify,
      'fcmToken': instance.fcmToken,
      'customFields': instance.customFields,
      'businessDoc': instance.businessDoc,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

BusinessDoc _$BusinessDocFromJson(Map<String, dynamic> json) => BusinessDoc(
      ssmCert: json['ssmCert'] as String? ?? '',
      businessCategory: json['businessCategory'] as String? ?? '',
      businessDescription: json['businessDescription'] as String? ?? '',
      businessPhone: json['businessPhone'] as String? ?? '',
      isAgent: json['isAgent'] as bool? ?? false,
      frontIc: json['frontIc'] as String? ?? '',
      backIc: json['backIc'] as String? ?? '',
    );

Map<String, dynamic> _$BusinessDocToJson(BusinessDoc instance) =>
    <String, dynamic>{
      'ssmCert': instance.ssmCert,
      'businessCategory': instance.businessCategory,
      'businessDescription': instance.businessDescription,
      'businessPhone': instance.businessPhone,
      'isAgent': instance.isAgent,
      'frontIc': instance.frontIc,
      'backIc': instance.backIc,
    };
