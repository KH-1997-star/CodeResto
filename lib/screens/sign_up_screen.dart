import 'package:code_resto/models/response.dart';
import 'package:code_resto/screens/myvalid_email_screen.dart';
import 'package:code_resto/services/conexion_repo.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/consts.dart';
import 'package:code_resto/utils/fonts.dart';
import 'package:code_resto/models/box_shadow.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/utils/validators.dart';
import 'package:code_resto/widgets/code_resto_title_widget.dart';
import 'package:code_resto/widgets/my_form_widget.dart';
import 'package:code_resto/widgets/my_title_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  String nom = '', prenom = '', numTel = '', mail = '', mdp = '';
  ConexionRepo conexionRepo = ConexionRepo();
  bool erreur = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: !erreur ? getHeight(context) : 1000.h,
                    width: getWidth(context),
                  ),
                  Positioned(
                    right: -162.w,
                    top: -208.h,
                    child: Image.asset(
                      'images/foodimg.png',
                      width: 380.w,
                      height: 380.h,
                    ),
                  ),
                  Positioned(
                      left: 23.w,
                      top: 84.h,
                      child: const CodeRestoTitleWidget()),
                  Positioned(
                    top: 241.h,
                    left: 22.w,
                    right: 30.w,
                    child: SizedBox(
                      width: getWidth(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'S\'inscrie',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: boldFont,
                            ),
                          ),
                          MyTitleButton(
                            onTap: () =>
                                Navigator.pushNamed(context, '/home_screen'),
                            color: Theme.of(context).secondaryHeaderColor,
                            boxShadow: MyBoxShadow(),
                            title: 'Passer',
                            titleColor: myWhite,
                            border: true,
                            fontSize: 13,
                            width: 100,
                            height: 38,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 332.h,
                    left: 22.w,
                    right: 21.w,
                    bottom: 10.h,
                    child: ListView(
                      padding: const EdgeInsets.all(0),
                      children: [
                        MyFormWidget(
                            borderColor: Theme.of(context).primaryColor,
                            validator: (value) {
                              return Validators.validateName(value);
                            },
                            onChange: (v) {
                              nom = v.trim();
                            },
                            hintTxt: 'Nom'),
                        SizedBox(
                          height: 25.h,
                        ),
                        MyFormWidget(
                            borderColor: Theme.of(context).primaryColor,
                            validator: (value) {
                              return Validators.validateName(value);
                            },
                            onChange: (v) {
                              prenom = v.trim();
                            },
                            hintTxt: 'Prénom'),
                        SizedBox(
                          height: 25.h,
                        ),
                        MyFormWidget(
                          borderColor: Theme.of(context).primaryColor,
                          formater: maskFormatter,
                          validator: (value) {
                            return Validators.validatePhone(value);
                          },
                          onChange: (v) {
                            numTel = v.trim();
                          },
                          hintTxt: 'Numero De Téléphone',
                          isText: false,
                          isNumbers: true,
                          isPhoneNumber: true,
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        MyFormWidget(
                          borderColor: Theme.of(context).primaryColor,
                          validator: (value) {
                            return Validators.validateEmail(value);
                          },
                          onChange: (v) {
                            mail = v.trim();
                          },
                          hintTxt: 'Adresse Mail',
                          isEmail: true,
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        MyFormWidget(
                          borderColor: Theme.of(context).primaryColor,
                          validator: (value) {
                            return Validators.validatePassword(value ?? '');
                          },
                          myValidationTxt: 'ce champ ne peut pas etre vide',
                          onChange: (v) {
                            mdp = v.trim();
                          },
                          hintTxt: 'Mot De Passe',
                          isPassword: true,
                        ),
                        SizedBox(
                          height: 45.h,
                        ),
                        MyTitleButton(
                          color: Theme.of(context).primaryColor,
                          boxShadow: MyBoxShadow(),
                          onTap: () async {
                            hideKeyboard(context);
                            if (formKey.currentState!.validate()) {
                              Response response = await futureMethod(
                                  conexionRepo.signUp(
                                      nom, prenom, numTel, mail, mdp),
                                  context);
                              response.result
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ValidateEmailScreen(
                                          email: mail,
                                          mdp: mdp,
                                        ),
                                      ),
                                    )
                                  : showToast(response.message,
                                      color: Colors.red);
                            } else {
                              setState(() {
                                erreur = true;
                              });
                            }
                          },
                          width: 330.w,
                          title: 'S\'inscrie',
                          height: 54.h,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
