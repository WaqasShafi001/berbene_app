import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:berbene_app/apiModels/allCategoryApiModel.dart';
import 'package:berbene_app/controllers/productApiController.dart';
import 'package:berbene_app/controllers/updateDeviceDataController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:berbene_app/flow/utils/apiURL.dart';
import 'package:path_provider/path_provider.dart';

class CategoriesApiController extends GetxController {
  var isLoading = true.obs;
  var apiCall = false.obs;
  var allProductsController = Get.put(ProductApiController());
  var updateDeviceDataController = Get.put(UpdateDeviceDataController());

  var productsLoaded = true.obs;
  var cacheDir;

  @override
  void onInit() {
    getAllCategories();
    super.onInit();
  }

  var categoriesList = <CategoryResponse>[].obs;

  void reCallHomeApiCtr() async {
    _deleteCacheDir();

    onInit();
    allProductsController.reCallProductApiCtr();
  }

  Future<void> _deleteCacheDir() async {
    cacheDir = await getApplicationDocumentsDirectory();
    print('cacche file is = $cacheDir');

    if (cacheDir.existsSync()) {
      print('cacche file is = yes exist');

      cacheDir.deleteSync(recursive: true);
    }
  }

  Future getAllCategories() async {
    try {
      String filename = 'CachedAllCategpriesAndProductsData.json';
      cacheDir = await getApplicationDocumentsDirectory();
      print('cacche file is = $cacheDir');
      if (await File(cacheDir.path + "/" + filename).existsSync()) {
        print('Loaading from cache get all categories with products');
        print('cacche file is = $cacheDir');
        var jsonData = File(cacheDir.path + "/" + filename).readAsStringSync();
        CategoryApiModel model =
            CategoryApiModel.fromJson(json.decode(jsonData));
        categoriesList.value = model.response!;
        isLoading.value = false;
        return model;
      } else {
        print('loading from api');
        var response = await http.get(
          Uri.parse(
            '$baseURL$allCategoryUrl',
          ),
        );
        if (response.statusCode == 200) {
          var jsonResponse = response.body;
          print(' this is from api = $jsonResponse ');
          CategoryApiModel model =
              CategoryApiModel.fromJson(json.decode(jsonResponse));

          var tempDir = await getApplicationDocumentsDirectory();
          File file = File(tempDir.path + "/" + filename);
          file.writeAsStringSync(jsonResponse,
              flush: true, mode: FileMode.write);
          categoriesList.value = model.response!;

          isLoading.value = false;
          await updateDeviceDataController.callUpdateDeviceDataApi();
          return model;
        }
      }
    } catch (e) {}
  }
}
