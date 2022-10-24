// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:get/get.dart';

class BottomBarController extends GetxController {
  var isHome = true.obs;
  var isCategories = false.obs;
  var isCallUs = false.obs;
  var mesgString = ''.obs;
  var showOnline = true.obs;

  var isShowStatisticScreen = false;
}
