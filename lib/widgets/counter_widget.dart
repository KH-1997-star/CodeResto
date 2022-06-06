import 'package:code_resto/models/box_shadow.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'circle_container_widget.dart';

class CounterWidget extends StatefulWidget {
  final int counter;
  final double height, width;
  final Function(dynamic) onCount;
  final dynamic price;

  const CounterWidget({
    Key? key,
    required this.counter,
    this.price = 0,
    required this.onCount,
    this.height = 23,
    this.width = 18,
  }) : super(key: key);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late int counter;
  late dynamic price;
  @override
  void initState() {
    super.initState();
    counter = widget.counter;
    price = widget.price * counter;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 66.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularContainerWidget(
                  boxShadow: MyBoxShadow(),
                  onTap: () => setState(() {
                    if (counter > 1) {
                      counter -= 1;
                      price -= widget.price;
                      widget.onCount(counter);
                    } else {
                      showToast('vous avez qu\'une seule commande de ce type');
                    }
                  }),
                  height: 23.h,
                  width: 18.w,
                  myWidget: const Center(
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
                Text(
                  '$counter',
                  style: TextStyle(fontSize: 13.sp),
                ),
                CircularContainerWidget(
                  boxShadow: MyBoxShadow(),
                  onTap: () => setState(() {
                    counter += 1;
                    price += widget.price;
                    widget.onCount(counter);
                  }),
                  height: 23.h,
                  width: 18.w,
                  myWidget: const Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Text(
            '€$price',
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xff808080),
            ),
          )),
        ],
      ),
    );
  }
}
