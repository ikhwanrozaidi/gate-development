import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gatepay_convert/profile/notifier/profile_state.dart';

import '../repository/service/profile_service.dart';

final profileNotifierProvider =
    NotifierProvider.autoDispose<ProfileNotifier, ProfileState>(
        ProfileNotifier.new);

class ProfileNotifier extends AutoDisposeNotifier<ProfileState> {
  @override
  ProfileState build() {
    getUserDetails();
    return ProfileLoading();
  }

  ProfileApiService get profileApiService =>
      ref.read(profileApiServiceProvider);

  Future<void> getUserDetails() async {
    try {
      state = ProfileLoading();
      final userData = await profileApiService.getUserDetails();

      state = ProfileLoaded(userData);
    } catch (e) {
      state = ProfileError(e.toString());
    }
  }
}
