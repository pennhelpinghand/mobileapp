import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _getWelcome() {
    var hour = new DateTime.now().hour;
    var welcome;
    if (hour > 5 && hour < 12) {
      welcome = "Good Morning, ";
    }
    else if (hour < 17) {
      welcome = "Good Afternoon, ";
    }
    else {
      welcome = "Good Evening, ";
    }
    return welcome;
  }

  String _getDate() {
    var month = new DateFormat.MMMMd().format(new DateTime.now());
    var year = new DateFormat.y().format(new DateTime.now());
    return month + ", " + year;
  }

  void printName()  {
    DocumentReference r = Firestore.instance.collection('users').document("testUser");
    var userQuery = Firestore.instance.collection('users').where("phoneNumber", isEqualTo: "703-894-7470").limit(1);

    userQuery.getDocuments();
    userQuery.getDocuments().then((data) {
      if (data.documents.length > 0) {
        print(data.documents[0].data["withdrawalTime"]);
      }
    });
  }

  void showLogBook() {

  }

  void notifyHH() async {
    var helpUrl = 'http://f1b86f3f.ngrok.io/request_help';
    var response = await http.post(helpUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode({'hhName': 'Aiden', 'hhPhone': '+17038947470', 'userName': "Amro", "userPhone": "+17038947470"}));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => new CupertinoAlertDialog(
          title: new Text("Success", textAlign: TextAlign.center,),
          content: new Text("Your HelpingHand has been notified!", textAlign: TextAlign.center,),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              isDefaultAction: true,
              child: new Text("Close"),
            ),
          ],
        ),
      );
      Firestore.instance.collection("users").document("testUser").updateData({"hhAssistance" : false});
    }
    else {
      showDialog(
        context: context,
        builder: (BuildContext context) => new CupertinoAlertDialog(
          title: new Text("Error", textAlign: TextAlign.center,),
          content: new Text("Sorry, something went wrong. Test your network and try again.", textAlign: TextAlign.center,),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              isDefaultAction: true,
              child: new Text("Close"),
            ),
          ],
        ),
      );
    }
  }

  void falseAlarm() {
    Firestore.instance.collection("users").document("testUser").updateData({"hhAssistance" : false});
  }

  void updateHelpingHand() {

  }

  void editTargets() {

  }

  Widget _buildMileStones() {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                child: Container(
                  height: 95,
                  width: MediaQuery.of(context).size.width * .90,
                  color: Color(0xFFB83E34),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 15),
                      Icon(
                        Icons.whatshot,
                        size: 70,
                        color: Colors.white,
                      ),
                      SizedBox(width: 50),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("92",
                          style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 14),
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: Text("Days Clean!",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                child: Container(
                  height: 95,
                  width: MediaQuery.of(context).size.width * .90,
                  color: Colors.green,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 15),
                      Icon(
                        Icons.attach_money,
                        size: 80,
                        color: Colors.white,
                      ),
                      SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "417",
                          style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: Text("Dollars Saved",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                child: Container(
                  height: 95,
                  width: MediaQuery.of(context).size.width * .90,
                  color: Color(0xFF2E5696),
                  child:  Row(
                    children: <Widget>[
                      SizedBox(width: 22),
                      Icon(
                        Icons.hotel,
                        size: 55,
                        color: Colors.white,
                      ),
                      SizedBox(width: 60),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("77",
                          style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 12),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          width: 110,
                          child: Text("Days of Target Sleep",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                child: Container(
                  height: 95,
                  width: MediaQuery.of(context).size.width * .90,
                  color: Colors.amber,
                  child:  Row(
                    children: <Widget>[
                      SizedBox(width: 22),
                      Icon(
                        Icons.fitness_center,
                        size: 55,
                        color: Colors.white,
                      ),
                      SizedBox(width: 50),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("34",
                          style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 12),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          width: 110,
                          child: Text("Days of Target Exercise",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            showLogBook();
          },
          child: Container(
            margin: const EdgeInsets.only(top: 15),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  child: Container(
                    height: 95,
                    width: MediaQuery.of(context).size.width * .90,
                    color: Colors.deepPurpleAccent,
                    child:  Row(
                      children: <Widget>[
                        SizedBox(width: 22),
                        Icon(
                          Icons.chrome_reader_mode,
                          size: 60,
                          color: Colors.white,
                        ),
                        SizedBox(width: 52),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("12",
                            style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 12),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Container(
                            width: 120,
                            child: Text("Logbook Entries",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // MINI ICON BUTTONS
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  return notifyHH();
                },
                child: new Container(
                  margin: const EdgeInsets.only(top: 15, right: 15),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        child: Container(
                          height: 95,
                          width: MediaQuery.of(context).size.width * .27,
                          color: Color(0xFFb0e0e6),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                                size: 60,
                              ),
                              Text("Notify HelpingHand",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  updateHelpingHand();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 15, right: 15),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        child: Container(
                          height: 95,
                          width: MediaQuery.of(context).size.width * .27,
                          color: Color(0xFFb0e0e6),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: 50,
                              ),
                              SizedBox(height: 5,),
                              Text("Update HelpingHand",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  editTargets();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 15,),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        child: Container(
                          height: 95,
                          width: MediaQuery.of(context).size.width * .27,
                          color: Color(0xFFb0e0e6),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 60,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Edit Targets",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNoAlert() {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                child: Image.asset("assets/images/morningSun.png"), height: 130,),
              Container(
                margin: const EdgeInsets.only(left: 0, top: 8),
                child: Align(
                  alignment: Alignment.center,
                  child: new Text(_getWelcome() + "Amro" + "!", style: new TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 0, top: 5),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(_getDate(),
                    style: new TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              _buildMileStones(),
            ],
          )
      ),
    );
  }

  Widget _buildAlert() {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                child: Image.asset("assets/images/morningSun.png"), height: 130,),
              Container(
                margin: const EdgeInsets.only(left: 0, top: 8),
                child: Align(
                  alignment: Alignment.center,
                  child: new Text(_getWelcome() + "Amro" + "!", style: new TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 0, top: 5),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(_getDate(),
                    style: new TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: Container(
                        height: 380,
                        width: MediaQuery.of(context).size.width * .90,
                        color: Color(0xFF2E5696),
                        child: Column(
                          children: <Widget>[
                            Image.asset("assets/images/fullLogo.png"),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: Text("We are detecting high stress or withdrawal "
                                  "symptoms.\n\nWould you like us to notify your HelpingHand?",
                                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 50,),
                                FlatButton(
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                  color: Colors.green,
                                  onPressed: notifyHH,
                                  child: Text("Yes, please!", style: TextStyle(color: Colors.white),),
                                ),
                                SizedBox(width: 15,),
                                FlatButton(
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                  color: Colors.green,
                                  onPressed: falseAlarm,
                                  child: Text("False Alarm!", style: TextStyle(color: Colors.white),),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Container(
                              margin: EdgeInsets.all(15),
                              child: Text("Note: If this is an emergency please dial 9-1-1 now",
                                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _buildMileStones(),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection("users").document("testUser").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data["hhAssistance"]) {
          return _buildNoAlert();
        }
        else {
          return _buildAlert();
        }
      },
    );
  }
}
