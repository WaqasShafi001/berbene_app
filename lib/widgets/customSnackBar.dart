// ignore_for_file: prefer_const_constructors

import 'package:berbene_app/style/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

customSnackbar({String? title, String? messageText}) {
  Get.snackbar(
    '$title', '$messageText',
    backgroundColor: AppColors.whiteColor.withOpacity(0.7),

    titleText: Text(
      '$title',
      style: TextStyle(
        color: AppColors.mainGreenColor,
        fontSize: 18,
        fontFamily: 'Poppins',
      ),
    ),
    messageText: Text(
      '$messageText',
      style: TextStyle(
        color: AppColors.mainGreenColor,
        fontSize: 15,
        fontFamily: 'Poppins',
      ),
    ),
    // onTap: (snack) {
    //   print('snackkk $snack');
    // },
  );
}
