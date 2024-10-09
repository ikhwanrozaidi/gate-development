import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gatepay_convert/shared/utils/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

Widget buildLoadingIndicator({double? blur, bool? isCentered}) {
  return BackdropFilter(
    filter: ImageFilter.blur(
      sigmaX: blur ?? 3,
      sigmaY: blur ?? 3,
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/lottie-loading.json',
            width: 100,
            height: 100,
            fit: BoxFit.contain,
            repeat: true,
            animate: true,
          ),
          SizedBox(height: 10),
          Text(
            textAlign: TextAlign.center,
            'Wait a second...',
            style: GoogleFonts.poppins(),
          )
        ],
      ),
    ),
  );
}

Widget serverErrorHolder(ref) {
  return LayoutBuilder(
    builder: (context, cons) {
      return ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            constraints: BoxConstraints(minHeight: cons.maxHeight),
            child: Center(
              child: TextButton(
                onPressed: () async {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ref;
                },
                style: TextButton.styleFrom(
                  backgroundColor: tPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Row(
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
              ),
            ),
          ),
        ],
      );
    },
  );
}
