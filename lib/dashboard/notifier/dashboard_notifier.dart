import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/service/dashboard_service.dart';
import 'dashboard_state.dart';

final dashboardNotifierProvider =
    NotifierProvider.autoDispose<DashboardNotifier, DashboardState>(
        DashboardNotifier.new);

class DashboardNotifier extends AutoDisposeNotifier<DashboardState> {
  @override
  DashboardState build() {
    // getDashboard();
    return DashboardLoaded();
  }

  DashboardApiService get dashboardApiService =>
      ref.read(dashboardApiServiceProvider);
}
