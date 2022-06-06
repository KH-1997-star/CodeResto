import 'package:code_resto/screens/forget_password_three.dart';
import 'package:code_resto/screens/forget_password_two_screen.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/consts.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:io';

class ForgetPasswordViewModel extends ChangeNotifier {
  final url = hostDynamique + "account/codeActivationMotDePasseOublier";
  final urlActiv = hostDynamique + "account/checkCodeActivation";
  final urlchange = hostDynamique + "account/changerPassword";
  bool? _isLoading;
  String? _email;
  String? _password;
  String? _code;
  String? token;
  ForgetPasswordViewModel();
  bool get isLoading => _isLoading ?? false;
  String get email => _email ?? "false";
  String get password => _password ?? "false";
  String get code => _code ?? "false";
  set password(String password) {
    _password = email;
  }

  set code(String code) {
    _code = code;
  }

  set email(String email) {
    _email = email;
  }

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  updateWith({isLoading}) {
    _isLoading = isLoading;
    notifyListeners();
  }

  String typee = "";
  Future<void> forgetPasswordOne(BuildContext context, String _email) async {
    Loader.show(context,
        progressIndicator: const CircularProgressIndicator(
          backgroundColor: myBlue,
          color: myBlue,
        ),
        themeData: Theme.of(context).copyWith(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.white)));
    updateWith(isLoading: true);

    var data = {"email": _email};
    iPrint("************************************");
    iPrint(data);
    iPrint(url + "*********");
    try {
      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          encoding: Encoding.getByName('utf-8'),
          body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Loader.hide();

        iPrint(response.body[0]);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ForgetPwdTwoScreen(
                      email: _email,
                    )));
      } else {
        Loader.hide();
        iPrint(response.body);

        showToast('E-mail invalide', color: Colors.red);
        iPrint("Il semble qu'il a y eu un problème !.");
      }
    } on SocketException {
      Loader.hide();

      showToast('Veuillez vérifier votre connexion', color: Colors.red);
      iPrint("Il semble qu'il a y eu un problème !.");
    } on HttpException {
      Loader.hide();
      showToast('Il semble qu\'il a y eu un problème !', color: Colors.red);
      iPrint("Il semble qu'il a y eu un problème !.");
    } on FormatException {
      Loader.hide();
      showToast('Il semble qu\'il a y eu un problème !', color: Colors.red);
      iPrint("Il semble qu'il a y eu un problème !.");
    }
  }

  Future<void> forgetPasswordTwo(
      BuildContext context, String _pinCODE, String? _email) async {
    updateWith(isLoading: true);
    Loader.show(context,
        progressIndicator: const CircularProgressIndicator(
          backgroundColor: myBlue,
        ),
        themeData: Theme.of(context).copyWith(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.white)));

    var data = {
      "email": _email,
      "code": _pinCODE,
    };
    iPrint("************************************");
    iPrint(data);
    iPrint(urlActiv);
    try {
      var response = await http.post(Uri.parse(urlActiv), body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Loader.hide();

        iPrint(response.body);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ForgetPwdThreeScreen(
                      email: _email,
                    )));
      } else if (response.statusCode == 400) {
        Loader.hide();
        showToast('Code incorrect', color: Colors.red);

        iPrint(response.body);
        iPrint("Il semble qu'il a y eu un problème !.");
      } else {
        Loader.hide();
        showToast('Code incorrect', color: Colors.red);

        iPrint(response.body);
        iPrint("Il semble qu'il a y eu un problème !.");
      }
    } on SocketException {
      Loader.hide();
      showToast('Veuillez vérifier votre connexion', color: Colors.red);

      iPrint("Il semble qu'il a y eu un problème !.");
    } on HttpException {
      Loader.hide();
      showToast('Il semble qu\'il a y eu un problème !', color: Colors.red);

      iPrint("Il semble qu'il a y eu un problème !.");
    } on FormatException {
      Loader.hide();

      showToast('Il semble qu\'il a y eu un problème !', color: Colors.red);
      iPrint("Il semble qu'il a y eu un problème !.");
    }
  }

  Future<void> newPassword(
      BuildContext context, String? _newpwd, String? _email) async {
    Loader.show(context,
        progressIndicator: const CircularProgressIndicator(
          backgroundColor: myBlue,
        ),
        themeData: Theme.of(context).copyWith(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.white)));
    updateWith(isLoading: true);

    var data = {
      "email": _email,
      "password": _newpwd,
    };
    iPrint("************************************");
    iPrint(data);
    iPrint(urlchange);
    try {
      var response = await http.post(Uri.parse(urlchange),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          encoding: Encoding.getByName('utf-8'),
          body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Loader.hide();

        iPrint(response.body);
        showToast(
          "Mot de passe changé avec succés!",
        );
        Navigator.pushNamed(context, '/login');
      } else {
        Loader.hide();
        showToast(
          "Il semble qu'il y a eu un problème!",
          color: Colors.red,
        );

        iPrint("Il semble qu'il a y eu un problème !.");
      }
    } on SocketException {
      Loader.hide();
      showToast('Il semble qu\'il a y eu un problème !', color: Colors.red);

      iPrint("Il semble qu'il a y eu un problème !.");
    } on HttpException {
      Loader.hide();
      showToast('Il semble qu\'il a y eu un problème !', color: Colors.red);
      iPrint("Il semble qu'il a y eu un problème !.");
    } on FormatException {
      Loader.hide();
      showToast('Il semble qu\'il a y eu un problème !', color: Colors.red);
      iPrint("Il semble qu'il a y eu un problème !.");
    }
  }

  void resendCode(BuildContext context, String? email) async {
    Loader.show(context,
        progressIndicator: const CircularProgressIndicator(
          backgroundColor: myBlue,
        ),
        themeData: Theme.of(context).copyWith(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.white)));
    var data = {"email": email};
    String url = hostDynamique + "account/codeActivationMotDePasseOublier";
    iPrint(data);
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        iPrint("******************** SUCCESS **********************");
        iPrint(response.body);
        Loader.hide();
        showToast("E-mail envoyé");
      } else {
        Loader.hide();
        iPrint("******************** FAILD **********************");
        iPrint(response.body);
        showToast(
          "Réessayer",
          color: Colors.red,
        );
      }
    } on SocketException {
      Loader.hide();
      iPrint('**************** EXCEPTION*******************');
      showToast("Veuillez Vérifier votre conexion ", color: Colors.red);
    } on HttpException {
      iPrint('**************** EXCEPTION*******************');
      showToast("Il semble qu'il a y eu un problème.", color: Colors.red);
      Loader.hide();
    } on FormatException {
      iPrint('**************** EXCEPTION*******************');
      showToast("Il semble qu'il a y eu un problème.", color: Colors.red);
      Loader.hide();
    }
  }
}
