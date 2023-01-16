import 'package:flutter/material.dart';

/*
 * themes defined for Test, thus defining each color, letter in the entire system
 * @author  SGV - 20230112
 * @version 1.0 - 20230112 - initial release
 */
class TestStyle {
  final ThemeData theme = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: Colors.white,
    //primaryColor: Color(0xff313031),
    primaryColorDark: Colors.black,
    // shadowColor: colors.aiAqua,
    //accentColor: Colors.grey,
    colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.white),
    errorColor: Colors.red[500],
    backgroundColor: Colors.white,
    cardColor: Color(0xfff0f0f0),
    canvasColor: Colors.white,
    //buttonColor: Colors.black38,
    dividerColor: Colors.black12,
    disabledColor: Colors.grey,

    iconTheme: IconThemeData(color: Colors.black38),
    textTheme:  const TextTheme(
      // headline1: TextStyle(color: Colors.white),
      headline1: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w300, fontSize: 20),
      headline2: TextStyle(
          color: Colors.black38, fontWeight: FontWeight.w300, fontSize: 36),
      headline3: TextStyle(
          color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 24),
      headline4: TextStyle(
          color: Colors.black38, fontWeight: FontWeight.w300, fontSize: 24),
      headline5: TextStyle(
          color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 20),
      headline6: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w300, fontSize: 20),
      subtitle1: TextStyle( color: Colors.white, fontWeight: FontWeight.w300, fontSize: 18),
      subtitle2: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 18),
      bodyText1: TextStyle( color: Colors.black, fontWeight: FontWeight.w300, fontSize: 15),
      bodyText2: TextStyle(
          color: Colors.black45, fontWeight: FontWeight.w300, fontSize: 15),
      caption: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w300, fontSize: 13),

      button: TextStyle(color: Colors.black, fontSize: 18),
      overline: TextStyle(
          color: Color(0xff1CADB1),
          fontWeight: FontWeight.bold,
          fontSize: 15,
          letterSpacing: 1),
    ),
  );
}

class CustomColors {
  final Color aiAqua =const Color(0xff009ebe);
  final Color frontColor = Colors.white;
  final Color backgroundColor = Colors.grey;
  final Color errorColor = Colors.red;
  final Color action =  Colors.green;
}

class _TextTheme {
  final TextStyle cardsText = const TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
      fontSize: 50,
      letterSpacing: 1);
}
