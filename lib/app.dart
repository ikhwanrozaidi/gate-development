import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gatepay_convert/authentication/onboarding/screens/onboarding_page.dart';
import 'package:gatepay_convert/authentication/signup/screens/signup_page.dart';
import 'package:gatepay_convert/authentication/test_page/test_page.dart';

import 'authentication/auth/notifier/auth_notifier.dart';
import 'authentication/auth/notifier/auth_state.dart';
// import 'authentication/navigation_bar/navigation_bar.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  static PageRoute route() {
    return PageRouteBuilder(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      pageBuilder: (context, anim1, anim2) {
        return const AnimatedSwitcher(
          duration: Duration(milliseconds: 1000),
          child: App(),
        );
      },
      settings: const RouteSettings(name: '/app'),
    );
  }

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);

    return Scaffold(
      body: Stack(
        children: [
          if (state is LoggedIn) const Page2(),
          if (state is LoggedOut) const OnboardingPage(),
        ],
      ),
    );
  }
}
