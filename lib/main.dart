import 'package:medcore/AuthScreens/change_password_screen.dart';
import 'package:medcore/AuthScreens/forgot_password_screen.dart';
import 'package:medcore/AuthScreens/signup_screen.dart';
import 'package:medcore/AuthScreens/signin_screen.dart';
import 'package:medcore/index.dart';
import 'package:medcore/splash_screen.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'database/mysqlDatabase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await mysqlDatabase.connect();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(medcore()));
}

class medcore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: ColorResources.green009),
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
      ),
      home: SplashScreen(),
      routes: {
        index.routeName: (ctx) => index(),
        SignInScreen.routeName: (ctx) => SignInScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        ChangePasswordScreen.routeName: (ctx) => ChangePasswordScreen(),
        ForgotPasswordScreen.routeName: (ctx) => ForgotPasswordScreen(),
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
