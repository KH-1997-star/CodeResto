import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/fonts.dart';
import 'package:code_resto/models/box_shadow.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/widgets/my_button_widget.dart';
import 'package:code_resto/widgets/my_form_widget.dart';
import 'package:code_resto/widgets/my_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CodePromoWidget extends StatelessWidget {
  final Function(String) onCodeConfirm;
  const CodePromoWidget({Key? key, required this.onCodeConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String code = '';
    return MyWidgetButton(
      boxShadow: MyBoxShadow(),
      radius: 19,
      color: myWhite,
      height: 50,
      width: 327,
      widget: MySearchWidget(
        borderWidth: 1,
        hintFontSize: 12,
        onChange: (v) {
          code = v;
          iPrint(code);
        },
        hintTxt: 'Promo code',
        hintColor: const Color(0xffCFCFCF),
        borderColor: myTransparent,
        sufixIcon: Padding(
          padding: EdgeInsets.only(right: 35.w),
          child: TextButton(
              onPressed: () {
                iPrint('MyCode: $code');
                onCodeConfirm(code);
              },
              child: Text(
                'Appliquer',
                style: TextStyle(
                  color: myBlack,
                  fontSize: 14.sp,
                  fontWeight: semiBoldFont,
                ),
              )),
        ),
      ),
      onTap: () {},
    );
  }
}
