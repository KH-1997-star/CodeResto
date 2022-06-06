import 'dart:async';
import 'dart:math';

import 'package:code_resto/models/box_shadow.dart';
import 'package:code_resto/models/panier.dart';
import 'package:code_resto/models/response.dart';
import 'package:code_resto/services/panier_repo.dart';
import 'package:code_resto/services/paiement_commande_repo.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/fonts.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/widgets/full_screen_widget.dart';
import 'package:code_resto/widgets/my_title_button_widget.dart';
import 'package:code_resto/widgets/my_title_widget_button.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'menu_panier_widget.dart';

class RecapScreen extends StatefulWidget {
  final String typeLivr,
      emplacemant,
      numTel,
      idCommande,
      idCustomer,
      emailClient;
  final String prix;

  const RecapScreen(
      {Key? key,
      required this.typeLivr,
      required this.prix,
      this.emplacemant = '',
      required this.idCommande,
      required this.idCustomer,
      required this.emailClient,
      this.numTel = ''})
      : super(key: key);

  @override
  State<RecapScreen> createState() => _RecapScreenState();
}

class _RecapScreenState extends State<RecapScreen> {
  final PanierRepo _panierRepo = PanierRepo();

  final PaiementCommandeRepo _paiementCommandeRepo = PaiementCommandeRepo();
  Map<String, dynamic>? paymentIntentData;

  bool isCelebrate = false;
  final _confettiController = ConfettiController();
  @override
  void initState() {
    super.initState();
    _confettiController.addListener(() {
      setState(() {
        isCelebrate =
            _confettiController.state == ConfettiControllerState.playing;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _confettiController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTitleWidgetButton(
              borderRadius: 10,
              onTap: () => Navigator.pop(context),
              title: const Icon(
                Icons.arrow_back_ios_new,
                size: 15,
              ),
              color: Theme.of(context).primaryColor,
              boxShadow: MyBoxShadow(),
            ),
          ),
          title: Text(
            'Récapitulatif',
            style: TextStyle(
              fontSize: 20.sp,
            ),
          )),
      body: SizedBox(
        height: getHeight(context),
        width: getWidth(context),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            const FullScreenWidget(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 150.h, horizontal: 10.w),
              child: Column(
                children: [
                  Text(
                    'Votre commande a été confirmé avec succés. Avant de précéder au paiement, voici un petit récapitulatif:   ',
                    style: TextStyle(
                      fontSize: 18.sp,
                      height: 2,
                      fontWeight: mediumFont,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    width: getWidth(context),
                    decoration: BoxDecoration(
                      color: myBlue,
                      border: Border.all(width: 2.0),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Prix totale : ${widget.prix}€',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: semiBoldFont,
                            ),
                          ),
                          Text('Type de livraison : ${widget.typeLivr}',
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: semiBoldFont)),
                          widget.emplacemant != ''
                              ? Text('à ${widget.emplacemant}',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: semiBoldFont,
                                  ))
                              : const SizedBox(),
                          widget.numTel != ''
                              ? Text('votre numéro ${widget.numTel}',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: semiBoldFont,
                                  ))
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ConfettiWidget(
                numberOfParticles: 20,
                emissionFrequency: 0.05,
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                blastDirection: -pi / 2,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: MyTitleButton(
                    /*  onTap: () async {
                      var response = await futureMethod(
                          _panierRepo.clearPanier(), context);
                      if (response.result) {
                        _confettiController.play();
                        showToast('bon appétit 😃​');

                        Timer(
                          const Duration(seconds: 2),
                          () {
                            Navigator.pushNamed(context, '/home_screen');
                          },
                        );
                      } else {
                        showToast(response.message);
                      }
                    }*/
                    onTap: () async {
                      Response response1 = await futureMethod(
                          _paiementCommandeRepo.makePayment(
                              widget.prix,
                              paymentIntentData,
                              widget.idCommande,
                              widget.idCustomer,
                              widget.emailClient),
                          context);

                      print(response1);
                      if (response1.result) {
                        _confettiController.play();
                        showToast('bon appétit 😃​');

                        Timer(
                          const Duration(seconds: 2),
                          () {
                            Navigator.pushNamed(context, '/home_screen');
                          },
                        );
                      } else {
                        showToast("il semble qu'il y ait eu un problème!");
                      }
                    },
                    boxShadow: MyBoxShadow(),
                    title: 'Commander',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
