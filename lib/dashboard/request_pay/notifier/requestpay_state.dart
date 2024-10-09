import 'package:equatable/equatable.dart';

sealed class RequestpayState extends Equatable {
  const RequestpayState();
  @override
  List<Object?> get props => [];
}

final class RequestpayInitial extends RequestpayState {}

final class RequestpayLoading extends RequestpayState {}

class RequestpayLoaded extends RequestpayState {}

final class RequestpayError extends RequestpayState {}
