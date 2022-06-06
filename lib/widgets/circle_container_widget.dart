import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/models/box_shadow.dart';
import 'package:flutter/material.dart';

class CircularContainerWidget extends StatelessWidget {
  final double height, width;
  final Widget myWidget;
  final Color color;
  final bool isShadow;
  final VoidCallback onTap;
  final MyBoxShadow boxShadow;
  CircularContainerWidget({
    Key? key,
    this.isShadow = false,
    this.height = 50,
    this.width = 50,
    this.myWidget = const SizedBox(),
    this.color = myBlack,
    required this.boxShadow,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: isShadow
                  ? boxShadow.color.withOpacity(
                      boxShadow.opacity,
                    )
                  : myTransparent,
              blurRadius: boxShadow.blurRadius,

              offset: Offset(boxShadow.x, boxShadow.y), // Shadow position
            )
          ],
        ),
        child: myWidget,
      ),
    );
  }
}
