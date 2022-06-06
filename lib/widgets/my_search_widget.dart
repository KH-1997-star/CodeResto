import 'package:code_resto/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySearchWidget extends StatefulWidget {
  final Function(String formContent) onChange;
  final Color hintColor, borderColor;
  final String hintTxt;
  final Widget? prefixIcon, sufixIcon;
  final double borderWidth;

  final double borderRadius, height, width, hintFontSize;

  const MySearchWidget({
    Key? key,
    required this.onChange,
    required this.hintTxt,
    this.prefixIcon,
    this.hintColor = myBlack,
    this.borderColor = myBlack,
    this.borderRadius = 19,
    this.height = 54,
    this.width = 332,
    this.hintFontSize = 14,
    this.borderWidth = 2,
    this.sufixIcon,
  }) : super(key: key);

  @override
  State<MySearchWidget> createState() => _MySearchWidgetState();
}

class _MySearchWidgetState extends State<MySearchWidget> {
  Icon passIcon = const Icon(Icons.visibility_off_outlined);
  bool hiden = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => widget.onChange(value),
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: widget.prefixIcon ?? const SizedBox(),
        suffixIcon: widget.sufixIcon ?? const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          borderSide: BorderSide(
            width: 2.w,
            color: Colors.red,
          ),
        ),
        /*  focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          borderSide: BorderSide(
            width: 5.w,
            color: myBlue,
          ),
        ), */
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          borderSide: BorderSide(
            width: widget.borderWidth.w,
            color: myBlack,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(23.w, 20.0.h, 5.0, 1.0),
        hintText: widget.hintTxt,
        hintStyle: TextStyle(
          fontSize: widget.hintFontSize.sp,
          color: widget.hintColor,
        ),
      ),
    );
  }
}
