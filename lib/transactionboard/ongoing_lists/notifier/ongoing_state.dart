import 'package:equatable/equatable.dart';

sealed class OngoingState extends Equatable {
  const OngoingState();
  @override
  List<Object?> get props => [];
}

final class OngoingInitial extends OngoingState {}

final class OngoingLoading extends OngoingState {}

class OngoingLoaded extends OngoingState {}

final class OngoingError extends OngoingState {}
