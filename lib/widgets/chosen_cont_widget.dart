import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseModeWidget extends StatefulWidget {
  final String title;
  final String imgPath;
  final bool isChosed;
  final Function() onChoose;
  const ChooseModeWidget({
    Key? key,
    required this.title,
    required this.imgPath,
    required this.isChosed,
    required this.onChoose,
  }) : super(key: key);

  @override
  State<ChooseModeWidget> createState() => _ChooseModeWidgetState();
}

class _ChooseModeWidgetState extends State<ChooseModeWidget> {
  bool clicked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clicked = widget.isChosed;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.onChoose();
          clicked = widget.isChosed;
          iPrint(widget.isChosed);
        });
      },
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            height: 87.h,
            width: 131.w,
            decoration: BoxDecoration(
              color: myWhite,
              boxShadow: [
                widget.isChosed
                    ? BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 20,
                        offset:
                            const Offset(2, 5), // changes position of shadow
                      )
                    : const BoxShadow(),
              ],
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: widget.isChosed ? myBlue : const Color(0xffDFDFDF),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.imgPath.contains('.svg')
                    ? SvgPicture.asset(
                        widget.imgPath,
                        height: 26.48.h,
                        width: 26.48.w,
                      )
                    : Image.asset(
                        widget.imgPath,
                        height: 36.48.h,
                        width: 30.48.w,
                      ),
                SizedBox(
                  height: 10.5.h,
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          widget.isChosed
              ? Positioned(
                  right: 14.w,
                  top: 10.h,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 1000),
                    alignment: Alignment.center,
                    height: widget.isChosed ? 18.w : 0,
                    width: widget.isChosed ? 18.w : 0,
                    child: Icon(
                      Icons.done,
                      size: 18.w,
                      color: myWhite,
                    ),
                    decoration: const BoxDecoration(
                      color: myBlue,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
