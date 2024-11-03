import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/utils/blurred_bg_loading.dart';
import '../../../shared/utils/theme.dart';
import '../../shared/utils/custom_snackbar.dart';
import '../notifier/verification_notifier.dart';
import '../notifier/verification_state.dart';
import 'widgets/verification_form1.dart';

class VerifyPage extends ConsumerStatefulWidget {
  final String? title;
  const VerifyPage({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  ConsumerState<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends ConsumerState<VerifyPage> {
  bool isOtpVerified = false;
  bool isSendOtp = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Color _getBorderColor(VerifyState state) {
    if (state is VerifyLoaded) {
      switch (state.usernameStatus) {
        case UsernameStatus.available:
          return Colors.green;
        case UsernameStatus.taken:
          return Colors.red;
        case UsernameStatus.checking:
          return Colors.blue;
        case UsernameStatus.invalid:
          return Colors.orange;
        default:
          return Colors.transparent;
      }
    }
    return Colors.transparent;
  }

  Widget? _getSuffixIcon(VerifyState state) {
    if (state is VerifyLoaded) {
      switch (state.usernameStatus) {
        case UsernameStatus.available:
          return Icon(Icons.check_circle, color: Colors.green);
        case UsernameStatus.taken:
          return Icon(Icons.error, color: Colors.red);
        case UsernameStatus.checking:
          return SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          );
        case UsernameStatus.invalid:
          return Icon(Icons.warning, color: Colors.orange);
        default:
          return null;
      }
    }
    return null;
  }

  String? _getHelperText(VerifyState state) {
    if (state is VerifyLoaded) {
      switch (state.usernameStatus) {
        case UsernameStatus.available:
          return 'Username is available';
        case UsernameStatus.taken:
          return 'Username is already taken';
        case UsernameStatus.checking:
          return 'Checking availability...';
        case UsernameStatus.invalid:
          return 'Username must be 3-20 characters (letters, numbers, underscore)';
        default:
          return null;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(verifyNotifierProvider);
    final w = MediaQuery.of(context).size.width;

    void showOtpBottomSheet(BuildContext context) {
      final TextEditingController digit1 = TextEditingController();
      final TextEditingController digit2 = TextEditingController();
      final TextEditingController digit3 = TextEditingController();
      final TextEditingController digit4 = TextEditingController();

      final FocusNode focus1 = FocusNode();
      final FocusNode focus2 = FocusNode();
      final FocusNode focus3 = FocusNode();
      final FocusNode focus4 = FocusNode();

      bool isError = false;

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Verify Phone Number",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: w * 0.05,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Kindly enter the OTP sent to your registered contact number",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        // fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: TextField(
                          controller: digit1,
                          focusNode: focus1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isError ? Colors.red : Colors.grey,
                                width: isError ? 2 : 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isError ? Colors.red : Colors.grey,
                                width: isError ? 2 : 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isError ? Colors.red : Colors.blue,
                                width: isError ? 2 : 1,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.length == 1) focus2.requestFocus();
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 50,
                        height: 50,
                        child: TextField(
                          controller: digit2,
                          focusNode: focus2,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isError ? Colors.red : Colors.grey,
                                width: isError ? 2 : 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isError ? Colors.red : Colors.grey,
                                width: isError ? 2 : 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isError ? Colors.red : Colors.blue,
                                width: isError ? 2 : 1,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.length == 1) focus3.requestFocus();
                            if (value.isEmpty) focus1.requestFocus();
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 50,
                        height: 50,
                        child: TextField(
                          controller: digit3,
                          focusNode: focus3,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isError ? Colors.red : Colors.grey,
                                width: isError ? 2 : 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isError ? Colors.red : Colors.grey,
                                width: isError ? 2 : 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isError ? Colors.red : Colors.blue,
                                width: isError ? 2 : 1,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.length == 1) focus4.requestFocus();
                            if (value.isEmpty) focus2.requestFocus();
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 50,
                        height: 50,
                        child: TextField(
                          controller: digit4,
                          focusNode: focus4,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isError ? Colors.red : Colors.grey,
                                width: isError ? 2 : 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isError ? Colors.red : Colors.grey,
                                width: isError ? 2 : 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isError ? Colors.red : Colors.blue,
                                width: isError ? 2 : 1,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isEmpty) focus3.requestFocus();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      String otp =
                          digit1.text + digit2.text + digit3.text + digit4.text;
                      if (otp == "0000") {
                        setState(() {
                          isOtpVerified = true;
                        });

                        Navigator.pop(context);

                        //-----PROBLEM----- look laggy snackBar because the context height changing when pop
                        showSuccessSnackBar(
                            context, 'OTP Verified Successfully!');
                      } else {
                        setState(() {
                          isError = true;
                        });

                        Future.delayed(Duration(seconds: 1), () {
                          setState(() {
                            isError = false;
                          });
                        });

                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text('Invalid OTP Code')),
                        // );
                      }
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
                    child: Text('Verify Code'),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          });
        },
      );
    }

    Widget bodyContent;
    if (state is VerifyLoaded) {
      bodyContent = GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: w * 0.03),
                Text(
                  "Just a few moments...",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: w * 0.07,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Let's verify your account before make any transactions",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade500,
                    // fontSize: w * 0.07,
                  ),
                ),
                SizedBox(height: 60),
                Text(
                  "Pick a username",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _usernameController,
                  style: TextStyle(
                    fontFamily: tSecondaryFont,
                    fontWeight: FontWeight.w500,
                  ),
                  onChanged: (value) {
                    // Debounce the username check to avoid too many calls
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (_usernameController.text == value) {
                        ref
                            .read(verifyNotifierProvider.notifier)
                            .checkUsername(value);
                      }
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: tPrimaryBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: _getBorderColor(state),
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: _getBorderColor(state),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: _getBorderColor(state),
                        width: 2,
                      ),
                    ),
                    suffixIcon: _getSuffixIcon(state),
                    helperText: _getHelperText(state),
                    helperStyle: TextStyle(
                      color: _getBorderColor(state),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Phone Number",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: w / 3.5,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: tPrimaryBackground,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Container(
                            width: 30.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "+60",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          fontFamily: tSecondaryFont,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: tPrimaryBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          constraints: BoxConstraints(maxHeight: 60),
                        ),
                        validator: (value) {
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showSnackBar(
                            context, 'OTP has been sent to registered phone');
                      },
                      child: Text(
                        isSendOtp ? "Resend OTP" : "",
                        style: TextStyle(
                          color: Color.fromARGB(255, 147, 171, 255),
                          fontFamily: tSecondaryFont,
                          fontSize: w * 0.035,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: w / 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: isOtpVerified
                          ? () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VerifyForm1(
                                          username: _usernameController.text,
                                          phone: _phoneController.text,
                                        )),
                              );
                            }
                          : () {
                              setState(() {
                                isSendOtp = true;
                              });
                              showOtpBottomSheet(context);
                            },
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
          ),
        ),
      );
    } else if (state is VerifyLoading) {
      bodyContent = Center(
        child: buildLoadingIndicator(
          blur: 0,
          isCentered: true,
        ),
      );
    } else if (state is VerifyError) {
      bodyContent = Text('Try Again');
      // serverErrorHolder(ref.read(verifyNotifierProvider.notifier).userDetails());
    } else {
      bodyContent = Text('Try Again');
      // serverErrorHolder(ref.read(verifyNotifierProvider.notifier).userDetails());
    }

    return Scaffold(
      appBar: AppBar(
          // title: Text(
          //   'Verify your account',
          //   style: GoogleFonts.poppins(
          //     fontWeight: FontWeight.w600,
          //     fontSize: 18,
          //   ),
          // ),
          ),
      body: bodyContent,
    );
  }
}
