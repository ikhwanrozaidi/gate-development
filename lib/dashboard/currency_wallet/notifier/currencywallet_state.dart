import 'package:equatable/equatable.dart';

sealed class CurrencyWalletState extends Equatable {
  const CurrencyWalletState();
  @override
  List<Object?> get props => [];
}

final class CurrencyWalletInitial extends CurrencyWalletState {}

final class CurrencyWalletLoading extends CurrencyWalletState {}

class CurrencyWalletLoaded extends CurrencyWalletState {}

final class CurrencyWalletError extends CurrencyWalletState {}
