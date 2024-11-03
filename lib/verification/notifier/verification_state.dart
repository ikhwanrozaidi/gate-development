// lib/features/verification/notifier/verification_state.dart

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
  final VerificationStatus? verificationStatus;

  const VerifyLoaded({
    this.usernameStatus = UsernameStatus.none,
    this.verificationStatus = VerificationStatus.none,
  });

  @override
  List<Object?> get props => [usernameStatus, verificationStatus];

  VerifyLoaded copyWith({
    UsernameStatus? usernameStatus,
    VerificationStatus? verificationStatus,
  }) {
    return VerifyLoaded(
      usernameStatus: usernameStatus ?? this.usernameStatus,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }
}

class VerifyError extends VerifyState {
  final String error;

  const VerifyError(this.error);

  @override
  List<Object?> get props => [error];
}

enum UsernameStatus {
  available,
  taken,
  checking,
  invalid,
  none,
}

enum VerificationStatus {
  none,
  processing,
  completed,
  failed,
}
