// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'package:berbene_app/controllers/categoryApiController.dart';
import 'package:berbene_app/controllers/categoryPageController.dart';
import 'package:berbene_app/controllers/productApiController.dart';
import 'package:berbene_app/flow/bottomNavBar/bottomNavbar.dart';
import 'package:berbene_app/flow/utils/persistedClass.dart';
import 'package:berbene_app/main.dart';
import 'package:berbene_app/style/appColors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../PasswordProtectedScreen.dart';
import '../controllers/navBarController.dart';
import '../flow/bottomNavBar/statisticScreen.dart';

AppBar customAppBar({
  double? height,
  double? width,
  bool isBackButton = false,
  BuildContext? context,
  bool isFromStatistic = false,
}) {
  var navbarController = Get.find<BottomBarController>();
  return AppBar(
    backgroundColor: AppColors.mainGreenColor,
    centerTitle: true,
    leading: isBackButton
        ? Platform.localeName.contains('ar')
            ? InkWell(
                onTap: () {
                  isFromStatistic
                      ? Get.to(BottomNavbar())
                      : Navigator.pop(context!);
                },
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              )
            : Platform.localeName.contains('en')
                ? InkWell(
                    onTap: () {
                      isFromStatistic
                          ? Get.to(BottomNavbar())
                          : Navigator.pop(context!);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                    ),
                  )
                : SizedBox()
        : SizedBox(),
    title: Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          navbarController.mesgString.value == 'Disconnected'
              ? CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 252, 125, 116),
                  maxRadius: 2,
                  minRadius: 2,
                )
              : navbarController.mesgString.value == 'Connected'
                  ? CircleAvatar(
                      backgroundColor: Colors.green,
                      maxRadius: 2,
                      minRadius: 2,
                    )
                  : SizedBox(),
          SizedBox(
            width: 5,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: height! * 0.008),
            child: GestureDetector(
              onLongPress: () => Get.to(PasswordProtectedScreen()),
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
                height: height * 0.07,
              ),
            ),
          ),
        ],
      ),
    ),
    actions: [
      Padding(
        padding: EdgeInsets.only(
          right: findLanguageController.isEnglish.value ? width! * 0.03 : 0.0,
          left: !findLanguageController.isEnglish.value ? width! * 0.03 : 0.0,
        ),
        child: myPopMenu(
          height: height,
          width: width,
        ),
      )
    ],
  );
}

Widget myPopMenu({
  double? height,
  double? width,
}) {
  SharedPreferenceClass prefes = SharedPreferenceClass();
  var allCategoryController = Get.put(CategoriesApiController());
  var allProductsController = Get.put(ProductApiController());
  var putPageController = Get.put(GetPageController());

  return PopupMenuButton(
    icon: Icon(
      Icons.language,
      color: Colors.white60,
      size: height! * 0.034,
    ),
    onSelected: (value) {
      print('this is clicked');
      allProductsController.isLoading2.value = false;
    },
    itemBuilder: (context) => [
      PopupMenuItem(
        height: height * 0.06,
        value: 1,
        onTap: () {
          allCategoryController.isLoading.value = true;
          putPageController.selectedIndex.value = 0;
          // allProductsController.productList.value = [];
          // allCategoryController.onInit();

          allProductsController.isLoading2.value = true;
          // isProductDetailScreen! ? Get.back() : print('do nothing');

          // allProductsController.noCategorySelected.value = true;
          print('english');
          findLanguageController.isEnglish.value = true;
          context.setLocale(engLocale);
          prefes.addLocale(en: 'en', dd: 'US');
          Get.updateLocale(engLocale);
          log('current Locale is === $engLocale');
          print('value is ===  ${findLanguageController.isEnglish.value}');
        
         allCategoryController.getAllCategories();
          // allCategoryController.getAllCategories().then((value) {
          //   allCategoryController.onInit();
          // });
          allProductsController.getAllProducts();
        },
        child: Obx(
          () => Text(
            'English',
            style: TextStyle(
                fontWeight: findLanguageController.isEnglish.value
                    ? FontWeight.bold
                    : FontWeight.normal,
                fontSize: height * 0.017),
          ),
        ),
      ),
      PopupMenuItem(
        height: height * 0.06,
        value: 2,
        onTap: () {
          allCategoryController.isLoading.value = true;
          putPageController.selectedIndex.value = 0;
          // allProductsController.productList.value = [];
          // allCategoryController.onInit();

          allProductsController.isLoading2.value = true;
          // allProductsController.noCategorySelected.value = true;
          
          // isProductDetailScreen! ? Get.back() : print('do nothing');

          print('arabic');
          findLanguageController.isEnglish.value = false;
          context.setLocale(arabLocale);
          prefes.addLocale(en: 'ar', dd: 'IQ');
          Get.updateLocale(arabLocale);
          log('current Locale is === $arabLocale');
          print('value is ===  ${findLanguageController.isEnglish.value}');
         
         allCategoryController.getAllCategories();
          // allCategoryController.getAllCategories().then((value) {
          //   allCategoryController.onInit();
          // });
          allProductsController.getAllProducts();
        },
        child: Obx(
          () => Text(
            'عربي',
            style: TextStyle(
                fontWeight: !findLanguageController.isEnglish.value
                    ? FontWeight.bold
                    : FontWeight.normal,
                fontSize: height * 0.017),
          ),
        ),
      ),
    ],
  );
}
