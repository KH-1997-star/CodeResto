import 'dart:convert';

import 'package:code_resto/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:code_resto/models/response.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PaiementCommandeRepo {
  Future<Response> makePayment(String prix, paymentIntentData,
      String idCommande, customerId, email) async {
    try {
      
      paymentIntentData = await createPaymentIntent(
      prix, 'EUR', customerId, email); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              applePay: true,
              googlePay: true,
              testEnv: true,
              style: ThemeMode.dark,
              merchantCountryCode: 'FRA',
              merchantDisplayName: 'CODERESTO PAIEMENT'));
     // print('etp1');

      ///now finally display payment sheeet

      bool response = await displayPaymentSheet(paymentIntentData, idCommande);
      if (response) {
     //   print('etp2 SUCESS');
        return Response({}, true);
      } else {
   //     print('etp2 failed');
        return Response({}, false);
      }
      // print("status paiement");
      //print(response.data['status']);
      //return Response({"status": response.data['status']}, true);
    } catch (e, s) {
      //print('exception:$e$s');
      return Response({}, false);
    }
  }

  Future<bool> displayPaymentSheet(
      paymentIntentData, String idAbonnement) async {
    bool result = false;
    try {
      print('1');
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) async {
        //    print('payment intent' + paymentIntentData!['id'].toString());
        //  print(
        //         'payment intent' + paymentIntentData!['client_secret'].toString());
        //  print('payment intent' + paymentIntentData!['status'].toString());
        //    print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
     //   print('2');
        var statutPaiement =
            await getStatutPaiement(paymentIntentData!['id'].toString());
        final status = stripePaymentCommande(
            paymentIntentData!['id'].toString(),
            statutPaiement.toString(),
            idAbonnement);
       // print('3');
        //  Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => QrCodeScreen()));

        // Navigator.pushNamed(context, '/home_screen');
        paymentIntentData = null;

    //    print('i m here');
      //  print(statutPaiement);
        if (statutPaiement == "payed") {
          result = true;
          return result;
        } else {
          result = false;
          return result;
        }

        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text("pay?? avec succ??s")));
      }).onError((error, stackTrace) {
      //  print(error);
        result = false;
        return result;
        //     print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      //print('stripeexception');
     // print(e.error);
      result = false;
      return result;
      //    print('Exception/DISPLAYPAYMENTSHEET==> $e');
      /*  showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Annul??"),
              ));*/
    } catch (e) {
     // print('e$e');
      result = false;
      return result;
    }
   // print('end point');
    return result;
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(
      String amount, String currency, String customerId, String email) async {
    try {
      //    print('first prix');
      //print(widget.prix.toString());
      //    print(currency);

      //1   print('yoooooo');

      ///comptesIdComptebancaire
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
        'customer': customerId,
        'receipt_email': email
      };
      print('yoooooo');
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51KyGBWGPdMzPfqhtjWwaWDoQJzjnq9Hph3uJ5UQaMNN5wFj8tBNP5iBrWCfyt0FxMngjfjxTRcMizB0QfELye3x100vk0zJnUr',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      //  print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      return Response({}, false);
//      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    print('cal');
    print(amount);
    double a = (double.parse(amount)) * 100;
    int price = a.toInt();
    return price.toString();
  }

  Future<bool> stripePaymentCommande(
      String idPaiement, String statutPaiement, idCommande) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(tokenconst);

    String urlstripePaymentCommande =
        hostDynamique + "api/client/stripePaymentCommande";
    var data = {
      "id_commande": idCommande,
      "id_payment": idPaiement,
      "statut_pay": statutPaiement,
      "mode_paiement": "card"
    };
    final response = await http.post(Uri.parse(urlstripePaymentCommande),
        headers: {'Authorization': 'Bearer $token'}, body: data);

    var body = jsonDecode(response.body);
    //  print(response.body);

    return true;
  }

  Future<String> getStatutPaiement(String idPaiement) async {
    String statutPaiement = "";

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString(tokenconst);
    String? urlstripePaymentCommande = hostDynamique +
        "api/client/get_statut_payment?id_payment=" +
        idPaiement;
    final response = await http.get(
      Uri.parse(urlstripePaymentCommande),
      headers: <String, String>{'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      //  print('statut paiement=====');
      var body = jsonDecode(response.body);
      //    print(body);
      statutPaiement = body['statut'];
      if (body['statut'] == "succeeded") {
        statutPaiement = "payed";
      } else {
        statutPaiement = "failure";
      }
      return statutPaiement;
    } else {
      statutPaiement = "failure";
      return statutPaiement;
    }
  }
}
