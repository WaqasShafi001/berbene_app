// ignore_for_file: file_names, unnecessary_string_interpolations

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceClass {
  Future addLocale({String? en, String? dd}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('en', '${en ?? 'en'}');
    prefs.setString('dd', '${dd ?? ' US'}');
  }

  Future savePassword({String? password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('pass', '$password');
  }

  Future<String?> readPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var pass = prefs.getString('pass');
    return pass;
  }

  // read({String? key}) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return json.decode(prefs.getString(key!)!);
  // }

  // save({String? key, value}) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString(key!, json.encode(value));
  // }

  // remove({String? key}) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.remove(key!);
  // }
}
