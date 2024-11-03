import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gatepay_convert/transactionboard/ongoing_lists/screens/ongoing_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../shared/utils/blurred_bg_loading.dart';
import '../../../shared/utils/theme.dart';
import '../notifier/transactionboard_notifier.dart';
import '../notifier/transactionboard_state.dart';

class TransactionboardPage extends ConsumerStatefulWidget {
  final String? title;
  const TransactionboardPage({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  ConsumerState<TransactionboardPage> createState() =>
      _TransactionboardPageState();
}

class _TransactionboardPageState extends ConsumerState<TransactionboardPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transactionboardNotifierProvider);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    Widget serverErrorHolder() {
      return LayoutBuilder(
        builder: (context, cons) {
          return ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                constraints: BoxConstraints(minHeight: cons.maxHeight),
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      // ref
                      //     .read(TransactionboardNotifierProvider.notifier)
                      //     .getTransactionboard();
                    },
                    child: const Chip(
                      label: Column(
                        children: [
                          Row(
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
                        ],
                      ),
                      backgroundColor: tPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    Widget bodyContent;
    if (state is TransactionboardLoaded) {
      bodyContent = SingleChildScrollView(
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Transactions',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: w * 0.08),
                  Text(
                    'Ongoing Transactions',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: w * 0.04,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: tPrimaryColorShade2.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Withheld Payment',
                          style: GoogleFonts.poppins(color: tDarkFontShade1),
                        ),
                        Text(
                          'MYR ${state.withheldPayment.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: w * 0.045,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: tPrimaryColorShade2.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Awaiting Payment',
                          style: GoogleFonts.poppins(color: tDarkFontShade1),
                        ),
                        Text(
                          'MYR ${state.awaitingPayment.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: w * 0.045,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: h * 0.3,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: tPrimaryColorShade2.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transaction Lists',
                              style:
                                  GoogleFonts.poppins(color: tDarkFontShade1),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OngoingPage()),
                                );
                              },
                              child: Text(
                                'View All',
                                style:
                                    GoogleFonts.poppins(color: tDarkFontShade1),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            // shrinkWrap: true,
                            itemCount: state.ongoingOrders.length,
                            itemBuilder: (context, index) {
                              final order = state.ongoingOrders[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 40.0,
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                              child: Text(
                                            'IR',
                                            style: TextStyle(
                                              fontFamily: tSecondaryFont,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              order.productName,
                                              style: GoogleFonts.poppins(
                                                color: tDarkFontShade1,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              '${order.receipientUsername}  •  ${DateFormat('d MMM').format(order.createdAt!)}',
                                              style: GoogleFonts.poppins(
                                                color: tDarkFontShade1,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Text(
                                      order.orderStatus == 'incoming'
                                          ? '+MYR ${order.actualPrice.toStringAsFixed(2)}'
                                          : '-MYR ${order.actualPrice.toStringAsFixed(2)}',
                                      style: GoogleFonts.poppins(
                                        // color: tDarkFontShade1,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: order.orderStatus == 'incoming'
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transaction History',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: w * 0.04,
                        ),
                      ),
                      Text(
                        'View All',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'TODAY',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade400),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.ongoingOrders.length,
                    itemBuilder: (context, index) {
                      final order = state.ongoingOrders[index];
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: tPrimaryColorShade2,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 191, 82),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                      child: Text(
                                    'IR',
                                    style: TextStyle(
                                      fontFamily: tSecondaryFont,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order.productName.toUpperCase(),
                                      style: GoogleFonts.poppins(
                                        color: tDarkFontShade1,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      order.receipientUsername.toUpperCase(),
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  order.orderStatus == 'incoming'
                                      ? '+MYR ${order.actualPrice.toStringAsFixed(2)}'
                                      : '-MYR ${order.actualPrice.toStringAsFixed(2)}',
                                  style: GoogleFonts.poppins(
                                    // color: tDarkFontShade1,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: order.orderStatus == 'incoming'
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                Text(
                                  DateFormat('d MMMM')
                                      .format(order.createdAt!)
                                      .toUpperCase(),
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              )),
        ),
      );
    } else if (state is TransactionboardLoading) {
      bodyContent = Center(
        child: buildLoadingIndicator(
          blur: 0,
          isCentered: true,
        ),
      );
    } else if (state is TransactionboardError) {
      bodyContent = serverErrorHolder();
    } else {
      bodyContent = serverErrorHolder();
    }

    return Scaffold(
      body: bodyContent,
    );
  }
}
