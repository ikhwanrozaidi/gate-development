import 'package:equatable/equatable.dart';

sealed class TransactionboardState extends Equatable {
  const TransactionboardState();
  @override
  List<Object?> get props => [];
}

final class TransactionboardInitial extends TransactionboardState {}

final class TransactionboardLoading extends TransactionboardState {}

class TransactionboardLoaded extends TransactionboardState {}

final class TransactionboardError extends TransactionboardState {}
