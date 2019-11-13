import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omg/Setup/home.dart';

class Assessment extends StatefulWidget {
  @override
  _AssessmentState createState() => _AssessmentState();
}

class _AssessmentState extends State<Assessment> {
  String _value1 = null;
  List<String> _values1 = new List<String>();
  String _UserId;

  List<Item> items = List();
  Item item;
  DatabaseReference itemRef;
  FirebaseUser currentUser;
  DatabaseReference watchRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    item = Item("", "", "", "");
    _initDB();

    _values1.addAll(["ระบุเกรด","score 1","score 2","score 3","score 4","score 5"]);
    _value1 = _values1.elementAt(0);
  }

  void _initDB() async{
    final FirebaseDatabase database = FirebaseDatabase.instance;
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    currentUser = await firebaseAuth.currentUser();
    itemRef = watchRef = database.reference().
    child('ForExpert').child(currentUser.uid).
    reference();
    itemRef.onChildAdded.listen(_onEntryAdded);
  }

  _onEntryAdded(Event event) {
    setState(() {
      items.add(Item.fromSnapshot(event.snapshot));
    });
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      itemRef.push().set(item.toJson());
    }
  }


  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser().then((user) {
      _UserId = user.uid;
    });
    return Scaffold(
      appBar: new AppBar(
        title: new Text("แบบประเมินเกรดเนื้อ"),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: FirebaseAnimatedList(
              query: itemRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return new Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.network(items[index].Picture,width: 200.0,height: 150.0,),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(items[index].Date),
    //                        Text(items[index].Detail1),
                          ],
                        ),
                      ],
                    ),
                    ExpansionTile(
                      backgroundColor: Colors.black26,
                      trailing: Icon(Icons.search),
                        title: Text('ให้เกรดเนื้อ',style: TextStyle(color: Colors.black),),
                      children: <Widget>[
                        new Column(
                          children: <Widget>[
//                            new Text('**ให้เกรดเนื้อ**',style: TextStyle(fontSize: 20,color: Colors.red),),
//                            new Text('score 1 คือ เกรดเนื้อพอใช้',style: TextStyle(fontSize: 15),),
//                            new Text('score 2 คือ เกรดเนื้อปานกลาง',style: TextStyle(fontSize: 15),),
//                            new Text('score 3 คือ เกรดเนื้อดี',style: TextStyle(fontSize: 15),),
//                            new Text('score 4 คือ เกรดเนื้อดีเยี่ยม',style: TextStyle(fontSize: 15),),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text('เกรด  :  ',style: TextStyle(fontSize: 15.0),),
                                        DropdownButton<String>(
                                          items: _values1.map<DropdownMenuItem<String>>((String value1){
                                            return DropdownMenuItem<String>(
                                              value: value1,
                                              child: Text(value1,style: TextStyle(color: Colors.black87),),
                                            );
                                          }).toList(),
                                          onChanged: (String newValueone){
                                            setState(() {
                                              this._value1 = newValueone;
                                            });
                                          },
                                          value: _value1,
                                        ),
                                      ],
                                    ),
                                    RaisedButton(
                                      color: Colors.black87,
                                      onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => Home()
                                      ));
                                    FirebaseDatabase.instance.reference().child('ForExpert(Used)').child(_getDateNow()).set({
                                      'UID' : (items[index]._userId),
                                      'Url_Picture':(items[index].Picture),
                                      'Date':(items[index].Date),
                                      'Detail1':(items[index].Detail1),
                                      'category': '$_value1',
                                      },);

                                    //FirebaseDatabase.instance.reference().child('ExpertHistory'). //ส่งเข้า History ของตัวเอง
                                    //child('$_UserId').child(_getDateNow()).set({
                                    //'Url_Picture':(items[index].Picture),
                                    //'Date':(items[index].Date),
                                    //'Detail1':(items[index].Detail1),
                                    //'category': '$_value1',
                                      //},);

                                      },
                                      child: Text("ให้เกรดเนื้อ",style: TextStyle(color: Colors.white70),),),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ]
                    )
                  ]
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  String key;
  String Picture;
  String Detail1;
  String Date;
  String _userId;

  Item(this.Picture, this.Detail1, this.Date, this._userId);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        Picture = snapshot.value["Url_Picture"],
        Detail1 = snapshot.value["category"],
        Date = snapshot.value["Date"],
        _userId = snapshot.value["UID"];

  toJson() {
    return {
      "Url_Picture": Picture,
      "category": Detail1,
      "Date": Date,
      "UID": _userId,
    };
  }
}

String _getDateNow() {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
  return formatter.format(now);
}
