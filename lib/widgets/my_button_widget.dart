import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/models/box_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyWidgetButton extends StatelessWidget {
  final double height;
  final double width;
  final Widget widget;
  final double radius;

  final Color color;
  final MyBoxShadow boxShadow;
  final double borderWidth;
  final bool isBordred, isShadow;
  final VoidCallback onTap;
  final Color borderColor;
  final AlignmentGeometry? alignment;
  const MyWidgetButton({
    this.height = 40,
    this.width = 40,
    this.radius = 15,
    this.borderColor = myBlue,
    this.isBordred = false,
    this.borderWidth = 1,
    required this.widget,
    this.color = myBlue,
    required this.onTap,
    key,
    this.alignment,
    required this.boxShadow,
    this.isShadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        alignment: alignment,
        height: height.h,
        width: width.w,
        child: widget,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius.r),
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
          border: isBordred
              ? Border.all(
                  color: borderColor,
                  width: borderWidth,
                )
              : null,
        ),
      ),
    );
  }
}
