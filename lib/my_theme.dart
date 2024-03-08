
import 'package:flutter/material.dart';

class MyTheme {

  static Color primaryColor = Color(0xff5D9CEC);
  static Color greenColor = Color(0xff61E757);
  static Color whiteColor = Color(0xffffffff);
  static Color redColor = Color(0xffEC4B4B);
  static Color blackColor = Color(0xff383838);
  static Color backGroundLightColor = Color(0xffDFECDB);
  static Color backGroundDarkColor = Color(0xff060E1E);
  static Color blackDarkColor = Color(0xff141922);
  static Color greyColor = Color(0xffC8C9CB);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor ,
    backgroundColor: whiteColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor ,
      elevation: 0 ,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 26 , fontWeight: FontWeight.bold , color: whiteColor),
      titleMedium: TextStyle(fontSize: 22 , fontWeight: FontWeight.bold , color: blackColor),
      titleSmall: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold , color: blackColor),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: greyColor,
      backgroundColor: Colors.transparent,
      elevation: 0 ,

    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(
          color: primaryColor ,
          width: 4,
        )
      )
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,

      shape: StadiumBorder(
          side: BorderSide(width: 3 , color: Colors.white))
    ),


  );

}