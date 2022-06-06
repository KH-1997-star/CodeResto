import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceTagWidget extends StatelessWidget {
  final dynamic pourcentage;
  final String? imageAbo;
  const PriceTagWidget({Key? key, this.pourcentage, required this.imageAbo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 55.w,
              ),
              SizedBox(
                height: 45.h,
                width: 45.w,
                child: Stack(
                  children: [
                    /*    Container(
                      color: Colors.red,
                      height: 45.h,
                      width: 45.w,
                    ), */
                    Image.network(
                      imageAbo!,
                      height: 45.w,
                      width: 45.w,
                      cacheHeight: 50,
                      cacheWidth: 50,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.scaleDown,
                    ),
                    /*   Align(
                      alignment: Alignment.topRight,
                      child: Stack(
                        children: [
                          Text(
                            '$pourcentage',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: semiBoldFont,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 4.w
                                ..color = Colors.yellow[600]!,
                            ),
                          ),
                          Text(
                            '$pourcentage',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: semiBoldFont,
                              /*   foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 0.5.w
                                  ..color = Colors.yellow, */
                            ),
                          ),
                        ],
                      ),
                    ), */
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
