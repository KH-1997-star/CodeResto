import 'package:code_resto/models/detail_menu.dart';
import 'package:code_resto/models/panier.dart';
import 'package:code_resto/models/response.dart';
import 'package:code_resto/services/favoris_repo.dart';
import 'package:code_resto/services/panier_repo.dart';
import 'package:code_resto/services/plat_repo.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/fonts.dart';
import 'package:code_resto/models/box_shadow.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/widgets/circle_container_widget.dart';
import 'package:code_resto/widgets/detail_menu_widget.dart';
import 'package:code_resto/widgets/full_screen_widget.dart';
import 'package:code_resto/widgets/heartAnimationWidget.dart';
import 'package:code_resto/widgets/my_button_widget.dart';
import 'package:code_resto/widgets/my_title_button_widget.dart';
import 'package:code_resto/widgets/top_detail_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailMenuScreen extends StatefulWidget {
  final int index;
  final String imagePath, id;
  final bool fromPanier;
  final int? counter;
  final String? idPanier;
  final List<String>? idTailleList,
      idSauceList,
      idViandeList,
      idGarnitureList,
      idBoissonList,
      idAutreList;
  final dynamic prixFromPanier;
  const DetailMenuScreen({
    Key? key,
    required this.index,
    required this.imagePath,
    required this.id,
    this.idTailleList,
    this.idSauceList,
    this.idViandeList,
    this.idGarnitureList,
    this.idBoissonList,
    this.idAutreList,
    this.fromPanier = false,
    this.counter,
    this.idPanier,
    this.prixFromPanier,
  }) : super(key: key);

  @override
  State<DetailMenuScreen> createState() => _DetailMenuScreenState();
}

class _DetailMenuScreenState extends State<DetailMenuScreen> {
  dynamic prixTotal = 0, prix, itemPrice = 0;
  final FavorisRepo _favorisRepo = FavorisRepo();

  int counter = 1;

  List<int> itemNumber = [5, 1, 2, 4, 2, 0];
  List<bool> hidenList = [false, false, false, false, false, false];
  List<String> keyList = [
    'tailles',
    'sauces',
    'viandes',
    'garnitures',
    'boisons',
    'autres'
  ];
  List<String> tailleList = [];
  List<String> sauceList = [];
  List<String> viandeList = [];
  List<String> garnitureList = [];
  List<String> boisonList = [];
  List<String> autreList = [];
  List taillePrix = [];
  List saucePrix = [];
  List viandePrix = [];
  List garniturePrix = [];
  List boisonPrix = [];
  List autrePrix = [];

  int qteMaxSauce = 0;
  int qteMaxViande = 0;
  int qteMaxGarniture = 0;
  int qteMaxBoison = 0;
  int qteMaxAutre = 0;
  List<Autre> sauceObjectList = [],
      viandeObjectList = [],
      garnitureObjectList = [],
      boisonObjectList = [],
      autreObjectList = [];
  List<MyTaille> tailleObjectList = [];

  List<bool> sauceBoolList = [],
      viandeBoolList = [],
      garnitureBoolList = [],
      boisonBoolList = [],
      autreBoolList = [],
      tailleBoolList = [];

  List<String> idTailleList = [],
      idSauceList = [],
      idViandeList = [],
      idGarnitureList = [],
      idBoissonList = [],
      idAutreList = [],
      otherTailleId = [],
      otherSauceId = [],
      otherViandeId = [],
      otherGarnitureId = [],
      otherBoissonId = [],
      otherAutreId = [],
      panierSauceList = [],
      panierViandeList = [],
      panierGarnitureList = [],
      panierBoissonList = [],
      panierAutreList = [];
  List qteTailleList = [],
      qteSauceList = [],
      qteViandeList = [],
      qteGarnitureList = [],
      qteBoissonList = [],
      qteAutreList = [];

  PlatRepo platRepo = PlatRepo();
  PanierRepo panierRepo = PanierRepo();
  DetailMenu detailMenu = DetailMenu();

  int maxChoice = 1;
  List<List<Boison>> myOtherDetailList = [];
  bool done = false, isLike = false, isChange = false;
  List<bool> boolList = [false, false, false];
  myGetDetailMenu() async {
    iPrint('RESULT');
    Response response = await platRepo.getDetailMenu(widget.id);

    iPrint(response.result);
    if (response.result) {
      detailMenu = response.data['detailMenu'];
      isLike = detailMenu.like ?? false;
      detailMenu.hasOffre!
          ? prixTotal = detailMenu.prixApplicable
          : prixTotal = detailMenu.prix;
      iPrint(detailMenu.titre);
      iPrint(detailMenu.prix);
      iPrint('ThePrice : $prixTotal');

      if (detailMenu.tailles!.isNotEmpty) {
        for (int i = 0; i < detailMenu.tailles!.length; i += 1) {
          if (!widget.fromPanier) {
            if (detailMenu.tailles?[i].prix == detailMenu.prix) {
              tailleBoolList.add(true);
              tailleObjectList.add(MyTaille(
                id: detailMenu.tailles?[i].id,
                prix: detailMenu.tailles?[i].prix,
              ));
            } else {
              tailleBoolList.add(false);
            }
          } else {
            if (widget.idTailleList!.contains(detailMenu.tailles?[i].id)) {
              tailleBoolList.add(true);
              tailleObjectList.add(MyTaille(
                id: detailMenu.tailles?[i].id,
                prix: detailMenu.tailles?[i].prix,
              ));
            } else {
              tailleBoolList.add(false);
            }
          }
          tailleList.add(detailMenu.tailles?[i].name);
          //TODO CHANGE OF PRICE FROM BACKEND
          taillePrix.add(detailMenu.tailles?[i].prix);
          idTailleList.add(detailMenu.tailles?[i].id);
          otherTailleId.add(detailMenu.tailles?[i].id);
        }
        if (detailMenu.sauces!.isNotEmpty) {
          qteMaxSauce = detailMenu.sauces?[0].qteMax;
          for (int i = 0; i < detailMenu.sauces![0].produits!.length; i += 1) {
            sauceList.add(detailMenu.sauces?[0].produits?[i].name);
            if (widget.fromPanier) {
              if (widget.idSauceList!
                  .contains(detailMenu.sauces![0].produits?[i].id)) {
                panierSauceList.add(detailMenu.sauces?[0].produits?[i].name);
                sauceBoolList.add(true);
                itemPrice += detailMenu.sauces![0].produits?[i].prixFacculatitf;
                sauceObjectList.add(Autre(
                  id: detailMenu.sauces?[0].produits?[i].id,
                  prixFacculatitf:
                      detailMenu.sauces?[0].produits?[i].prixFacculatitf,
                  qte: 1,
                ));
              } else {
                sauceBoolList.add(false);
              }
            } else {
              sauceBoolList.add(false);
            }
            saucePrix.add(detailMenu.sauces?[0].produits?[i].prixFacculatitf);
            idSauceList.add(detailMenu.sauces?[0].produits?[i].id);
            otherSauceId.add(detailMenu.sauces?[0].produits?[i].id);
            qteSauceList.add(detailMenu.sauces?[0].qteMax);
          }
          iPrint(sauceList);
        }
        if (detailMenu.viandes!.isNotEmpty) {
          qteMaxViande = detailMenu.viandes?[0].qteMax;
          for (int i = 0; i < detailMenu.viandes![0].produits!.length; i += 1) {
            viandeList.add(detailMenu.viandes?[0].produits?[i].name);
            if (widget.fromPanier) {
              if (widget.idViandeList!
                  .contains(detailMenu.viandes![0].produits?[i].id)) {
                panierViandeList.add(detailMenu.viandes?[0].produits?[i].name);
                viandeBoolList.add(true);
                itemPrice +=
                    detailMenu.viandes![0].produits?[i].prixFacculatitf;
                viandeObjectList.add(Autre(
                  id: detailMenu.viandes?[0].produits?[i].id,
                  prixFacculatitf:
                      detailMenu.viandes?[0].produits?[i].prixFacculatitf,
                  qte: 1,
                ));
              } else {
                viandeBoolList.add(false);
              }
            } else {
              viandeBoolList.add(false);
            }
            viandePrix.add(detailMenu.viandes?[0].produits?[i].prixFacculatitf);
            idViandeList.add(detailMenu.viandes?[0].produits?[i].id);
            otherViandeId.add(detailMenu.viandes?[0].produits?[i].id);
            qteViandeList.add(detailMenu.viandes?[0].qteMax);
          }
          iPrint(viandeList);
        }
        if (detailMenu.garnitures!.isNotEmpty) {
          qteMaxGarniture = detailMenu.garnitures?[0].qteMax;
          for (int i = 0;
              i < detailMenu.garnitures![0].produits!.length;
              i += 1) {
            garnitureList.add(detailMenu.garnitures![0].produits?[i].name);
            if (widget.fromPanier) {
              if (widget.idGarnitureList!
                  .contains(detailMenu.garnitures![0].produits?[i].id)) {
                panierGarnitureList
                    .add(detailMenu.garnitures?[0].produits?[i].name);
                itemPrice +=
                    detailMenu.garnitures![0].produits?[i].prixFacculatitf;
                garnitureBoolList.add(true);
                garnitureObjectList.add(Autre(
                  id: detailMenu.garnitures?[0].produits?[i].id,
                  prixFacculatitf:
                      detailMenu.garnitures?[0].produits?[i].prixFacculatitf,
                  qte: 1,
                ));
              } else {
                garnitureBoolList.add(false);
              }
            } else {
              garnitureBoolList.add(false);
            }
            garniturePrix
                .add(detailMenu.garnitures?[0].produits?[i].prixFacculatitf);
            idGarnitureList.add(detailMenu.garnitures?[0].produits?[i].id);
            otherGarnitureId.add(detailMenu.garnitures?[0].produits?[i].id);
            qteGarnitureList.add(detailMenu.garnitures?[0].qteMax);
          }
          iPrint(garnitureList);
        }
        if (detailMenu.boisons!.isNotEmpty) {
          qteMaxBoison = detailMenu.boisons?[0].qteMax;
          for (int i = 0; i < detailMenu.boisons![0].produits!.length; i += 1) {
            if (widget.fromPanier) {
              if (widget.idBoissonList!
                  .contains(detailMenu.boisons![0].produits?[i].id)) {
                panierBoissonList.add(detailMenu.boisons?[0].produits?[i].name);
                itemPrice +=
                    detailMenu.boisons![0].produits?[i].prixFacculatitf;
                iPrint('Im heeere BOISON CONDITION');
                boisonBoolList.add(true);
                boisonObjectList.add(Autre(
                  id: detailMenu.boisons?[0].produits?[i].id,
                  prixFacculatitf:
                      detailMenu.boisons?[0].produits?[i].prixFacculatitf,
                  qte: 1,
                ));
              } else {
                boisonBoolList.add(false);
              }
            } else {
              boisonBoolList.add(false);
            }
            boisonList.add(detailMenu.boisons![0].produits?[i].name);
            boisonPrix.add(detailMenu.boisons?[0].produits?[i].prixFacculatitf);
            idBoissonList.add(detailMenu.boisons?[0].produits?[i].id);
            otherBoissonId.add(detailMenu.boisons?[0].produits?[i].id);
            qteBoissonList.add(detailMenu.boisons?[0].qteMax);
          }
          iPrint(boisonList);
        }
        if (detailMenu.autres!.isNotEmpty) {
          qteMaxAutre = detailMenu.autres?[0].qteMax;
          for (int i = 0; i < detailMenu.autres![0].produits!.length; i += 1) {
            autreList.add(detailMenu.autres![0].produits?[i].name);
            autrePrix.add(detailMenu.autres?[0].produits?[i].prixFacculatitf);
            idAutreList.add(detailMenu.autres?[0].produits?[i].id);
            qteAutreList.add(detailMenu.autres?[0].qte);
            if (widget.fromPanier) {
              if (widget.idAutreList!
                  .contains(detailMenu.autres![0].produits?[i].id)) {
                panierAutreList.add(detailMenu.sauces?[0].produits?[i].name);
                autreBoolList.add(true);
                itemPrice += detailMenu.autres![0].produits?[i].prixFacculatitf;
                autreObjectList.add(Autre(
                  id: detailMenu.autres?[0].produits?[i].id,
                  prixFacculatitf:
                      detailMenu.autres?[0].produits?[i].prixFacculatitf,
                  qte: 1,
                ));
              } else {
                autreBoolList.add(false);
              }
            } else {
              autreBoolList.add(false);
            }
          }
          iPrint(autreList);
        }
      }
    } else {
      showToast(response.message);
      Navigator.pop(context);
    }
    if (mounted) {
      setState(() {
        done = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.fromPanier) {
      idTailleList = widget.idTailleList!;
      idSauceList = widget.idSauceList!;
      idViandeList = widget.idViandeList!;
      idBoissonList = widget.idBoissonList!;
      idGarnitureList = widget.idGarnitureList!;
      idAutreList = widget.idAutreList!;
      counter = widget.counter!;
      print('detail Id taille : $idTailleList');
    }
    myGetDetailMenu();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        isChange
            ? Navigator.pushNamed(context, '/home_screen')
            : Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70.h,
          backgroundColor: myWhite,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularContainerWidget(
              height: 37.h,
              width: 37.h,
              color: myWhite,
              boxShadow: MyBoxShadow(
                x: -2,
                y: 1,
                blurRadius: 7,
                color: const Color(0xff000000),
                opacity: 0.16,
              ),
              myWidget: SvgPicture.asset(
                'icons/arrow_back_icon.svg',
                fit: BoxFit.scaleDown,
              ),
              onTap: () => isChange
                  ? Navigator.pushNamed(context, '/home_screen')
                  : Navigator.pop(context),
              isShadow: true,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: HeartAnimationWidget(
                alwaysAnimate: true,
                isAnimating: isLike,
                child: CircularContainerWidget(
                  height: 40.h,
                  width: 40.h,
                  color: myWhite,
                  boxShadow: MyBoxShadow(
                    x: -2,
                    y: 1,
                    blurRadius: 7,
                    color: const Color(0xff000000),
                    opacity: 0.16,
                  ),
                  onTap: () async {
                    isChange = true;
                    setState(() {
                      isLike = !isLike;
                    });
                    await _favorisRepo.likeMenu(detailMenu.identifiant);
                  },
                  myWidget: !done
                      ? const Icon(
                          Icons.favorite_border_rounded,
                          color: myBlack,
                        )
                      : isLike
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border_rounded,
                              color: myBlack,
                            ),
                  isShadow: true,
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            const FullScreenWidget(),
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TopDetailMenuWidget(
                      titreOffre: detailMenu.titreOffre ?? '',
                      offre: detailMenu.offre,
                      offrePrice: detailMenu.prixApplicable ?? 0,
                      hasOffre: detailMenu.hasOffre,
                      imapgePath: widget.imagePath,
                      description: detailMenu.description ?? '',
                      title: detailMenu.titre ?? '',
                      price: detailMenu.prix ?? 0,
                      index: widget.index,
                    ),
                    !done
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(
                            height: 300,
                            child: ListView(
                              padding: EdgeInsets.only(bottom: 200.h),
                              shrinkWrap: true,
                              children: [
                                tailleBoolList.isNotEmpty
                                    ? DetailMenuWidget(
                                        onTailleChoice:
                                            (list, taille, prix, id, index) {
                                          if (!widget.fromPanier) {
                                            tailleObjectList = [
                                              MyTaille(
                                                id: id,
                                                prix: prix,
                                              )
                                            ];
                                            print(
                                                'this is it' + idTailleList[0]);
                                            iPrint(tailleObjectList.toList());
                                            iPrint('ID: $id');
                                            iPrint(list);
                                            iPrint('Itemmmm:' + taille);
                                            setState(() {
                                              tailleBoolList = list;
                                              prixTotal = prix;
                                            });
                                          } else {
                                            print(idTailleList);
                                            print(index);
                                            tailleObjectList = [
                                              MyTaille(
                                                id: otherTailleId[index],
                                                prix: prix,
                                              )
                                            ];

                                            iPrint(tailleObjectList.toList());
                                            iPrint('ID: $id');
                                            iPrint(list);
                                            iPrint('Itemmmm:' + taille);
                                            setState(() {
                                              tailleBoolList = list;
                                              prixTotal = prix;
                                            });
                                          }
                                        },
                                        isOblig: true,
                                        onChoice: (l, itemlist, prix, id, qte,
                                            add, item) {
                                          /*    iPrint('PRIXXX: $prix');
                    
                                          setState(() {
                                            tailleBoolList = l;
                                            itemlist.isEmpty
                                                ? prixTotal = 0
                                                : prixTotal = prix;
                                          });
                                          iPrint(itemlist); */
                                        },
                                        boolList: tailleBoolList,
                                        qteMax: 1,
                                        itemName: tailleList,
                                        titre: 'Tailles',
                                        numItem:
                                            detailMenu.tailles?.length ?? 0,
                                        prix: taillePrix,
                                        itemId: idTailleList,
                                      )
                                    : const SizedBox(),
                                sauceBoolList.isNotEmpty
                                    ? DetailMenuWidget(
                                        fromPanier: widget.fromPanier,
                                        fromPanierNameList: panierSauceList,
                                        qte: qteSauceList,
                                        boolList: sauceBoolList,
                                        qteMax: qteMaxSauce,
                                        itemName: sauceList,
                                        titre: detailMenu.sauces?[0].titre,
                                        numItem: sauceList.length,
                                        onChoice: (List<bool> list, itemlist,
                                            prix, id, qte, add, item) {
                                          iPrint('PRIXXX: $prix');
                                          if (add) {
                                            sauceObjectList.add(Autre(
                                              id: id,
                                              prixFacculatitf: prix,
                                              qte: 1,
                                            ));
                                            setState(() {
                                              panierSauceList.add(item);
                                            });
                                          } else {
                                            sauceObjectList.removeWhere(
                                                (element) => element.id == id);
                                          }

                                          setState(() {
                                            panierSauceList.remove(item);
                                            sauceBoolList = list;
                                            itemPrice += prix;
                                          });
                                        },
                                        prix: saucePrix,
                                        itemId: otherSauceId,
                                      )
                                    : const SizedBox(),
                                viandeBoolList.isNotEmpty
                                    ? DetailMenuWidget(
                                        fromPanier: widget.fromPanier,
                                        fromPanierNameList: panierViandeList,
                                        qte: qteViandeList,
                                        boolList: viandeBoolList,
                                        qteMax: qteMaxViande,
                                        itemName: viandeList,
                                        titre: detailMenu.viandes?[0].titre,
                                        numItem: viandeList.length,
                                        onChoice: (List<bool> list, itemlist,
                                            prix, id, qte, add, item) {
                                          iPrint('if $add and $item');
                                          if (add) {
                                            viandeObjectList.add(Autre(
                                              id: id,
                                              prixFacculatitf: prix,
                                              qte: 1,
                                            ));
                                            setState(() {
                                              panierViandeList.add(item);
                                            });
                                            iPrint('DTE :: $qte');
                                          } else {
                                            viandeObjectList.removeWhere(
                                                (element) => element.id == id);
                                            setState(() {
                                              panierViandeList.remove(item);
                                            });
                                          }
                                          iPrint('PRIXXX: $prix');
                                          setState(() {
                                            viandeBoolList = list;
                                            itemPrice += prix;
                                          });
                                        },
                                        prix: viandePrix,
                                        itemId: otherViandeId,
                                      )
                                    : const SizedBox(),
                                garnitureBoolList.isNotEmpty
                                    ? DetailMenuWidget(
                                        fromPanier: widget.fromPanier,
                                        fromPanierNameList: panierGarnitureList,
                                        qte: qteGarnitureList,
                                        prix: garniturePrix,
                                        boolList: garnitureBoolList,
                                        qteMax: qteMaxGarniture,
                                        itemName: garnitureList,
                                        titre: detailMenu.garnitures?[0].titre,
                                        numItem: garnitureList.length,
                                        onChoice: (List<bool> list, itemlist,
                                            prix, id, qte, add, item) {
                                          if (add) {
                                            garnitureObjectList.add(Autre(
                                              id: id,
                                              prixFacculatitf: prix,
                                              qte: 1,
                                            ));
                                            setState(() {
                                              panierGarnitureList.add(item);
                                            });
                                          } else {
                                            garnitureObjectList.removeWhere(
                                                (element) => element.id == id);
                                          }
                                          iPrint('PRIXXX: $prix');
                                          setState(() {
                                            panierGarnitureList.remove(item);
                                            garnitureBoolList = list;
                                            itemPrice += prix;
                                          });
                                        },
                                        itemId: otherGarnitureId,
                                      )
                                    : const SizedBox(),
                                boisonBoolList.isNotEmpty
                                    ? DetailMenuWidget(
                                        fromPanier: widget.fromPanier,
                                        fromPanierNameList: panierBoissonList,
                                        qte: qteBoissonList,
                                        boolList: boisonBoolList,
                                        qteMax: qteMaxBoison,
                                        itemName: boisonList,
                                        titre: detailMenu.boisons?[0].titre,
                                        numItem: boisonList.length,
                                        onChoice: (List<bool> list, itemlist,
                                            prix, id, qte, add, item) {
                                          if (add) {
                                            boisonObjectList.add(Autre(
                                              id: id,
                                              prixFacculatitf: prix,
                                              qte: 1,
                                            ));
                                            setState(() {
                                              panierBoissonList.add(item);
                                            });
                                          } else {
                                            boisonObjectList.removeWhere(
                                                (element) => element.id == id);
                                          }
                                          iPrint('PRIXXX: $prix');
                                          setState(() {
                                            panierBoissonList.remove(item);
                                            boisonBoolList = list;
                                            itemPrice += prix;
                                          });
                                        },
                                        prix: boisonPrix,
                                        itemId: otherBoissonId,
                                      )
                                    : const SizedBox(),
                                autreBoolList.isNotEmpty
                                    ? DetailMenuWidget(
                                        fromPanier: widget.fromPanier,
                                        fromPanierNameList: panierAutreList,
                                        qte: qteAutreList,
                                        qteMax: qteMaxAutre,
                                        itemName: autreList,
                                        titre: detailMenu.autres?[0].titre,
                                        numItem: autreList.length,
                                        boolList: autreBoolList,
                                        onChoice: (List<bool> list, itemList,
                                            prix, id, qte, add, item) {
                                          if (add) {
                                            autreObjectList.add(Autre(
                                              id: id,
                                              prixFacculatitf: prix,
                                              qte: 1,
                                            ));
                                            setState(() {
                                              panierAutreList.add(item);
                                            });
                                          } else {
                                            autreObjectList.removeWhere(
                                                (element) => element.id == id);
                                          }
                                          iPrint('PRIXXX: $prix');
                                          setState(() {
                                            panierAutreList.remove(item);
                                            autreBoolList = list;
                                            itemPrice += prix;
                                          });
                                        },
                                        prix: autrePrix,
                                        itemId: idAutreList,
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120.h,
                color: myWhite,
                child: Padding(
                  padding: EdgeInsets.only(left: 44.w, bottom: 45.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 28.h,
                            width: 100.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MyWidgetButton(
                                  borderWidth: 1.5,
                                  boxShadow: MyBoxShadow(),
                                  height: 28.w,
                                  width: 28.w,
                                  radius: 8,
                                  isBordred: true,
                                  color: myWhite,
                                  borderColor: myBlack,
                                  widget: const Center(
                                    child: Icon(
                                      Icons.remove,
                                      size: 20,
                                    ),
                                  ),
                                  onTap: () {
                                    if (counter > 1) {
                                      setState(() {
                                        counter -= 1;
                                      });
                                    }
                                  },
                                ),
                                Text(
                                  '$counter',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: mediumFont,
                                  ),
                                ),
                                MyWidgetButton(
                                  borderWidth: 1.5,
                                  boxShadow: MyBoxShadow(),
                                  height: 28.w,
                                  width: 28.w,
                                  radius: 8,
                                  isBordred: true,
                                  color: myWhite,
                                  borderColor: myBlack,
                                  widget: const Center(
                                    child: Icon(
                                      Icons.add,
                                      size: 20,
                                    ),
                                  ),
                                  onTap: () {
                                    iPrint(prix);
                                    setState(() {
                                      counter += 1;
                                      // prixTotal = prix * counter;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            alignment: Alignment.center,
                            width: 110.w,
                            child: Text(
                              ((prixTotal + itemPrice) * counter).toString() +
                                  '€',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: semiBoldFont,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 33.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: !done
                            ? const Center(child: CircularProgressIndicator())
                            : MyTitleButton(
                                color: Theme.of(context).primaryColor,
                                onTap: () async {
                                  iPrint(widget.idPanier);
                                  Response response;
                                  !widget.fromPanier
                                      ? response = await futureMethod(
                                          panierRepo.ajoutPanier(
                                              sauceObjectList.toList(),
                                              tailleObjectList.toList(),
                                              viandeObjectList.toList(),
                                              boisonObjectList.toList(),
                                              garnitureObjectList.toList(),
                                              autreObjectList.toList(),
                                              counter,
                                              widget.id),
                                          context)
                                      : response = await futureMethod(
                                          panierRepo.updatePanier(
                                              sauceObjectList.toList(),
                                              tailleObjectList.toList(),
                                              viandeObjectList.toList(),
                                              boisonObjectList.toList(),
                                              garnitureObjectList.toList(),
                                              autreObjectList.toList(),
                                              counter,
                                              widget.idPanier),
                                          context);
                                  response.result
                                      ? Navigator.pushNamed(
                                          context, '/panier_screen')
                                      : showToast(response.message);
                                },
                                borderRadius: 18,
                                boxShadow: MyBoxShadow(
                                  x: 0,
                                  y: 4,
                                  blurRadius: 15,
                                  color: const Color(0xff484848),
                                  opacity: 0.5,
                                ),
                                isShadow: true,
                                width: 170,
                                title: !widget.fromPanier
                                    ? 'Ajouter Panier'
                                    : 'Modifier',
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                      )
                    ],
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
