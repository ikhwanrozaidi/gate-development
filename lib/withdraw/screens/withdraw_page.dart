import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gatepay_convert/shared/utils/price_formatter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/utils/blurred_bg_loading.dart';
import '../../shared/utils/theme.dart';
import '../notifier/withdraw_notifier.dart';
import '../notifier/withdraw_state.dart';

class WithdrawPage extends ConsumerStatefulWidget {
  final String? title;
  const WithdrawPage({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  ConsumerState<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends ConsumerState<WithdrawPage> {
  final _amountFocusNode = FocusNode();
  final _recipientNameFocusNode = FocusNode();
  final _accountNumberFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _recipientName = TextEditingController();
  final _bankName = TextEditingController();
  final _accountNumber = TextEditingController();

  @override
  void dispose() {
    _amountFocusNode.dispose();
    _recipientNameFocusNode.dispose();
    _accountNumberFocusNode.dispose();

    _amountController.dispose();
    _recipientName.dispose();
    _bankName.dispose();
    _accountNumber.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(withdrawNotifierProvider);
    final w = MediaQuery.of(context).size.width;

    Widget bodyContent;
    if (state is WithdrawLoaded) {
      bodyContent = SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            _amountFocusNode.unfocus();
            _recipientNameFocusNode.unfocus();
            _accountNumberFocusNode.unfocus();

            FocusScope.of(context).unfocus();
          },
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: w * 0.03),
                    Text(
                      "Withdraw your balance",
                      style: TextStyle(
                        fontFamily: tSecondaryFont,
                        fontWeight: FontWeight.w700,
                        fontSize: w * 0.06,
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Amount to withdraw',
                      style: TextStyle(
                        fontFamily: tSecondaryFont,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: tPrimaryBackground,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _amountController,
                              focusNode: _amountFocusNode,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9,]')),
                                DecimalFirstFormatter(),
                              ],
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
                          ),
                          Text(
                            'MYR',
                            style: TextStyle(
                              fontFamily: tSecondaryFont,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(
                      height: 1,
                      color: tGreyShade5,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Recipient Name',
                      style: TextStyle(
                        fontFamily: tSecondaryFont,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _recipientName,
                      focusNode: _recipientNameFocusNode,
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
                    SizedBox(height: 20),
                    Text(
                      'Receipient Bank',
                      style: TextStyle(
                        fontFamily: tSecondaryFont,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: tPrimaryBackground,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: tPrimaryColorShade4,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                    child: Text(
                                  'M',
                                  style: TextStyle(
                                    fontFamily: tSecondaryFont,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Maybank',
                                style: TextStyle(
                                  fontFamily: tSecondaryFont,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () async {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ref;
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: tPrimaryColorShade3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                            ),
                            child: Text(
                              'Change',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Account Number',
                      style: TextStyle(
                        fontFamily: tSecondaryFont,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _accountNumber,
                      focusNode: _accountNumberFocusNode,
                      keyboardType: TextInputType.number,
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
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Use the helper method instead of direct parsing
                          double amount = DecimalFirstFormatter.getNumericValue(
                              _amountController.text);
                          await ref
                              .read(withdrawNotifierProvider.notifier)
                              .processWithdraw(
                                amount,
                                'Maybank',
                                _recipientName.text,
                                _accountNumber.text,
                              );

                          // Show success message and navigate back with result
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Top up successful!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.of(context)
                                .pop(true); // Pop with true to indicate success
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: tPrimaryColor,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: state is WithdrawProcessing
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Continue',
                            ),
                    ),
                  ],
                ),
              )),
        ),
      );
    } else if (state is WithdrawLoading || state is WithdrawProcessing) {
      bodyContent = Center(
        child: buildLoadingIndicator(
          blur: 0,
          isCentered: true,
        ),
      );
    } else if (state is WithdrawError) {
      bodyContent =
          // serverErrorHolder(ref.read(WithdrawNotifierProvider.notifier).userDetails())
          Text('Try Again');
    } else {
      bodyContent =
          // serverErrorHolder(ref.read(WithdrawNotifierProvider.notifier).userDetails())
          Text('Try Again');
    }
    return Scaffold(
      appBar: AppBar(),
      body: bodyContent,
    );
  }
}
