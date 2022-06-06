import 'package:code_resto/models/panier.dart';
import 'package:code_resto/models/plat.dart';
import 'package:code_resto/models/response.dart';
import 'package:code_resto/services/favoris_repo.dart';
import 'package:code_resto/services/panier_repo.dart';
import 'package:code_resto/services/plat_repo.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/screens/detail_menu_screen.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/widgets/bottom_navig_bar.dart';
import 'package:code_resto/widgets/code_resto_title_widget.dart';
import 'package:code_resto/widgets/food_widget.dart';
import 'package:code_resto/widgets/full_screen_widget.dart';
import 'package:code_resto/widgets/my_search_widget.dart';
import 'package:code_resto/widgets/search_by_tags_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearch = false;
  bool isDone = false;
  bool tagsGet = false;
  bool? likeThis;
  String wordToSearch = '';
  PlatRepo platRepo = PlatRepo();
  PanierRepo panierRepo = PanierRepo();
  FavorisRepo favorisRepo = FavorisRepo();
  Panier panier = Panier();
  bool getPanier = false;
  int numPlat = 10;
  String tags = '';
  getMonPanier() async {
    Response response = await panierRepo.getMonPanier();
    if (response.result) {
      panier = response.data['panier'];
      setState(() {
        getPanier = true;
      });
    } else {
      showToast(response.message);
      Navigator.pop(context);
    }
  }

  Plat plat = Plat();

  Future<bool> getAllPlat(String tag, numPlat) async {
    Response response = await platRepo.getAllPlat(
      tag,
      numPlat,
    );
    if (response.result) {
      setState(() {
        plat = response.data['plat'];
      });
    } else {
      showToast(response.message);
    }

    setState(() {
      isDone = response.result;
    });
    return response.result;
  }

  searchByWord(str) async {
    hideKeyboard(context);
    var response = await futureMethod(platRepo.searchByWord(str), context);
    if (response.result) {
      setState(() {
        plat = response.data['plat'];
      });
    } else {
      showToast(response.message);
    }
  }

  @override
  void initState() {
    super.initState();
    isSearch = false;
    getAllPlat(tags, numPlat);
    getMonPanier();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: !isDone || !getPanier
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: myTransparent,
                  color: myBlue,
                ),
              )
            : Stack(
                children: [
                  const FullScreenWidget(),
                  Padding(
                    padding: EdgeInsets.all(8.0.h),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () => setState(() {
                          isSearch = false;
                        }),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: isSearch ? 1 : 0,
                          child: SizedBox(
                            height: 50.h,
                            width: 50.h,
                            child: SvgPicture.asset(
                              'icons/arrow_back_icon.svg',
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 110.h,
                    left: 16.5.w,
                    child: AnimatedOpacity(
                      opacity: isSearch ? 0 : 1,
                      duration: const Duration(milliseconds: 700),
                      child: SearchByTagsWidget(
                        onSearch: () => setState(() {
                          isSearch = true;
                        }),
                        onTag: (p0, tagsStrList) {
                          iPrint(tagsStrList);
                          tags = tagsStrList.join('');
                          iPrint(tags);
                          getAllPlat(tags, numPlat);
                        },
                        iconTagsSpace: 6.5,
                        firstSearchWidget: SvgPicture.asset('icons/Search.svg'),
                        numOfTags: 20,
                        title: 'Populaire',
                        spaceBetwennTags: 20.5,
                      ),
                    ),
                  ),
                  isSearch
                      ? Positioned(
                          top: 61.h,
                          left: 20.w,
                          right: 20.w,
                          child: MySearchWidget(
                            onChange: (v) {
                              wordToSearch = v;
                            },
                            hintTxt: '',
                            prefixIcon: InkWell(
                              onTap: () => searchByWord(wordToSearch),
                              child: SizedBox(
                                child: SvgPicture.asset(
                                  'icons/Search.svg',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 700),
                    top: !isSearch ? 210.h : 117.h,
                    right: 5.w,
                    left: 10.w,
                    child: SizedBox(
                      height: getHeight(context),
                      width: getWidth(context),
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollNotification.metrics.pixels ==
                              scrollNotification.metrics.maxScrollExtent) {
                            void getResult() async {
                              bool result = false;

                              numPlat += 2;
                              iPrint('NumPlat : \n $numPlat');
                              result = await getAllPlat(tags, numPlat);
                            }

                            if (!isSearch) getResult();
                            iPrint('hello Its The Maximum GridView here');
                          }
                          return true;
                        },
                        child: GridView.builder(
                          padding: EdgeInsets.only(
                            top: 0,
                            bottom: 500.h,
                          ),
                          itemCount: plat.results!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 15.h,
                            mainAxisSpacing: 20.h,
                          ),
                          itemBuilder: (context, index) {
                            return FoodWidget(
                              imageAbo: plat.results?[index].imageAb,
                              offreTitle: plat.results?[index].titreOffre,
                              offre: plat.results?[index].offre,
                              likeIt: plat.results?[index].like,
                              id: plat.results?[index].identifiant,
                              discountPrice: plat.results?[index].prixApplicable
                                  .toString(),
                              pourcentage: plat.results?[index].pourcentage,
                              hasOffre: plat.results?[index].hasOffre,
                              titre: plat.results?[index].titre ?? '',
                              descrip: plat.results?[index].description ?? '',
                              imagePath: plat.results?[index].image ??
                                  'plateau-repas.png',
                              price: plat.results?[index].prix.toString(),
                              index: index,
                              onAdd: (index) {
                                print("hello");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailMenuScreen(
                                        id: plat.results?[index].identifiant ??
                                            '',
                                        imagePath: plat.results?[index].image ??
                                            'plateau-repas.png',
                                        index: index),
                                  ),
                                );
                                iPrint('onAdd $index');
                              },
                              onLove: (p0) {
                                iPrint('onLove $p0');
                                if (p0 == 1) {
                                  setState(() {
                                    likeThis = plat.results?[index].like;
                                  });
                                  iPrint('OKKY');
                                }
                                //iPrint(plat.results?[index].like);
                              },
                              onClick: (index) {
                                print("hello");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailMenuScreen(
                                        id: plat.results?[index].identifiant ??
                                            '',
                                        imagePath: plat.results?[index].image ??
                                            'plateau-repas.png',
                                        index: index),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: AnimatedOpacity(
                      opacity: isSearch ? 0 : 1,
                      duration: const Duration(milliseconds: 500),
                      child: const Align(
                        alignment: Alignment.topCenter,
                        child: CodeRestoTitleWidget(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: BottomNavigBar(
                        pageIndex: 0,
                        panierCounter: panier.listeMenus?.length ?? 0,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
