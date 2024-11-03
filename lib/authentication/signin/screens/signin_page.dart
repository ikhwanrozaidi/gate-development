import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app_drawer/screen/app_drawer.dart';
import '../../../shared/utils/blurred_bg_loading.dart';
import '../../../shared/utils/theme.dart';
import '../../onboarding/screens/onboarding_page.dart';
import '../../signup/screens/signup_page.dart';
import '../notifier/signin_notifier.dart';
import '../notifier/signin_state.dart';
import '../repository/service/signin_service.dart';

class SignInPage extends ConsumerStatefulWidget {
  final String? title;
  const SignInPage({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isSwitched = false;
  bool _isObscured = true;

  void _onToggleSwitch(bool newValue) {
    setState(() {
      isSwitched = newValue;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      final signInService = ref.read(signInApiServiceProvider);
      final result = await signInService.signIn(
        _emailController.text,
        _passwordController.text,
      );

      if (result['success']) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AppDrawer()),
          (Route<dynamic> route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['error'] ?? 'Sign in failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signInNotifierProvider);
    final w = MediaQuery.of(context).size.width;

    Widget serverErrorHolder() {
      return LayoutBuilder(
        builder: (context, cons) {
          return ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                constraints: BoxConstraints(minHeight: cons.maxHeight),
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      // ref
                      //     .read(SignInNotifierProvider.notifier)
                      //     .getSignIn();
                    },
                    child: const Chip(
                      label: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.refresh, color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                'Try again',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      backgroundColor: tPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    Widget bodyContent;
    if (state is SignInLoaded) {
      bodyContent = Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.of(context).pushAndRemoveUntil(
                      //   MaterialPageRoute(
                      //       builder: (context) => OnboardingPage()),
                      //   (Route<dynamic> route) => false,
                      // );
                    },
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      margin: EdgeInsets.only(top: w * 0.1),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 200, 222, 255),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: tPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Hey, Welcome Back!',
                    style: TextStyle(
                        fontFamily: tSecondaryFont,
                        fontWeight: FontWeight.w700,
                        fontSize: w * 0.07),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Your Email',
                    style: TextStyle(
                      fontFamily: tSecondaryFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    style: TextStyle(
                      fontFamily: tSecondaryFont,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: tPrimaryBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Password',
                    style: TextStyle(
                      fontFamily: tSecondaryFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    style: TextStyle(
                      fontFamily: tSecondaryFont,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: tPrimaryBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscured ? Icons.visibility_off : Icons.visibility,
                          color: Color.fromARGB(255, 147, 171, 255),
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    obscureText: _isObscured,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Password must be at least 6 characters long.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Transform.scale(
                            scale: 0.8,
                            child: Switch(
                              value: isSwitched,
                              onChanged: _onToggleSwitch,
                              activeColor: tPrimaryColor,
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: Colors.grey[300],
                            ),
                          ),
                          Text(
                            isSwitched ? "Don't forget me!" : "Forget me?",
                            style: TextStyle(
                              fontFamily: tSecondaryFont,
                              fontSize: w * 0.035,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 147, 171, 255),
                            fontFamily: tSecondaryFont,
                            fontSize: w * 0.035,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () async {
                      await _signIn();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: tPrimaryColor,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('Sign In', style: TextStyle(fontSize: 16)),
                  ),
                  // OutlinedButton(
                  //   onPressed: () {},
                  //   style: OutlinedButton.styleFrom(
                  //     side: BorderSide(color: tPrimaryColor, width: 2),
                  //     foregroundColor: tPrimaryColor,
                  //     minimumSize: Size(double.infinity, 50),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),
                  //     backgroundColor: Colors.white,
                  //   ),
                  //   child: Text('Sign In with Google',
                  //       style: TextStyle(fontSize: 16)),
                  // ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                        fontFamily: tSecondaryFont,
                        fontSize: w * 0.035,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Register',
                          style: TextStyle(
                            color: tPrimaryColor,
                            fontSize: w * 0.03,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
    } else if (state is SignInLoading) {
      bodyContent = Center(
        child: buildLoadingIndicator(
          blur: 0,
          isCentered: true,
        ),
      );
    } else if (state is SignInError) {
      bodyContent = serverErrorHolder();
    } else {
      bodyContent = serverErrorHolder();
    }

    return Scaffold(
      body: bodyContent,
    );
  }
}
