import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'profile_state.dart';
import '../repository/service/profile_service.dart';

final profileNotifierProvider =
    NotifierProvider.autoDispose<ProfileNotifier, ProfileState>(
        ProfileNotifier.new);

class ProfileNotifier extends AutoDisposeNotifier<ProfileState> {
  @override
  ProfileState build() {
    userDetails();
    return ProfileLoading();
  }

  ProfileApiService get profileApiService =>
      ref.read(profileApiServiceProvider);

  Future<void> userDetails() async {
    try {
      state = ProfileLoading();
      final userData = await profileApiService.getUserDetails();

      if (userData != null) {
        state = ProfileLoaded(userData);
      } else {
        state = ProfileError('User data not found');
      }
    } catch (e) {
      state = ProfileError(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await profileApiService.signOut();
      state = ProfileInitial();
    } catch (e) {
      state = ProfileError(e.toString());
    }
  }
}
