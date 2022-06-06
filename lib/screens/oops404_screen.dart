import 'package:code_resto/models/box_shadow.dart';
import 'package:code_resto/utils/fonts.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/widgets/full_screen_widget.dart';
import 'package:code_resto/widgets/my_title_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Oops404Screen extends StatelessWidget {
  const Oops404Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/');
        return false;
      },
      child: Scaffold(
        body: SizedBox(
          height: getHeight(context),
          width: getWidth(context),
          child: Stack(
            children: [
              const FullScreenWidget(),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 180.h),
                  child: SizedBox(
                    height: 455.h,
                    //color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'images/oops.png',
                          cacheHeight: 150,
                          cacheWidth: 150,
                          height: 150.h,
                          width: 150.w,
                        ),
                        Column(
                          children: [
                            Text(
                              'Page Introuvable',
                              style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight: semiBoldFont,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'page introuvable quelque chose s\'est mal passé, veuillez réessayer',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 70.h),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MyTitleButton(
                    onTap: () => Navigator.pushNamed(context, '/'),
                    boxShadow: MyBoxShadow(),
                    title: 'Retour',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
