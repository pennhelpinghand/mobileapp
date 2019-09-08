import 'package:flutter/material.dart';
import 'home.dart';
import 'signup_flow.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool firstTime = true;
    if (firstTime) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //primarySwatch: Colors.white,
        ),
        home: SignupFlow(),
      );
    }
    else {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      );
    }

  }
}
