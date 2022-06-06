import 'package:code_resto/services/conexion_repo.dart';
import 'package:code_resto/services/google_sign_in.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/fonts.dart';
import 'package:code_resto/models/box_shadow.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/widgets/code_resto_title_widget.dart';
import 'package:code_resto/widgets/full_screen_widget.dart';
import 'package:code_resto/widgets/my_title_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  GoogleSgnIn googleSgnIn = GoogleSgnIn();
  ConexionRepo conexionRepo = ConexionRepo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const FullScreenWidget(),
          Padding(
            padding: EdgeInsets.only(left: 22.w, right: 21.w, bottom: 50.h),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        var result = await futureMethod(
                            googleSgnIn.googleLogIn(), context);
                        print("hellloooooo  $result");
                        if (result.result) {
                          final user = googleSgnIn.user;

                          var response = await futureMethod(
                              conexionRepo.signInWithGoogleOrFacebook(
                                token: result.data['token'],
                                id: user.id,
                                type: 'google',
                                email: user.email,
                                nom: user.displayName ?? '',
                              ),
                              context);
                          iPrint('message' + response.message);
                          if (response.result &&
                              response.message == 'compte valide') {
                            Navigator.pushNamed(context, '/home_screen');
                          } else if (response.result &&
                              response.message
                                  .contains('inscription avec success')) {
                            Navigator.pushNamed(context, '/abonnement_screen');
                          } else {
                            showToast(response.message);
                          }
                        } else {
                          showToast(result.message);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.w,
                        width: 50.w,
                        child: const FaIcon(
                          FontAwesomeIcons.google,
                          color: myWhite,
                        ),
                        decoration: const BoxDecoration(
                          color: myGoogleColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {},
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.w,
                        width: 50.w,
                        child: const FaIcon(
                          FontAwesomeIcons.facebookF,
                          color: myWhite,
                        ),
                        decoration: const BoxDecoration(
                          color: myFacebookColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ) /*  MyTitleWidgetButton(
                boxShadow: MyBoxShadow(),
                onTap: () async {
                 
                },
                height: 54,
                borderRadius: 18,
                color: myWhite,
                border: true,
                borderWidth: 2,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.google,
                      color: myGoogleColor,
                    ),
                    Text(
                      'Conexion avec compte gmail',
                      style:
                          TextStyle(fontSize: 15.sp, fontWeight: semiBoldFont),
                    )
                  ],
                ),
                titleColor: myBlack,
              ), */
                ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 22.w, right: 21.w, bottom: 164.h),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MyTitleButton(
                bordorColor: Theme.of(context).primaryColor,
                boxShadow: MyBoxShadow(),
                onTap: () => Navigator.pushNamed(context, '/login_screen'),
                height: 54,
                borderRadius: 18,
                color: myWhite,
                border: true,
                borderWidth: 2,
                title: 'Se Connecter',
                titleColor: myBlack,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 22.w, right: 21.w, bottom: 125.h),
            child: const Align(
                alignment: Alignment.bottomCenter,
                child: Text('Ou se connecter avec')),
          ),
          Padding(
            padding: EdgeInsets.only(left: 22.w, right: 21.w, bottom: 244.h),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MyTitleButton(
                color: Theme.of(context).primaryColor,
                boxShadow: MyBoxShadow(),
                onTap: () => Navigator.pushNamed(context, '/signup_screen'),
                height: 54,
                borderRadius: 18,
                borderWidth: 2,
                title: 'S\'inscrire',
              ),
            ),
          ),
          /*   Padding(
            padding: EdgeInsets.only(left: 120.w, bottom: 336.h),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, '/home_screen'),
                    child: Text(
                      'Passer',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: semiBoldFont,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.5.h,
                  ),
                  SvgPicture.asset('icons/long_arrow_icon.svg'),
                ],
              ),
            ),
          ), */
          Padding(
            padding: EdgeInsets.only(left: 44.w, right: 43.w, bottom: 406.h),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Organiser, trouver et profiter de dans une application moderne, et d\'une façon dynamique',
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: semiBoldFont,
                    color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            top: 151.h,
            left: 30.w,
            child: const CodeRestoTitleWidget(
              fontSize: 41,
            ),
          ),
          Positioned(
            right: -125.w,
            top: -183.h,
            child: Image.asset(
              'images/foodimg.png',
              width: 380.w,
              height: 380.h,
            ),
          ),
        ],
      ),
    );
  }
}
