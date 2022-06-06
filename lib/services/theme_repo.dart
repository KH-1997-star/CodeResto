import 'package:code_resto/models/color_model.dart';
import 'package:code_resto/utils/consts.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/utils/url.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ThemeRepo extends ChangeNotifier {
  ThemeModel themeData = ThemeModel();

  Future<ThemeModel?> getTheme() async {
    print(urlTheme);
    await http.get(Uri.parse(urlTheme)).then((response) {
      print(response.body);
      themeData = themeModelFromJson(response.body);
      print(themeData);
      print("hellloooo");
      String logo = themeData.results?[0].logo ?? "";
      setCurrentLogo(logo);
      return themeData;
    }).catchError((onError) {
      print("error");
      themeData = themeModelFromJson("json/theme.json");
      return themeData;
    });
    return themeData;
  }
}
