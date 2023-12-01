import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<dynamic> jsonFileToMap(String jsonAssetFilePath) async {
  if (!GetPlatform.isWeb) {
    jsonAssetFilePath = 'assets/$jsonAssetFilePath';
  }
  var jsonString = await rootBundle.loadString(jsonAssetFilePath);
  final response = await json.decode(jsonString);
  return response;
}
