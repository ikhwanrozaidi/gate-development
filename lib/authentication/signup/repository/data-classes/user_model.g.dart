// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: json['userId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      email: json['email'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      country: json['country'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      nationality: json['nationality'] as String? ?? '',
      profilePic: json['profilePic'] as String? ?? '',
      username: json['username'] as String? ?? '',
      isVerify: json['isVerify'] as bool? ?? false,
      fullName: json['fullName'] as String? ?? '',
      gateScore: (json['gateScore'] as num?)?.toInt() ?? 0,
      fcmToken: json['fcmToken'] as String? ?? '',
      directReferral: (json['directReferral'] as num?)?.toInt() ?? 0,
      customFields: (json['customFields'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          [],
      totalReferral: (json['totalReferral'] as num?)?.toInt() ?? 0,
      userReferral: (json['userReferral'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userId': instance.userId,
      'title': instance.title,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'country': instance.country,
      'phone': instance.phone,
      'nationality': instance.nationality,
      'profilePic': instance.profilePic,
      'username': instance.username,
      'isVerify': instance.isVerify,
      'fullName': instance.fullName,
      'gateScore': instance.gateScore,
      'fcmToken': instance.fcmToken,
      'directReferral': instance.directReferral,
      'customFields': instance.customFields,
      'totalReferral': instance.totalReferral,
      'userReferral': instance.userReferral,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
