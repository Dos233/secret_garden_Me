import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'package:secretgender/orderscreen.dart';

class PaymentScreen extends StatefulWidget {
  final User user;
  final String orderid, val,email;
  PaymentScreen({this.user,this.email,this.orderid, this.val});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final User user;
  final String orderid, val,email;
  _PaymentScreenState({this.user,this.email,this.orderid,this.val}) : super();
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.black
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('PAYMENT'),
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
              Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (BuildContext context)=>OrderScreen(user:user, email: email,))
              );
            }),

            // backgroundColor: Colors.deepOrange,
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: WebView(
                  initialUrl:
                  'http://lossyhome.xyz/payment.php?email=' +
                      widget.email +
                      '&mobile=' +
                      widget.user.phone +
                      '&name=' +
                      widget.user.name +
                      '&amount=' +
                      widget.val +
                      '&orderid=' +
                      widget.orderid,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                ),
              )
            ],
          )),
    );
  }
}