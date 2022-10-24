import 'package:berbene_app/style/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'VerifyPasswordScreen.dart';
import 'flow/splashScreen/SplashScreen.dart';

class CheckPasswordScreen extends StatefulWidget {
  const CheckPasswordScreen({Key? key}) : super(key: key);

  @override
  State<CheckPasswordScreen> createState() => _CheckPasswordScreenState();
}

class _CheckPasswordScreenState extends State<CheckPasswordScreen> {
  @override
  void initState() {
    super.initState();
    isPassSaved();
  }

  Future isPassSaved() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var pass =  preferences.getString('pass');
    if (pass != null) {
      Get.off(SplashScreen());
      print('this is saved password $pass');
    } else {
      Get.off(VerifyPasswordScreen());
      print('password is not saved');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainGreenColor,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
