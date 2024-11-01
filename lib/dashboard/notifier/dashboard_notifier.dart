import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profile/repository/service/profile_service.dart';
import '../repository/service/dashboard_service.dart';
import 'dashboard_state.dart';

final dashboardNotifierProvider =
    NotifierProvider.autoDispose<DashboardNotifier, DashboardState>(
        DashboardNotifier.new);

class DashboardNotifier extends AutoDisposeNotifier<DashboardState> {
  @override
  DashboardState build() {
    initialDashboard();
    return DashboardLoading();
  }

  DashboardApiService get dashboardApiService =>
      ref.read(dashboardApiServiceProvider);

  ProfileApiService get profileApiService =>
      ref.read(profileApiServiceProvider);

  Future<void> initialDashboard() async {
    try {
      state = DashboardLoading();

      final userData = await profileApiService.getUserDetails();
      final accounts = await dashboardApiService.getAccountDetails();

      if (accounts.isNotEmpty && userData != null) {
        // Find the default account
        final defaultAccount = accounts.firstWhere(
          (account) =>
              account.businessDoc == null && account.businessName.isEmpty,
          orElse: () => accounts.first,
        );

        state = DashboardLoaded(
          userData,
          accounts,
          defaultAccount,
        );
      } else {
        state = DashboardError('User data not found');
      }
    } catch (e) {
      state = DashboardError(e.toString());
    }
  }
}
