import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/utils/blurred_bg_loading.dart';
import '../../../shared/utils/theme.dart';
import '../../notifier/verification_notifier.dart';
import '../../notifier/verification_state.dart';

class VerifyForm1 extends ConsumerStatefulWidget {
  final String? title;
  final String? username;
  final String? phone;
  const VerifyForm1({
    Key? key,
    this.title,
    this.username,
    this.phone,
  }) : super(key: key);

  @override
  ConsumerState<VerifyForm1> createState() => _VerifyForm1State();
}

class _VerifyForm1State extends ConsumerState<VerifyForm1> {
  bool isCapture = false;

  void _handleVerification() {
    if (widget.username == null || widget.phone == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username and phone number are required')),
      );
      return;
    }

    setState(() {
      isCapture = true;
    });

    ref.read(verifyNotifierProvider.notifier).updateVerification(
          username: widget.username!,
          phone: widget.phone!,
          onSuccess: () {
            if (mounted) {
              setState(() {
                isCapture = false;
              });

              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Verification completed successfully!'),
                  backgroundColor: Colors.green,
                ),
              );

              // Navigate back or to next screen
              Navigator.of(context).pop(true);
            }
          },
          onError: (error) {
            if (mounted) {
              setState(() {
                isCapture = false;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: $error'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        );
  }

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
              SizedBox(height: 40),
              Container(
                width: 250.0,
                height: 250.0,
                child: ClipOval(
                  child: Container(
                    color: Colors.grey.shade200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, color: Colors.grey),
                        Text('Tap to enable camera',
                            style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80),
              ElevatedButton(
                onPressed: !isCapture ? _handleVerification : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: tPrimaryColor,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
                child: isCapture
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Submit',
                        style: GoogleFonts.poppins(),
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
