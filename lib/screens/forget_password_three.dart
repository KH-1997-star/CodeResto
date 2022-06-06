import 'package:code_resto/models/box_shadow.dart';
import 'package:code_resto/services/forget_password_repo.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/utils/validators.dart';
import 'package:code_resto/widgets/custom_input_pwd.dart';
import 'package:code_resto/widgets/my_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgetPwdThreeScreen extends ConsumerStatefulWidget {
  final String? email;
  const ForgetPwdThreeScreen({Key? key, this.email}) : super(key: key);

  @override
  _ForgetPwdThreeScreenState createState() => _ForgetPwdThreeScreenState();
}

class _ForgetPwdThreeScreenState extends ConsumerState<ForgetPwdThreeScreen> {
  ForgetPasswordViewModel ChangePwd = ForgetPasswordViewModel();

  TextEditingController secondPwdController = TextEditingController();

  TextEditingController pwdController = TextEditingController();

  String typee = "email";
  bool _showPassword = false;
  bool _showPasswordTwo = false;
  bool enablpwd = false;
  bool enablemail = false;
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNodepwd = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
              color: myWhite,
              height: size.height,
              width: size.width,
              child: Stack(
                children: [
                  Positioned(
                    top: 36.h,
                    left: 36.w,
                    child: MyWidgetButton(
                      boxShadow: MyBoxShadow(),
                      widget: SvgPicture.asset(
                        'icons/arrow_back_icon.svg',
                        height: 3.h,
                        width: 3.w,
                        fit: BoxFit.none,
                      ),
                      color: myWhite,
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                      top: 276.h,
                      right: 36.w,
                      left: 36.w,
                      child: const Text(
                        "Entrez votre nouveau mot de passe",
                        style: TextStyle(
                            color: myWhite,
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )),
                  Positioned(
                    top: 315.h,
                    right: 36.w,
                    left: 36.w,
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomInputPwd(
                              onTap: () {
                                setState(() {
                                  enablpwd = true;
                                });
                              },
                              labelText: "Nouveau mot de passe",
                              enableField: enablpwd,
                              obscureText: !_showPassword,
                              controller: pwdController,
                              suffixIcon: IconButton(
                                iconSize: 15,
                                icon: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: _showPassword ? myBlack : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(
                                      () => _showPassword = !_showPassword);
                                },
                              ),
                              validator: (v) {
                                return Validators.validatePassword(v!);
                              },
                            ),
                            CustomInputPwd(
                              onTap: () {
                                setState(() {
                                  enablpwd = true;
                                });
                              },
                              labelText: "Nouveau mot de passe",
                              enableField: enablpwd,
                              obscureText: !_showPasswordTwo,
                              controller: secondPwdController,
                              suffixIcon: IconButton(
                                iconSize: 15,
                                icon: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color:
                                      _showPasswordTwo ? myBlue : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() =>
                                      _showPasswordTwo = !_showPasswordTwo);
                                },
                              ),
                              validator: (v) {
                                return Validators.validateConfirmPassword(
                                    v!, pwdController.text);
                              },
                            ),
                          ],
                        )),
                  ),
                  Positioned(
                    top: 500.h,
                    left: 36.w,
                    child: MyWidgetButton(
                      width: 303,
                      height: 50,
                      color: myBlue,
                      widget: Center(
                        child: Text('Continuer',
                            style: TextStyle(
                                color: myBlack,
                                fontFamily: "Robot",
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp)),
                      ),
                      onTap: () {
                        iPrint(_formKey.currentState!.validate());
                        if (_formKey.currentState!.validate()) {
                          iPrint("Hello================>");

                          // iPrint("Hello");
                          // Navigator.pushNamed(context, '/slide_screen');
                          ChangePwd.newPassword(
                              context, pwdController.text, widget.email);
                        }
                      },
                      boxShadow: MyBoxShadow(),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
