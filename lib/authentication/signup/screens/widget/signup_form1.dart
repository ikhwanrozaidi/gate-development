import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gatepay_convert/authentication/signup/screens/widget/signup_form2.dart';

import '../../../../shared/utils/blurred_bg_loading.dart';
import '../../../../shared/utils/theme.dart';
import '../../../signin/screens/signin_page.dart';
import '../../notifier/signup_notifier.dart';
import '../../notifier/signup_state.dart';

class SignUpForm1 extends ConsumerStatefulWidget {
  final String email;
  final String password;

  const SignUpForm1({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  ConsumerState<SignUpForm1> createState() => _SignUpForm1State();
}

class _SignUpForm1State extends ConsumerState<SignUpForm1> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  void _continueToNextForm() {
    String capitalizeFirstLetter(String text) {
      if (text.isEmpty) return "";
      return text[0].toUpperCase() + text.substring(1).toLowerCase();
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpForm2(
          email: widget.email,
          password: widget.password,
          title: _titleController.text,
          firstName: capitalizeFirstLetter(_firstNameController.text),
          lastName: capitalizeFirstLetter(_lastNameController.text),
          country: capitalizeFirstLetter(_countryController.text),
        ),
      ),
    );
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
                  "Welcome Aboard! This won't take long...",
                  style: TextStyle(
                      fontFamily: tSecondaryFont,
                      fontWeight: FontWeight.w700,
                      fontSize: w * 0.07),
                ),
                SizedBox(height: 40),
                Text(
                  'Title',
                  style: TextStyle(
                    fontFamily: tSecondaryFont,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _titleController,
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
                  validator: (value) {
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text(
                  'First Name',
                  style: TextStyle(
                    fontFamily: tSecondaryFont,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _firstNameController,
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
                  validator: (value) {
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text(
                  'Last Name',
                  style: TextStyle(
                    fontFamily: tSecondaryFont,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _lastNameController,
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
                  validator: (value) {
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text(
                  'Country of Residence',
                  style: TextStyle(
                    fontFamily: tSecondaryFont,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _countryController,
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
                  validator: (value) {
                    return null;
                  },
                ),
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _continueToNextForm,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(20),
                        backgroundColor: tPrimaryColor,
                        shape: CircleBorder(),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
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
      body: bodyContent,
    );
  }
}
