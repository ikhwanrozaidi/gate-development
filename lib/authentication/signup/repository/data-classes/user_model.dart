import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(defaultValue: '')
  final String userId;

  @JsonKey(defaultValue: '')
  final String title;

  @JsonKey(defaultValue: '')
  final String email;

  @JsonKey(defaultValue: '')
  final String firstName;

  @JsonKey(defaultValue: '')
  final String lastName;

  @JsonKey(defaultValue: '')
  final String country;

  @JsonKey(defaultValue: '')
  final String phone;

  @JsonKey(defaultValue: '')
  final String nationality;

  @JsonKey(defaultValue: '')
  final String profilePic;

  @JsonKey(defaultValue: '')
  final String username;

  @JsonKey(defaultValue: false)
  final bool isVerify;

  @JsonKey(defaultValue: '')
  final String fullName;

  @JsonKey(defaultValue: 0)
  final int gateScore;

  @JsonKey(defaultValue: '')
  final String fcmToken;

  @JsonKey(defaultValue: 0)
  final int directReferral;

  @JsonKey(defaultValue: [])
  final List<Map<String, dynamic>> customFields;

  @JsonKey(defaultValue: 0)
  final int totalReferral;

  @JsonKey(defaultValue: [])
  final List<String> userReferral;

  @JsonKey(defaultValue: null)
  final DateTime? createdAt;

  @JsonKey(defaultValue: null)
  final DateTime? updatedAt;

  UserModel({
    required this.userId,
    this.title = '',
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.country = '',
    this.phone = '',
    this.nationality = '',
    this.profilePic = '',
    this.username = '',
    this.isVerify = false,
    this.fullName = '',
    this.gateScore = 0,
    this.fcmToken = '',
    this.directReferral = 0,
    this.customFields = const [],
    this.totalReferral = 0,
    this.userReferral = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
