import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gatepay_convert/app_drawer/screen/widgets/test_page.dart';
import 'package:gatepay_convert/dashboard/currency_wallet/screens/currencywallet_page.dart';
import 'package:gatepay_convert/dashboard/request_pay/screens/requestpay_page.dart';
import 'package:gatepay_convert/pay_boarding/screens/pay_boarding_page.dart';
import 'package:gatepay_convert/shared/utils/flags_imagenetwork.dart';
import 'package:gatepay_convert/topup/screens/topup_page.dart';
import 'package:gatepay_convert/withdraw/screens/withdraw_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/utils/blurred_bg_loading.dart';
import '../../../shared/utils/theme.dart';
import '../../shared/utils/price_formatter.dart';
import '../notifier/dashboard_notifier.dart';
import '../notifier/dashboard_state.dart';

class DashboardPage extends ConsumerStatefulWidget {
  final String? title;
  const DashboardPage({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  String formatAccountNumber(String accountNumber) {
    return accountNumber.replaceAllMapped(
        RegExp(r'.{4}'), (match) => '${match.group(0)} ');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardNotifierProvider);
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
                      //     .read(DashboardNotifierProvider.notifier)
                      //     .getDashboard();
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
    if (state is DashboardLoaded) {
      bodyContent = ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // SizedBox(height: w * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${getGreeting()}, ${state.userData.firstName}!',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: w * 0.045,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 200, 222, 255),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                          child: Text(
                        '${state.userData.firstName.split(' ').first[0].toUpperCase()}${state.userData.lastName.split(' ').first[0].toUpperCase()}',
                        style: TextStyle(
                          fontFamily: tSecondaryFont,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                    ),
                  ],
                ),
                SizedBox(height: h / 25),
                Container(
                  height: w / 2.1,
                  width: w / 1.2,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    // color: tPrimaryColorShade2,
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/bg-mainCard.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              'GatePay',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            formatAccountNumber(
                                state.defaultAccount.accountNumber),
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: w * 0.06,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${state.userData.firstName} ${state.userData.lastName}',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: w * 0.03,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'MYR ${state.defaultAccount.balance.withComma()}',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: w * 0.055,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40.0,
                            width: 40.0,
                            child: Image.asset(
                              'assets/images/logo-gatepay.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                            'BASIC',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 20),
                Container(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: tPrimaryColor,
                      width: 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 2,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CountryFlagWidget(alpha2code: 'MY'),
                          SizedBox(width: 10),
                          Text(
                            'Malaysia (MYR)',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        state.defaultAccount.balance.withComma(),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: w * 0.05,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CurrencyWalletPage()),
                    );
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 33),
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: tPrimaryColor,
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.control_point_outlined,
                            // weight: 0.5,
                            size: w * 0.05,
                            color: tPrimaryColor,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Add Currency',
                            style: GoogleFonts.inter(
                              color: tPrimaryColor,
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Actions',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: w * 0.045,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    quickActionButton(
                        icon: Icons.control_point_duplicate,
                        title: 'Topup',
                        navigateTo: TopupPage()),
                    quickActionButton(
                        icon: Icons.payment,
                        title: 'Pay',
                        navigateTo: PayBoardingPage()),
                    quickActionButton(
                        icon: Icons.supervisor_account,
                        title: 'Request',
                        navigateTo: RequestpayPage()),
                    quickActionButton(
                        icon: Icons.account_balance,
                        title: 'Withdraw',
                        navigateTo: WithdrawPage()),
                    quickActionButton(
                        icon: Icons.compare_arrows,
                        title: 'Transfer',
                        navigateTo: TestPage5()),
                  ],
                ),
                SizedBox(height: 35),
                Text(
                  'Explore the capability',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: w * 0.045,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 10),
                Container(
                  width: w / 1.8,
                  height: h / 5,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: tPrimaryColorShade2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Make the most profit',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tPrimaryColorShade3,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          minimumSize: Size(64, 30),
                          visualDensity: VisualDensity.compact,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Learn More',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: w / 1.8,
                  height: h / 5,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: tPrimaryColorShade2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Secure your transactions',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tPrimaryColorShade3,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          minimumSize: Size(64, 30),
                          visualDensity: VisualDensity.compact,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Learn More',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
        ],
      );
    } else if (state is DashboardLoading) {
      bodyContent = Center(
        child: buildLoadingIndicator(
          blur: 0,
          isCentered: true,
        ),
      );
    } else if (state is DashboardError) {
      bodyContent = serverErrorHolder();
    } else {
      bodyContent = serverErrorHolder();
    }

    return Scaffold(
      body: bodyContent,
    );
  }

  quickActionButton(
      {IconData? icon, String? title, required Widget navigateTo}) {
    final w = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigateTo),
        );

        if (result == true) {
          ref.read(dashboardNotifierProvider.notifier).initialDashboard();
        }
      },
      child: Column(
        children: [
          Container(
            width: 55.0,
            height: 55.0,
            decoration: BoxDecoration(
              color: tPrimaryColorShade1,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            title ?? 'null',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: w * 0.03,
            ),
          )
        ],
      ),
    );
  }
}
