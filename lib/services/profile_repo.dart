import 'dart:convert';

import 'package:code_resto/models/profile.dart';
import 'package:code_resto/models/response.dart';
import 'package:code_resto/utils/consts.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ProfileRepo extends ChangeNotifier {
  Profile profile = Profile();
  bool done = false;
  Future<Response> getProfileData() async {
    String? id = await getCurrentId(), token = await getCurrentToken();
    String url =
        '${hostDynamique}api/client/read/$id?vueAvancer=comptes_single';
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "authorization": "Bearer " + token!,
        },
      );
      if (response.statusCode == 200) {
        iPrint(response.body);
        profile = Profile.fromJson(jsonDecode(response.body)[0]);

        //notifyListeners();
        done = true;
        return Response({'profile': profile}, true);
      } else {
        done = false;
        iPrint(
            'profile_repo/GetProfileDate  ${response.statusCode} ${response.body}');
        return Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      done = false;
      iPrint('profile_repo/GetProfileDate Exception $e');
      return Response({}, false, message: erreurCnx);
    }
  }

  Future<Response> updateProfile(String? nom, String? prenom, String? ville,
      String? adresse, String? pays, int? codePostale, String? phone) async {
    String? id = await getCurrentId(), token = await getCurrentToken();
    Map<String, dynamic> data = {
      "extraPayload": {
        "nom": nom,
        "prenom": prenom,
        "phone": phone,
        "ville": ville,
        "addresse": adresse,
        "pays": pays,
        "codePostal": codePostale,
      }
    };
    String urlUpdateAccount = '${hostDynamique}api/account/updateAccount/$id';
    try {
      var response = await http.post(
        Uri.parse(urlUpdateAccount),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json",
          "authorization": "Bearer " + token!,
        },
      );
      if (response.statusCode == 200) {
        return Response({}, true);
      } else {
        return Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {}
    return Response({}, false, message: erreurCnx);
  }
}
