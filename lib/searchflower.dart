import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:secretgender/mainscreen.dart';
import 'package:secretgender/loginscreen.dart';
import 'package:secretgender/editflower.dart';
import 'user.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key,this.flowerdata,this.email,this.user}) : super(key: key);
  List flowerdata;
  String email;
  final User user;

  @override
  _SearchScreenState createState() {
    return _SearchScreenState(flowerdata: flowerdata,email: email,user: user);
  }
}

class _SearchScreenState extends State<SearchScreen> {
  _SearchScreenState({Key key,this.flowerdata,this.email,this.user}) : super();
  List flowerdata;
  String email;
  final User user;

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.black
      ),
      home: Scaffold(
          appBar:AppBar(
              actions:<Widget>[
                IconButton(
                    icon:Icon(Icons.search),
                    onPressed: (){
                      showSearch(context:context,delegate: searchBarDelegate(flowerdata: flowerdata));
                    }
                ),
              ]
          ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child:UserAccountsDrawerHeader(
                        accountEmail: Text(
                          email,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQbqzB7ad7DCIvbeOn95QQIwF1aknvNaPjP19lj4w0VJ5ovzHTT&usqp=CAU"),
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage("http://lossyhome.xyz/flowerimage/rose.jpg"),
                                fit: BoxFit.cover
                            )
                        ),
                      )
                  )
                ],
              ),
              Divider(),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.view_array),
                ),
                title: Text("View All Flowers"),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext)=>MainScreen(email: email,user: user,))
                  );
                },
              ),
              Divider(),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.search),
                ),
                title: Text("Search Flower"),
                onTap: (){
                  print(flowerdata.length);
                  Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (BuildContext)=>SearchScreen(flowerdata: flowerdata,email: email,))
                  );
                },
              ),
              Divider(),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.add),
                ),
                title: Text("Edit Flower Info"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>EditScreen(flowerdata: flowerdata,email: email,)));
                },
              ),
              Divider(),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.exit_to_app),
                ),
                title: Text("Exit"),
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (context) => new AlertDialog(
                      title: new Text('Are you sure?'),
                      content: new Text('Do you want to exit to login panel'),
                      actions: <Widget>[
                        MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (BuildContext context)=>LoginScreen())
                              );
                            },
                            child: Text("Exit")),
                        MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text("Cancel")),
                      ],
                    ),
                  );
                },
              ),
              Divider(),

            ],
          ),
        ),
      ),
      );
  }
}
class searchBarDelegate extends SearchDelegate<String>{
  searchBarDelegate({Key key,this.flowerdata}) : super();
  List flowerdata;
  double screenHeight, screenWidth;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: ()=>query="",

      )
    ];
  }
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: ()=>close(context, null),
    );
  }
  @override
  Widget buildResults(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
      for(int i=0;i<flowerdata.length;i++){
        if (flowerdata[i]['NAME']==query) {
          return Container(
            height: screenWidth/1.5,
            width: screenWidth/2,
            child: Card(
              color: Colors.brown,
              elevation: 10,
              child: Padding(
                padding:EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: screenWidth / 4,
                        width: screenWidth / 4,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                            Border.all(color: Colors.black),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    "http://lossyhome.xyz/flowerimage/${flowerdata[i]['ID']}.jpg")))),
                    Text(flowerdata[i]['NAME'],
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Text(
                      "Duration " + flowerdata[i]['DURATION'],
                      style:
                      TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text("Characters: " +
                        flowerdata[i]['CHARACTERS'],
                      style:
                      TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text("Position: " +
                        flowerdata[i]['POSITION'],
                      style:
                      TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        }else if (i==flowerdata.length-1&&flowerdata[i]['NAME']!=query) {
          break;
        }
      }
    return Container(
    );
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: flowerdata.length,
      itemBuilder: (context,index) => ListTile(

      ),
    );
  }
}