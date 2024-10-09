import 'package:equatable/equatable.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();
  @override
  List<Object?> get props => [];
}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {}

final class DashboardError extends DashboardState {}
