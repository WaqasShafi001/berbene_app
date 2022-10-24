import 'dart:developer';
import 'package:berbene_app/apiModels/addFeedbackApiModel.dart';
import 'package:berbene_app/flow/FeedBack/ThanksForFeedback.dart';
import 'package:berbene_app/flow/bottomNavBar/bottomNavbar.dart';
import 'package:berbene_app/flow/utils/apiURL.dart';
import 'package:berbene_app/style/appColors.dart';
import 'package:berbene_app/widgets/customSnackBar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apiModels/bulkFeedbackModel.dart';
import '../apiModels/passwordVerifyModel.dart';
import '../checkPasswordScreen.dart';
import '../flow/FeedBack/bulkFeedbackModel.dart';
import '../flow/FeedBack/database/db_helper.dart';
import 'navBarController.dart';

class FeedbackApiController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  var lastSyncTime = DateFormat().format(DateTime.now()).toString().obs;

  var navbarController = Get.find<BottomBarController>();

  var scanBarcode = ''.obs;
  var optionalComments = TextEditingController();
  var phoneTextController = TextEditingController();

  var isLoading = false.obs;

  List listofBoolTasteOfFood = [false, false, false, false, false].obs;
  List listofBoolCleanliness = [false, false, false, false, false].obs;
  List listofBoolServices = [false, false, false, false, false].obs;
  List listofBoolStaffBehaviour = [false, false, false, false, false].obs;

  var foodTasteRating = 0.obs;
  var cleanliness = 0.obs;
  var servicesRating = 0.obs;
  var behaviourRating = 0.obs;

  List<Feedbackk>? newListForFeddbacks = [];
  String deviceIdentifier = "unknown";
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Future<String> deviceInformation() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceIdentifier = androidInfo.androidId!;
    return deviceIdentifier;
  }

  submitFeedbackToDatabase() async {
    print('this is bacode value == ${scanBarcode.value}');
    print('this is foodTasteRating value == ${foodTasteRating.value}');
    print('this is cleanliness value == ${cleanliness.value}');
    print('this is servicesRating value == ${servicesRating.value}');
    print('this is behaviourRating value == ${behaviourRating.value}');
    print('this is optionalComments value == ${optionalComments.value}');
    print('this is phone number == ${phoneTextController.value}');

    try {
      var customerFeedback = Feedbackk(
        orderCode: scanBarcode.value,
        foodTaste: foodTasteRating.value,
        environment: cleanliness.value,
        service: servicesRating.value,
        staffBehaviour: behaviourRating.value,
        comment: '${optionalComments.value.text}',
        phone: '${phoneTextController.value}',
      );

      DatabaseHelper.instance.insertFeedback(customerFeedback);

      var databaseContent = await DatabaseHelper.instance.allFeedbacksFromDB();

      Get.defaultDialog(
        actions: [
          MaterialButton(
            color: AppColors.mainGreenColor,
            onPressed: () {
              resetQRCode();
              Get.to(ThanksForFeedback());
            },
            child: Text(
              'Okay',
              style: TextStyle(
                color: Colors.white,
              ),
            ).tr(),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          )
        ],
        title: tr('great'),
        titleStyle: TextStyle(
          color: AppColors.greyTextColor,
        ),
        content: Center(
          child: Text(
            'feedback_saved_successfully_in database',
            textAlign: TextAlign.center,
          ).tr(),
        ),
      );
    } catch (e) {
      print('this is the exception = = = == =  ${e.toString()}');
    }
  }

  Future sendFeedbackJsonToApi() async {
    await deviceInformation();
    var bulkFeedback = BulkFeedback(
      deviceid: deviceIdentifier,
      feedbacks: DatabaseHelper.instance.feedbacksMap,
    );

    var jsonToSend = jsonEncode(bulkFeedback.toJson());

    if (navbarController.mesgString.value == 'Connected') {
      if (jsonToSend.isNotEmpty) {
        try {
          var response = await http
              .post(
            Uri.parse('$baseURL$sendBulkFeedbackUrl'),
            body: jsonToSend,
          )
              .then((value) {
            var result = jsonDecode(value.body);
            BulkFeedbackModel model = BulkFeedbackModel.fromJson(result);
            if (model.status == 200) {
              print(model.message);
              print('bulk feedbacks sent to server');
              DateTime now = DateTime.now();
              lastSyncTime.value = DateFormat().format(now);
              DatabaseHelper.instance.deleteAllFeedbacks();
              customSnackbar(
                title: tr('good'),
                messageText: tr('all_feedbacks_synced'),
              );
            } else {
              print(model.message);
              print('bulk feedbacks did not sent to server');
            }
          }).timeout(
            const Duration(
              seconds: 5,
            ),
            onTimeout: () {
              print('time out : some error happened');
            },
          );
        } catch (e) {
          print(e.toString());
        }
      } else {
        print('Nothing to send');
      }
    } else {
      print('Not connected to intenet');
    }
  }

  Future<FeedBackApiModel?> submitFeedback() async {
    await deviceInformation();

    try {
      isLoading.value = true;
      var response = await http.post(
        Uri.parse('$baseURL$addFeedbackApiUrl'),
        body: {
          "order_code": "${scanBarcode.value}",
          "food_taste": "${foodTasteRating.value}",
          "deviceid": "$deviceIdentifier",
          "environment": "${cleanliness.value}",
          "service": "${servicesRating.value}",
          "staff_behaviour": "${behaviourRating.value}",
          "comment": "${optionalComments.text}",
          "phone": "${phoneTextController.text}"
        },
      ).then(
        (value) {
          var result = jsonDecode(value.body);
          FeedBackApiModel model = FeedBackApiModel.fromJson(result);
          if (model.status == 200) {
            Get.defaultDialog(
              actions: [
                MaterialButton(
                  color: AppColors.mainGreenColor,
                  onPressed: () {
                    Get.to(ThanksForFeedback());
                  },
                  child: Text(
                    'Okay',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ).tr(),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                )
              ],
              title: tr('great'),
              titleStyle: TextStyle(
                color: AppColors.greyTextColor,
              ),
              content: Center(
                child: Text(
                  'feedback_saved_successfully.',
                  textAlign: TextAlign.center,
                ).tr(),
              ),
            );

            resetQRCode();
          } else if (model.status == 500) {
            Get.defaultDialog(
              actions: [
                MaterialButton(
                  color: AppColors.mainGreenColor,
                  onPressed: () {
                    Get.to(BottomNavbar(
                      currentIndex: 3,
                    ));
                  },
                  child: Text(
                    'Okay',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ).tr(),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                )
              ],
              title: tr('oh_no'),
              titleStyle: TextStyle(
                color: AppColors.greyTextColor,
              ),
              content: Center(
                child: Text(
                  'already_saved_feedback_regarding_this_barcode_qr_code',
                  textAlign: TextAlign.center,
                ).tr(),
              ),
            );

            resetQRCode();
          } else {
            Get.to(BottomNavbar());
            customSnackbar(
              title: 'Message',
              messageText: 'Something went wrong',
            );
            resetQRCode();
          }
        },
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          Get.to(BottomNavbar(
            currentIndex: 3,
          ));
          customSnackbar(
            title: 'Message',
            messageText: 'Something went wrong',
          );
          resetQRCode();
        },
      );
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future checkPasswordMatch() async {
    // isLoading.value = true;
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // var pass = preferences.getString('pass');

    // try {
    //   var response = await http
    //       .post(
    //     Uri.parse('$baseURL$passwordVerifyUrl?password=$pass'),
    //   )
    //       .then((value) {
    //     PasswordVerifyModel model =
    //         PasswordVerifyModel.fromJson(jsonDecode(value.body));
    //     if (model.status == 200) {
    //       isLoading.value = false;

    submitFeedback();
    //     } else {
    //       isLoading.value = false;

    //       preferences.remove('pass');
    //       // terminate the app
    //       Get.off(CheckPasswordScreen());
    //     }
    //   });
    // } catch (e) {
    //   isLoading.value = false;

    //   print(e.toString());
    // }
  }

  Future checkPasswordMatch2() async {
    // isLoading.value = true;
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // var pass = preferences.getString('pass');

    // try {
    //   var response = await http
    //       .post(
    //     Uri.parse('$baseURL$passwordVerifyUrl?password=$pass'),
    //   )
    //       .then((value) {
    //     PasswordVerifyModel model =
    //         PasswordVerifyModel.fromJson(jsonDecode(value.body));
    //     if (model.status == 200) {
    //       isLoading.value = false;

    sendFeedbackJsonToApi();
    //     } else {
    //       isLoading.value = false;

    //       preferences.remove('pass');
    //       // terminate the app
    //       Get.off(CheckPasswordScreen());
    //     }
    //   });
    // } catch (e) {
    //   isLoading.value = false;

    //   print(e.toString());
    // }
  }

  updateListofBoolTasteOfFood(int index) {
    for (var i = 0; i < listofBoolTasteOfFood.length; i++) {
      listofBoolTasteOfFood[i] = false;
    }
    listofBoolTasteOfFood[index] = true;
  }

  updateListofBoolCleanliness(int index) {
    for (var i = 0; i < listofBoolCleanliness.length; i++) {
      listofBoolCleanliness[i] = false;
    }
    listofBoolCleanliness[index] = true;
  }

  updateListofBoolServices(int index) {
    for (var i = 0; i < listofBoolServices.length; i++) {
      listofBoolServices[i] = false;
    }
    listofBoolServices[index] = true;
  }

  updateListofBoolStaffBehaviour(int index) {
    for (var i = 0; i < listofBoolStaffBehaviour.length; i++) {
      listofBoolStaffBehaviour[i] = false;
    }
    listofBoolStaffBehaviour[index] = true;
  }

  String? validateMobile(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value!.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return '';
  }

  resetQRCode() {
    isLoading.value = false;
    scanBarcode.value = '';
    foodTasteRating.value = 0;
    cleanliness.value = 0;
    servicesRating.value = 0;
    behaviourRating.value = 0;
    optionalComments.text = '';
    phoneTextController.text = '';
    listofBoolTasteOfFood = [false, false, false, false, false].obs;
    listofBoolCleanliness = [false, false, false, false, false].obs;
    listofBoolServices = [false, false, false, false, false].obs;
    listofBoolStaffBehaviour = [false, false, false, false, false].obs;
  }
}
