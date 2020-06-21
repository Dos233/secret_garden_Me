import 'dart:async';
import 'dart:convert';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:random_string/random_string.dart';
import 'mainscreen.dart';
import 'payment.dart';
import 'package:intl/intl.dart';
import 'user.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key key,this.user,this.email}) : super(key: key);
  String email;
  final User user;

  @override
  _OrderScreenState createState() {
    return _OrderScreenState(user: user,email: email);
  }
}

class _OrderScreenState extends State<OrderScreen> {
  _OrderScreenState({this.user,this.email}) : super();
  String email;
  final User user;
  String server = "https://slumberjer.com/grocery";
  double screenHeight, screenWidth;
  String label;
  double deliverycharge;
  double amountpayable;
  String titlecenter = "Loading your cart";
  List picked = [false, false];
  int totalAmount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  pickToggle(index) {
    setState(() {
      picked[index] = !picked[index];
      getTotalAmount();
    });
  }

  getTotalAmount() {
    int count=0;
    for (int i = 0; i < picked.length; i++) {
      if (picked[i]) {
        count+=1;
      }
      if (i == picked.length - 1) {
        if (count == 2) {
          setState(() {
            totalAmount = 140;
          });
        }else if (count == 1) {
          if (picked[0]) {
            setState(() {
              totalAmount = 20;
            });
          } else {
            setState(() {
              totalAmount = 120;
            });
          }
        }
        else if(count == 0){
          setState(() {
            totalAmount = 0;
          });
        }
      }
    }
  }
  Future<void> makePayment() async {
    int count=0;
    for (int i = 0; i < picked.length; i++){
      if (picked[i]) {
        count+=1;
      }
      if (i == picked.length - 1) {
        if (count == 2) {
          print("WRONG OPERATION");
          Toast.show("You must choose ether Monthly or Annuel", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }else if (count == 1) {
          if (picked[0]) {
            print("MONTHLY PICKUP");
            Toast.show("Monthly Membership Picked", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          } else {
            print("ANNUEL PICKUP");
            Toast.show("Annuel Membership picked", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
          var now = new DateTime.now();
          var formatter = new DateFormat('ddMMyyyy-');
          String orderid = email.substring(1,4) +
              "-" +
              formatter.format(now) +
              randomAlphaNumeric(6);
          print(orderid);
          await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => PaymentScreen(
              email: email,
              user: user,
              val: totalAmount.toStringAsFixed(2),
              orderid: orderid,
            )));
          //_loadCart();
        }
        else if(count == 0){
          print("NO PICKUP");
          Toast.show("Please select an option at least", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
        body: ListView(shrinkWrap: true, children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Stack(children: [
              Stack(children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                ),
                Container(
                  height: 250.0,
                  width: double.infinity,
                  color: Color(0xFFFDD148),
                ),
                Positioned(
                  bottom: 450.0,
                  right: 100.0,
                  child: Container(
                    height: 400.0,
                    width: 400.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200.0),
                      color: Color(0xFFFEE16D),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 500.0,
                  left: 150.0,
                  child: Container(
                      height: 300.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(150.0),
                          color: Color(0xFFFEE16D).withOpacity(0.5))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: IconButton(
                      alignment: Alignment.topLeft,
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(builder: (BuildContext context)=>MainScreen(email: email,))
                        );
                      }),
                ),
                Positioned(
                    top: 75.0,
                    left: 15.0,
                    child: Text(
                      'Ordering Screen',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    )),
                Positioned(
                  top: 150.0,
                  child: Column(
                    children: <Widget>[
                      itemCard('Monthly Member', 'gray', '20',
                          'assets/images/monthly-member-icon.png', true, 0),
                      itemCard('Annual Member', 'gray', '120',
                          'assets/images/yearmember.png', true, 1),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 600.0, bottom: 15.0),
                    child: Container(
                        height: 50.0,
                        width: double.infinity,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('Total: \RM ' + totalAmount.toString()),
                            SizedBox(width: 10.0),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                onPressed: makePayment,
                                elevation: 0.5,
                                color: Colors.red,
                                child: Center(
                                  child: Text(
                                    'Pay Now',
                                  ),
                                ),
                                textColor: Colors.white,
                              ),
                            )
                          ],
                        )))
              ])
            ])
          ])
        ]),
      );
  }
  Widget itemCard(itemName, color, price, imgPath, available, i) {
    return InkWell(
      onTap: () {
        if (available) {
          pickToggle(i);
        }
      },
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Material(
              borderRadius: BorderRadius.circular(10.0),
              elevation: 3.0,
              child: Container(
                  padding: EdgeInsets.only(left: 15.0, right: 10.0),
                  width: MediaQuery.of(context).size.width - 20.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              height: 25.0,
                              width: 25.0,
                              decoration: BoxDecoration(
                                color: available
                                    ? Colors.grey.withOpacity(0.4)
                                    : Colors.red.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(12.5),
                              ),
                              child: Center(
                                  child: available
                                      ? Container(
                                    height: 12.0,
                                    width: 12.0,
                                    decoration: BoxDecoration(
                                        color: picked[i]
                                            ? Colors.yellow
                                            : Colors.grey
                                            .withOpacity(0.4),
                                        borderRadius:
                                        BorderRadius.circular(6.0)),
                                  )
                                      : Container()))
                        ],
                      ),
                      SizedBox(width: 3.0),
                      Container(
                        height: 120.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                                    imgPath
                                ),
                                fit: BoxFit.contain)),
                      ),
                      SizedBox(width: 4.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                itemName,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              SizedBox(width: 7.0),
                              available
                                  ? picked[i]
                                  ? Text(
                                'x1',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.grey),
                              )
                                  : Container()
                                  : Container()
                            ],
                          ),
                          SizedBox(height: 7.0),
                          available
                              ? Text(
                            '\$' + price,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Color(0xFFFDD34A)),
                          )
                              : Container(),
                        ],
                      )
                    ],
                  )))),
    );
  }
}