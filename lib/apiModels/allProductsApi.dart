import 'dart:convert';
import 'dart:io';
import 'package:berbene_app/flow/utils/apiURL.dart';
import 'package:http/http.dart' as http;
import 'package:berbene_app/apiModels/allProductApiModel.dart';
import 'package:path_provider/path_provider.dart';

class AllProductsApiClass {
  Future<AllProductsApiModel?>? getAllProductsDetailFromAPIorCache(
      {String? language}) async {
    try {
      String filename = 'CachedData.json';
      var cacheDir = await getApplicationDocumentsDirectory();

      if (await File(cacheDir.path + "/" + filename).exists()) {
        print('Loaading from cache all products');
        var jsonData = File(cacheDir.path + "/" + filename).readAsStringSync();
        AllProductsApiModel response =
            AllProductsApiModel.fromJson(json.decode(jsonData));
        return response;
      } else {
        print('loading from api');
        var response =
            await http.get(Uri.parse('$baseURL$allProductUrl$language'));
        if (response.statusCode == 200) {
          var jsonResponse = response.body;
          print(' this is from api = $jsonResponse ');

          AllProductsApiModel res =
              AllProductsApiModel.fromJson(json.decode(jsonResponse));
          var tempDir = await getApplicationDocumentsDirectory();
          File file = File(tempDir.path + "/" + filename);
          file.writeAsStringSync(jsonResponse,
              flush: true, mode: FileMode.write);
          return res;
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
