import 'dart:convert';

import 'package:berbene_app/flow/utils/apiURL.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../apiModels/updateDeviceDataModel.dart';

class UpdateDeviceDataController extends GetxController {
  String deviceIdentifier = "unknown";
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Future<String> deviceInformation() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceIdentifier = androidInfo.androidId!;
    return deviceIdentifier;
  }

  Future callUpdateDeviceDataApi() async {
    await deviceInformation();
    try {
      var response = await http.post(
        Uri.parse('$baseURL$updateDeviceDataUrl'),
        body: {
          "deviceid": "$deviceIdentifier",
        },
      ).then((value) {
        var result = jsonDecode(value.body);
        UpdateDeviceDataModel model = UpdateDeviceDataModel.fromJson(result);
        if (model.status == 200) {
          print(model.message);
        } else {
          print(model.message);
        }
      }).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
