import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBoxShadow {
  final double x, y, blurRadius, opacity, spreadRadius;
  final Color color;
  MyBoxShadow({
    this.opacity = 0.5,
    this.spreadRadius = 8,
    this.x = 0,
    this.y = 3,
    this.blurRadius = 7,
    this.color = const Color(0xff9e9e9e),
  });
  get getOpacity => opacity;
  get getSpreadRadius => spreadRadius;
  get getXshadow => x;
  get getYshadow => y;
  get getColorShadow => color;
}
