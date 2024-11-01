import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DecimalFirstFormatter extends TextInputFormatter {
  final NumberFormat _numberFormat = NumberFormat('#,##0.00', 'en_US');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If the new value is empty, return 0.00
    if (newValue.text.isEmpty) {
      return const TextEditingValue(
        text: '0.00',
        selection: TextSelection.collapsed(offset: 4),
      );
    }

    // Remove all non-digit characters (including commas and periods)
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Handle backspace when the last character is removed
    if (digitsOnly.isEmpty) {
      return const TextEditingValue(
        text: '0.00',
        selection: TextSelection.collapsed(offset: 4),
      );
    }

    // Convert to decimal first format
    double number = double.parse(digitsOnly) / 100;

    // Format the number with commas and fixed 2 decimal places
    String formatted = _numberFormat.format(number);

    // Return the formatted value while maintaining cursor position
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }

  // Helper method to get numeric value from formatted string
  static double getNumericValue(String text) {
    if (text.isEmpty) return 0;
    // Remove all commas and other non-numeric characters except decimal point
    final cleanText = text.replaceAll(',', '');
    return double.tryParse(cleanText) ?? 0;
  }
}

extension CommaFormatter on num {
  String withComma() {
    return NumberFormat('#,##0.00', 'en_US').format(this);
  }
}
