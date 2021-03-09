import 'package:flutter/material.dart';
import 'package:pic2text_app/home.dart';
import 'package:pic2text_app/splash.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      // home: HomePage(),
    );
  }
}
