import 'package:equatable/equatable.dart';

import '../../authentication/signup/repository/data-classes/account_model.dart';

abstract class WithdrawState extends Equatable {
  const WithdrawState();

  @override
  List<Object?> get props => [];
}

class WithdrawInitial extends WithdrawState {}

class WithdrawLoading extends WithdrawState {}

class WithdrawLoaded extends WithdrawState {
  final AccountModel account;

  const WithdrawLoaded(this.account);

  @override
  List<Object?> get props => [account];
}

class WithdrawProcessing extends WithdrawState {}

class WithdrawSuccess extends WithdrawState {
  final double newBalance;

  const WithdrawSuccess(this.newBalance);

  @override
  List<Object?> get props => [newBalance];
}

class WithdrawError extends WithdrawState {
  final String error;

  const WithdrawError(this.error);

  @override
  List<Object?> get props => [error];
}
