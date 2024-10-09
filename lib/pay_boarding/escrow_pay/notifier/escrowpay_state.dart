import 'package:equatable/equatable.dart';

sealed class EscrowpayState extends Equatable {
  const EscrowpayState();
  @override
  List<Object?> get props => [];
}

final class EscrowpayInitial extends EscrowpayState {}

final class EscrowpayLoading extends EscrowpayState {}

class EscrowpayLoaded extends EscrowpayState {}

final class EscrowpayError extends EscrowpayState {}
