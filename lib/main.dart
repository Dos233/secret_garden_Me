import 'package:flutter/material.dart';
import 'package:secretgender/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();    
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SplashScreen();

  }
}
