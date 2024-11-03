import 'package:equatable/equatable.dart';

abstract class EscrowpayState extends Equatable {
  const EscrowpayState();

  @override
  List<Object?> get props => [];
}

class EscrowpayInitial extends EscrowpayState {}

class EscrowpayLoading extends EscrowpayState {}

class EscrowpayLoaded extends EscrowpayState {
  final UsernameStatus? usernameStatus;
  final VerificationStatus? verificationStatus;

  const EscrowpayLoaded({
    this.usernameStatus = UsernameStatus.none,
    this.verificationStatus = VerificationStatus.none,
  });

  @override
  List<Object?> get props => [usernameStatus, verificationStatus];

  EscrowpayLoaded copyWith({
    UsernameStatus? usernameStatus,
    VerificationStatus? verificationStatus,
  }) {
    return EscrowpayLoaded(
      usernameStatus: usernameStatus ?? this.usernameStatus,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }
}

class EscrowpayError extends EscrowpayState {
  final String error;

  const EscrowpayError(this.error);

  @override
  List<Object?> get props => [error];
}

enum UsernameStatus {
  valid,
  invalid,
  nouser,
  checking,
  none,
}

enum VerificationStatus {
  none,
  processing,
  completed,
  failed,
}
