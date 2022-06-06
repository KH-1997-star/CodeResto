import 'dart:convert';

import 'package:code_resto/models/panier.dart';
import 'package:code_resto/models/response.dart';
import 'package:code_resto/utils/consts.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/utils/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PanierRepo extends ChangeNotifier {
  getMonPanier() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = await getCurrentId();
    iPrint('id :: $id');
    Map body = {
      "extraPayload": {"linkedCompte": id} //"6246f94ea5ac44764e6fc50a"}
    };
    try {
      iPrint('url get mon panier' + urlGetMonPanier);
      var response = await http.post(
        Uri.parse(urlGetMonPanier),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        iPrint(response.body);

        Panier panier = Panier.fromJson(jsonDecode(response.body)[0]);
        iPrint(panier);
        prefs.setString(
          idPanier,
          panier.identifiant ?? '',
        );
        iPrint('PANIERRR IDDD ISSSS');
        String? idmYPanier = await getCurrentPanierId();
        iPrint(idmYPanier);
        return Response({'panier': panier}, true);
      } else {
        iPrint(
            'panier_repo/getMonPanier\n ${response.statusCode}\n${response.body} ');
        return Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      iPrint('panier_repo/getMonPanier\n Exception $e');
      return Response({}, false, message: erreurCnx);
    }
  }

  Future<Response> ajoutPanier(
    List sauceList,
    List tailleList,
    List viandeList,
    List boissonList,
    List garnitureList,
    List autreList,
    int qt,
    String? idMenu,
  ) async {
    String? idPanier = await getCurrentPanierId();
    Map data = {
      'extraPayload': {
        'linkedPanier': idPanier,
        'linkedMenu': idMenu,
        'tailles': tailleList,
        'sauces': sauceList,
        'viandes': viandeList,
        'garnitures': garnitureList,
        'boisons': boissonList,
        'autres': autreList,
        'quantite': qt
      }
    };
    try {
      var response = await http.post(
        Uri.parse(urlAjoutPanier),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          data,
        ),
      );
      if (response.statusCode == 200) {
        iPrint('  YAAAAH');
        iPrint(response.body);
        return Response({}, true,
            message: 'votre commande a été passée avec succès');
      } else {
        iPrint('  NOOOOOO');
        return Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      return Response({}, false, message: erreurCnx);
    }
  }

  Future<Response> updatePanier(
    List sauceList,
    List tailleList,
    List viandeList,
    List boissonList,
    List garnitureList,
    List autreList,
    int qt,
    String? idMenu,
  ) async {
    Map data = {
      'extraPayload': {
        //'linkedPanier': idPanier,

        'linkedMenuPanier': idMenu,
        'tailles': tailleList,
        'sauces': sauceList,
        'viandes': viandeList,
        'garnitures': garnitureList,
        'boisons': boissonList,
        'autres': autreList,
        'quantite': qt
      }
    };
    try {
      var response = await http.post(
        Uri.parse(urlUpdatePanier),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          data,
        ),
      );
      if (response.statusCode == 200) {
        iPrint('  YAAAAH');
        iPrint(response.body);
        return Response({}, true,
            message: 'votre commande a été passée avec succès');
      } else {
        iPrint('  NOOOOOO');
        iPrint(response.statusCode);
        iPrint(response.body);
        return Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      iPrint(e);
      iPrint('Exception');
      return Response({}, false, message: erreurCnx);
    }
  }

  Future<Response> passerCommande() async {
    String? idClient = await getCurrentId(),
        idPanier = await getCurrentPanierId(),
        token = await getCurrentToken();
    Map data = {
      "extraPayload": {
        "client": idClient,
        "panier": idPanier,
      }
    };
    try {
      var response = await http.post(Uri.parse(urlCreateCommand),
          headers: {
            'Content-Type': 'application/json',
            "authorization": "Bearer " + token!,
          },
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        iPrint('Succeed');
        iPrint(response.body);
        var body = jsonDecode(response.body);
        setCurrentCommandeId(body['idCommande']);
        return Response({}, true);
      } else {
        iPrint(
            'panier_repo/passerCommande\n ${response.statusCode}\n${response.body} ');
        return Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      iPrint('panier_repo/passerCommande\n Exception $e');
      return Response({}, false, message: erreurCnx);
    }
  }

  Future<Response> clearPanier() async {
    String url = '${hostDynamique}clearPanier';
    String? idPanier = await getCurrentPanierId();

    Map body = {
      "extraPayload": {"linkedPanier": idPanier}
    };
    try {
      var response =
          await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        return Response({}, true);
      } else {
        return Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      return Response({}, false, message: erreurCnx);
    }
  }

  supprimerMenuFromPanier(String? idMenu) async {
    String? idPanier = await getCurrentPanierId();
    try {
      var response = await http.post(
        Uri.parse(urlSuppMenu),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'extraPayload': {
              'linkedPanier': idPanier,
              'linkedMenuPanier': idMenu,
            }
          },
        ),
      );

      if (response.statusCode == 200) {
        //var body = jsonDecode(response.body);
        return Response({}, true);
      } else {
        return Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      return Response({}, false, message: erreurCnx);
    }
    // return false;
  }

  Future<Response> modeLivraison(
      String phone, ville, codePostal, rue, modeLiv) async {
    String? idCommande = await getCurrentCommandeId();
    String? token = await getCurrentToken();
    print(idCommande);
    print(phone);
    print(ville);
    var data = {
      "extraPayload": {
        'phoneClient': phone,
        'villeClient': ville,
        'codePostalClient': codePostal,
        'rueClient': rue,
        'modeLivraison': modeLiv,
        'idCommande': idCommande
      }
    };
    print(data);
    try {
      var response = await http.post(Uri.parse(urlModeLiv),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(data));
      //  print(response.body);

      var body = jsonDecode(response.body);
      print(body);
      String idCommande = body['idCommande'];
      String customerId = body['idCustomer'].toString();
      String email = body['email'].toString();
      if (response.statusCode == 200) {
        return Response({
          "idCommande": idCommande,
          "customerId": customerId,
          "email": email
        }, true);
      } else {
        return Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      return Response({}, false, message: erreurCnx);
    }
  }
}
