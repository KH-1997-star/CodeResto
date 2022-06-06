import 'dart:ui';

import 'package:code_resto/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInputWidget extends StatelessWidget {
  final FormFieldValidator<String> validator;
  final double height;
  final double width;
  final TextEditingController controller;
  final double radius;
  final String hintText;
  final TextInputType keyboardType;
  final bool enableField, showLabel, enabled;
  final VoidCallback onTap;
  final TextInputFormatter? formater;
  final bool? isphone;
  final String? texte;
  final double hintSize;
  final Color hintColor;
  const CustomInputWidget({
    this.texte,
    required this.onTap,
    this.enableField = true,
    this.formater,
    this.height = 60,
    this.width = 303,
    this.radius = 13,
    this.keyboardType = TextInputType.text,
    required this.validator,
    required this.hintText,
    required this.controller,
    key,
    this.isphone = false,
    this.showLabel = true,
    this.hintSize = 15,
    this.hintColor = Colors.grey,
    this.enabled = true,

    // required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 10),
      width: width.w,
      height: height.w,
      constraints: BoxConstraints(minHeight: height.h),
      decoration: BoxDecoration(
        //color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(radius.r),
        ),
      ),
      child: TextFormField(
          enabled: enabled,
          keyboardType: keyboardType,
          controller: controller,
          cursorColor: Colors.grey,
          inputFormatters: formater == null ? [] : [formater!],
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: myBlack),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: myBlue),
              ),
              contentPadding: EdgeInsets.only(top: 5.h, left: 10.w),
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: hintSize.sp,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  color: hintColor),
              // focusedBorder: OutlineInputBorder(
              //     borderRadius: BorderRadius.all(
              //       Radius.circular(13.r),
              //     ),
              //     borderSide: BorderSide(width: 1, color: my_green)),
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(radius.r),
              //   borderSide: const BorderSide(
              //     color: Colors.purple,
              //     // width: 0.5,
              //   ),
              // ),
              // errorBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(13.0.r),
              //   borderSide: BorderSide(
              //     color: Colors.purple,
              //     width: 1.0,
              //   ),
              // ),
              labelStyle: TextStyle(
                  fontSize: hintSize.sp,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  color: enableField ? myBlue : hintColor),
              fillColor: myWhite,
              filled: true),
          onTap: onTap,
          // width: width.w,
          validator: validator),
    );
  }
}
