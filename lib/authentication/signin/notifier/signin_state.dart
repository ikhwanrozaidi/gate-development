import 'package:equatable/equatable.dart';

sealed class SignInState extends Equatable {
  const SignInState();
  @override
  List<Object?> get props => [];
}

final class SignInInitial extends SignInState {}

final class SignInLoading extends SignInState {}

class SignInLoaded extends SignInState {}

final class SignInError extends SignInState {}
