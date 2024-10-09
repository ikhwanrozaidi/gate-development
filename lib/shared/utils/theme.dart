import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Theme for::: switchTheme, textfont, appbar, floating action, dialog, elevated button, datepicker

const tPrimaryColor = Color.fromARGB(255, 24, 109, 255);
const tPrimaryBackground = Color.fromARGB(255, 213, 227, 255);

const tPrimaryColorShade1 = Color.fromARGB(255, 66, 107, 255);
const tPrimaryColorShade2 = Color.fromARGB(255, 200, 222, 255);
const tPrimaryColorShade3 = Color.fromARGB(255, 66, 130, 255);
const tPrimaryColorShade4 = Color.fromARGB(255, 229, 239, 255);

const tDarkFontShade1 = Color.fromARGB(255, 45, 69, 116);

const Color tColorDisplayText = Color(0xFF334151);
const Color tGreyShade1 = Color.fromARGB(255, 176, 175, 175);
const Color tGreyShade2 = Color.fromARGB(255, 203, 203, 203);
const Color tGreyShade4 = Color.fromARGB(255, 58, 58, 58);
const Color tGreyShade5 = Color.fromARGB(255, 210, 209, 209);
const tColorsurfaceCanvas = Color.fromARGB(255, 230, 241, 255);
const tSecondaryColor = Color.fromARGB(255, 211, 253, 255);

const tPrimaryFont = 'Montserrat';
const tSecondaryFont = 'Poppins';

//LIGHT-THEME
ThemeData get kAppLightTheme {
  ThemeData base = ThemeData.light(
    useMaterial3: true,
  );
  return base.copyWith(
    // splashColor: Colors.transparent,
    primaryColor: tPrimaryColor,
    colorScheme: buildColorScheme(base.colorScheme),
    disabledColor: tGreyShade2,
    scaffoldBackgroundColor: tColorsurfaceCanvas,
    appBarTheme: buildAppBarTheme(),
    drawerTheme: const DrawerThemeData(elevation: 0),
    textTheme: buildTextTheme(base.textTheme),
    primaryTextTheme: buildTextTheme(base.primaryTextTheme),
    inputDecorationTheme: buildInputDecorationTheme(
      base.inputDecorationTheme,
      buildTextTheme(base.textTheme),
    ),
    iconTheme: const IconThemeData(
      color: tColorDisplayText,
    ),
    elevatedButtonTheme: buildElevatedButtonTheme(),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
      ),
    ),
    dialogTheme: buildDiaLogTheme(),
    listTileTheme: const ListTileThemeData(
      iconColor: tColorDisplayText,
      selectedColor: tPrimaryColor,
      textColor: tColorDisplayText,
    ),
    switchTheme: buildSwitchTheme(),
    dividerTheme: const DividerThemeData(color: tGreyShade5),
    expansionTileTheme: const ExpansionTileThemeData(
      backgroundColor: Colors.transparent,
      collapsedBackgroundColor: Colors.transparent,
      textColor: tPrimaryColor,
      iconColor: tPrimaryColor,
    ),
    floatingActionButtonTheme: buildFloatingActionButtonTheme(),
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: tColorDisplayText,
    ),
    tooltipTheme: buildToolTipTheme(),
    datePickerTheme: buildDatePickerTheme(),
    snackBarTheme: const SnackBarThemeData(backgroundColor: tPrimaryColor),
    chipTheme: const ChipThemeData(
      side: BorderSide(
        color: Colors.transparent,
      ),
      iconTheme: IconThemeData(
        color: tColorDisplayText,
      ),
    ),
    bottomNavigationBarTheme:
        buildBottomNavBarTheme(base.bottomNavigationBarTheme),
    popupMenuTheme: PopupMenuThemeData(
      color: base.colorScheme.background,
    ),
  );
}

//TO SWITCH THEME
buildSwitchTheme() {
  return SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return tPrimaryColor;
        }
        return Colors.grey;
      },
    ),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (!states.contains(MaterialState.selected)) {
          return Colors.grey;
        }
        return tPrimaryColor;
      },
    ),
    trackOutlineColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (!states.contains(MaterialState.selected)) {
          return tGreyShade5;
        }
        return tSecondaryColor;
      },
    ),
    trackColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (!states.contains(MaterialState.selected)) {
          return tGreyShade5;
        }
        return tSecondaryColor;
      },
    ),
  );
}

//BOTTOM-NAVBAR
buildBottomNavBarTheme(BottomNavigationBarThemeData base) {
  return base.copyWith(
    backgroundColor: Colors.white,
    unselectedIconTheme: const IconThemeData(
      color: tColorDisplayText,
    ),
    unselectedItemColor: tColorDisplayText,
  );
}

final kDropDownInputDecoration = InputDecoration(
  suffixIcon: const Icon(Icons.arrow_drop_down),
  suffixIconConstraints: BoxConstraints.tight(
    const Size(48, 18),
  ),
);

//TEXT-THEME
TextTheme buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        displayLarge: base.displayLarge?.copyWith(
          // fontWeight: FontWeight.w600,
          fontFamily: tPrimaryFont,
        ),
        displayMedium: base.displayMedium?.copyWith(
          // fontWeight: FontWeight.w600,
          fontFamily: tPrimaryFont,
        ),
        displaySmall: base.displaySmall?.copyWith(
          // fontWeight: FontWeight.w600,
          fontFamily: tPrimaryFont,
        ),
        headlineLarge: base.headlineLarge?.copyWith(
          fontWeight: FontWeight.w600,
          fontFamily: tPrimaryFont,
        ),
        headlineMedium: base.headlineMedium?.copyWith(
          fontWeight: FontWeight.w600,
          fontFamily: tPrimaryFont,
        ),
        headlineSmall: base.headlineSmall?.copyWith(
          fontWeight: FontWeight.w600,
          fontFamily: tPrimaryFont,
        ),
        //alert dialog title
        titleLarge: base.titleLarge?.copyWith(
          fontWeight: FontWeight.w400,
          fontFamily: tPrimaryFont,
        ),
        //alert dialog content
        titleMedium: base.titleMedium?.copyWith(
          fontWeight: FontWeight.w400,
          fontFamily: tPrimaryFont,
        ),
        titleSmall: base.titleSmall?.copyWith(
          fontFamily: tPrimaryFont,
        ),
        bodyLarge: base.bodyLarge?.copyWith(
          fontFamily: tPrimaryFont,
        ),
        bodyMedium: base.bodyMedium?.copyWith(
          fontFamily: tPrimaryFont,
        ),
        bodySmall: base.bodySmall?.copyWith(
          fontFamily: tPrimaryFont,
        ),
        labelLarge: base.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          fontFamily: tPrimaryFont,
        ),
        labelMedium: base.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
          fontFamily: tPrimaryFont,
        ),
        labelSmall: base.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
          fontFamily: tPrimaryFont,
        ),
      )
      .apply(
        bodyColor: tColorDisplayText,
        displayColor: tColorDisplayText,
        decorationColor: tColorDisplayText,
      );
}

//APP-BAR THEME
buildAppBarTheme() {
  return const AppBarTheme(
    centerTitle: true,
    color: Colors.white,
    scrolledUnderElevation: 0,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w600,
      color: tGreyShade4,
    ),
    iconTheme: IconThemeData(color: tGreyShade2),
  );
}

//FOR ELEVATED-BUTTON
buildElevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: tPrimaryColor,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 53),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

//FOR DIALOG
buildDiaLogTheme() {
  return const DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
  );
}

//FLOATING ACTION BUTTON
buildFloatingActionButtonTheme() {
  return const FloatingActionButtonThemeData(
    elevation: 0,
    backgroundColor: tPrimaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(30.0),
      ),
    ),
  );
}

//FOR DATEPICKER
buildDatePickerTheme() {
  return const DatePickerThemeData(
    elevation: 0,
    headerBackgroundColor: tPrimaryColor,
    headerForegroundColor: Colors.white,
    // yearOverlayColor: MaterialStateProperty.resolveWith<Color>((state) {
    //   if (state.contains(MaterialState.selected)) {
    //     return kGreyShade1;
    //   }
    //   return kGreyShade1;
    // }),
  );
}

//DON'T KNOW
buildToolTipTheme() {
  return const TooltipThemeData(
    decoration: BoxDecoration(
      color: tPrimaryColor,
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    ),
  );
}

//DON'T KNOW
buildIconTheme(IconThemeData base) {
  return base.copyWith(
    color: tColorDisplayText,
  );
}

//DON'T KNOW
InputDecorationTheme buildInputDecorationTheme(
  InputDecorationTheme base,
  TextTheme baseTextTheme,
) {
  const borderSide = BorderSide(
    color: tGreyShade1,
  );
  final inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: tGreyShade1,
    ),
  );
  return base.copyWith(
    // contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    contentPadding:
        const EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 12),
    border: inputBorder,
    hintStyle: const TextStyle(color: tGreyShade1),
    enabledBorder: inputBorder,
    disabledBorder: inputBorder.copyWith(
      borderSide: borderSide.copyWith(color: tGreyShade1),
    ),
    errorBorder: inputBorder.copyWith(
      borderSide: borderSide.copyWith(
        color: Colors.red,
      ),
    ),
    errorMaxLines: 2,
    focusedBorder: inputBorder.copyWith(
      borderSide: borderSide.copyWith(
        color: tPrimaryColor,
      ),
    ),
    isDense: true,
    filled: true,
    fillColor: const Color(0xFFF3F3F3),
    labelStyle: baseTextTheme.bodyMedium?.copyWith(fontSize: 13),
  );
}

//HMM DON'T KNOW
ColorScheme buildColorScheme(ColorScheme colorScheme) {
  return colorScheme.copyWith(
    error: Colors.red,
    primary: tPrimaryColor,
    secondary: tSecondaryColor,
    background: Colors.white,
    onPrimary: Colors.white,
  );
}
