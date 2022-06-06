import 'dart:convert';

import 'package:code_resto/models/favoris.dart';
import 'package:code_resto/models/response.dart';
import 'package:code_resto/utils/consts.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class FavorisRepo extends ChangeNotifier {
  Favoris favoris = Favoris();
  bool done = false;
  Future<Response> likeMenu(String idMenu, {bool fromFavoris = false}) async {
    String? token = await getCurrentToken();
    String url = '${hostDynamique}api/client/likeMenu';
    Map body = {'idMenu': idMenu};
    try {
      var response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          "authorization": "Bearer " + token!,
        },
      );
      if (response.statusCode == 200) {
        if (fromFavoris) {
          await viewMyLikeList();
        }
        return Response({}, true);
      } else {
        iPrint(response.statusCode);
        iPrint(response.body);
        return Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      return Response({}, false, message: erreurCnx);
    }
  }

  Future<Response> viewMyLikeList() async {
    String url = '${hostDynamique}api/client/mesFavoris';
    String? token = await getCurrentToken();
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "authorization": "Bearer " + token!,
        },
      );
      if (response.statusCode == 200) {
        favoris = Favoris.fromJson(jsonDecode(response.body));
        iPrint('done');
        done = true;
        return Response({'favoris': favoris}, true);
      } else if (response.statusCode == 401) {
        return Response({}, false, message: '401');
      } else {
        iPrint('nop');
        done = false;
        iPrint(response.statusCode);
        iPrint(response.body);
        return Response({}, false);
      }
    } catch (e) {
      done = false;
      iPrint('exception');
      return Response({}, false);
    }
  }
}
