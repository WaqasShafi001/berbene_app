import 'dart:convert';

import 'package:berbene_app/flow/utils/apiURL.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../apiModels/deviceIdModel.dart';

class DeviceIdController extends GetxController {
  String deviceIdentifier = "unknown";
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Future<String> deviceInformation() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceIdentifier = androidInfo.androidId!;
    return deviceIdentifier;
  }

  Future sendDeviceIdToApi() async {
    await deviceInformation();
    try {
      var response = await http.post(
        Uri.parse('$baseURL$addDeviceUrl'),
        body: {
          "deviceid": "$deviceIdentifier",
        },
      ).then((value) {
        var result = jsonDecode(value.body);
        DeviceIdModel model = DeviceIdModel.fromJson(result);
        if (model.status == 200) {
          print(model.message);
          print('Device ID sent over server at the time of installation');
        } else {
          print(model.message);
        }
      }).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          print('device id not sent');
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
