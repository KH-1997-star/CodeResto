import 'dart:convert';

import 'package:code_resto/models/response.dart';
import 'package:code_resto/utils/consts.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/utils/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ConexionRepo extends ChangeNotifier {
  Future<Response> signUp(nom, prenom, numTel, email, mdp) async {
    Map<String, dynamic> data = {
      "extraPayload": {
        'nom': nom,
        'prenom': prenom,
        'phone': numTel,
        'email': email,
        'password': mdp,
        'type': '',
      }
    };
    try {
      var response = await http.post(
        Uri.parse(urlSignUp),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(idConst, jsonDecode(response.body));

        return Response(
          {},
          true,
        );
      } else if (response.statusCode == 400) {
        return Response({}, false,
            message: 'cette adresse email est déjà utilisée');
      } else {
        iPrint(
            'ConexionRepo/signUp \n${response.body}\n ${response.statusCode}');

        return Response({}, false, message: erreurClient);
      }
    } catch (e) {
      iPrint('ConexionRepo/signUp Exception: \n${e.toString()}');
      return Response({}, false, message: erreurUlterieur);
    }
  }

//Method SignIn
  Future<Response> signInWithEmailAndPassword(
      {String? email,
      String? password,
      String? id,
      String? token,
      String? type}) async {
    Map<String, dynamic> data = id == null
        ? {
            'email': email,
            'password': password,
            'role': 'ROLE_CLIENT',
          }
        : {
            'email': email,
            'accessToken': token,
            'idUser': id,
            'type': type,
            'password': id,
            'role': 'ROLE_CLIENT',
          };
    try {
      var response = await http.post(
        Uri.parse(urlLogin),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: data,
      );
      if (response.statusCode == 200) {
        id == null
            ? iPrint('Im Connecting With Email')
            : iPrint('Im Connecting With Google or Facebook');
        var body = jsonDecode(response.body);
        iPrint(body['message']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(idConst, body["identifiantMongo"]);
        prefs.setString(tokenconst, body["token"]);
        iPrint('MY TOKEN : ');
        iPrint(body["token"]);

        return Response({}, true, message: body['message']);
      } else {
        iPrint(
            'ConexionRepo/signIn \n${response.body}\n ${response.statusCode}');

        return Response({}, false, message: erreurClient);
      }
    } catch (e) {
      iPrint(e.toString());
      iPrint('ConexionRepo/signIn : \n${e.toString()}');
      return Response({}, false, message: erreurUlterieur);
    }
  }

  Future<Response> signInWithGoogleOrFacebook(
      {required String token,
      required String id,
      required String type,
      required String email,
      required String nom,
      required}) async {
    Map<String, dynamic> data = {
      "extraPayload": {
        'email': email,
        'role': 'ROLE_CLIENT',
        'accessToken': token,
        'idUser': id,
        'type': type,
        'nom': nom,
      }
    };

    try {
      print(data);
      var response = await http.post(
        Uri.parse(urlSignInDirect),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        iPrint('GOOGLE');
        var body = jsonDecode(response.body);
        iPrint(body['message']);
        await signInWithEmailAndPassword(
            email: email, type: type, id: id, token: token);
        return Response({}, true, message: body['message']);
      } else {
        iPrint(response.statusCode);
        iPrint(response.body);
        return Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      iPrint('conexion_repo/signInWithGoogleOrFacebook\nException: $e');
      return Response({}, false, message: erreurCnx);
    }
  }

  Future<Response> activateAccount(String email, String code,
      {String? mdp}) async {
    var data = {"email": email, "code": code};
    try {
      var response = await http.post(Uri.parse(urlActiv), body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var resp =
            await signInWithEmailAndPassword(email: email, password: mdp);
        if (resp.result) {
          return Response(
            {},
            true,
          );
        }
        return Response({}, false, message: 'INSCRIPTION');
      } else if (response.statusCode == 400) {
        return Response({}, false, message: "code incorrecte");
      } else {
        iPrint(
            'conexion_repo/activateAccount: ${response.statusCode} ${response.body}');
        return Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      iPrint('conexion_repo/activateAccount: Exception $e');
      return Response({}, false, message: erreurCnx);
    }
  }

  Future<Response> resendCode(String email) async {
    var data = {"email": email};
    try {
      var response = await http.post(Uri.parse(urlResend), body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Response({}, true, message: 'E-mail envoyé avec sucée');
      } else {
        iPrint(
            'conexion_repo/activateAccount: ${response.statusCode} ${response.body}');
        return Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      iPrint('conexion_repo/activateAccount: Exception $e');
      return Response({}, false, message: erreurCnx);
    }
  }
}
