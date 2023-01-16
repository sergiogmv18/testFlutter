
import 'package:flutter/material.dart';
import 'package:test/screen/home.dart';
import 'package:test/screen/splash.dart';
import 'package:test/screen/user/login.dart';
import 'screen/contact/insert_contact.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
 '/': (BuildContext context) =>  SplashScreen(),
 '/login' : (BuildContext context) => LoginScreen(data: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?),
 '/home' : (BuildContext context) => HomeScreen(data: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?),
 '/insert/contact' : (BuildContext context) => InsertContactScreen(data: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?),
 
  






  
  
};
