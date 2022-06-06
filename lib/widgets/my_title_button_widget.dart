// ignore_for_file: use_key_in_widget_constructors

import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/fonts.dart';
import 'package:code_resto/models/box_shadow.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTitleButton extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final Color titleColor;
  final Color color;
  final bool border, isShadow;
  final MyBoxShadow boxShadow;
  final Color bordorColor;
  final VoidCallback onTap;
  final double borderRadius, borderWidth, fontSize;
  final FontWeight fontWeight;

  const MyTitleButton({
    this.color = myBlack,
    this.height = 50,
    this.width = 303,
    this.title = '',
    this.border = false,
    this.bordorColor = myBlack,
    this.titleColor = Colors.white,
    required this.onTap,
    this.borderRadius = 13,
    this.borderWidth = 1,
    this.fontSize = 15,
    this.fontWeight = semiBoldFont,
    this.isShadow = false,
    required this.boxShadow,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        alignment: Alignment.center,
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: isShadow
                  ? boxShadow.color.withOpacity(
                      boxShadow.opacity,
                    )
                  : myTransparent,
              blurRadius: boxShadow.blurRadius,

              offset: Offset(boxShadow.x, boxShadow.y), // Shadow position
            )
          ],
          color: color,
          borderRadius: BorderRadius.circular(borderRadius.r),
          border: border
              ? Border.all(
                  color: bordorColor,
                  width: borderWidth.w,
                )
              : Border.all(
                  width: 0,
                  color: Colors.transparent,
                ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            child: Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontWeight: fontWeight,
                fontSize: fontSize.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
