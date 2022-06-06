import 'package:code_resto/utils/functions.dart';
import 'package:flutter/material.dart';

class FullScreenWidget extends StatelessWidget {
  const FullScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context),
      width: getWidth(context),
    );
  }
}
