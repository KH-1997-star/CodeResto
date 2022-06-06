import 'dart:convert';

import 'package:code_resto/models/abonnement.dart';
import 'package:code_resto/models/response.dart';
import 'package:code_resto/models/specefic_abonnement.dart';
import 'package:code_resto/utils/consts.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:http/http.dart' as http;

class AbonnnementRepo {
  String urlGetAllAbonnements =
      '${hostDynamique}readAll/optionsAbonnements?vueAvancer=optionsAbonnements_multi&etat=1&statut=created';

  Future<Response> getAllAbonnement() async {
    try {
      var response = await http.get(Uri.parse(urlGetAllAbonnements));
      if (response.statusCode == 200) {
        iPrint(response.body);
        Abonnement abonnement = Abonnement.fromJson(jsonDecode(response.body));
        iPrint('DONE');
        return Response({'abonnement': abonnement}, true);
      } else {
        iPrint('Erreur');
        return Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      iPrint('Exception');
      iPrint(e);
      return Response({}, false, message: erreurCnx);
    }
  }

  Future<Response> acheterAbonnemant(String type, String abonnementId) async {
    String? id = await getCurrentId();
    String url = '${hostDynamique}acheterAbonnement';
    Map body = {
      'identifiantMongo': id,
      'typeAbonnement': type,
      'abonnement': abonnementId,
    };
    iPrint(body);
    try {
      var response = await http.post(Uri.parse(url), body: body);
      if (response.statusCode == 200) {
        // iPrint('done');

        var body = jsonDecode(response.body);
        //    print(body);
        String idAbonnement = body['idAbonnement'];
       String prixTTC = body['prixTTC'].toString();
         String customerId = body['customerId'].toString();
           String email = body['email'].toString();
        return Response({"prixTTC":prixTTC,"idAbonnement":idAbonnement,"customerId":customerId,"email":email}, true);
      } else {
      //  iPrint('no');
        return Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      //iPrint('Exception');
      return Response({}, false, message: erreurCnx);
    }
  }

  Future<Response> getMyAbonnement() async {
    String? id = await getCurrentId(), token = await getCurrentToken();
    String url =
        '${hostDynamique}api/client/readAll/abonnements?linkedCompte=$id&vueAvancer=abonnements_multi';
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {"authorization": "Bearer " + token!},
      );
      if (response.statusCode == 200) {
        iPrint(response.body);
        SpeceficAbonnement abonnement =
            SpeceficAbonnement.fromJson(jsonDecode(response.body));
        iPrint('Abonnement done');
        return Response({'abonnement': abonnement}, true);
      } else {
        iPrint('nop');
        return Response({}, false);
      }
    } catch (e) {
      iPrint('Abonnement Exception');
      return Response({}, false);
    }
  }
}
