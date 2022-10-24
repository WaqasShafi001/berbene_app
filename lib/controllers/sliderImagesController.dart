// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, empty_catches
import 'dart:convert';
import 'dart:io';
import 'package:berbene_app/apiModels/sliderApiModel.dart';
import 'package:berbene_app/flow/utils/apiURL.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class SliderImagesController extends GetxController {
  @override
  void onInit() {
    getSliderImages();
    super.onInit();
  }

  var isLoading = true.obs;
  var sliderImageList = <ResponseObject>[].obs;

  var listOfImagePaths = <String?>[];

  Future<SliderAPIModel?>? getSliderImages() async {
    try {
      String filename = 'CachedSliderData.json';
      var cacheDir = await getApplicationDocumentsDirectory();
      if (await File(cacheDir.path + "/" + filename).exists()) {
        print('Loaading from cache slider');
        var jsonData = File(cacheDir.path + "/" + filename).readAsStringSync();
        SliderAPIModel response =
            SliderAPIModel.fromJson(json.decode(jsonData));
        isLoading.value = false;
        return response;
      } else {
        var response = await http.get(
          Uri.parse(
            '$baseURL$sliderImagesUrl',
          ),
        );
        if (response.statusCode == 200) {
          var jsonResponse = response.body;
          print(' this is from api = $jsonResponse ');
          var data = jsonDecode(jsonResponse);

          SliderAPIModel res = SliderAPIModel.fromJson(data);
          var tempDir = await getApplicationDocumentsDirectory();
          File file = File(tempDir.path + "/" + filename);
          file.writeAsStringSync(jsonResponse,
              flush: true, mode: FileMode.write);
          isLoading.value = false;

          return res;
        }
      }
    } catch (e) {}
  }
}
