// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'VerifyPasswordScreen.dart';
import 'checkPasswordScreen.dart';
import 'controllers/deviceIdController.dart';
import 'controllers/languageController.dart';
import 'flow/splashScreen/SplashScreen.dart';
import 'style/appColors.dart';

var engLocale = Locale('en', 'US');
var arabLocale = Locale('ar', 'IQ');

var findLanguageController = Get.find<LangugeController>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.mainGreenColor,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  var deviceIdController = Get.put(DeviceIdController());
  await deviceIdController.sendDeviceIdToApi();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  var putLanguageController = Get.put(LangugeController());
  var firstTimeLocale = preferences.getString('en');
  log('this is first time local setting ==== $firstTimeLocale   and controller value ==== ${putLanguageController.isEnglish.value}');

  if (firstTimeLocale != null) {
    String? en = preferences.getString('en');
    String? dd = preferences.getString('dd');

    if (en == 'en' && dd == 'US') {
      putLanguageController.isEnglish.value = true;
      log('is working engLocale? = = = ${putLanguageController.isEnglish.value}');
    } else {
      putLanguageController.isEnglish.value = false;
      log('is working arabLocale? = = = ${putLanguageController.isEnglish.value}');
    }

    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('ar', 'IQ')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: MyApp(
          en: en,
          dd: dd,
        ),
      ),
    );
  } else {
    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('ar', 'IQ')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final String? en;
  final String? dd;
  const MyApp({Key? key, this.en = 'en', this.dd = 'US'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Berbene Restaurant',
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('ar', 'IQ'),
      ],
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      // locale: Locale(en!, dd),

      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      builder: (context, child) {
        Widget error = Text('...rendering error...');
        if (child is Scaffold || child is Navigator)
          error = Scaffold(body: Center(child: error));
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) => error;
        return child!;
      },
      home: SplashScreen()
      //CheckPasswordScreen(),
      // SplashScreen(),
    );
  }
}
