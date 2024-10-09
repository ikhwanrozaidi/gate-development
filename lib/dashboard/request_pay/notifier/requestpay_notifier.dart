import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/service/requestpay_service.dart';
import 'requestpay_state.dart';

final requestpayNotifierProvider =
    NotifierProvider.autoDispose<RequestpayNotifier, RequestpayState>(
        RequestpayNotifier.new);

class RequestpayNotifier extends AutoDisposeNotifier<RequestpayState> {
  @override
  RequestpayState build() {
    // getRequestpay();
    return RequestpayLoaded();
  }

  RequestpayApiService get requestpayApiService =>
      ref.read(requestpayApiServiceProvider);

  // List<String> _descriptions = [];

  // void addDescription(String description) {
  //   if (_descriptions.length < 5 && description.isNotEmpty) {
  //     _descriptions = [..._descriptions, description];
  //     state = RequestpayLoaded(descriptions: _descriptions);
  //   }
  // }

  // void removeDescription(int index) {
  //   _descriptions = _descriptions
  //       .asMap()
  //       .entries
  //       .where((entry) => entry.key != index)
  //       .map((e) => e.value)
  //       .toList();
  //   state = RequestpayLoaded(descriptions: _descriptions);
  // }
}
