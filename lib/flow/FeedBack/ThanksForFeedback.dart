import 'package:berbene_app/flow/bottomNavBar/bottomNavbar.dart';
import 'package:berbene_app/style/appColors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

class ThanksForFeedback extends StatelessWidget {
  const ThanksForFeedback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.height * 0.1),
              child: Image.asset(
                'assets/logo.png',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Text(
                'thank_you',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: height * 0.02, color: AppColors.mainGreenColor),
              ).tr(),
            ),
            InkWell(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              onTap: () => Get.to(BottomNavbar()),
              child: Container(
                height: height * 0.05,
                width: width * 0.4,
                decoration: BoxDecoration(
                    color: AppColors.mainGreenColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/home_on.png',
                        color: AppColors.whiteColor,
                      ),
                      Text(
                        'homepage',
                        style: TextStyle(
                            fontSize: height * 0.018,
                            color: AppColors.whiteColor),
                      ).tr(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
