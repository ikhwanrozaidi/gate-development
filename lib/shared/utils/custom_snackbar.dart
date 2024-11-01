import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gatepay_convert/shared/utils/theme.dart';
import 'package:google_fonts/google_fonts.dart';

showSnackBar(
  BuildContext context,
  String message, {
  int? ms,
  double? heightFactor,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.none,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * (heightFactor ?? 0.79),
          right: 20,
          left: 20),
      duration: Duration(milliseconds: ms ?? 1500),
      backgroundColor: tPrimaryColorShade1,
      content: Center(
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

showSuccessSnackBar(
  BuildContext context,
  String message, {
  int? ms,
  double? heightFactor,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.none,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * (heightFactor ?? 0.79),
          right: 20,
          left: 20),
      duration: Duration(milliseconds: ms ?? 1500),
      backgroundColor: Colors.green,
      content: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.poppins(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
