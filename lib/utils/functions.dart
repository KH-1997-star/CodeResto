import 'dart:io';

import 'package:code_resto/models/response.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/consts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

double getHeight(context) => MediaQuery.of(context).size.height;
const bool kDebugMode = !kReleaseMode && !kProfileMode;
void iPrint(dynamic str) {
  if (kDebugMode) {
    print(str);
  }
}

double getWidth(context) => MediaQuery.of(context).size.width;
void buildshowToast(String msg) => Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER,
      fontSize: 2,
      backgroundColor: Colors.red,
    );
void hideKeyboard(context) => FocusScope.of(context).requestFocus(
      FocusNode(),
    );
void showToast(String msg,
        {Color color = myBlack, Color txtColor = myWhite, int duration = 1}) =>
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: color,
      textColor: txtColor,
      timeInSecForIosWeb: duration,
    );

showLoader(context) => Loader.show(
      context,
      progressIndicator: const CircularProgressIndicator(
        backgroundColor: myBlue,
      ),
      themeData: Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
      ),
    );
hideLoader(context) => Loader.hide();

Future<Response> futureMethod(f, context) async {
  showLoader(context);
  Response response = await f;
  hideLoader(context);
  return response;
}

Future<String?> getCurrentId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? id = prefs.getString(idConst);
  return id;
}

Future<String?> getCurrentToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString(tokenconst);
  return token;
}

Future<String?> getCurrentPanierId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString(idPanier);
  return token;
}

Future<String?> getCurrentCommandeId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString(idCommande);
  return token;
}

setCurrentCommandeId(String idCmd) async {
  SharedPreferences? prefs = await SharedPreferences.getInstance();
  prefs.setString(idCommande, idCmd);
}

setCurrentLogo(String logo) async {
  SharedPreferences? prefs = await SharedPreferences.getInstance();
  prefs.setString(logoShare, logo);
}

getCurrentLogo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getString(logoShare);
}

Future<bool> disconnect() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool result = false;
  while (!result) {
    if (await prefs.remove(idConst)) {
      if (await prefs.remove(tokenconst)) {
        result = await prefs.remove(idPanier);
      }
    }
  }
  return result;
}

/* Future<void> clearStorage() async {
  final LocalStorage storage = LocalStorage('codepadding');
  await storage.clear();
}
 */

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
