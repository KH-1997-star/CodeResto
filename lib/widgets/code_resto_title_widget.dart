import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CodeRestoTitleWidget extends StatelessWidget {
  final double fontSize;
  const CodeRestoTitleWidget({
    Key? key,
    this.fontSize = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CODE',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            height: 1.1,
            fontSize: fontSize.sp,
            fontWeight: extraBoldFont,
          ),
        ),
        Text(
          'RESTO',
          style: TextStyle(
            height: 1.1,
            fontSize: fontSize.sp,
            fontWeight: extraBoldFont,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.5.w
              ..color = Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
