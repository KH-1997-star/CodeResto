import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/models/box_shadow.dart';
import 'package:code_resto/widgets/my_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailPaymentWidget extends StatelessWidget {
  final String somme, livraison, total;
  const DetailPaymentWidget(
      {Key? key,
      required this.somme,
      required this.livraison,
      required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyWidgetButton(
        boxShadow: MyBoxShadow(),
        color: myWhite,
        radius: 15,
        height: 126,
        width: 327,
        widget: Padding(
          padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Somme Totale',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    Text(
                      '$somme€',
                      style: TextStyle(fontSize: 14.sp),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Livraison',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    Text(
                      '$livraison€',
                      style: TextStyle(fontSize: 14.sp),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Totale',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    Text(
                      '$total€',
                      style: TextStyle(fontSize: 14.sp),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {});
  }
}
