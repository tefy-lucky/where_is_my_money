import 'package:flutter/material.dart';

class ListViewBros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Where is my money',
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          title: Text('List'),
          centerTitle: true,
        ),
        body: Container(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 8.0,
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                        border: new Border(
                          right: new BorderSide(width: 1.0, color: Colors.white24)
                        )
                      ),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(
                      "Person 1",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Icon(Icons.attach_money, color: Colors.yellowAccent),
                        Text(" 5,000 Ar", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    trailing: Icon(Icons.delete, color: Colors.white, size: 30.0),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}