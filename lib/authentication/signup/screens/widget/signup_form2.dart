import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/utils/blurred_bg_loading.dart';
import '../../../../shared/utils/custom_checkbox.dart';
import '../../../../shared/utils/theme.dart';
import '../../../onboarding/screens/onboarding_page.dart';
import '../../notifier/signup_notifier.dart';
import '../../notifier/signup_state.dart';

class SignUpForm2 extends ConsumerStatefulWidget {
  final String email;
  final String password;
  final String title;
  final String firstName;
  final String lastName;
  final String country;

  const SignUpForm2({
    Key? key,
    required this.email,
    required this.password,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.country,
  }) : super(key: key);

  @override
  ConsumerState<SignUpForm2> createState() => _SignUpForm2State();
}

class _SignUpForm2State extends ConsumerState<SignUpForm2> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _dayController = TextEditingController();
  TextEditingController _monthController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  FocusNode _dayFocus = FocusNode();
  FocusNode _monthFocus = FocusNode();
  FocusNode _yearFocus = FocusNode();
  bool _agreedToCA = false;
  bool _agreedToAML = false;
  bool _agreedToPPRF = false;

  @override
  void initState() {
    super.initState();
    _dayController.addListener(() {
      if (_dayController.text.length == 2) {
        FocusScope.of(context).requestFocus(_monthFocus);
      }
    });
    _monthController.addListener(() {
      if (_monthController.text.length == 2) {
        FocusScope.of(context).requestFocus(_yearFocus);
      }
    });
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _dayFocus.dispose();
    _monthFocus.dispose();
    _yearFocus.dispose();
    super.dispose();
  }

  void _toggleAgreedToCA(bool? newValue) {
    setState(() {
      _agreedToCA = newValue!;
    });
  }

  void _toggleAgreedToAML(bool? newValue) {
    setState(() {
      _agreedToAML = newValue!;
    });
  }

  void _toggleAgreedToPPRF(bool? newValue) {
    setState(() {
      _agreedToPPRF = newValue!;
    });
  }

  Future<void> _finishSignUp() async {
    String dob =
        "${_dayController.text}/${_monthController.text}/${_yearController.text}";

    Map<String, dynamic> userDetails = {
      'email': widget.email,
      'title': widget.title,
      'firstName': widget.firstName,
      'lastName': widget.lastName,
      'country': widget.country,
      'dob': dob,
    };

    try {
      final signUpNotifier = ref.read(signUpNotifierProvider.notifier);

      await signUpNotifier.signUp(widget.email, widget.password, userDetails);
    } catch (e) {
      log('Error during sign up: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpNotifierProvider);
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

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
                      //     .read(SignUpNotifierProvider.notifier)
                      //     .getSignUp();
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
    if (state is SignUpLoaded) {
      bodyContent = Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 90),
                Text(
                  "Maybe we can celebrate your birthday?",
                  style: TextStyle(
                      fontFamily: tSecondaryFont,
                      fontWeight: FontWeight.w700,
                      fontSize: w * 0.07),
                ),
                SizedBox(height: 40),
                Text(
                  'Date of Birth',
                  style: TextStyle(
                    fontFamily: tSecondaryFont,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: _dayController,
                        focusNode: _dayFocus,
                        decoration: InputDecoration(
                          hintText: 'DD',
                          filled: true,
                          fillColor: tPrimaryBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: TextField(
                        controller: _monthController,
                        focusNode: _monthFocus,
                        decoration: InputDecoration(
                          hintText: 'MM',
                          filled: true,
                          fillColor: tPrimaryBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: TextField(
                        controller: _yearController,
                        focusNode: _yearFocus,
                        decoration: InputDecoration(
                          hintText: 'YYYY',
                          filled: true,
                          fillColor: tPrimaryBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    CustomCheckbox(
                      value: _agreedToCA,
                      onChanged: _toggleAgreedToCA,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _toggleAgreedToCA(!_agreedToCA),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: w * 0.035,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'I agree to the '),
                              TextSpan(
                                text: 'Client Agreement',
                                style: TextStyle(
                                    color: tPrimaryColor,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomCheckbox(
                      value: _agreedToAML,
                      onChanged: _toggleAgreedToAML,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _toggleAgreedToAML(!_agreedToAML),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: w * 0.035,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'I agree to the '),
                              TextSpan(
                                text: 'AML Policy',
                                style: TextStyle(
                                    color: tPrimaryColor,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomCheckbox(
                      value: _agreedToPPRF,
                      onChanged: _toggleAgreedToPPRF,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _toggleAgreedToPPRF(!_agreedToPPRF),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: w * 0.035,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'I agree to the '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                    color: tPrimaryColor,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                              TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Refund Policy',
                                style: TextStyle(
                                    color: tPrimaryColor,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: h / 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await _finishSignUp();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => OnboardingPage()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: tPrimaryColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        // minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      child: Text('Complete', style: GoogleFonts.poppins()),
                    ),
                  ],
                ),
              ],
            ),
          ));
    } else if (state is SignUpLoading) {
      bodyContent = Center(
        child: buildLoadingIndicator(
          blur: 0,
          isCentered: true,
        ),
      );
    } else if (state is SignUpError) {
      bodyContent = serverErrorHolder();
    } else {
      bodyContent = serverErrorHolder();
    }

    return Scaffold(
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: bodyContent),
    );
  }
}
