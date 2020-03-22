import 'package:flutter/material.dart';
import 'package:secretgender/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.brown,
      ),
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Colors.black26,
          body: Container(
            child: Stack(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/splash.jpg'),
                            fit: BoxFit.cover))),
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 230,
                        ),
                        Text(
                        "Secret Garden",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 50,
                              color: Colors.pinkAccent
                          ),
                        ),
                        Text(
                          "Welcome To\n a Secret Base !",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: Colors.pinkAccent
                          ),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                  ),
                Container(height: 300, child: ProgressIndicator())
              ],
            ),
          )),
    );;
  }
}
class ProgressIndicator extends StatefulWidget {
  @override
  _ProgressIndicatorState createState() => new _ProgressIndicatorState();
}


class _ProgressIndicatorState extends State<ProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          //updating states
          if (animation.value > 0.99) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()));
          }
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
          //width: 300,
          child: CircularProgressIndicator(
            value: animation.value,
            //backgroundColor: Colors.brown,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ));
  }
}


