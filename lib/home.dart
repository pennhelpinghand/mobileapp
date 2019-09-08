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
    welcome = "Good Morning, ";
    return welcome;
  }

  String _getDate() {
    var month = new DateFormat.MMMMd().format(new DateTime.now());
    var year = new DateFormat.y().format(new DateTime.now());
    return month + ", " + year;
  }

  void showLogBook() {

  }

  void notifyHH() async {
    var helpUrl = 'http://f1b86f3f.ngrok.io/request_help';
    var userQuery = Firestore.instance.collection('users').where("id", isEqualTo: "thisIsId").limit(1);
    userQuery.getDocuments().then((data) async {
      if (data.documents.length > 0) {
        var response = await http.post(helpUrl,
            headers: {"Content-Type": "application/json"},
            body: json.encode({'hhName': data.documents[0].data["HHName"].split(" ")[0], 'hhPhone': data.documents[0].data["HHNumber"], 'userName': data.documents[0].data["name"].split(" ")[0], "userPhone": data.documents[0].data["phoneNumber"]}));
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
    });
  }

  void falseAlarm() {
    Firestore.instance.collection("users").document("testUser").updateData({"hhAssistance" : false});
  }

  var updateHHNum;
  var updateHHName;

  void updateHelpingHand() {
      showDialog(
        context: context,
        builder: (BuildContext context) => new CupertinoAlertDialog(
          title: Text(" Update HelpingHand:", textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16),),
          content: Card(
            color: Colors.transparent,
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                SizedBox(height: 15,),
                TextField(
                  onChanged: (newName) {
                    setState(() {
                      updateHHName = newName;
                    });
                  },
                  maxLength: 30,
                  style: new TextStyle(
                    fontSize: 16,
                  ),
                  decoration: new InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                    counterText: "",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Martin Luther Ki...',
                  ),
                ),
                SizedBox(height: 5,),
                TextField(
                  onChanged: (newNum) {
                    setState(() {
                      updateHHNum = newNum;
                    });
                  },
                  maxLength: 30,
                  style: new TextStyle(
                    fontSize: 16,
                  ),
                  decoration: new InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                    counterText: "",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: '123-456-7890',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () async {
                var helpUrl = 'http://f1b86f3f.ngrok.io/register_helping_hand';
                var userQuery = Firestore.instance.collection('users').where("id", isEqualTo: "thisIsId").limit(1);
                userQuery.getDocuments().then((data) async {
                  if (data.documents.length > 0) {
                    var response = await http.post(helpUrl,
                        headers: {"Content-Type": "application/json"},
                        body: json.encode({'hhName': updateHHName.split(" ")[0], 'hhPhone': "+1" + updateHHNum.replaceAll("-", "").replaceAll(" ", ""),
                          'userName': data.documents[0].data["name"]}));
                    if (response.statusCode == 200) {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => new CupertinoAlertDialog(
                          title: new Text("Success", textAlign: TextAlign.center,),
                          content: new Text("Your HelpingHand has been updated!", textAlign: TextAlign.center,),
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
                      Firestore.instance.collection("users").document("testUser").updateData(
                          {"HHName" : updateHHName, "HHNumber" : "+1" +
                              updateHHNum.replaceAll("-", "").replaceAll(" ", ""),});
                    }
                    else {
                      Navigator.pop(context);
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
                });
              },
              isDefaultAction: true,
              child: new Text("Update"),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              isDefaultAction: false,
              child: new Text("Cancel"),
            ),
          ],
        ),
      );
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
                  width: MediaQuery.of(context).size.width * .93,
                  color: Color(0xFFB83E34),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.whatshot,
                            size: 70,
                            color: Colors.white,
                          ),
                          SizedBox(width: 41),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: StreamBuilder(
                                stream: Firestore.instance.collection("users").document("testUser").snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Text("",
                                      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                                    );
                                  }
                                  else {
                                    return Text(snapshot.data["daysClean"].toString(),
                                      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                                    );
                                  }
                                },
                              ),
                          ),
                          SizedBox(width: 14),
                          Padding(
                            padding: const EdgeInsets.only(top: 35.0),
                            child: Container(
                              width: 110,
                              child: Text("Days Clean",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
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
                  width: MediaQuery.of(context).size.width * .93,
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.attach_money,
                            size: 80,
                            color: Colors.white,
                          ),
                          SizedBox(width: 13),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: StreamBuilder(
                              stream: Firestore.instance.collection("users").document("testUser").snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text("",
                                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                                  );
                                }
                                else {
                                  return Text(snapshot.data["dollarsSaved"].toString(),
                                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            width: 110,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 35.0, right: 10),
                              child: Text("Dollars Saved",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                          //SizedBox(width: 15),
                        ],
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
                  width: MediaQuery.of(context).size.width * .93,
                  color: Color(0xFF2E5696),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(width: 10,),
                          Icon(
                            Icons.hotel,
                            size: 60,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: StreamBuilder(
                              stream: Firestore.instance.collection("users").document("testUser").snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text("",
                                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                                  );
                                }
                                else {
                                  return Text(snapshot.data["sleepDays"].toString(),
                                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            width: 110,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Text("Days of Target Sleep",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                          //SizedBox(width: 15),
                        ],
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
                  width: MediaQuery.of(context).size.width * .93,
                  color: Colors.amber,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(width: 10,),
                          Icon(
                            Icons.fitness_center,
                            size: 60,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: StreamBuilder(
                              stream: Firestore.instance.collection("users").document("testUser").snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text("",
                                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                                  );
                                }
                                else {
                                  return Text(snapshot.data["exerciseDays"].toString(),
                                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            width: 110,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Text("Days of Target Exercise",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
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
                    width: MediaQuery.of(context).size.width * .93,
                    color: Colors.deepPurpleAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(width: 10,),
                            Icon(
                              Icons.chrome_reader_mode,
                              size: 60,
                              color: Colors.white,
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: StreamBuilder(
                                stream: Firestore.instance.collection("users").document("testUser").snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Text("",
                                      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                                    );
                                  }
                                  else {
                                    return Text(snapshot.data["logbookCount"].toString(),
                                      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                                    );
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 15),
                            Container(
                              width: 110,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text("Logbook Entries",
                                  style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            ),
                            //SizedBox(width: 15),
                          ],
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
          margin: EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  return notifyHH();
                },
                child: new Container(
                  margin: const EdgeInsets.only(top: 15, right: 17),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        child: Container(
                          height: 95,
                          width: MediaQuery.of(context).size.width * .44,
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
                  margin: const EdgeInsets.only(top: 15, right: 0),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        child: Container(
                          height: 95,
                          width: MediaQuery.of(context).size.width * .44,
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
            ],
          ),
        ),
      ],
    );
  }

  void sendPositiveReinforcement(duration, exercise) {
    var helpUrl = 'http://f1b86f3f.ngrok.io/encourage';
    var userQuery = Firestore.instance.collection('users').where("id", isEqualTo: "thisIsId").limit(1);
    userQuery.getDocuments().then((data) async {
      if (data.documents.length > 0) {
        var response = await http.post(helpUrl,
            headers: {"Content-Type": "application/json"},
            body: json.encode({
              'hhName': data.documents[0].data["HHName"].split(" ")[0],
              'hhPhone': data.documents[0].data["HHNumber"],
              'userName': data.documents[0].data["name"].split(" ")[0],
              "userPhone": data.documents[0].data["phoneNumber"],
              "daysStreakFree": duration,
              "numConsistentExercise": exercise.toString(),
            }));
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        print(response.statusCode);
      }
    });
  }

  int stateOfDays = 0;
  Widget _buildNoAlert() {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (stateOfDays == 0) {
                    Firestore.instance.collection("users").document("testUser").updateData(
                        {"daysClean" : 5, "dollarsSaved" : 34, "exerciseDays" : 3, "sleepDays" : 4, "logbookCount" : 1});
                    sendPositiveReinforcement("5 days", 3);
                  }
                  else if (stateOfDays == 1) {
                    Firestore.instance.collection("users").document("testUser").updateData(
                        {"daysClean" : 10, "dollarsSaved" : 52, "exerciseDays" : 7, "sleepDays" : 9, "logbookCount" : 3});
                    sendPositiveReinforcement("10 days", 7);
                  }
                  else if (stateOfDays == 2) {
                    Firestore.instance.collection("users").document("testUser").updateData(
                        {"daysClean" : 30, "dollarsSaved" : 131, "exerciseDays" : 25, "sleepDays" : 26, "logbookCount" : 8});
                    sendPositiveReinforcement("1 month", 25);
                  }
                  else if (stateOfDays == 3) {
                    Firestore.instance.collection("users").document("testUser").updateData(
                        {"daysClean" : 50, "dollarsSaved" : 234, "exerciseDays" : 32, "sleepDays" : 43, "logbookCount" : 14});
                    sendPositiveReinforcement("50 days", 32);
                  }
                  else if (stateOfDays == 4) {
                    Firestore.instance.collection("users").document("testUser").updateData(
                        {"daysClean" : 100, "dollarsSaved" : 417, "exerciseDays" : 72, "sleepDays" : 83, "logbookCount" : 22});
                    sendPositiveReinforcement("100 days", 72);
                  }
                  else if (stateOfDays == 5) {
                    Firestore.instance.collection("users").document("testUser").updateData(
                        {"daysClean" : 365, "dollarsSaved" : 1251, "exerciseDays" : 312, "sleepDays" : 321, "logbookCount" : 43});
                    sendPositiveReinforcement("1 year", 312);
                  }
                  setState(() {
                    stateOfDays++;
                  });
                },
                child: Container(
                  child: Image.asset("assets/images/morningSun.png"), height: 130,),
              ),
              Container(
                margin: const EdgeInsets.only(left: 0, top: 8),
                child: Align(
                  alignment: Alignment.center,
                  child: StreamBuilder(
                    stream: Firestore.instance.collection("users").document("testUser").snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(_getWelcome(), style: new TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,));
                      }
                      else {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(_getWelcome() + snapshot.data["name"].split(" ")[0] + "!",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),),
                        );
                      }
                    }),
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
              GestureDetector(
                onTap: () {
                  Firestore.instance.collection("users").document("testUser").updateData(
                      {"daysClean" : 92, "dollarsSaved" : 417, "exerciseDays" : 34, "sleepDays" : 77, "logbookCount" : 12});
                },
                child: Container(
                  child: Image.asset("assets/images/morningSun.png"), height: 130,),
              ),
              Container(
                margin: const EdgeInsets.only(left: 0, top: 8),
                child: Align(
                  alignment: Alignment.center,
                  child: StreamBuilder(
                      stream: Firestore.instance.collection("users").document("testUser").snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text(_getWelcome(), style: new TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,));
                        }
                        else {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(_getWelcome() + snapshot.data["name"].split(" ")[0] + "!",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),),
                          );
                        }
                      }),
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
                        width: MediaQuery.of(context).size.width * .93,
                        color: Color(0xFF2E5696),
                        child: Column(
                          children: <Widget>[
                            Image.asset("assets/images/fullLogo.png"),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: Text("We are detecting high stress or withdrawal "
                                  "symptoms.\n\nWould you like us to notify your HelpingHand?",
                                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 53,),
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
                              child: Text("Or contact the national drug helpline at 1-844-289-0879",
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
