import 'package:berbene_app/style/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'controllers/passwordVerifyController.dart';

class VerifyPasswordScreen extends StatelessWidget {
  const VerifyPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var verifyPassWordController = Get.put(PasswordVerifyController());
    var height = Get.height;
    var width = Get.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: AppColors.mainGreenColor,
        child: Obx(
          () => Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.fill,
                  width: width * 0.5,
                ),
              ),
              SizedBox(
                height: height * 0.15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: TextField(
                  controller: verifyPassWordController.passwordTextController,
                  cursorColor: AppColors.unselectedCategoryColor,
                  style: TextStyle(
                      color: AppColors.unselectedCategoryColor, fontSize: 18),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: AppColors.unselectedCategoryColor,
                    ),
                    hintText: tr("enter_password"),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.unselectedCategoryColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.unselectedCategoryColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.025,
              ),
              MaterialButton(
                onPressed: () {
                  if (verifyPassWordController
                      .passwordTextController.text.isNotEmpty) {
                    verifyPassWordController.passwordVerify(
                        '${verifyPassWordController.passwordTextController.text}');
                  } else {
                    // Get.snackbar('title', 'message');

                  }
                },
                color: AppColors.unselectedCategoryColor,
                elevation: 3,
                height: height * 0.05,
                minWidth: width * 0.3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  'confirm',
                  style:
                      TextStyle(color: AppColors.mainGreenColor, fontSize: 18),
                ).tr(),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              verifyPassWordController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.unselectedCategoryColor,
                      ),
                    )
                  : SizedBox(),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
