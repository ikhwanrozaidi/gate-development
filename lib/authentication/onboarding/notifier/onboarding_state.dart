part of 'onboarding_notifier.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
    this.page = 0,
  });

  final int page;

  OnboardingState copyWith({
    int? page,
  }) {
    return OnboardingState(
      page: page ?? this.page,
    );
  }

  @override
  List<Object> get props => [page];
}
