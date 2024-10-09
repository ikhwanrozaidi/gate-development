import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/service/escrowpay_service.dart';
import 'escrowpay_state.dart';

final escrowpayNotifierProvider =
    NotifierProvider.autoDispose<EscrowpayNotifier, EscrowpayState>(
        EscrowpayNotifier.new);

class EscrowpayNotifier extends AutoDisposeNotifier<EscrowpayState> {
  @override
  EscrowpayState build() {
    // getEscrowpay();
    return EscrowpayLoaded();
  }

  EscrowpayApiService get escrowpayApiService =>
      ref.read(escrowpayApiServiceProvider);

  // List<String> _descriptions = [];

  // void addDescription(String description) {
  //   if (_descriptions.length < 5 && description.isNotEmpty) {
  //     _descriptions = [..._descriptions, description];
  //     state = EscrowpayLoaded(descriptions: _descriptions);
  //   }
  // }

  // void removeDescription(int index) {
  //   _descriptions = _descriptions
  //       .asMap()
  //       .entries
  //       .where((entry) => entry.key != index)
  //       .map((e) => e.value)
  //       .toList();
  //   state = EscrowpayLoaded(descriptions: _descriptions);
  // }
}
