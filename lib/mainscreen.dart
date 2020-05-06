import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:secretgender/editflower.dart';
import 'package:secretgender/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:secretgender/searchflower.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.email}) : super(key: key);
  final String email;

  @override
  _MainScreenState createState() {
    return _MainScreenState(email: email);
  }
}

class _MainScreenState extends State<MainScreen> {
  _MainScreenState({Key key, this.email}) : super();
  List flowerdata;
  final String email;
  double screenHeight, screenWidth;
  TextEditingController _idController=new TextEditingController();
  TextEditingController _nameController=new TextEditingController();
  TextEditingController _durationController=new TextEditingController();
  TextEditingController _charactersController=new TextEditingController();
  TextEditingController _positionController=new TextEditingController();
  TextEditingController _descriptionController=new TextEditingController();

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }



  void _loadData() {
    String urlLoadJobs = "http://lossyhome.xyz/load_flowers.php";
    http.post(urlLoadJobs, body: {}).then((res) {
      setState(() {
        var extractdata = json.decode(res.body);
        flowerdata = extractdata["flowers"];
        flowerdata.length;
      });
    }).catchError((err) {
      print(err);
    });
  }
  _onImageDisplay(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content: new Container(
              height: screenHeight / 2.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: screenWidth / 1.7,
                      width: screenWidth / 1.5,
                      decoration: BoxDecoration(
                        //border: Border.all(color: Colors.black),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  "http://lossyhome.xyz/flowerimage/${flowerdata[index]['ID']}.jpg")))),
                ],
              ),
            ));
      },
    );
  }



  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _flowerController=new TextEditingController();
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    if (flowerdata == null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.black
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Flower List'),
            ),
            body: Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Loading Flowers",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ))),
      );
    }  else{
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.black
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Secret Garden"),
          ),
          floatingActionButton: SpeedDial(
            backgroundColor: Colors.brown,
            animatedIcon: AnimatedIcons.close_menu,
            children: [
              SpeedDialChild(
                child: Icon(Icons.camera),
                label: "Take A Picture",
                labelStyle: TextStyle(
                  fontSize: 17,
                ),
                onTap: (){
                  getImage();
                }
              ),
              SpeedDialChild(
                child: Icon(Icons.add_to_queue),
                label: "Add New Flower",
                  labelStyle: TextStyle(
                      fontSize: 17,
                  ),
                onTap: (){
                  showDialog(context: context,builder: (_)=>FlowerInfoDialog(flowerdata:flowerdata));
                }
              )
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Flexible(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                  children: List.generate(flowerdata.length, (index){
                    return Card(
                      color: Colors.brown,
                      elevation: 10,
                      child: Padding(
                        padding:EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => _onImageDisplay(index),
                              child: Container(
                                  height: screenWidth / 4.5,
                                  width: screenWidth / 4.5,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                      Border.all(color: Colors.black),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              "http://lossyhome.xyz/flowerimage/${flowerdata[index]['ID']}.jpg")))),
                            ),
                            Text(flowerdata[index]['NAME'],
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                            Text(
                              "Duration " + flowerdata[index]['DURATION'],
                              style:
                              TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text("Characters: " +
                                flowerdata[index]['CHARACTERS'],
                              style:
                              TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text("Position: " +
                                flowerdata[index]['POSITION'],
                              style:
                              TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                minWidth: 100,
                                height: 50,
                                child: Text('Delete it'),
                                color: Colors.green,
                                textColor: Colors.white,
                                elevation: 10,
                                onPressed: () {
                                  print(_nameController.text);
                                  http.post("http://lossyhome.xyz/flowerimage/delete_flower.php", body: {
                                    "name": flowerdata[index]['NAME'],
                                  }).then((res) {
                                    setState(() {
                                      _loadData();
                                    });
                                    print(res.body);
                                  });
                                }
                            ),
                            /*_image == null
                            ? Text("no image selected")
                            : Image.file(
                          _image,
                          fit: BoxFit.cover,
                        ),*/
                          ],
                        ),
                      ),
                    );
                  }),
                  padding: EdgeInsets.all(10),
                ),
              )

            ],
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
                        MaterialPageRoute(builder: (BuildContext)=>MainScreen(email: email))
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
}
class FlowerInfoDialog extends AlertDialog{
  FlowerInfoDialog({Key key, this.flowerdata}) : super(key: key);
  List flowerdata;
  Widget get content => DialogContent(flowerdata:flowerdata);
}
class DialogContent extends StatefulWidget {
  DialogContent({Key key, this.flowerdata}) : super(key: key);
  List flowerdata;
  @override
  _DialogContentState createState() {
    return _DialogContentState(flowerdata: flowerdata);
  }
}

class _DialogContentState extends State<DialogContent> {
  _DialogContentState({Key key, this.flowerdata}) : super();
  TextEditingController _idController=new TextEditingController();
  TextEditingController _nameController=new TextEditingController();
  TextEditingController _durationController=new TextEditingController();
  TextEditingController _charactersController=new TextEditingController();
  TextEditingController _positionController=new TextEditingController();
  TextEditingController _descriptionController=new TextEditingController();
  double screenHeight, screenWidth;
  List flowerdata;
  File _image;  //hold on the picture i choose
  Future _getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }


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

    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: 180,
                        width: 200,
                        child: _image == null
                            ? Text("No Image Selected")
                            : Image.file(
                          _image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Flower Name',
                            icon: Icon(Icons.person_add),
                          )),
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
                        _getImageFromGallery();
                      }, child: Text("Choose Image")),
                      FlatButton(onPressed: (){
                        _addNewFlower();
                      }, child: Text("Upload All")),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }

  void _addNewFlower(){
    String base64Image = base64Encode(_image.readAsBytesSync());
    print(base64Image);
    String temp=flowerdata[flowerdata.length-1]['ID'];
    int temp_1=int.parse(temp)+1;
    print(temp_1);
    String temp_2=temp_1.toString();
    http.post("http://lossyhome.xyz/flowerimage/add_flower.php", body: {
      "id": temp_2,
      "name": _nameController.text,
      "duration": _durationController.text,
      "characters": _charactersController.text,
      "position": _positionController.text,
      "description": _descriptionController.text,
      "encoded_string": base64Image,
    }).then((res) {
      print(res.body);
      if (res.body.replaceAll('\n', "") == "success") {
        Toast.show("Upload success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pop(false);
      }else{
        Toast.show("Upload failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    });

  }
}




