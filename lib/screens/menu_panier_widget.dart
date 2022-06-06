import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/widgets/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PanierMenuWidget extends StatefulWidget {
  final String title, description;
  final dynamic price;
  final int counter, index;
  final bool inDissmissing;
  final Object imagePath;
  final Function(int) onCount;
  final VoidCallback onTap;

  const PanierMenuWidget({
    Key? key,
    required this.title,
    this.inDissmissing = false,
    required this.imagePath,
    required this.price,
    required this.counter,
    required this.description,
    required this.onCount,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  @override
  State<PanierMenuWidget> createState() => _PanierMenuWidgetState();
}

class _PanierMenuWidgetState extends State<PanierMenuWidget> {
  dynamic myPrice;
  late int counter;
  @override
  void initState() {
    super.initState();
    myPrice = widget.price;
    counter = widget.counter;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.inDissmissing ? myWhite : myTransparent,
          borderRadius: BorderRadius.circular(13.r),
          boxShadow: [
            BoxShadow(
              color: widget.inDissmissing
                  ? const Color(0xff959595).withOpacity(0.35)
                  : myTransparent,
              blurRadius: 17,

              offset: const Offset(8, 10), // Shadow position
            )
          ],
        ),
        height: 100.h,
        width: getWidth(context),
        child: ListTile(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ),
              // Expanded(
              //   child: Text(
              //     '€${widget.price}',
              //     style: TextStyle(fontSize: 15.sp, color: myBlack),
              //   ),
              // ),
            ],
          ),
          subtitle: Text(
            widget.description,
            style: TextStyle(
              fontSize: 11.sp,
              color: const Color(0xff808080),
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 3,
          ),
          leading: Hero(
            tag: 'image_pos_kit${widget.index}',
            child: Container(
              height: 78.h,
              width: 79.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: widget.imagePath as ImageProvider,
                  fit: BoxFit.contain,
                ),
              ),
              //child: widget.imagePath,
            ),
          ),
          trailing: SizedBox(
            height: 50.h,
            width: 66.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: CounterWidget(
                  counter: counter,
                  onCount: (p) {
                    widget.onCount(p);
                  },
                  price: widget.price,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
