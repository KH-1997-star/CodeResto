import 'package:code_resto/models/box_shadow.dart';
import 'package:code_resto/models/response.dart';
import 'package:code_resto/services/conexion_repo.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/widgets/code_resto_title_widget.dart';
import 'package:code_resto/widgets/my_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pin_put/pin_put.dart';

class ValidateEmailScreen extends StatefulWidget {
  final String? email, mdp;
  const ValidateEmailScreen({this.email, Key? key, this.mdp}) : super(key: key);

  @override
  State<ValidateEmailScreen> createState() => _ValidateEmailScreenState();
}

class _ValidateEmailScreenState extends State<ValidateEmailScreen>
    with TickerProviderStateMixin {
  ConexionRepo conexionRepo = ConexionRepo();
  TextEditingController emailController = TextEditingController();
  late AnimationController controller;
  late Animation<double> animation;
  String? _email = "";
  String typee = "email";
  bool showPassword = false;
  bool enablpwd = false;
  bool enablemail = false;
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNodepwd = FocusNode();
  final formKey = GlobalKey<FormState>();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    animation = Tween<double>(begin: 1, end: 0)
        .chain(CurveTween(curve: Curves.easeIn))
        .animate(controller);
    controller.forward();
    setState(() {
      _email = widget.email;
    });
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: Colors.grey,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10.0.r),
    );
  }

  BoxDecoration get _selectedpinPutDecoration {
    return BoxDecoration(
      color: Colors.grey,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10.0.r),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            color: myBlack,
            height: getHeight(context),
            width: getWidth(context),
            child: Stack(
              children: [
                Positioned(
                  top: 36.h,
                  left: 36.w,
                  child: MyWidgetButton(
                    widget: SvgPicture.asset(
                      'icons/arrow_back_icon.svg',
                      height: 3.h,
                      width: 3.w,
                      fit: BoxFit.none,
                    ),
                    color: myWhite,
                    onTap: () => Navigator.pop(context),
                    boxShadow: MyBoxShadow(),
                  ),
                ),
                Positioned(
                  top: 75.h,
                  right: 131.w,
                  child: Container(
                    color: myWhite,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CodeRestoTitleWidget(
                        fontSize: 41.sp,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 276.h,
                  right: 36.w,
                  left: 36.w,
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      double x = animation.value * getWidth(context);
                      return Transform(
                        transform: Matrix4.translationValues(x, 0, 0),
                        child: child,
                      );
                    },
                    child: const Text(
                      "Entrez le code OTP à 4 chiffres envoyés",
                      style: TextStyle(
                          color: myWhite,
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Positioned(
                  top: 315.h,
                  right: 36.w,
                  left: 36.w,
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      double x = animation.value * getWidth(context);
                      return Transform(
                        transform: Matrix4.translationValues(x, 0, 0),
                        child: child,
                      );
                    },
                    child: PinPut(
                      eachFieldHeight: 58.h,
                      eachFieldWidth: 58.w,
                      fieldsCount: 4,
                      onSubmit: (String pin) => _showSnackBar(pin, context),
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      submittedFieldDecoration: _pinPutDecoration.copyWith(
                        borderRadius: BorderRadius.circular(10.0.r),
                      ),
                      selectedFieldDecoration: _selectedpinPutDecoration,
                      followingFieldDecoration: _pinPutDecoration.copyWith(
                        borderRadius: BorderRadius.circular(10.0.r),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 400.h,
                  left: 36.w,
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      double x = animation.value * getWidth(context);
                      return Transform(
                        transform: Matrix4.translationValues(x, 0, 0),
                        child: child,
                      );
                    },
                    child: MyWidgetButton(
                        boxShadow: MyBoxShadow(),
                        width: 303,
                        height: 50,
                        color: myBlue,
                        widget: Center(
                          child: Text(
                            'Continuer',
                            style: TextStyle(
                                color: myBlack,
                                fontFamily: "Robot",
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp),
                          ),
                        ),
                        onTap: () async {
                          iPrint(
                              "email  $_email  code: ${_pinPutController.text} ");
                          Response response = await futureMethod(
                              conexionRepo.activateAccount(
                                widget.email ?? '',
                                _pinPutController.text,
                                mdp: widget.mdp,
                              ),
                              context);
                          iPrint('RESULLLT ::::: ${response.result}');
                          if (!response.result &&
                              response.message == 'INSCRIPTION') {
                            Navigator.pushNamed(context, '/login_screen');
                          } else {
                            response.result
                                ? Navigator.pushNamed(
                                    context, '/abonnement_screen')
                                : showToast(response.message);
                          }

                          /* viewModel.activateAccount(
                              context, _email!, _pinPutController.text); */
                          iPrint("Hello");
                          // viewModel.onChangeData(
                          //     email: emailController.text,
                          //     password: pwdController.text);
                          // viewModel.signInWithEmailAndPassword(context);
                        }),
                  ),
                ),
                Positioned(
                  top: 475.h,
                  left: 79.w,
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      double x = animation.value * getWidth(context);
                      return Transform(
                        transform: Matrix4.translationValues(x, 0, 0),
                        child: child,
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Vous n'avez pas reçu de code?",
                          style: TextStyle(
                              color: myWhite,
                              fontFamily: 'Roboto',
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        InkWell(
                            child: SizedBox(
                              height: 30.h,
                              child: const Text(
                                "Cliquez ici",
                                style: TextStyle(
                                    color: myBlue,
                                    fontFamily: 'Roboto',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onTap: () async {
                              Response response = await futureMethod(
                                  conexionRepo.resendCode(widget.email ?? ''),
                                  context);
                              showToast(response.message,
                                  color: response.result
                                      ? Colors.green
                                      : Colors.red);
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: SizedBox(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted. Value: $pin',
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
