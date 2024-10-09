import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gatepay_convert/inbox/notifier/inbox_state.dart';

import '../repository/service/inbox_service.dart';

final inboxNotifierProvider =
    NotifierProvider.autoDispose<InboxNotifier, InboxState>(InboxNotifier.new);

class InboxNotifier extends AutoDisposeNotifier<InboxState> {
  @override
  InboxState build() {
    // getInbox();
    return InboxLoaded();
  }

  InboxApiService get inboxApiService => ref.read(inboxApiServiceProvider);
}
