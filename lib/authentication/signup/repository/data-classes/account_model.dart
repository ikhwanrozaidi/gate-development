import 'package:json_annotation/json_annotation.dart';

part 'account_model.g.dart';

@JsonSerializable()
class AccountModel {
  @JsonKey(defaultValue: '')
  final String accountId;

  @JsonKey(defaultValue: '')
  final String businessName;

  @JsonKey(defaultValue: '')
  final String username;

  @JsonKey(defaultValue: '')
  final String phone;

  @JsonKey(defaultValue: '')
  final String accountNumber;

  @JsonKey(defaultValue: '')
  final String expiryDate;

  @JsonKey(defaultValue: 'MYR')
  final String currency;

  @JsonKey(defaultValue: 0.0)
  final double balance;

  @JsonKey(defaultValue: 0.0)
  final double receivingTransaction;

  @JsonKey(defaultValue: 0.0)
  final double payingTransaction;

  @JsonKey(defaultValue: 0.0)
  final double totalTransactionDone;

  @JsonKey(defaultValue: 0.0)
  final double receivedTransaction;

  @JsonKey(defaultValue: 0.0)
  final double paidTransaction;

  @JsonKey(defaultValue: '')
  final String profilePic;

  @JsonKey(defaultValue: 0)
  final int gateScore;

  @JsonKey(defaultValue: false)
  final bool isVerify;

  @JsonKey(defaultValue: '')
  final String fcmToken;

  @JsonKey(defaultValue: [])
  final List<Map<String, dynamic>> customFields;

  @JsonKey(defaultValue: null)
  final BusinessDoc? businessDoc;

  @JsonKey(defaultValue: null)
  final DateTime? createdAt;



  AccountModel({
    required this.accountId,
    this.businessName = '',
    this.username = '',
    this.phone = '',
    this.accountNumber = '',
    this.expiryDate = '',
    this.currency = 'MYR',
    this.balance = 0.0,
    this.receivingTransaction = 0.0,
    this.payingTransaction = 0.0,
    this.totalTransactionDone = 0.0,
    this.receivedTransaction = 0.0,
    this.paidTransaction = 0.0,
    this.profilePic = '',
    this.gateScore = 0,
    this.isVerify = false,
    this.fcmToken = '',
    this.customFields = const [],
    this.businessDoc,
    this.createdAt,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);
}

@JsonSerializable()
class BusinessDoc {
  @JsonKey(defaultValue: '')
  final String ssmCert;

  @JsonKey(defaultValue: '')
  final String businessCategory;

  @JsonKey(defaultValue: '')
  final String businessDescription;

  @JsonKey(defaultValue: '')
  final String businessPhone;

  @JsonKey(defaultValue: false)
  final bool isAgent;

  @JsonKey(defaultValue: '')
  final String frontIc;

  @JsonKey(defaultValue: '')
  final String backIc;

  BusinessDoc({
    this.ssmCert = '',
    this.businessCategory = '',
    this.businessDescription = '',
    this.businessPhone = '',
    this.isAgent = false,
    this.frontIc = '',
    this.backIc = '',
  });

  factory BusinessDoc.fromJson(Map<String, dynamic> json) => _$BusinessDocFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessDocToJson(this);
}