import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gatepay_convert/transactionboard/notifier/transactionboard_state.dart';

import '../repository/data-classes/order_history_model.dart';
import '../repository/service/transactionboard_service.dart';

final transactionboardNotifierProvider = NotifierProvider.autoDispose<
    TransactionboardNotifier,
    TransactionboardState>(TransactionboardNotifier.new);

class TransactionboardNotifier
    extends AutoDisposeNotifier<TransactionboardState> {
  @override
  TransactionboardState build() {
    getTransactionSummary();
    return TransactionboardLoading();
  }

  TransactionboardApiService get transactionboardApiService =>
      ref.read(transactionboardApiServiceProvider);

  Future<void> getTransactionSummary() async {
    try {
      state = TransactionboardLoading();

      // Get orders from service
      final orders = await transactionboardApiService.getOrderHistory();

      // Process orders in the notifier
      double withheldPayment = 0.0;
      double awaitingPayment = 0.0;
      List<OrderHistory> ongoingOrders = [];

      for (var order in orders) {
        // Add to withheld if outgoing and not completed
        if (order.orderStatus == 'outgoing' && order.deliveryStatus != 4) {
          withheldPayment += order.actualPrice;
        }

        // Add to awaiting if incoming and not completed
        if (order.orderStatus == 'incoming' && order.deliveryStatus != 4) {
          awaitingPayment += order.actualPrice;
        }

        // Add to ongoing list if not completed
        if (order.deliveryStatus != 4) {
          ongoingOrders.add(order);
        }
      }

      // Sort ongoing orders by date
      ongoingOrders.sort((a, b) => (b.createdAt ?? DateTime.now())
          .compareTo(a.createdAt ?? DateTime.now()));

      state = TransactionboardLoaded(
        withheldPayment: withheldPayment,
        awaitingPayment: awaitingPayment,
        ongoingOrders: ongoingOrders,
      );
    } catch (e) {
      log('Error getting transaction summary: $e');
      state = TransactionboardError(e.toString());
    }
  }

  // Additional helper methods can be added here
  List<OrderHistory> getFilteredOrders({
    required List<OrderHistory> orders,
    String? status,
    bool onlyActive = true,
  }) {
    return orders.where((order) {
      if (onlyActive && order.deliveryStatus == 4) return false;
      if (status != null && order.orderStatus != status) return false;
      return true;
    }).toList();
  }

  double calculateTotal(List<OrderHistory> orders, String type) {
    return orders
        .where(
            (order) => order.orderStatus == type && order.deliveryStatus != 4)
        .fold(0.0, (sum, order) => sum + order.payingTransaction);
  }
}
