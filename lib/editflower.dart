import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:secretgender/mainscreen.dart';
import 'package:secretgender/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:secretgender/searchflower.dart';
import 'package:toast/toast.dart';

class EditScreen extends StatefulWidget {
  EditScreen({Key key,this.flowerdata,this.email}) : super(key: key);
  List flowerdata;
  String email;

  @override
  _EditScreenState createState() {
    return _EditScreenState(flowerdata: flowerdata,email: email);
  }
}

class _EditScreenState extends State<EditScreen> {
  _EditScreenState({Key key,this.flowerdata,this.email}) : super();
  List flowerdata;
  String email;

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
                    showSearch(context:context,delegate: EdittBarDelegate(flowerdata: flowerdata));
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
                      MaterialPageRoute(builder: (BuildContext)=>MainScreen(email: email,))
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
                  Navigator.push(
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
class EdittBarDelegate extends SearchDelegate<String>{
  EdittBarDelegate({Key key,this.flowerdata}) : super();
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
                  GestureDetector(
                    child: Container(
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
                    onTap: (){
                      showDialog(context: context,builder: (_)=>FlowerInfoDialog(flowerdata:flowerdata,list_num: i,));},
                  ),
                  
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
class FlowerInfoDialog extends AlertDialog{
  FlowerInfoDialog({Key key, this.flowerdata,this.list_num}) : super(key: key);
  List flowerdata;
  int list_num;
  Widget get content => DialogContent(flowerdata:flowerdata,list_num: list_num,);
}
class DialogContent extends StatefulWidget {
  DialogContent({Key key, this.flowerdata,this.list_num}) : super(key: key);
  List flowerdata;
  int list_num;
  @override
  _DialogContentState createState() {
    return _DialogContentState(flowerdata: flowerdata,list_num: list_num);
  }
}

class _DialogContentState extends State<DialogContent> {
  _DialogContentState({Key key, this.flowerdata,this.list_num}) : super();
  TextEditingController _durationController=new TextEditingController();
  TextEditingController _charactersController=new TextEditingController();
  TextEditingController _positionController=new TextEditingController();
  TextEditingController _descriptionController=new TextEditingController();
  double screenHeight, screenWidth;
  List flowerdata;
  int list_num;

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
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child:ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: screenWidth/6,
                        ),
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
                                        "http://lossyhome.xyz/flowerimage/${flowerdata[list_num]['ID']}.jpg")))),
                        TextField(
                            controller: _durationController,
                            decoration: InputDecoration(
                              labelText: 'Flower Duration',
                              icon: Icon(Icons.library_add),
                            )),
                        TextField(
                            controller: _charactersController,
                            decoration: InputDecoration(
                              labelText: 'Characters',
                              icon: Icon(Icons.label),
                            )),
                        TextField(
                            controller: _positionController,
                            decoration: InputDecoration(
                              labelText: 'Position',
                              icon: Icon(Icons.place),
                            )),
                        TextField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              icon: Icon(Icons.description),
                            )),
                        FlatButton(onPressed: (){
                          _editNewFlower();
                        }, child: Text("Upload All")),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );

  }

  void _editNewFlower(){
    String temp=flowerdata[flowerdata.length-1]['ID'];
    int temp_1=int.parse(temp)+1;
    print(temp_1);
    http.post("http://lossyhome.xyz/flowerimage/update_flower.php", body: {
      "name": flowerdata[list_num]['NAME'],
      "duration": _durationController.text,
      "characters": _charactersController.text,
      "position": _positionController.text,
      "description": _descriptionController.text,
    }).then((res) {
      print(res.body);
      if (res.body.replaceAll('\n', "") == "success") {
        Toast.show("Edit success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pop(false);
      }else{
        Toast.show("Edit failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    });

  }
}