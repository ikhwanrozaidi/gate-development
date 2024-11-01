import 'package:equatable/equatable.dart';
import '../../authentication/signup/repository/data-classes/user_model.dart';

abstract class VerifyState extends Equatable {
  const VerifyState();

  @override
  List<Object?> get props => [];
}

class VerifyInitial extends VerifyState {}

class VerifyLoading extends VerifyState {}

class VerifyLoaded extends VerifyState {}

class VerifyError extends VerifyState {
  final String error;

  const VerifyError(this.error);

  @override
  List<Object?> get props => [error];
}
