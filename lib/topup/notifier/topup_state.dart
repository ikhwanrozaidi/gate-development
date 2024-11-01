import 'package:equatable/equatable.dart';

import '../../authentication/signup/repository/data-classes/account_model.dart';

abstract class TopupState extends Equatable {
  const TopupState();

  @override
  List<Object?> get props => [];
}

class TopupInitial extends TopupState {}

class TopupLoading extends TopupState {}

class TopupLoaded extends TopupState {
  final AccountModel account;

  const TopupLoaded(this.account);

  @override
  List<Object?> get props => [account];
}

class TopupProcessing extends TopupState {}

class TopupSuccess extends TopupState {
  final double newBalance;

  const TopupSuccess(this.newBalance);

  @override
  List<Object?> get props => [newBalance];
}

class TopupError extends TopupState {
  final String error;

  const TopupError(this.error);

  @override
  List<Object?> get props => [error];
}
