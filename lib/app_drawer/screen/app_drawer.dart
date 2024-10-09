import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gatepay_convert/profile/screens/profile_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../dashboard/screens/dashboard_page.dart';
import '../../inbox/screens/inbox_page.dart';
import '../../pay_boarding/screens/pay_boarding_page.dart';
import '../../shared/utils/theme.dart';
import '../../transactionboard/screens/transactionboard_page.dart';
import 'widgets/test_page.dart';

class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({super.key});

  @override
  ConsumerState<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedBottomMenuIndex = 0;
  bool showBottomBar = true;

  // BottomNavigation Content
  List<Widget> pages = <Widget>[
    DashboardPage(),
    TransactionboardPage(),
    PayBoardingPage(),
    InboxPage(),
    ProfilePage(),
  ];

  void onTap(int value) {
    if (!mounted) return;

    if (value == 2) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PayBoardingPage(),
      ));
    } else {
      setState(() {
        selectedBottomMenuIndex = value;
      });
    }
  }

  Color getIconColor(int index) {
    return selectedBottomMenuIndex == index
        ? tPrimaryColor
        : tPrimaryColorShade1.withOpacity(0.3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      key: scaffoldKey,
      body: pages[selectedBottomMenuIndex],
      bottomNavigationBar: showBottomBar
          ? BottomAppBar(
              color: Colors.white,
              // elevation: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                        selectedBottomMenuIndex == 0
                            ? Icons.grid_view_rounded
                            : Icons.grid_view,
                        color: getIconColor(0)),
                    onPressed: () => onTap(0),
                  ),
                  IconButton(
                    icon: Icon(
                        selectedBottomMenuIndex == 1
                            ? Icons.donut_small
                            : Icons.donut_small_outlined,
                        color: getIconColor(1)),
                    onPressed: () => onTap(1),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tPrimaryColorShade3,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.payment, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          'Pay',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    onPressed: () => onTap(2),
                  ),
                  IconButton(
                    icon: Icon(
                        selectedBottomMenuIndex == 3
                            ? Icons.inbox
                            : Icons.inbox_outlined,
                        color: getIconColor(3)),
                    onPressed: () => onTap(3),
                  ),
                  IconButton(
                    icon: Icon(
                        selectedBottomMenuIndex == 4
                            ? Icons.person
                            : Icons.person_outlined,
                        color: getIconColor(4)),
                    onPressed: () => onTap(4),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
