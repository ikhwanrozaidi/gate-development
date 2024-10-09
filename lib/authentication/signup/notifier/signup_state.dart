import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpLoaded extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String accessToken;

  const SignUpSuccess(this.accessToken);

  @override
  List<Object?> get props => [accessToken];
}

class SignUpError extends SignUpState {
  final String error;

  const SignUpError(this.error);

  @override
  List<Object?> get props => [error];
}
