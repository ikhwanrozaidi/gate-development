import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../shared/utils/blurred_bg_loading.dart';
import '../../../../shared/utils/custom_checkbox.dart';
import '../../../../shared/utils/theme.dart';
import '../../notifier/requestpay_notifier.dart';
import '../../notifier/requestpay_state.dart';

class RequestpayForm2 extends ConsumerStatefulWidget {
  final String? title;
  const RequestpayForm2({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  ConsumerState<RequestpayForm2> createState() => _RequestpayForm2State();
}

class _RequestpayForm2State extends ConsumerState<RequestpayForm2> {
  bool hasAccount = true;
  bool _agreedToPPRF = false;
  bool _agreedToGP = false;
  bool _agreedTo3 = false;

  void _toggleAgreedToPPRF(bool? newValue) {
    setState(() {
      _agreedToPPRF = newValue!;
    });
  }

  void _toggleAgreedToGP(bool? newValue) {
    setState(() {
      _agreedToGP = newValue!;
    });
  }

  void _toggleAgreedTo3(bool? newValue) {
    setState(() {
      _agreedTo3 = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(requestpayNotifierProvider);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    Widget serverErrorHolder() {
      return LayoutBuilder(
        builder: (context, cons) {
          return Container(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: h / 8),
                  Lottie.asset(
                    'assets/lottie/lottie-unplug.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.fill,
                    repeat: true,
                    animate: true,
                  ),
                  Text(
                    'Uh-oh!',
                    style: GoogleFonts.poppins(
                      color: tDarkFontShade1,
                      fontWeight: FontWeight.w600,
                      fontSize: w * 0.05,
                    ),
                  ),
                  Text(
                    'We may ran into a problem',
                    style: GoogleFonts.poppins(
                      color: tDarkFontShade1,
                      fontWeight: FontWeight.w600,
                      fontSize: w * 0.04,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'Please check your internet connection and try again',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        // fontWeight: FontWeight.w500,
                        // fontSize: w * 0.04,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () async {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      // ref
                      //     .read(QrpayNotifierProvider.notifier)
                      //     .getQrpay();
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        // ref
                        //     .read(QrpayNotifierProvider.notifier)
                        //     .getQrpay();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tPrimaryColorShade3,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        minimumSize: Size(64, 30),
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        'Try again',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    Widget bodyContent;
    if (state is RequestpayLoaded) {
      bodyContent = SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: w * 0.05),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text(
                  "Last Step! We need to know your buyer",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: w * 0.06,
                  ),
                ),
              ),
              SizedBox(height: 60),
              Row(
                children: [
                  SizedBox(
                    width: w / 2,
                    child: Text(
                      'Does your buyer have an account with us?',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => hasAccount = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: hasAccount
                                    ? tPrimaryColor
                                    : tPrimaryColorShade2,
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(100)),
                              ),
                              child: Center(
                                child: Text(
                                  'Yes',
                                  style: GoogleFonts.poppins(
                                    color: hasAccount
                                        ? Colors.white
                                        : tPrimaryColorShade3.withOpacity(0.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => hasAccount = false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: !hasAccount
                                    ? tPrimaryColor
                                    : tPrimaryColorShade2,
                                borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(100)),
                              ),
                              child: Center(
                                child: Text(
                                  'No',
                                  style: GoogleFonts.poppins(
                                    color: !hasAccount
                                        ? Colors.white
                                        : tPrimaryColorShade3.withOpacity(0.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                hasAccount ? "Buyer's Username" : "Buyer's Phone Number",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
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
                ),
                validator: (value) {
                  return null;
                },
              ),
              SizedBox(height: 40),
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
                            TextSpan(
                                text: 'I agree to the ',
                                style:
                                    GoogleFonts.poppins(fontSize: w * 0.035)),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: GoogleFonts.poppins(
                                  color: tPrimaryColor,
                                  fontSize: w * 0.035,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            TextSpan(
                                text: ' and ',
                                style:
                                    GoogleFonts.poppins(fontSize: w * 0.035)),
                            TextSpan(
                              text: 'Refund Policy',
                              style: GoogleFonts.poppins(
                                  color: tPrimaryColor,
                                  fontSize: w * 0.035,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()..onTap = () {},
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
                    value: _agreedToGP,
                    onChanged: _toggleAgreedToGP,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                        onTap: () => _toggleAgreedToGP(!_agreedToPPRF),
                        child: Text(
                          "Your product must adhere to GatePay Policy",
                          style: GoogleFonts.poppins(fontSize: w * 0.035),
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  CustomCheckbox(
                    value: _agreedTo3,
                    onChanged: _toggleAgreedTo3,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                        onTap: () => _toggleAgreedTo3(!_agreedToPPRF),
                        child: Text(
                          'GatePay have rights to cancel your order if any T&C are violated',
                          style: GoogleFonts.poppins(fontSize: w * 0.035),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      //Temporary
                      Navigator.pop(context);
                      Navigator.pop(context);
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
                    child: Text('Send Request', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else if (state is RequestpayLoading) {
      bodyContent = Center(
        child: buildLoadingIndicator(
          blur: 0,
          isCentered: true,
        ),
      );
    } else if (state is RequestpayError) {
      bodyContent = serverErrorHolder();
    } else {
      bodyContent = serverErrorHolder();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Request',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: bodyContent,
    );
  }
}
