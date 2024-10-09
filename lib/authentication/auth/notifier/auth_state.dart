import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

final class Checking extends AuthState {}

final class LoggedIn extends AuthState {}

final class LoggedOut extends AuthState {}

final class TokenExpired extends AuthState {}
