import 'package:code_resto/models/response.dart';
import 'package:code_resto/services/conexion_repo.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/fonts.dart';
import 'package:code_resto/models/box_shadow.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/utils/validators.dart';
import 'package:code_resto/widgets/code_resto_title_widget.dart';
import 'package:code_resto/widgets/full_screen_widget.dart';
import 'package:code_resto/widgets/my_form_widget.dart';
import 'package:code_resto/widgets/my_title_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ConexionRepo conexionRepo = ConexionRepo();
  final formKey = GlobalKey<FormState>();
  String email = '', password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                const FullScreenWidget(),
                Positioned(
                  right: -82.w,
                  top: -57.h,
                  child: Image.asset(
                    'images/foodimg.png',
                    width: 308.w,
                    height: 308.h,
                  ),
                ),
                Positioned(
                  top: 240.h,
                  left: 30.w,
                  child: const CodeRestoTitleWidget(),
                ),
                Positioned(
                  top: 396.h,
                  left: 30.w,
                  child: Text(
                    'Se connecter',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: boldFont,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 48.h,
                  left: 21.w,
                  right: 22.w,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        MyFormWidget(
                          borderColor: Theme.of(context).primaryColor,
                          onChange: (v) {
                            email = v.trim();
                          },
                          hintTxt: 'Email',
                          isEmail: true,
                          validator: (value) {
                            return Validators.validateEmail(value);
                          },
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyFormWidget(
                              borderColor: Theme.of(context).primaryColor,
                              onChange: (v) {
                                password = v.trim();
                              },
                              hintTxt: 'Mot de passe',
                              isPassword: true,
                              validator: (value) {
                                return Validators.validateEmpty(value);
                              },
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/forgetPwdOne'),
                              child: Text(
                                'mot de passe oublié ?',
                                style: TextStyle(
                                  color: myBlack,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 48.h),
                        MyTitleButton(
                          color: Theme.of(context).primaryColor,
                          boxShadow: MyBoxShadow(),
                          onTap: () async {
                            hideKeyboard(context);
                            if (formKey.currentState!.validate()) {
                              Response response = await futureMethod(
                                  conexionRepo.signInWithEmailAndPassword(
                                      email: email, password: password),
                                  context);

                              response.result
                                  ? Navigator.pushNamed(context, '/home_screen')
                                  : showToast(
                                      response.message,
                                      color: Colors.red,
                                    );
                            }
                          },
                          width: 332.w,
                          title: 'Se Connecter',
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
