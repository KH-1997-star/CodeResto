import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigBar extends StatelessWidget {
  final int pageIndex, panierCounter;

  const BottomNavigBar(
      {Key? key, required this.pageIndex, this.panierCounter = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      width: 353.w,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
              child: InkWell(
            onTap: () {
              if (pageIndex != 0) {
                Navigator.pushNamed(context, '/home_screen');
              }
            },
            child: Container(
              height: 35.h,
              width: 35.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: pageIndex == 0 ? const Color(0x80707070) : myTransparent,
              ),
              child: SvgPicture.asset(
                'icons/home_icon.svg',
                height: 19.h,
                width: 19.w,
                fit: BoxFit.scaleDown,
              ),
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              if (pageIndex != 1) {
                Navigator.pushNamed(context, '/favoris_screen');
              }
            },
            child: Container(
              height: 35.h,
              width: 35.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: pageIndex == 1 ? const Color(0x80707070) : myTransparent,
              ),
              child: SvgPicture.asset(
                'icons/heart_icon.svg',
                height: 19.h,
                width: 19.w,
                fit: BoxFit.scaleDown,
              ),
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              if (pageIndex != 2) {
                Navigator.pushNamed(context, '/panier_screen');
              }
            },
            child: Container(
              height: 35.h,
              width: 35.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: pageIndex == 2 ? const Color(0x80707070) : myTransparent,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    right: 15.w,
                    top: -0.1.h,
                    child: Container(
                      alignment: Alignment.center,
                      height: 13.w,
                      width: 13.w,
                      child: Text(
                        '$panierCounter',
                        style: TextStyle(
                            fontSize: 10.sp, fontWeight: semiBoldFont),
                      ),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: myWhite,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'icons/chario_icon.svg',
                    height: 19.h,
                    width: 19.w,
                    fit: BoxFit.scaleDown,
                  ),
                ],
              ),
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              if (pageIndex != 3) {
                Navigator.pushNamed(context, '/code_qr_screen');
              }
            },
            child: Container(
              height: 35.h,
              width: 35.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: pageIndex == 3 ? const Color(0x80707070) : myTransparent,
              ),
              child: SvgPicture.asset(
                'icons/notif_icon.svg',
                height: 19.h,
                width: 19.w,
                fit: BoxFit.scaleDown,
              ),
            ),
          )),
          Expanded(
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, '/profile_screen'),
              child: Container(
                height: 35.h,
                width: 35.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      pageIndex == 4 ? const Color(0x80707070) : myTransparent,
                ),
                child: SvgPicture.asset(
                  'icons/profile_icon.svg',
                  height: 19.h,
                  width: 19.w,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
