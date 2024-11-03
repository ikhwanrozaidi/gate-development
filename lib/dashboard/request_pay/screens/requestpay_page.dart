import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gatepay_convert/pay_boarding/escrow_pay/screens/widget/escrowpage_form1.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../shared/utils/blurred_bg_loading.dart';
import '../../../shared/utils/theme.dart';
import '../notifier/requestpay_notifier.dart';
import '../notifier/requestpay_state.dart';
import 'widget/requestpage_form2.dart';

class RequestpayPage extends ConsumerStatefulWidget {
  final String? title;
  const RequestpayPage({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  ConsumerState<RequestpayPage> createState() => _RequestpayPageState();
}

class _RequestpayPageState extends ConsumerState<RequestpayPage> {
  final TextEditingController youPayController = TextEditingController();
  final TextEditingController sellerReceiveController = TextEditingController();
  final double incrementFactor = 0.03;
  bool _isUpdatingYouPay = false;
  bool _isUpdatingSellerReceive = false;

  @override
  void initState() {
    super.initState();
    youPayController.addListener(_onYouPayChanged);
    sellerReceiveController.addListener(_onSellerReceiveChanged);
  }

  @override
  void dispose() {
    youPayController.removeListener(_onYouPayChanged);
    sellerReceiveController.removeListener(_onSellerReceiveChanged);
    youPayController.dispose();
    sellerReceiveController.dispose();
    super.dispose();
  }

  void _onYouPayChanged() {
    if (_isUpdatingYouPay) return;
    _isUpdatingSellerReceive = true;
    if (youPayController.text.isNotEmpty) {
      double youPay = double.tryParse(youPayController.text) ?? 0;
      double sellerReceive = youPay * (1 + incrementFactor);
      sellerReceiveController.text = sellerReceive.toStringAsFixed(2);
    } else {
      sellerReceiveController.clear();
    }
    _isUpdatingSellerReceive = false;
  }

  void _onSellerReceiveChanged() {
    if (_isUpdatingSellerReceive) return;
    _isUpdatingYouPay = true;
    if (sellerReceiveController.text.isNotEmpty) {
      double sellerReceive = double.tryParse(sellerReceiveController.text) ?? 0;
      double youPay = sellerReceive / (1 + incrementFactor);
      youPayController.text = youPay.toStringAsFixed(2);
    } else {
      youPayController.clear();
    }
    _isUpdatingYouPay = false;
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
                Text(
                  "Let's ease your buyer journey!",
                  style: TextStyle(
                    fontFamily: tSecondaryFont,
                    fontWeight: FontWeight.w700,
                    fontSize: w * 0.06,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Product Name',
                  style: TextStyle(
                    fontFamily: tSecondaryFont,
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
                SizedBox(height: 20),
                Text(
                  'Product Description',
                  style: TextStyle(
                    fontFamily: tSecondaryFont,
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
                SizedBox(height: 20),
                Text(
                  'Price',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: tPrimaryBackground,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'You Receive (MYR)',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: w * 0.035,
                              ),
                            ),
                            TextFormField(
                              controller: youPayController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d*')),
                              ],
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: tPrimaryBackground,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Buyer Pay (MYR)',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: w * 0.035,
                              ),
                            ),
                            TextFormField(
                              controller: sellerReceiveController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d*')),
                              ],
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestpayForm2()),
                        );
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
            )),
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
