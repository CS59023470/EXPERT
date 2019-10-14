import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mastesting/Setup/home.dart';

class Assessment extends StatefulWidget {
  Assessment({Key key}) : super(key: key);
  @override
  _AssessmentState createState() => _AssessmentState();
}

class _AssessmentState extends State<Assessment> {
  String _value1 = null;
  List<String> _values1 = new List<String>();
  String _value2 = null;
  List<String> _values2 = new List<String>();
  String _value3 = null;
  List<String> _values3 = new List<String>();
  String _value4 = null;
  List<String> _values4 = new List<String>();
  String _value5 = null;
  List<String> _values5 = new List<String>();

  List<Item> items = List();
  Item item;
  DatabaseReference itemRef;
  String getUID;
  FirebaseUser currentUser;
  DatabaseReference watchRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    item = Item("","","");
    _initDB();

    _values1.addAll(["ชั้นดีเลิศ","ชั้นดีมาก","ชั้นดี","ชั้นปานกลาง","ชั้นพอใช้"]);
    _value1 = _values1.elementAt(0);
  }

  void _initDB() async{
    final FirebaseDatabase database = FirebaseDatabase.instance;
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    currentUser = await firebaseAuth.currentUser();
    itemRef = watchRef = database.reference().
    child('ExpertMeet').
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
    return Scaffold(
      appBar: AppBar(
        title: Text('ให้คะแนนเกรดเนื้อโค'),
      ),
    );
  }
}

class Item {
  String key;
  String Picture;
  String Date;
  String _userId;

  Item(this.Picture, this.Date, this._userId);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        Picture = snapshot.value["Url_Picture"],

        Date = snapshot.value["เวลาที่ทำการวิเคราะห์"],
        _userId = snapshot.value["UID"];

  toJson() {
    return {
      "Url_Picture": Picture,
      "เวลาที่ทำการวิเคราะห์": Date,
      "UID": _userId,
    };
  }
}

String _getDateNow() {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
  return formatter.format(now);
}