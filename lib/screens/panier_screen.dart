import 'package:code_resto/models/panier.dart';
import 'package:code_resto/models/response.dart';
import 'package:code_resto/screens/detail_menu_screen.dart';
import 'package:code_resto/screens/type_commande_screen.dart';
import 'package:code_resto/services/panier_repo.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/fonts.dart';
import 'package:code_resto/models/box_shadow.dart';
import 'package:code_resto/screens/menu_panier_widget.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/widgets/detail_payment_widget.dart';
import 'package:code_resto/widgets/full_screen_widget.dart';
import 'package:code_resto/widgets/my_title_button_widget.dart';
import 'package:code_resto/widgets/my_title_widget_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PanierScreen extends StatefulWidget {
  const PanierScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PanierScreen> createState() => _PanierScreenState();
}

class _PanierScreenState extends State<PanierScreen> {
  List<String> idTailleList = [],
      idSauceList = [],
      idViandeList = [],
      idGarnitureList = [],
      idBoissonList = [],
      idAutreList = [];
  bool onDisMissing = false;
  int x = 0, count = 0;
  Panier panier = Panier();
  bool done = false;
  dynamic prix;

  PanierRepo panierRepo = PanierRepo();
  getMonPanier() async {
    Response response = await panierRepo.getMonPanier();
    if (response.result) {
      panier = response.data['panier'];
      prix = panier.prixTtc;
      iPrint('Length ${panier.listeMenus?.length}');
    } else {
      showToast(response.message);
      Navigator.pop(context);
    }
    setState(() {
      done = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getMonPanier();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/home_screen');
        return false;
      },
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        backgroundColor: mygreyBg,
        appBar: AppBar(
          backgroundColor: mygreyBg,
          elevation: 0,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTitleWidgetButton(
              color: Theme.of(context).primaryColor,
              borderRadius: 10,
              onTap: () => Navigator.pushNamed(context, '/home_screen'),
              title: const Icon(
                Icons.arrow_back_ios_new,
                size: 15,
              ),
              boxShadow: MyBoxShadow(),
            ),
          ),
          title: Text(
            'Panier',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: mediumFont,
              color: myBlack,
            ),
          ),
        ),
        body: !done
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  const FullScreenWidget(),
                  SizedBox(
                    height: 400.h,
                    width: getWidth(context),
                    child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 50.h),
                        itemCount: panier.listeMenus?.length,
                        itemBuilder: (context, index) {
                          iPrint('HELLO');
                          iPrint(panier.listeMenus?[index].prixTtc);
                          return Slidable(
                            key:
                                ValueKey(panier.listeMenus?[index].identifiant),
                            endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (_) {
                                      iPrint(onDisMissing);

                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          content: const Text(
                                              "Etes-vous sûr de vouloir supprimer ce menu?"),
                                          actions: [
                                            MyTitleButton(
                                              width: 60.w,
                                              onTap: () async {
                                                Response response = await futureMethod(
                                                    panierRepo
                                                        .supprimerMenuFromPanier(
                                                            panier
                                                                .listeMenus?[
                                                                    index]
                                                                .identifiant),
                                                    context);
                                                if (response.result) {
                                                  Navigator.pushNamed(context,
                                                      '/panier_screen');
                                                } else {
                                                  showToast(response.message,
                                                      color: Colors.red);
                                                }
                                              },
                                              boxShadow: MyBoxShadow(),
                                              title: 'OUI',
                                              color: Colors.green,
                                            ),
                                            MyTitleButton(
                                              width: 60.w,
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              boxShadow: MyBoxShadow(),
                                              title: 'NON',
                                              color: Colors.red,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    // label: 'Delete',
                                  ),
                                ]),
                            child: PanierMenuWidget(
                              index: index,
                              onTap: () {
                                for (int i = 0;
                                    i <
                                        panier
                                            .listeMenus![index].tailles!.length;
                                    i += 1) {
                                  idTailleList.add(
                                      panier.listeMenus![index].tailles?[i].id);
                                }
                                for (int i = 0;
                                    i <
                                        panier
                                            .listeMenus![index].sauces!.length;
                                    i += 1) {
                                  idSauceList.add(
                                      panier.listeMenus![index].sauces?[i].id);
                                }
                                for (int i = 0;
                                    i <
                                        panier
                                            .listeMenus![index].viandes!.length;
                                    i += 1) {
                                  idViandeList.add(
                                      panier.listeMenus![index].viandes?[i].id);
                                }
                                for (int i = 0;
                                    i <
                                        panier
                                            .listeMenus![index].boisons!.length;
                                    i += 1) {
                                  idBoissonList.add(
                                      panier.listeMenus![index].boisons?[i].id);
                                }
                                for (int i = 0;
                                    i <
                                        panier.listeMenus![index].garnitures!
                                            .length;
                                    i += 1) {
                                  idGarnitureList.add(panier
                                      .listeMenus![index].garnitures?[i].id);
                                }
                                for (int i = 0;
                                    i <
                                        panier
                                            .listeMenus![index].autres!.length;
                                    i += 1) {
                                  idAutreList.add(
                                      panier.listeMenus![index].autres?[i].id);
                                }
                                iPrint(idTailleList);
                                iPrint(idSauceList);
                                iPrint(idViandeList);
                                iPrint('Biossoooonnnn');
                                iPrint(idBoissonList);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailMenuScreen(
                                      index: index,
                                      imagePath: panier.listeMenus?[index]
                                          .linkedMenu?[0].image,
                                      id: panier.listeMenus?[index]
                                          .linkedMenu?[0].identifiant,
                                      idTailleList: idTailleList,
                                      idSauceList: idSauceList,
                                      idViandeList: idViandeList,
                                      idBoissonList: idBoissonList,
                                      idAutreList: idAutreList,
                                      idGarnitureList: idGarnitureList,
                                      fromPanier: true,
                                      counter:
                                          panier.listeMenus?[index].quantite ??
                                              0,
                                      idPanier:
                                          panier.listeMenus?[index].identifiant,
                                          prixFromPanier :  prix,
                                    ),
                                  ),
                                ).then((value) {
                                  idTailleList.clear();
                                  idSauceList.clear();
                                  idViandeList.clear();
                                  idBoissonList.clear();
                                  idGarnitureList.clear();
                                  idAutreList.clear();
                                });
                              },

                              inDissmissing:
                                  false, //x == index ? onDisMissing : false,
                              title: panier.listeMenus?[index].linkedMenu?[0]
                                      .titre ??
                                  '',
                              imagePath: panier.listeMenus?[index]
                                              .linkedMenu?[0].image ==
                                          null ||
                                      panier.listeMenus![index].linkedMenu![0]
                                              .image ==
                                          ''
                                  ? const AssetImage('images/plateau-repas.png')
                                  : NetworkImage(
                                      panier.listeMenus![index].linkedMenu![0]
                                              .image ??
                                          '',
                                    ),
                              price: panier.listeMenus![index].prixTtc! /
                                  panier.listeMenus![index].quantite!,
                              counter: panier.listeMenus?[index].quantite ?? 0,
                              description:
                                  panier.listeMenus?[index].description ?? '',
                              onCount: (p0) async {
                                Response response = await futureMethod(
                                    panierRepo.updatePanier(
                                      panier.listeMenus?[index].sauces ?? [],
                                      panier.listeMenus?[index].tailles ?? [],
                                      panier.listeMenus?[index].viandes ?? [],
                                      panier.listeMenus?[index].boisons ?? [],
                                      panier.listeMenus?[index].garnitures ??
                                          [],
                                      panier.listeMenus?[index].autres ?? [],
                                      p0,
                                      panier.listeMenus?[index].identifiant,
                                    ),
                                    context);
                                if (!response.result) {
                                  setState(() {
                                    showToast(response.message);
                                  });
                                } else {
                                  Navigator.pushNamed(
                                      context, '/panier_screen');
                                }
                              },
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 29.h),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          /*    CodePromoWidget(
                            onCodeConfirm: (code) {},
                          ), */
                          SizedBox(
                            height: 17.h,
                          ),
                          DetailPaymentWidget(
                            somme: '$prix',
                            livraison: '0',
                            total: '$prix',
                          ),
                          SizedBox(
                            height: 28.h,
                          ),
                          panier.listeMenus!.isEmpty
                              ? const SizedBox()
                              : MyTitleButton(
                                  color: Theme.of(context).primaryColor,
                                  boxShadow: MyBoxShadow(),
                                  borderRadius: 15,
                                  title: 'Valider',
                                  onTap: () async {
                                    var response = await futureMethod(
                                        panierRepo.passerCommande(), context);
                                    /* if (response.result) {
                                response = await futureMethod(
                                    panierRepo.clearPanier(), context);
                              } */
                                    if (response.result) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  TypeCommandeScreen(
                                                    prix: prix,
                                                  )));
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text('Désoler'),
                                          content: Text(response.message),
                                        ),
                                      );
                                    }
                                  },
                                ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
