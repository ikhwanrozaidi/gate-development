import 'package:equatable/equatable.dart';

abstract class VerifyState extends Equatable {
  const VerifyState();

  @override
  List<Object?> get props => [];
}

class VerifyInitial extends VerifyState {}

class VerifyLoading extends VerifyState {}

class VerifyLoaded extends VerifyState {
  final UsernameStatus? usernameStatus;

  const VerifyLoaded({this.usernameStatus});

  @override
  List<Object?> get props => [usernameStatus];
}

class VerifyError extends VerifyState {
  final String error;

  const VerifyError(this.error);

  @override
  List<Object?> get props => [error];
}

enum UsernameStatus { available, taken, checking, invalid, none }
