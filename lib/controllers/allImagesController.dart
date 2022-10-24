import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:berbene_app/flow/utils/apiURL.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../apiModels/AllImagesModel.dart';

class AllImagesController extends GetxController {
  // @override
  // void onInit() {
  //   fetchAllImages();
  //   super.onInit();
  // }

  var cacheDir;

  var allImagesList = <String>[].obs;

  var lastSyncTime = DateFormat().format(DateTime.now()).toString().obs;

  Future deleteCache() async {
    String filename = 'CachedAllImagesData.json';
    try {
      cacheDir = await getApplicationDocumentsDirectory();
      if (await File(cacheDir.path + "/" + filename).existsSync())
        File(cacheDir.path + "/" + filename).deleteSync();
    } catch (e) {
      print(e.toString());
    }
  }

  Future fetchAllImages() async {
    String filename = 'CachedAllImagesData.json';

    try {
      cacheDir = await getApplicationDocumentsDirectory();
      if (await File(cacheDir.path + "/" + filename).existsSync()) {
        print('Loading grid images from cache');
        print('cacche file is = $cacheDir');
        var jsonData = File(cacheDir.path + "/" + filename).readAsStringSync();
        ImagesAll model = ImagesAll.fromJson(json.decode(jsonData));
        allImagesList.value = model.data!;
        return model;
      } else {
        print('loading grid images from api');
        try {
          var response = await http.get(
            Uri.parse('$baseURL$allImagesUrl'),
          );

          if (response.statusCode == 200) {
            var result = response.body;
            ImagesAll model = ImagesAll.fromJson(json.decode(result));
            var tempDir = await getApplicationDocumentsDirectory();
            File file = File(tempDir.path + "/" + filename);
            file.writeAsStringSync(result, flush: true, mode: FileMode.write);

            allImagesList.value = model.data!;
            DateTime now = DateTime.now();
            lastSyncTime.value = DateFormat().format(now);

            log('this is all images URLS $allImagesList');
            return model;
          } else {}
        } catch (e) {
          print(e.toString());
        }
      }
    } catch (e) {}
  }
}
