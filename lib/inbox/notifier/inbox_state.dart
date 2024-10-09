import 'package:equatable/equatable.dart';

sealed class InboxState extends Equatable {
  const InboxState();
  @override
  List<Object?> get props => [];
}

final class InboxInitial extends InboxState {}

final class InboxLoading extends InboxState {}

class InboxLoaded extends InboxState {}

final class InboxError extends InboxState {}
