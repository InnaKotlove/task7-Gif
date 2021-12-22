import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class FetchHelper {
  final String url;

  FetchHelper(this.url);

  Future<Map<String, dynamic>?> getData() async {
    debugPrint("from home_page _getData:");
    debugPrint(url);
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else {
      print("from inside fetch getData");
      print(response.statusCode);
      return null;
    }
  }
}
