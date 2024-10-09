import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../shared/utils/blurred_bg_loading.dart';
import '../../../shared/utils/theme.dart';
import '../notifier/currencywallet_notifier.dart';
import '../notifier/currencywallet_state.dart';

class CurrencyWalletPage extends ConsumerStatefulWidget {
  final String? title;
  const CurrencyWalletPage({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  ConsumerState<CurrencyWalletPage> createState() => _CurrencyWalletPageState();
}

class _CurrencyWalletPageState extends ConsumerState<CurrencyWalletPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(currencyWalletNotifierProvider);
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
                      //     .read(currencyWalletNotifierProvider.notifier)
                      //     .getQrpay();
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        // ref
                        //     .read(currencyWalletNotifierProvider.notifier)
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
    if (state is CurrencyWalletLoaded) {
      bodyContent = SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: w * 0.03),
                Text(
                  "Spend money worldwide with us",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: w * 0.07,
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    "Open a balance with new currency to secure your transaction abroad",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                      // fontSize: w * 0.07,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: tPrimaryColorShade4,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: tDarkFontShade1,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search Currency',
                            hintStyle:
                                GoogleFonts.poppins(color: tDarkFontShade1),
                            border: InputBorder.none,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 200, 222, 255),
                              shape: BoxShape.circle,
                            ),
                            child: Center(),
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'United Arab Emirates Dirham',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Min Amount: RM 10.00',
                                style: GoogleFonts.poppins(
                                  fontSize: w * 0.03,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Color.fromARGB(255, 200, 222, 255),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 200, 222, 255),
                              shape: BoxShape.circle,
                            ),
                            child: Center(),
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bangladeshi Taka',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Min Amount: RM 10.00',
                                style: GoogleFonts.poppins(
                                  fontSize: w * 0.03,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Color.fromARGB(255, 200, 222, 255),
                      )
                    ],
                  ),
                )
              ],
            ))),
      );
    } else if (state is CurrencyWalletLoading) {
      bodyContent = Center(
        child: buildLoadingIndicator(
          blur: 0,
          isCentered: true,
        ),
      );
    } else if (state is CurrencyWalletError) {
      bodyContent = serverErrorHolder();
    } else {
      bodyContent = serverErrorHolder();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Currency',
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
