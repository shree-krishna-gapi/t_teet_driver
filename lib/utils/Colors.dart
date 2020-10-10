import 'package:flutter/material.dart';

class AppColor{
  static const Color colorPrimary = Color(0xFF2BA407);
  static const Color inputFocusColor = Color(0xFF3BFEBB);
  static const Color verylightPrimary = Color(0xFFeffbeb); //0xFFd5efce
  static const Color verylightPrimary1 = Color(0xFFeff8Fc);
  static const Color verylightPrimary2 = Color(0xFFd5efce);
  static const Color splashColorPrimary = Color(0xFF2BA407);
  static const Color onLineColor = Color(0xFF00C853);
  static const Color offLineColor = Color(0xFFDD2C00);
  static const Color greenGrey = Color(0xFF88de71);
  static const Color noticeColor = Color(0xFF1F5DEC);
  static const Color blackBorder = Color(0xFFaaaaaaa);
  static const Color transparent = Colors.transparent;
  static const verylightGradient = LinearGradient(
    colors: <Color>[verylightPrimary, transparent,transparent,transparent,verylightPrimary],
    stops: [0.1, 0.4,0.6,0.1, 0.9],
    begin: Alignment.topCenter,

    end: Alignment.bottomCenter,
  );

  static const primaryGradient = LinearGradient(
    colors: <Color>[Colors.white, colorPrimary],
    stops: [0.1, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const greenGridGradient = LinearGradient(
    colors: <Color>[colorPrimary, greenGrey],
    stops: [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

}
//begin: Alignment.topCenter,
//end: Alignment.center,
//colors: [AppColor.colorPrimary, Colors.white])