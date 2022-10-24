// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, constant_identifier_names, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> ar_IQ = {
    "home": "الصفحة الرئيسية",
    "category": "لصفحة الرئيسية",
    "call": "لصفحة الرئيسية"
  };
  static const Map<String, dynamic> en_US = {
    "home": "Home",
    "category": "Home",
    "call": "Home"
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "ar_IQ": ar_IQ,
    "en_US": en_US
  };
}
