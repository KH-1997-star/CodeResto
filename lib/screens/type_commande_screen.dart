import 'dart:async';

import 'package:code_resto/models/profile.dart';
import 'package:code_resto/models/response.dart';
import 'package:code_resto/screens/recap_screen.dart';
import 'package:code_resto/services/panier_repo.dart';
import 'package:code_resto/services/profile_repo.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/fonts.dart';
import 'package:code_resto/models/box_shadow.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/utils/validators.dart';
import 'package:code_resto/widgets/chosen_cont_widget.dart';
import 'package:code_resto/widgets/code_resto_title_widget.dart';
import 'package:code_resto/widgets/full_screen_widget.dart';
import 'package:code_resto/widgets/my_form_widget.dart';
import 'package:code_resto/widgets/my_search_widget.dart';
import 'package:code_resto/widgets/my_title_button_widget.dart';
import 'package:code_resto/widgets/my_title_widget_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TypeCommandeScreen extends StatefulWidget {
  final dynamic prix;
  const TypeCommandeScreen({Key? key, this.prix}) : super(key: key);

  @override
  State<TypeCommandeScreen> createState() => _TypeCommandeScreenState();
}

class _TypeCommandeScreenState extends State<TypeCommandeScreen> {
  List<bool> checkedList = [false, false, false];
  bool startAnimation = false;
  String typeLivraiseon = '', emplacemant = '';
  final formKey = GlobalKey<FormState>();
  PanierRepo cmdRepo = PanierRepo();
  ProfileRepo profileRepo = ProfileRepo();
  bool done = false;
  Profile profile = Profile();
  String phone = "";
  String adresse = "";
  getProfile() async {
    Response response = await profileRepo.getProfileData();
    if (response.result) {
      profile = response.data['profile'];
      phone = profile.phone ?? "";
      adresse = profile.addresse ?? "";
    } else {
      Navigator.pushNamed(context, '/oops_404');
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
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<ProfileRepo>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/home_screen');
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const FullScreenWidget(),
            Positioned(
              right: -95.w,
              top: -125.h,
              child: Image.asset(
                'images/foodimg.png',
                width: 296.w,
                height: 296.h,
              ),
            ),
            Positioned(
              top: 55.h,
              left: 21.w,
              child: MyTitleWidgetButton(
                color: Theme.of(context).primaryColor,
                width: 35.w,
                borderRadius: 10,
                onTap: () => Navigator.pop(context),
                title: const Icon(
                  Icons.arrow_back_ios_new,
                  color: myWhite,
                  size: 20,
                ),
                boxShadow: MyBoxShadow(),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 700),
              top: checkedList[1] ? 226.h : 257.h,
              left: 59.w,
              right: 56.w,
              child: Text(
                'Choisissez un type de commande',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: semiBoldFont,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 700),
              top: checkedList[1] ? 278.h : 309.h,
              left: 9.w,
              right: 8.w,
              child: Row(
                children: [
                  Flexible(
                    child: ChooseModeWidget(
                        title: 'À emporter',
                        imgPath: 'icons/bag_icon.svg',
                        isChosed: checkedList[0],
                        onChoose: () {
                          typeLivraiseon = 'À emporter';
                          setState(() {
                            checkedList[0] = true;
                            checkedList[1] = false;
                            checkedList[2] = false;
                            Timer(const Duration(milliseconds: 20), () {
                              setState(() {
                                if (checkedList[1]) {
                                  startAnimation = true;
                                } else {
                                  startAnimation = false;
                                }
                              });
                            });
                          });
                        }),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Flexible(
                    child: ChooseModeWidget(
                      title: 'Se faire livrer',
                      imgPath: 'icons/bicycle_icon.svg',
                      isChosed: checkedList[1],
                      onChoose: () {
                        typeLivraiseon = 'Se faire livrer';
                        setState(() {
                          checkedList[1] = true;
                          checkedList[0] = false;
                          checkedList[2] = false;
                          Timer(const Duration(milliseconds: 20), () {
                            setState(() {
                              if (checkedList[1]) {
                                startAnimation = true;
                              } else {
                                startAnimation = false;
                              }
                            });
                          });
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Flexible(
                    child: ChooseModeWidget(
                        title: 'Sur place',
                        imgPath: 'icons/restaurant_icon.png',
                        isChosed: checkedList[2],
                        onChoose: () {
                          typeLivraiseon = 'Sur place';
                          setState(() {
                            checkedList[0] = false;
                            checkedList[1] = false;
                            checkedList[2] = true;
                            Timer(const Duration(milliseconds: 20), () {
                              setState(() {
                                if (checkedList[1]) {
                                  startAnimation = true;
                                } else {
                                  startAnimation = false;
                                }
                              });
                            });
                          });
                        }),
                  ),
                ],
              ),
            ),
            checkedList[1]
                ? AnimatedPositioned(
                    duration: const Duration(milliseconds: 700),
                    top: 396.h,
                    right: !startAnimation ? 1500.w + getWidth(context) : 22.w,
                    left: startAnimation ? 18.w : -1500.w,
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Saisissez  l\'adresse de la livraison',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: mediumFont,
                            ),
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          MyFormWidget(
                              borderColor: Theme.of(context).primaryColor,
                              initialValue: adresse,
                              validator: (value) {
                                return Validators.validateName(value);
                              },
                              onChange: (v) {
                                adresse = v;
                              },
                              hintTxt: 'adresse'),
                          SizedBox(
                            height: 14.h,
                          ),
                          SizedBox(
                            height: 80.h,
                            width: 332.w,
                            child: MyFormWidget(
                                isText: false,
                                isPhoneNumber: true,
                                borderColor: Theme.of(context).primaryColor,
                                initialValue: phone,
                                validator: (value) {
                                  return Validators.validateName(value);
                                },
                                onChange: (v) {
                                  phone = v;
                                },
                                hintTxt: 'téléphone'),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MyTitleButton(
                    boxShadow: MyBoxShadow(),
                    color: Theme.of(context).primaryColor,
                    border: false,
                    title: 'Valider',
                    titleColor: myWhite,
                    onTap: () async {
                      if (typeLivraiseon == 'Se faire livrer') {
                        if (formKey.currentState!.validate()) {
                          Response response = await futureMethod(
                              cmdRepo.modeLivraison(
                                  phone, adresse, "", "", typeLivraiseon),
                              context);
                          if (!response.result) {
                            setState(() {
                              showToast(response.message);
                            });
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RecapScreen(
                                  typeLivr: typeLivraiseon,
                                  prix: widget.prix.toString(),
                                  emplacemant: adresse,
                                  idCommande: response.data['idCommande'],
                                  idCustomer: response.data['customerId'],
                                  emailClient: response.data['email'],
                                  numTel: phone,
                                ),
                              ),
                            );
                          }
                        }
                      } else if (typeLivraiseon != '') {
                        Response response = await futureMethod(
                            cmdRepo.modeLivraison(
                                phone, adresse, "", "", typeLivraiseon),
                            context);
                        if (response.result) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RecapScreen(
                                typeLivr: typeLivraiseon,
                                prix: widget.prix.toString(),
                                emplacemant: '',
                                idCommande: response.data['idCommande'],
                                idCustomer: response.data['customerId'],
                                emailClient: response.data['email'],
                                numTel: '',
                              ),
                            ),
                          );
                        } else {
                          showToast(response.message);
                        }
                      } else {
                        showToast('veuillez choisir votre mode de livraison');
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
