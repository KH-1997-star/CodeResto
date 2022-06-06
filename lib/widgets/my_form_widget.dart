import 'package:code_resto/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyFormWidget extends StatefulWidget {
  final FormFieldValidator<String>? validator;
  final Function(String formContent) onChange;
  final Color hintColor, borderColor;
  final String hintTxt, myValidationTxt;
  final bool isNumbers, isText, isPassword, isEmail, isPhoneNumber;
  final double borderRadius, height, width, hintFontSize;
  final TextInputFormatter? formater;
  final String? initialValue;
  const MyFormWidget({
    Key? key,
    required this.onChange,
    required this.hintTxt,
    this.initialValue = '',
    this.myValidationTxt = '',
    this.isNumbers = false,
    this.isText = true,
    this.isPassword = false,
    this.isEmail = false,
    this.isPhoneNumber = false,
    this.hintColor = myBlack,
    this.borderColor = myBlack,
    this.borderRadius = 19,
    this.height = 54,
    this.width = 332,
    this.hintFontSize = 14,
    this.validator,
    this.formater,
  }) : super(key: key);

  @override
  State<MyFormWidget> createState() => _MyFormWidgetState();
}

class _MyFormWidgetState extends State<MyFormWidget> {
  Icon passIcon = const Icon(Icons.visibility_off_outlined);
  bool hiden = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      inputFormatters: widget.formater == null ? [] : [widget.formater!],
      obscureText: widget.isPassword ? hiden : false,
      keyboardType: widget.isText
          ? widget.isEmail
              ? TextInputType.emailAddress
              : TextInputType.text
          : widget.isPhoneNumber
              ? TextInputType.phone
              : TextInputType.number,
      validator: widget.validator,
      onChanged: (value) => widget.onChange(value),
      decoration: InputDecoration(
        isDense: true,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    hiden = !hiden;
                    hiden
                        ? passIcon = const Icon(Icons.visibility_off_outlined)
                        : passIcon = const Icon(
                            Icons.remove_red_eye_outlined,
                            // color: Theme.of(context).secondaryHeaderColor,
                          );
                  });
                },
                icon: passIcon)
            : const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          borderSide: BorderSide(
            width: 2.w,
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          borderSide: BorderSide(
            width: 2.w,
            color: Theme.of(context).secondaryHeaderColor,
            
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          borderSide: BorderSide(
            width: 2.w,
            color: widget.borderColor,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(23.w, 20.0.h, 5.0, 1.0),
        hintText: widget.hintTxt,
        hintStyle: TextStyle(
          fontSize: widget.hintFontSize.sp,
          color: widget.hintColor,
        ),
      ),
    );
  }
}
