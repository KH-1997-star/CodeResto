import 'dart:convert';
import 'dart:io';

import 'package:code_resto/models/detail_menu.dart';
import 'package:code_resto/models/plat.dart';
import 'package:code_resto/models/response.dart';
import 'package:code_resto/models/tags.dart';
import 'package:code_resto/utils/consts.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/utils/url.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PlatRepo extends ChangeNotifier {
  Future<Response> getAllPlat(String tag, int num) async {
    String? idMongo = await getCurrentId();
    String id = 'identifiantMongo=$idMongo';
    String url =
        '${hostDynamique}listeMenus?$id&indexVue=CLIENT&vueAvancer=menus_multi&isActive=1&offset=1&maxResults=$num$tag';
    iPrint(
        '${hostDynamique}listeMenus?$id&indexVue=CLIENT&vueAvancer=menus_multi&isActive=1&offset=1&maxResults=$num$tag');
    try {
      var response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        Plat plat = Plat.fromJson(jsonDecode(response.body));
        return Response(
          {
            'plat': plat,
          },
          true,
        );
      } else {
        iPrint('PlatRepo/getAllPlat : ${response.statusCode} ${response.body}');
        return Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      iPrint('PlatRepo/getAllPlat Exception : $e');
      return Response({}, false, message: erreurCnx);
    }
  }

  Future<Response> getAllTags() async {
    try {
      var response = await http.get(Uri.parse(urlAllTags));
      if (response.statusCode == 200) {
        Tags tags = Tags();
        tags = Tags.fromJson(jsonDecode(response.body));
        iPrint(tags.results!.length);
        return Response(
          {'tags': tags},
          true,
        );
      } else {
        iPrint('PlatRepo/getAllTags: ${response.body} ${response.statusCode}');
        return Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      iPrint('PlatRepo/getAllTags Exception:  $e');
      return Response({}, false, message: erreurCnx);
    }
  }

  Future<Response> searchByWord(String str) async {
    String? id = await getCurrentId();
    Map<String, dynamic> data = {
      'word': str,
      'identifiantMongo': id,
    };
    try {
      var response = await http.post(
        Uri.parse(urlSearchByWord),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: data,
      );
      if (response.statusCode == 200) {
        Plat plat = Plat.fromJson(jsonDecode(response.body));
        return Response(
          {
            'plat': plat,
          },
          true,
        );
      } else {
        iPrint(
            'PlatRepo/searchByWord : ${response.statusCode} ${response.body}');
        return Response({}, false, message: erreurUlterieur);
      }
    } on SocketException catch (e) {
      iPrint('PlatRepo/searchByWord Exception : $e ');
      return Response({}, false, message: erreurCnx);
    } catch (e) {
      iPrint('PlatRepo/searchByWord Exception : $e ');
      return Response({}, false,
          message: '$str n\'est pas reconnu dans nos menus');
    }
  }

  Future<Response> getDetailMenu(id) async {
    String? idMongo = await getCurrentId();
    try {
      var response = await http
          .get(Uri.parse('$urlDetailMenu$id?identifiantMongo=$idMongo'));
      print('$urlDetailMenu$id?identifiantMongo=$idMongo');
      if (response.statusCode == 200) {
        /*   List<DetailMenu> listDetail = List<DetailMenu>.from(
            json.decode(response.body).map((x) => DetailMenu.fromJson(x))); */
        iPrint('Result : ${response.body}');
        List<DetailMenu> listDetailMenu = List<DetailMenu>.from(
            json.decode(response.body).map((x) => DetailMenu.fromJson(x)));
        DetailMenu detailMenu = listDetailMenu[0];

        return Response({'detailMenu': detailMenu}, true);
      } else {
        iPrint(
            'PlatRepo/getDetailMenu : ${response.statusCode} ${response.body}');
        return Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      iPrint('PlatRepo/getDetailMenu Exception : $e ');
      return Response({}, false, message: erreurCnx);
    }
  }
}
