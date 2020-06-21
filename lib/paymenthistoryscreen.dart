import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:secretgender/mainscreen.dart';
import 'user.dart';
import 'package:intl/intl.dart';

class PaymentHistoryScreen extends StatefulWidget {
  final User user;
  final String email;

  const PaymentHistoryScreen({Key key, this.email, this.user}) : super(key: key);

  @override
  _PaymentHistoryScreenState createState() => _PaymentHistoryScreenState(email: email,user: user);
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  _PaymentHistoryScreenState({Key key,this.email,this.user}) : super();
  List _paymentdata;
  final String email;
  final User user;
  String titlecenter = "Loading payment history...";
  final f = new DateFormat('dd-MM-yyyy hh:mm a');
  var parsedDate;
  double screenHeight, screenWidth;

  @override
  void initState() {
    super.initState();
    _loadPaymentHistory();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.black
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Payment History'),
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
            Navigator.pop(
                context,
                MaterialPageRoute(builder: (BuildContext context)=>MainScreen(user:user, email: email,))
            );
          }),
        ),
        body: Center(
          child: Column(children: <Widget>[
            Text(
              "Payment History",
              style: TextStyle(
                  color: Colors.black12, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _paymentdata == null
                ? Flexible(
                child: Container(
                    child: Center(
                        child: Text(
                          titlecenter,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ))))
                : Expanded(
                child: ListView.builder(
                  //Step 6: Count the data
                    itemCount: _paymentdata == null ? 0 : _paymentdata.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                          child: InkWell(
                              onTap: () {},
                              child: Card(
                                color: Colors.white,
                                elevation: 10,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            "No."+
                                                (index + 1).toString(),
                                            style:
                                            TextStyle(color: Colors.black),
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            "RM " +
                                                _paymentdata[index]['total'],
                                            style:
                                            TextStyle(color: Colors.black),
                                          )),
                                      Expanded(
                                          flex: 4,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Order Id: "+
                                                    _paymentdata[index]['orderid'],
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              SizedBox(height: 10,),
                                              Text(
                                                "Bill Id: "+
                                                    _paymentdata[index]['billid'],
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              )));
                    }))
          ]),
        ),
      ),
    );
  }

  Future<void> _loadPaymentHistory() async {
    String urlLoadJobs =
        "http://lossyhome.xyz/load_paymenthistory.php";
    await http
        .post(urlLoadJobs, body: {"email": widget.email}).then((res) {
      print(res.body);
      if (res.body.replaceAll('\n', "") == "nodata") {
        setState(() {
          _paymentdata = null;
          titlecenter = "No Previous Payment";
        });
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          _paymentdata = extractdata["payment"];
          print(_paymentdata);
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}