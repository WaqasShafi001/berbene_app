import 'dart:convert';
import 'dart:io';
import 'package:berbene_app/flow/utils/apiURL.dart';
import 'package:berbene_app/flow/utils/persistedClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../apiModels/passwordVerifyModel.dart';
import '../flow/splashScreen/SplashScreen.dart';

class PasswordVerifyController extends GetxController {
  var isLoading = false.obs;
  TextEditingController passwordTextController = TextEditingController();
  Future passwordVerify(String password) async {
    isLoading.value = true;
    try {
      var response = await http
          .post(
        Uri.parse('$baseURL$passwordVerifyUrl?password=$password'),
      )
          .then((value) {
        PasswordVerifyModel model =
            PasswordVerifyModel.fromJson(jsonDecode(value.body));
        if (model.status == 200) {
          SharedPreferenceClass prefes = SharedPreferenceClass();
          prefes.savePassword(password: password);

          isLoading.value = false;

          Get.off(SplashScreen());
        } else {
          isLoading.value = false;
          exit(0);
        }
      });
    } catch (e) {
      isLoading.value = false;

      print(e.toString());
    }
  }
}
