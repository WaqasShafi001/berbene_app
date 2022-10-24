// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, empty_catches

import 'dart:io';
import 'package:berbene_app/apiModels/allProductApiModel.dart';
import 'package:berbene_app/apiModels/productApiModel.dart';
import 'package:berbene_app/flow/utils/apiURL.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ProductApiController extends GetxController {
  var apiCall = false.obs;
  var listOfCachedProducts = [].obs;
  var cacheDir;
  var isLoading2 = false.obs;
  var selectedIndexx = 0.obs;

  @override
  void onInit() {
    getAllProducts();
    super.onInit();
  }

  void reCallProductApiCtr() async {
    _deleteCacheDir();
    getAllProducts()!.then((value) {
      apiCall.value = false;
      getAllProducts();
    });
  }

  var sliderImagesForProductDetail = <String?>[];

  var isLoading = true.obs;
  var isLoading1 = false.obs;
  var noCategorySelected = true.obs;
  var productDetailTitle = ''.obs;
  var productDetailPrice = 0.obs;
  var productDetailImage = ''.obs;
  var productDetailIngredients = ''.obs;
  var productDetailNutritionInfo = ''.obs;
  var productDetailSliderImages = <String?>[].obs;

  var productList = <ProductResponse>[].obs;
  var allProductList = <ProductApiResponse>[].obs;
  var allFeaturedProductList = <ProductApiResponse>[].obs;
  Map productDetail = {}.obs;

  Future getProductsByCategoryId({int? categoryId}) async {
    isLoading.value = true;

    try {
      String filenameForProduct =
          'language' + categoryId!.toString() + 'CachedSingleProductsData.json';
      cacheDir = await getApplicationDocumentsDirectory();
      print('cache file for single product is = $cacheDir');

      if (await File(cacheDir.path + "/" + filenameForProduct).existsSync()) {
        print('Loaading from cache products by id');
        var jsonData =
            File(cacheDir.path + "/" + filenameForProduct).readAsStringSync();
        ProductApiModel response =
            ProductApiModel.fromJson(json.decode(jsonData));
        productList.value = response.response!;

        isLoading.value = false;

        return response;
      } else {
        var response =
            await http.get(Uri.parse('$baseURL$productsUrl$categoryId'));
        if (response.statusCode == 200) {
          var jsonResponse = response.body;

          ProductApiModel res =
              ProductApiModel.fromJson(json.decode(jsonResponse));
          var tempDir = await getApplicationDocumentsDirectory();
          File file = File(tempDir.path + "/" + filenameForProduct);
          file.writeAsStringSync(jsonResponse,
              flush: true, mode: FileMode.write);
          productList.value = res.response!;

          isLoading.value = false;

          return res;
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _deleteCacheDir() async {
    cacheDir = await getApplicationDocumentsDirectory();
    print('cacche file is = $cacheDir');

    if (cacheDir.existsSync()) {
      print('cacche file is = yes exist');

      cacheDir.deleteSync(recursive: true);
    }
  }

  Future<AllProductsApiModel?>? getAllProducts() async {
    try {
      String filename = 'language' + 'CachedAllProductsData.json';
      cacheDir = await getApplicationDocumentsDirectory();
      print('cacche file is = $cacheDir');

      if (await File(cacheDir.path + "/" + filename).existsSync()) {
        var jsonData = File(cacheDir.path + "/" + filename).readAsStringSync();
        AllProductsApiModel response =
            AllProductsApiModel.fromJson(json.decode(jsonData));
        allProductList.value = response.response!;

        isLoading.value = false;

        return response;
      } else {
        var response = await http.get(Uri.parse('$baseURL$allProductUrl'));
        if (response.statusCode == 200) {
          var jsonResponse = response.body;

          AllProductsApiModel res =
              AllProductsApiModel.fromJson(json.decode(jsonResponse));
          var tempDir = await getApplicationDocumentsDirectory();
          File file = File(tempDir.path + "/" + filename);
          file.writeAsStringSync(jsonResponse,
              flush: true, mode: FileMode.write);
          allProductList.value = res.response!;
          allFeaturedProductList.value = allProductList
              .where((p0) => p0.isFeatured == 1 || p0.isFeatured == true)
              .toList();
          log('this is new featured products list = = = $allFeaturedProductList');
          log('this is only featured product list ${allProductList.where((p0) => p0.isFeatured == 1 || p0.isFeatured == true)}');
          var nameIs = allFeaturedProductList.map((e) => e.title);
          log('this is new list nameIs= = = $nameIs');

          isLoading.value = false;

          return res;
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
