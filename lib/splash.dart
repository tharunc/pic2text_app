import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: HomePage(),

      title: Text('Pic2Text',
      style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
      
      image: Image.asset('assets/splash.png'),
      backgroundColor: Color(0xFFFFFFFF),
      photoSize: 250.0,
      loadingText:  Text("DON'T PANIC",
      style: GoogleFonts.biryani(),),
      loaderColor: Color(0xFFDBE3E9),

    );
    
  }
}
