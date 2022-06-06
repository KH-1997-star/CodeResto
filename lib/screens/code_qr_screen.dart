import 'package:code_resto/utils/fonts.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/widgets/bottom_navig_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CodeQrScreen extends StatelessWidget {
  const CodeQrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: getHeight(context),
            width: getWidth(context),
            child: Column(
              children: [
                SizedBox(
                  height: 121.h,
                ),
                Text(
                  'Merci Pour Votre Commande',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: semiBoldFont,
                  ),
                ),
                SizedBox(
                  height: 147.h,
                ),
                Image.asset(
                  'images/scanner_image_del.png',
                  height: 194.w,
                  width: 194.w,
                ),
                Text(
                  'Met ce code sous le scanner',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: semiBoldFont,
                  ),
                ),
                SizedBox(
                  height: 131.h,
                ),
                Text(
                  'Commande #2007',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: semiBoldFont,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 34.h),
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavigBar(
                pageIndex: 3,
              ),
            ),
          )
        ],
      ),
    );
  }
}
