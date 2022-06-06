import 'package:code_resto/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PaymentOptionWidget extends StatefulWidget {
  final String optionStr;
  final dynamic price;
  final VoidCallback onChoice;
  final bool taped;
  const PaymentOptionWidget(
      {required this.optionStr,
      required this.price,
      required this.onChoice,
      required this.taped});
  @override
  _PaymentOptionWidgetState createState() => _PaymentOptionWidgetState();
}

class _PaymentOptionWidgetState extends State<PaymentOptionWidget> {
  Widget? mywidget;
  bool tapped = false;

  @override
  void initState() {
    super.initState();
    mywidget = WhiteCircularContainerWidget();
  }

  @override
  Widget build(BuildContext context) {
    String strPrice = widget.price.toString();
    if (widget.taped) {
      setState(() {
        mywidget = PurpleCircularContainerWidget();
      });
    } else {
      setState(() {
        mywidget = WhiteCircularContainerWidget();
      });
    }
    if (strPrice.endsWith('.0')) {
      strPrice = strPrice.split('.')[0];
    }
    return InkWell(
      onTap: () {
        setState(() {
          widget.onChoice();
        });
      },
      child: Container(
        height: 67.h,
        decoration: BoxDecoration(
          color: !widget.taped ? Colors.transparent : Colors.grey[200],
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(
              color: !widget.taped ? Color(0xffDBDBDB) : myBlack, width: 2),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: 29.h,
                  width: 29.w,
                  child: Icon(Icons.card_membership_rounded),
                ),
              ),
              Flexible(
                flex: 4,
                child: Text(
                  widget.optionStr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'MonteBold',
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: strPrice == '0'
                    ? Text(
                        '    $strPrice€/Mois',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'SemiBold',
                        ),
                      )
                    : Text(
                        '$strPrice€/Mois',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'SemiBold',
                        ),
                      ),
              ),
              Flexible(
                flex: 1,
                child: Stack(
                  children: [
                    Container(
                      height: 25.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xffDBDBDB), width: 3),
                      ),
                    ),
                    Positioned(
                      top: 5.5.h,
                      left: 5.5.w,
                      child: AnimatedSwitcher(
                        duration: Duration(
                          milliseconds: 700,
                        ),
                        child: mywidget,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WhiteCircularContainerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('1'),
      height: 14.h,
      width: 14.w,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}

class PurpleCircularContainerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('2'),
      height: 14.h,
      width: 14.w,
      decoration: BoxDecoration(
        color: Colors.blue[300],
        shape: BoxShape.circle,
      ),
    );
  }
}

class ArrowFrowardWidget extends StatelessWidget {
  final Color myColor;
  ArrowFrowardWidget({required this.myColor});
  @override
  Widget build(BuildContext context) {
    return Align(
      key: const Key('1'),
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(bottom: 37.h),
        child: Container(
          width: 102.w,
          height: 60.h,
          child: Icon(
            Icons.arrow_forward,
            size: 40,
            color: Colors.black,
          ),
          decoration: BoxDecoration(
              color: myColor,
              border: Border.all(),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10))),
        ),
      ),
    );
  }
}

class AleatoirTxtContainer extends StatelessWidget {
  final String txt;
  AleatoirTxtContainer({
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: Icon(
            Icons.done,
            color: myBlack,
          ),
        ),
        Expanded(
          flex: 4,
          child: SizedBox(
            width: 300.w,
            child: Text(
              txt,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'MonteRegular',
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
