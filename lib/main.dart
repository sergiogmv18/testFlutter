
import 'package:flutter/material.dart';
import 'package:test/routes.dart';

void main() {
  runApp(const Test());
}

 class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      routes: routes, 
      debugShowCheckedModeBanner: false,
    );
  }
}
