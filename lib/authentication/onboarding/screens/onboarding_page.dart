// pageview_screen.dart
import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gatepay_convert/authentication/signup/screens/signup_page.dart';

import '../../signin/screens/signin_page.dart';
import '../notifier/onboarding_notifier.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const OnboardingPage());
  }

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPage();
}

class _OnboardingPage extends ConsumerState<OnboardingPage> {
  PageController pageController = PageController(initialPage: 0);
  Timer? _timer;
  double currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    _startAutoSwipe();
    pageController.addListener(_pageScrollListener);
  }

  void _startAutoSwipe() {
    const period = Duration(seconds: 5);
    int maxPage = 2;
    bool goingForward = true;

    _timer = Timer.periodic(period, (timer) {
      Duration pageDuration = const Duration(milliseconds: 800);
      if (goingForward) {
        if (pageController.page!.round() < maxPage) {
          pageController.nextPage(
              duration: pageDuration, curve: Curves.easeInOut);
        } else {
          goingForward = false;
          pageController.previousPage(
              duration: pageDuration, curve: Curves.easeInOut);
        }
      } else {
        if (pageController.page!.round() > 0) {
          pageController.previousPage(
              duration: pageDuration, curve: Curves.easeInOut);
        } else {
          goingForward = true;
          pageController.nextPage(
              duration: pageDuration, curve: Curves.easeInOut);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    pageController.dispose();
    pageController.removeListener(_pageScrollListener);
    super.dispose();
  }

  void _pageScrollListener() {
    setState(() {
      currentPageValue = pageController.page ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: h / 10, right: 40.0, left: 40.0),
              child: PageView(
                  scrollDirection: Axis.horizontal,
                  reverse: false,
                  onPageChanged: (index) {
                    // print('------$index');
                    ref.read(onboardingProvider.notifier).pageChanged(index);
                  },
                  controller: pageController,
                  pageSnapping: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: w * 20,
                          height: h / 2.8,
                          child: Image.asset('assets/images/pageview-1.png',
                              fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          'SECURE YOUR TRANSACTION',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // fontSize: w / 25,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Shop and sell with confidence! Protects every transaction with advanced security, keeping your money safe in every step.',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: w * 20,
                          height: h / 2.8,
                          child: Image.asset('assets/images/pageview-2.png',
                              fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          'FLEXIBLE ESCROW',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // fontSize: w / 25,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Escrow adjusts to your needs, holding funds securely until everyone's happy, making transactions smooth and stress-free.",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: w * 20,
                          height: h / 2.8,
                          child: Image.asset('assets/images/pageview-3.png',
                              fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          'REFER A FRIEND, EARN REWARDS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // fontSize: w / 25,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Bring friends to GatePay and earn rewards together! Each referral brings you both a step closer to bonus perks.",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
          DotsIndicator(
            mainAxisAlignment: MainAxisAlignment.center,
            reversed: false,
            dotsCount: 3,
            position: currentPageValue,
            decorator: DotsDecorator(
                color: Colors.grey.shade300,
                activeColor: const Color.fromARGB(255, 53, 97, 255),
                size: const Size.square(8.0),
                activeSize: const Size(30.0, 10.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                spacing: const EdgeInsets.all(4)),
          ),
          SizedBox(height: w * 0.1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 53, 97, 255),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      // fontSize: 16,
                      // fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              SizedBox(width: w * 0.08),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.blue, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                      // fontSize: 16,
                      // fontWeight: FontWeight.w600,
                      ),
                ),
              )
            ],
          ),
          SizedBox(height: w * 0.3),
        ],
      ),
    );
  }

  Widget buildTLogin(BuildContext context, int index, String title) {
    return GestureDetector(
      child: Container(
        width: 325,
        height: 50,
        margin: const EdgeInsets.only(top: 100, left: 25, right: 25),
        decoration: const BoxDecoration(color: Colors.blue),
        child: Center(
          child: Text(title),
        ),
      ),
      onTap: () {
        if (index < 3) {
          pageController.animateToPage(index,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        } else {}
      },
    );
  }
}
