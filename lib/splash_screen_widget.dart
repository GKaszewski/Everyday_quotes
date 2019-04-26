import 'package:flutter/material.dart';
import 'package:everyday_quotes/home.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new SplashScreenWidgetState();
  }

}

class SplashScreenWidgetState extends State<SplashScreenWidget>{
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 2,
      navigateAfterSeconds: new HomeScreen(),
      image: Image.asset('Quotes_logo.png'),
    );
  }

}