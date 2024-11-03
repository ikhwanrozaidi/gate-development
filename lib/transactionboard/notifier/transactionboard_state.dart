import 'package:equatable/equatable.dart';
import '../repository/data-classes/order_history_model.dart';

abstract class TransactionboardState extends Equatable {
  const TransactionboardState();

  @override
  List<Object?> get props => [];
}

class TransactionboardInitial extends TransactionboardState {}

class TransactionboardLoading extends TransactionboardState {}

class TransactionboardLoaded extends TransactionboardState {
  final double withheldPayment;
  final double awaitingPayment;
  final List<OrderHistory> ongoingOrders;

  const TransactionboardLoaded({
    required this.withheldPayment,
    required this.awaitingPayment,
    required this.ongoingOrders,
  });

  @override
  List<Object?> get props => [withheldPayment, awaitingPayment, ongoingOrders];
}

class TransactionboardError extends TransactionboardState {
  final String error;

  const TransactionboardError(this.error);

  @override
  List<Object?> get props => [error];
}
