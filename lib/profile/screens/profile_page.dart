import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gatepay_convert/verification/screens/verification_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/utils/blurred_bg_loading.dart';
import '../../../shared/utils/theme.dart';
import '../../authentication/signin/screens/signin_page.dart';
import '../notifier/profile_notifier.dart';
import '../notifier/profile_state.dart';
import '../repository/service/profile_service.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final String? title;
  const ProfilePage({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileNotifierProvider);
    final w = MediaQuery.of(context).size.width;
    // bool isSwitched = false;

    // void _onToggleSwitch(bool newValue) {
    //   setState(() {
    //     isSwitched = newValue;
    //   });
    // }

    Widget bodyContent;
    if (state is ProfileLoaded) {
      bodyContent = SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Profile',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: w * 0.08),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
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
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${state.userData.firstName.split(' ').map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase()).join(' ')} ${state.userData.lastName.split(' ').map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase()).join(' ')}',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  state.userData.country ?? 'Country not set',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.border_color_outlined),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 20),
                          Text(
                            (state.userData.phone == '')
                                ? "Verify your phone number"
                                : state.userData.phone,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.mail_outline_outlined,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 20),
                          Text(
                            state.userData.email ?? 'Email not set',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Divider(color: Colors.grey.shade300),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: tPrimaryColorShade2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Get account verification now?',
                            style: GoogleFonts.poppins(
                              //fontWeight: FontWeight.w500,
                              fontSize: w * 0.035,
                              color: tPrimaryColorShade3,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VerifyPage()),
                              );
                            },
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
                              'Verify',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Icon(Icons.lock_reset_outlined),
                          SizedBox(width: 20),
                          Text(
                            'Change Password',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              // fontSize: w * 0.035,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.phonelink_lock_outlined),
                              SizedBox(width: 20),
                              Text(
                                'Two-Factor Authencation',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  // fontSize: w * 0.035,
                                ),
                              ),
                            ],
                          ),
                          // Transform.scale(
                          //   scale: 0.8,
                          //   child: Switch(
                          //     value: isSwitched,
                          //     onChanged: _onToggleSwitch,
                          //     activeColor: tPrimaryColor,
                          //     inactiveThumbColor: Colors.grey,
                          //     inactiveTrackColor: Colors.grey[300],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.fingerprint),
                              SizedBox(width: 20),
                              Text(
                                'Biometric Pass',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  // fontSize: w * 0.035,
                                ),
                              ),
                            ],
                          ),
                          // Transform.scale(
                          //   scale: 0.8,
                          //   child: Switch(
                          //     value: isSwitched,
                          //     onChanged: _onToggleSwitch,
                          //     activeColor: tPrimaryColor,
                          //     inactiveThumbColor: Colors.grey,
                          //     inactiveTrackColor: Colors.grey[300],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Icon(Icons.notifications_active_outlined),
                          SizedBox(width: 20),
                          Text(
                            'Notifications Settings',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              // fontSize: w * 0.035,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Icon(Icons.phone_android),
                          SizedBox(width: 20),
                          Text(
                            'About',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              // fontSize: w * 0.035,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Divider(color: Colors.grey.shade300),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Icon(Icons.headset_mic_outlined),
                          SizedBox(width: 20),
                          Text(
                            'Contact Our Agent',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              // fontSize: w * 0.035,
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        try {
                          final signInService =
                              ref.read(profileApiServiceProvider);
                          await signInService.signOut();

                          // Navigate to the sign-in page
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => SignInPage()),
                            (Route<dynamic> route) => false,
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to log out: $e')),
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Icon(
                              Icons.power_settings_new,
                              color: Colors.red,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Log Out',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.red,
                                // fontSize: w * 0.035,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Text('Powered by BerryPay'),
              SizedBox(height: 40),
            ],
          ),
        ),
      );
    } else if (state is ProfileLoading) {
      bodyContent = Center(
        child: buildLoadingIndicator(
          blur: 0,
          isCentered: true,
        ),
      );
    } else if (state is ProfileError) {
      bodyContent = serverErrorHolder(
          ref.read(profileNotifierProvider.notifier).userDetails());
    } else {
      bodyContent = serverErrorHolder(
          ref.read(profileNotifierProvider.notifier).userDetails());
    }

    return Scaffold(
      body: bodyContent,
    );
  }
}
