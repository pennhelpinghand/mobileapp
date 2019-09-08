import 'package:flutter/material.dart';
import 'home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignupFlow extends StatefulWidget {
  @override
  _SignupFlowState createState() => _SignupFlowState();
}

class _SignupFlowState extends State<SignupFlow> {
  var stateArray = ["IGNORE", "", "", "IGNORE", "IGNORE", "", ""];
  var pageNumber = 1;
  var questions = {1 : "What is your name?", 2 : "What is your phone number?",
  3 : "What can we help you with?", 4 : "Tell us some more about yourself", 5 : "Who is your HelpingHand?"};

  void nextPage() {
    if (pageNumber < 5) {
      if(stateArray[pageNumber] != "IGNORE" && stateArray[pageNumber].trim().length == 0) {
        return;
      }
      else {
        setState(() {
          pageNumber++;
        });
      }
    }
  }

  void updateStateArray(newText) {
    if (stateArray[pageNumber] != "IGNORE") {
      setState(() {
        stateArray[pageNumber] = newText;
      });
    }
  }

  void sendHHNotification() async {
    var url = 'http://f1b86f3f.ngrok.io/register_helping_hand';
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({'hhName': 'Aiden', 'hhPhone': '+17038947470', 'userName': "Amro"}));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  void goToHome() async {
    var helpUrl = 'http://f1b86f3f.ngrok.io/register_helping_hand';
    var response = await http.post(helpUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode({'hhName': 'Aiden', 'hhPhone': '+17038947470', 'userName': "Amro", "userPhone": "+17038947470"}));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  Widget nextButton() {
    if (pageNumber < 5) {
      return Container(
        width: 60.0,
        height: 73.0,
        child: IconButton(
          icon: Icon(Icons.play_circle_filled),
          iconSize: 60,
          onPressed: nextPage,
        ),
      );
    }
    else {
      return Container(
        width: 60.0,
        height: 73.0,
        child: IconButton(
          icon: Icon(Icons.check_circle, color: Colors.green,),
          iconSize: 60,
          onPressed: goToHome,
        ),
      );
    }
  }

  Widget footer() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            width: 35.0,
            height: 35.0,
            decoration: new BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            width: 35.0,
            height: 35.0,
            decoration: new BoxDecoration(
              color: pageNumber >= 2 ? Colors.red : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            width: 35.0,
            height: 35.0,
            decoration: new BoxDecoration(
              color: pageNumber >= 3 ? Colors.red : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            width: 35.0,
            height: 35.0,
            decoration: new BoxDecoration(
              color: pageNumber >= 4 ? Colors.red : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            width: 35.0,
            height: 35.0,
            decoration: new BoxDecoration(
              color: pageNumber >= 5 ? Colors.red : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          nextButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 710,
            child: Column(
              children: <Widget>[
                SizedBox(height: 50,),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 120),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Welcome!",
                      style: new TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 25, top: 35),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(questions[pageNumber],
                      style: new TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 3,
                  margin: const EdgeInsets.only(left: 27.0, right: 250.0, top: 10),
                  color: Colors.red,
                ),
                currentQuestion(),
              ],
            ),
          ),
          footer(),
        ],
      ),
    );
  }

  TextEditingController _phoneNumberController;
  @override
  void initState() {
    super.initState();
    _phoneNumberController = new TextEditingController(text: "");
  }

  Widget currentQuestion() {
    if (pageNumber == 1) {
      return usersName();
    }
    if (pageNumber == 2) {
      return userPhoneNumber();
    }
    if (pageNumber == 3) {
      return userSubstance();
    }
    if (pageNumber == 4) {
      return userData();
    }
    if (pageNumber == 5) {
      return helpingHand();
    }
    return Container();
  }

  double hoursSleep = 8;
  double minutesExercise = 45;

  Widget usersName() {
    return Padding(
      padding: const EdgeInsets.only(left: 27, top: 25),
      child: Container(
        padding: const EdgeInsets.only(right: 15),
        child: new TextField(
          onChanged: (newName) {
            updateStateArray(newName);
          },
          maxLength: 30,
          style: new TextStyle(
            fontSize: 25,
          ),
          decoration: new InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: -2),
            counterText: "",
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: 'Benjamin Frank...',
          ),
        ),
      ),
    );
  }

  Widget userPhoneNumber() {
    return Padding(
      padding: const EdgeInsets.only(left: 27, top: 25),
      child: Container(
        padding: const EdgeInsets.only(right: 15),
        child: new TextField(
          controller: _phoneNumberController,
          onChanged: (number) {
            updateStateArray(number);
          },
          maxLength: 30,
          style: new TextStyle(
            fontSize: 25,
          ),
          decoration: new InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: -2),
            counterText: "",
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: '123-456-7890',
          ),
        ),
      ),
    );
  }

  Widget userSubstance() {
    return Padding(
      padding: const EdgeInsets.only(left: 27, top: 25),
      child: Container(
        padding: const EdgeInsets.only(right: 15),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                    child: Text("Tobacco/Nicotine Addiction", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    color: Colors.amber,
                    onPressed: nextPage,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                    child: Text("Alcohol Addiction", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    color: Colors.amber,
                    onPressed: nextPage,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                    child: Text("Marijuana Addiction", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    color: Colors.amber,
                    onPressed: nextPage,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                    child: Text("Opioid Addiction", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    color: Colors.amber,
                    onPressed: nextPage,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                    child: Text("Cocaine Addiction", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    color: Colors.amber,
                    onPressed: nextPage,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget userData() {
    return Padding(
      padding: const EdgeInsets.only(left: 27, top: 25),
      child: Container(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "How much do you spend on your addiction per week?",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8, right: 275, bottom: 15),
              height: 2,
              color: Colors.amber,
            ),
            TextField(
              onChanged: (newTitle) {},
              maxLength: 30,
              style: TextStyle(
                fontSize: 25,
              ),
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: -2),
                counterText: "",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: '\$79',
              ),
            ),
            SizedBox(height: 30,),
            Container(
              child: Text("What is your target sleep per night?",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8, right: 275, bottom: 15),
              height: 2,
              color: Colors.amber,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 23),
              child: new Slider(
                min: 0,
                max: 16,
                divisions: 32,
                value: hoursSleep,
                label: "$hoursSleep Hours",
                onChanged: (double d) {
                  setState(() {
                    hoursSleep = d;
                  });
                },
                activeColor: Colors.red,
                inactiveColor: Colors.grey,
              ),
            ),
            SizedBox(height: 30,),
            Container(
              child: Text("What is your target excersise per day?",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8, right: 275, bottom: 15),
              height: 2,
              color: Colors.amber,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 23),
              child: new Slider(
                min: 0,
                max: 240,
                divisions: 16,
                value: minutesExercise,
                label: "$minutesExercise minutes",
                onChanged: (double d) {
                  setState(() {
                    minutesExercise = d;
                  });
                },
                activeColor: Colors.red,
                inactiveColor: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget helpingHand() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 27, top: 25),
          child: Container(
            padding: const EdgeInsets.only(right: 15),
            child: TextField(
              onChanged: (hhName) {
                updateStateArray(hhName);
              },
              maxLength: 30,
              style: new TextStyle(
                fontSize: 25,
              ),
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: -2),
                counterText: "",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Thomas Jef...',
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 27, top: 25),
          child: Container(
            padding: const EdgeInsets.only(right: 15),
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (hhNum) {
                updateStateArray(hhNum);
              },
              maxLength: 30,
              style: new TextStyle(
                fontSize: 25,
              ),
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: -2),
                counterText: "",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: '123-456-7890',
              ),
            ),
          ),
        ),
      ],
    );
  }
}





class CurrentQuestion extends StatefulWidget {
  final int pageNumber;

  const CurrentQuestion({Key key, this.pageNumber}) : super(key: key);
  @override
  _CurrentQuestionState createState() => _CurrentQuestionState();
}

class _CurrentQuestionState extends State<CurrentQuestion> {
  @override
  Widget build(BuildContext context) {

  }
}

