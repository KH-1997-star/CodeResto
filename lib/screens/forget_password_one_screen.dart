import 'package:code_resto/models/box_shadow.dart';
import 'package:code_resto/services/forget_password_repo.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/utils/validators.dart';
import 'package:code_resto/widgets/costum_form_widget.dart';
import 'package:code_resto/widgets/my_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ForgetPwdOneScreen extends ConsumerStatefulWidget {
  final String? email;
  const ForgetPwdOneScreen({Key? key, this.email}) : super(key: key);

  @override
  _ForgetPwdOneScreenState createState() => _ForgetPwdOneScreenState();
}

class _ForgetPwdOneScreenState extends ConsumerState<ForgetPwdOneScreen> {
  ForgetPasswordViewModel ChangePwd = ForgetPasswordViewModel();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController adresseController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  String typee = "email";
  bool enablpwd = false;
  bool enablemail = false;
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNodepwd = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  MaskTextInputFormatter? maskEMpty = MaskTextInputFormatter();

  BoxDecoration get pinPutDecoration {
    return BoxDecoration(
      color: myWhite,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10.0.r),
    );
  }

  BoxDecoration get selectedpinPutDecoration {
    return BoxDecoration(
      color: myWhite,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10.0.r),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final viewModel = ref.read(signUpModelSignUp);

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
                      widget: SvgPicture.asset(
                        'icons/arrow_back_icon.svg',
                        height: 3.h,
                        width: 3.w,
                        fit: BoxFit.none,
                      ),
                      color: myWhite,
                      borderColor: myBlue,
                      borderWidth: 1.5,
                      isBordred: true,
                      onTap: () => Navigator.pop(context),
                      boxShadow: MyBoxShadow(),
                    ),
                  ),
                  Positioned(
                      top: 276.h,
                      right: 36.w,
                      left: 36.w,
                      child: const Text(
                        "Entrez votre adresse E-mail",
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
                      child: CustomInputWidget(
                        formater: maskEMpty,
                        onTap: () {
                          setState(() {
                            enablemail = true;
                          });
                        },
                        enableField: enablemail,
                        hintText: "E-mail",
                        controller: emailController,
                        validator: (v) {
                          return Validators.validateEmail(v!);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 400.h,
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
                        }
                        // iPrint("Hello");
                        // Navigator.pushNamed(context, '/slide_screen');
                        ChangePwd.forgetPasswordOne(
                            context, emailController.text);
                        //     email: emailController.text,
                        //     password: pwdController.text);
                        // viewModel.signInWithEmailAndPassword(context);
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

  void showSnackBar(String pin, BuildContext context) {
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
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
