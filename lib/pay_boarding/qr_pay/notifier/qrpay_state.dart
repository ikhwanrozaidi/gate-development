import 'package:equatable/equatable.dart';

sealed class QrpayState extends Equatable {
  const QrpayState();
  @override
  List<Object?> get props => [];
}

final class QrpayInitial extends QrpayState {}

final class QrpayLoading extends QrpayState {}

class QrpayLoaded extends QrpayState {}

final class QrpayError extends QrpayState {}
