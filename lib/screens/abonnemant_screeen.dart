import 'package:code_resto/models/abonnement.dart';
import 'package:code_resto/models/response.dart';
import 'package:code_resto/screens/home_screen.dart';
import 'package:code_resto/services/abonnement_repo.dart';
import 'package:code_resto/services/paiement_repo.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/costum_page_route.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/widgets/payment_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AbonnementScreen extends StatefulWidget {
  @override
  _AbonnementScreenState createState() => _AbonnementScreenState();
}

class _AbonnementScreenState extends State<AbonnementScreen>
    with TickerProviderStateMixin {
  Abonnement? abonnement;
  bool done = false;
  int? abonnemantIndex;
  int maxLength = -1;
  final AbonnnementRepo _abonnnementRepo = AbonnnementRepo();
  Map<String, dynamic>? paymentIntentData;
  final PaiementRepo _paiementRepo = PaiementRepo();
  List<bool> myabonmentList = [false, false, false, false];
  String typeAbonnement = '';
  Widget? myWidget;

  //bool isloading = true;
  late AnimationController animationController;
  late Animation<double> animation;
  String id = '';
  getAllAbonnement() async {
    Response response = await _abonnnementRepo.getAllAbonnement();
    setState(() {
      done = true;
    });
    if (response.result) {
      abonnement = response.data['abonnement'];
      iPrint('IMHERE');
      maxLength = abonnement?.results?.length ?? -1;
    } else {
      Navigator.pushNamed(context, '/oops_404');
    }
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        duration: const Duration(
          milliseconds: 600,
        ),
        vsync: this);

    animation = Tween<double>(
      begin: 0,
      end: 1,
    )
        .chain(
          CurveTween(
            curve: Curves.easeIn,
          ),
        )
        .animate(animationController);
    myWidget = myWidget = GestureDetector(
      key: const Key('2'),
      child: ArrowFrowardWidget(
        myColor: Colors.grey,
      ),
    );
    getAllAbonnement();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void startAnimation({@required Widget? destionation}) {
    animationController.forward().whenComplete(() {
      Navigator.of(context)
          .push(
        CostumPageRoute(
          child: destionation ?? const HomeScreen(),
          myDuration: 0,
          direction: AxisDirection.down,
        ),
      )
          .whenComplete(() {
        animationController.reset();
      }).then((value) {
        animation = Tween<double>(begin: 1, end: 0)
            .chain(
              CurveTween(
                curve: Curves.easeIn,
              ),
            )
            .animate(animationController);
        animationController
            .forward()
            .whenComplete(
              () => animationController.forward(),
            )
            .whenComplete(() {
          animation =
              Tween<double>(begin: 0, end: 1).animate(animationController);
          animationController.reset();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (myabonmentList.contains(true)) {
      setState(() {
        myWidget = GestureDetector(
          // cet widget ce trouve dans arrow_froward_widget.dart
          child: ArrowFrowardWidget(
            myColor: Colors.grey,
          ),
          onTap: () async {
            Response response = await futureMethod(
                _abonnnementRepo.acheterAbonnemant('Mensuel',
                    abonnement?.results?[abonnemantIndex!].identifiant ?? ''),
                context);
            if (response.result) {
              Response response1 = await _paiementRepo.makePayment(
                  response.data['prixTTC'],
                  paymentIntentData,
                  response.data['idAbonnement'],
                  response.data['customerId'],
                  response.data['email']);

              print(response1);
              if (response1.result) {
                Navigator.pushNamed(context, '/home_screen');
              } else {
                showToast("il semble qu'il y ait eu un problème!");
              }
            } else {
              showToast(response.message);
            }
          },
          /*onTap: () async {
                    await _paiementRepo.makePayment("20",paymentIntentData);
                  },*/
        );
      });
    } else {
      setState(() {
        myWidget = GestureDetector(
          key: const Key('0'),
          child: ArrowFrowardWidget(
            myColor: Colors.grey[200]!,
          ),
        );
      });
    }

    return !done
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/home_screen'),
                    child: const Text('passer cette étape',
                        style: TextStyle(color: myBlack)),
                  ),
                )
              ],
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              toolbarHeight: 200.h,
              flexibleSpace: SizedBox(
                height: 230.h,
                child: Stack(
                  children: [
                    // cet widget ce trouve dans le fichier back_titile_widget.dart

                    Positioned(
                      bottom: 0,
                      left: 37.w,
                      child: AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          double x = animation.value *
                              MediaQuery.of(context).size.width;
                          return Transform(
                            transform: Matrix4.translationValues(x, 0, 0),
                            child: child,
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Promis, c\'est bientôt fini',
                              style: TextStyle(
                                  fontSize: 25.sp,
                                  fontFamily: 'MonteBold',
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'veuillez choisir l’option d’abonnement',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: 'MonteLight',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      1 > maxLength
                          ? const SizedBox()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 37.w,
                              ),
                              // cet widget se trouve dans le fichier payment_option_widget.dart
                              child: PaymentOptionWidget(
                                price: abonnement?.results?[0].prixMensuelTtc,
                                optionStr: abonnement?.results?[0].titre ?? '',
                                taped: myabonmentList[0],
                                onChoice: () => setState(
                                  () {
                                    abonnemantIndex = 0;
                                    myabonmentList[0] = !myabonmentList[0];
                                    myabonmentList[1] = false;
                                    myabonmentList[2] = false;
                                    myabonmentList[3] = false;
                                  },
                                ),
                              ),
                            ),
                      1 > maxLength
                          ? const SizedBox()
                          : myabonmentList[0]
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 37.w,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20.h),
                                      // cet widget ce trouve dans alea_txt_container.dart
                                      AleatoirTxtContainer(
                                        txt:
                                            'Le Lorem Ipsum n’est pas simplement du texte aléatoire. ',
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      AleatoirTxtContainer(
                                        txt:
                                            'Le Lorem Ipsum n’est pas simplement du texte aléatoire. ',
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                      SizedBox(
                        height: 19.h,
                      ),
                      2 > maxLength
                          ? const SizedBox()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 37.w,
                              ),
                              child: PaymentOptionWidget(
                                price: abonnement?.results?[1].prixMensuelTtc,
                                optionStr: abonnement?.results?[1].titre ?? '',
                                taped: myabonmentList[1],
                                onChoice: () => setState(() {
                                  abonnemantIndex = 1;
                                  typeAbonnement = 'Premium';
                                  myabonmentList[0] = false;
                                  myabonmentList[1] = !myabonmentList[1];
                                  myabonmentList[2] = false;
                                  myabonmentList[3] = false;
                                }),
                              ),
                            ),
                      2 > maxLength
                          ? const SizedBox()
                          : myabonmentList[1]
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 37.w,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      AleatoirTxtContainer(
                                        txt:
                                            'Le Lorem Ipsum n’est pas simplement du texte aléatoire. ',
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      AleatoirTxtContainer(
                                        txt:
                                            'Le Lorem Ipsum n’est pas simplement du texte aléatoire. ',
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                      SizedBox(
                        height: 20.h,
                      ),
                      3 > maxLength
                          ? const SizedBox()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 37.w,
                              ),
                              child: PaymentOptionWidget(
                                price: abonnement?.results?[2].prixMensuelTtc,
                                optionStr: abonnement?.results?[2].titre ?? '',
                                taped: myabonmentList[2],
                                onChoice: () => setState(() {
                                  abonnemantIndex = 2;
                                  myabonmentList[0] = false;
                                  myabonmentList[1] = false;
                                  myabonmentList[3] = false;
                                  myabonmentList[2] = !myabonmentList[2];
                                }),
                              ),
                            ),
                      3 > maxLength
                          ? const SizedBox()
                          : myabonmentList[2]
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 37.w,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      AleatoirTxtContainer(
                                        txt:
                                            'Le Lorem Ipsum n’est pas simplement du texte aléatoire. ',
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      AleatoirTxtContainer(
                                        txt:
                                            'Le Lorem Ipsum n’est pas simplement du texte aléatoire. ',
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                      SizedBox(
                        height: 20.h,
                      ),
                      4 > maxLength
                          ? const SizedBox()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 37.w,
                              ),
                              child: PaymentOptionWidget(
                                price: abonnement?.results?[3].prixMensuelTtc,
                                optionStr: abonnement?.results?[3].titre ?? '',
                                taped: myabonmentList[3],
                                onChoice: () => setState(() {
                                  abonnemantIndex = 3;
                                  myabonmentList[0] = false;
                                  myabonmentList[1] = false;
                                  myabonmentList[2] = false;
                                  myabonmentList[3] = !myabonmentList[3];
                                }),
                              ),
                            ),
                      4 > maxLength
                          ? const SizedBox()
                          : myabonmentList[3]
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 37.w,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      AleatoirTxtContainer(
                                        txt:
                                            'Le Lorem Ipsum n’est pas simplement du texte aléatoire. ',
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      AleatoirTxtContainer(
                                        txt:
                                            'Le Lorem Ipsum n’est pas simplement du texte aléatoire. ',
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: myWidget,
                ),
              ],
            ));
  }
}
