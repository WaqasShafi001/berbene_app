import 'package:berbene_app/controllers/categoryApiController.dart';
import 'package:berbene_app/controllers/productApiController.dart';
import 'package:berbene_app/flow/bottomNavBar/bottomNavbar.dart';
import 'package:berbene_app/style/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var productController;
  var allCategoryController;
  @override
  void initState() {
    productController = Get.put(ProductApiController());
    allCategoryController = Get.put(CategoriesApiController());
    Future.delayed(
      Duration(
        seconds: 2,
      ),
    ).then((value) => Get.to(
          BottomNavbar(),
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainGreenColor,
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          fit: BoxFit.fill,
          width: Get.width * 0.5,
        ),
      ),
    );
  }
}
