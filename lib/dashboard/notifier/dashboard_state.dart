import 'package:equatable/equatable.dart';

import '../../authentication/signup/repository/data-classes/account_model.dart';
import '../../authentication/signup/repository/data-classes/user_model.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final UserModel userData;
  final List<AccountModel> accounts;
  final AccountModel defaultAccount;

  const DashboardLoaded(
    this.userData,
    this.accounts,
    this.defaultAccount,
  );

  @override
  List<Object?> get props => [userData, accounts, defaultAccount];
}

class DashboardError extends DashboardState {
  final String error;

  const DashboardError(this.error);

  @override
  List<Object?> get props => [error];
}
