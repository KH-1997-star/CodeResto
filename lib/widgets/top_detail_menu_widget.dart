import 'package:code_resto/utils/fonts.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopDetailMenuWidget extends StatelessWidget {
  final String title, description, imapgePath;
  final double price;
  final bool? hasOffre;
  final int index;
  final double? offrePrice;
  final String? titreOffre, offre;

  const TopDetailMenuWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.index,
    required this.imapgePath,
    required this.hasOffre,
    this.offrePrice,
    this.titreOffre,
    this.offre,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200.h,
          width: 280.w,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
          child: Hero(
            tag: 'image_pos_kit$index',
            child: imapgePath == 'plateau-repas.png'
                ? Image.asset('images/$imapgePath')
                : Image.network(
                    imapgePath,
                    fit: BoxFit.contain,
                  ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h, left: 24.w, right: 47.w),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: semiBoldFont,
                  ),
                ),
              ),
              hasOffre ?? false
                  ? Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  '$offrePrice/ ',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: semiBoldFont,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  '$price',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: semiBoldFont,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red,
                                    decorationThickness: 3.5,
                                    decorationStyle: TextDecorationStyle.wavy,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text('$offre'),
                          Text('$titreOffre'),
                        ],
                      ),
                    )
                  : Expanded(
                      flex: 0,
                      child: Text(
                        '$price',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: semiBoldFont,
                        ),
                      ),
                    ),
            ],
          ),
        ),
        SizedBox(
          height: 22.h,
        ),
        SizedBox(
          height: 60.h,
          width: getWidth(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 26.w, right: 55.w),
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xffAFAFAF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
