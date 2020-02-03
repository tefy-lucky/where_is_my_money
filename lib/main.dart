import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: Scaffold(
        appBar: AppBar(title: Text("Where is my money"),),
        body: Center(
          child: Text("Hello my dear!"),
        ),
      ),
    );
  }
}