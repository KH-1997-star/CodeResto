import 'package:code_resto/utils/colors.dart';
import 'package:flutter/material.dart';

ThemeData myThemeData = ThemeData(
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: Colors.blue,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: myBlack,
      fontSize: 20,
    ),
    elevation: 0,
    backgroundColor: myWhite,
  ),
);
