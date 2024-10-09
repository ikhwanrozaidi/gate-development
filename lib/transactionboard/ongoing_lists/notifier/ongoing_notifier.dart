import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/service/ongoing_service.dart';
import 'ongoing_state.dart';

final ongoingNotifierProvider =
    NotifierProvider.autoDispose<OngoingNotifier, OngoingState>(
        OngoingNotifier.new);

class OngoingNotifier extends AutoDisposeNotifier<OngoingState> {
  @override
  OngoingState build() {
    // getOngoing();
    return OngoingLoaded();
  }

  OngoingApiService get ongoingApiService =>
      ref.read(ongoingApiServiceProvider);
}
