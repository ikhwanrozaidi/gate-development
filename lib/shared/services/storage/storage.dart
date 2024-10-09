import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final storageServiceProvider = Provider((ref) {
  return StorageService(ref, const FlutterSecureStorage());
});

class StorageService {
  Ref ref;
  StorageService(this.ref, this.secureStorage);

  late final SharedPreferences sharedPrefs;
  final FlutterSecureStorage secureStorage;

  final String kAccessTokenKey = 'accessToken';
  final String kRefreshTokenKey = 'refreshToken';
  final String kUserDataKey = 'userData';
  final String kFirstInstallKey = 'firstInstall';

  String? _accessToken;
  String? _refreshToken;
  Map<String, dynamic>? _userData;

  Future<void> initStorage() async {
    try {
      sharedPrefs = await SharedPreferences.getInstance();
      bool? isFirstInstall = sharedPrefs.getBool(kFirstInstallKey);
      if (isFirstInstall == null || !isFirstInstall) {
        await secureStorage.deleteAll();
        await sharedPrefs.setBool(kFirstInstallKey, true);
      }
    } catch (e) {
      print('SharedPreferences initialization failed: $e');
      // Continue without SharedPreferences
    }
  }

  Future<void> setAccessToken(String? token) async {
    await secureStorage.write(key: kAccessTokenKey, value: token);
    _accessToken = token;
  }

  Future<void> setRefreshToken(String? token) async {
    await secureStorage.write(key: kRefreshTokenKey, value: token);
    _refreshToken = token;
  }

  Future<void> setUserData(Map<String, dynamic> data) async {
    await secureStorage.write(key: kUserDataKey, value: json.encode(data));
    _userData = data;
  }

  Future<String?> get accessToken async {
    if (_accessToken != null) return _accessToken;
    return await secureStorage.read(key: kAccessTokenKey);
  }

  Future<String?> get refreshToken async {
    if (_refreshToken != null) return _refreshToken;
    return await secureStorage.read(key: kRefreshTokenKey);
  }

  Future<Map<String, dynamic>?> get userData async {
    if (_userData != null) return _userData;
    final data = await secureStorage.read(key: kUserDataKey);
    return data != null ? json.decode(data) : null;
  }

  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
    await Future.wait([
      secureStorage.delete(key: kAccessTokenKey),
      secureStorage.delete(key: kRefreshTokenKey),
    ]);
  }

  Future<void> clearAll() async {
    _accessToken = null;
    _refreshToken = null;
    _userData = null;
    await secureStorage.deleteAll();
  }

  Future<void> logout() async {
    await Future.wait([
      secureStorage.delete(key: kAccessTokenKey),
      secureStorage.delete(key: kRefreshTokenKey),
      secureStorage.delete(key: kUserDataKey),
    ]);
  }
}
