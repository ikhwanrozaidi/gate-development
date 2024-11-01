import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/utils/blurred_bg_loading.dart';
import '../../../shared/utils/theme.dart';
import '../../notifier/verification_notifier.dart';
import '../../notifier/verification_state.dart';

class VerifyForm2 extends ConsumerStatefulWidget {
  final String? title;
  const VerifyForm2({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  ConsumerState<VerifyForm2> createState() => _VerifyForm2State();
}

class _VerifyForm2State extends ConsumerState<VerifyForm2> {
  bool isCapture = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(verifyNotifierProvider);
    final w = MediaQuery.of(context).size.width;

    Widget bodyContent;
    if (state is VerifyLoaded) {
      bodyContent = SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: w * 0.03),
              Text(
                "Say Cheese!",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: w * 0.07,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Just want to make sure you're not robot",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
                  // fontSize: w * 0.07,
                ),
              ),
              SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: tPrimaryColor,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
                child: isCapture
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Continue',
                      ),
              ),
            ],
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
      appBar: AppBar(),
      body: bodyContent,
    );
  }
}
