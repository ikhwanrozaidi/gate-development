import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gatepay_convert/shared/utils/price_formatter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/utils/blurred_bg_loading.dart';
import '../../shared/utils/theme.dart';
import '../notifier/topup_notifier.dart';
import '../notifier/topup_state.dart';

class TopupPage extends ConsumerStatefulWidget {
  final String? title;
  const TopupPage({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  ConsumerState<TopupPage> createState() => _TopupPageState();
}

class _TopupPageState extends ConsumerState<TopupPage> {
  final FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _focusNode
        .dispose(); // Make sure to dispose the focus node to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(topupNotifierProvider);
    final w = MediaQuery.of(context).size.width;

    Widget bodyContent;
    if (state is TopupLoaded) {
      bodyContent = SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
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
                      "Topup your balance",
                      style: TextStyle(
                        fontFamily: tSecondaryFont,
                        fontWeight: FontWeight.w700,
                        fontSize: w * 0.06,
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Amount to add',
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
                              focusNode: _focusNode,
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
                    Text(
                      'Paying with',
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
                                  'I',
                                  style: TextStyle(
                                    fontFamily: tSecondaryFont,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Online Banking',
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
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: tPrimaryColorShade3,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Currency'),
                              Text('Malaysian Ringgit (MYR)')
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total amount'),
                              Text('100.00'),
                            ],
                          ),
                          SizedBox(height: 20),
                          Divider(
                            height: 1,
                            color: tGreyShade5,
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Online Banking Fees'),
                              Text('1.00 MYR'),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Our Fee (5%)'),
                              Text('5.00 MYR'),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Fee'),
                              Text('6.00 MYR'),
                            ],
                          ),
                          SizedBox(height: 20),
                          Divider(
                            height: 1,
                            color: tGreyShade5,
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total You'll pay"),
                              Text('106.00 MYR'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Use the helper method instead of direct parsing
                          double amount = DecimalFirstFormatter.getNumericValue(
                              _amountController.text);
                          await ref
                              .read(topupNotifierProvider.notifier)
                              .processTopup(amount);

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
                      child: state is TopupProcessing
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
    } else if (state is TopupLoading || state is TopupProcessing) {
      bodyContent = Center(
        child: buildLoadingIndicator(
          blur: 0,
          isCentered: true,
        ),
      );
    } else if (state is TopupError) {
      bodyContent =
          // serverErrorHolder(ref.read(topupNotifierProvider.notifier).userDetails())
          Text('Try Again');
    } else {
      bodyContent =
          // serverErrorHolder(ref.read(topupNotifierProvider.notifier).userDetails())
          Text('Try Again');
    }
    return Scaffold(
      appBar: AppBar(),
      body: bodyContent,
    );
  }
}
