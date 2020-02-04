import 'package:flutter/material.dart';
import 'package:where_is_my_money/model/bro.dart';
import 'package:where_is_my_money/util/database_helper.dart';

//class ListViewBros extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'Where is my money',
//      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
//      home: Scaffold(
//        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
//        appBar: AppBar(
//          title: Text('List'),
//          centerTitle: true,
//        ),
//        body: Container(
//          child: ListView.builder(
//            scrollDirection: Axis.vertical,
//            shrinkWrap: true,
//            itemCount: 10,
//            itemBuilder: (BuildContext context, int index) {
//              return Card(
//                elevation: 8.0,
//                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
//                child: Container(
//                  decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
//                  child: ListTile(
//                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//                    leading: Container(
//                      padding: EdgeInsets.only(right: 12.0),
//                      decoration: new BoxDecoration(
//                        border: new Border(
//                          right: new BorderSide(width: 1.0, color: Colors.white24)
//                        )
//                      ),
//                      child: Icon(Icons.person, color: Colors.white, size: 30.0),
//                    ),
//                    title: Text(
//                      "Person 1",
//                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                    ),
//                    subtitle: Row(
//                      children: <Widget>[
//                        Icon(Icons.account_balance_wallet, color: Colors.yellowAccent),
//                        Text(" 5,000 Ar", style: TextStyle(color: Colors.white)),
//                      ],
//                    ),
//                    trailing: Icon(Icons.delete, color: Colors.white, size: 30.0),
//                  ),
//                ),
//              );
//            },
//          ),
//        ),
//      ),
//    );
//  }
//}

class ListViewBros extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ListViewBros();
  }
}

class _ListViewBros extends State<ListViewBros> {
  List<Bro> items = new List();
  DatabaseHelper databaseHelper = new DatabaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    databaseHelper.bros().then((bros) {
      setState(() {
        bros.forEach((bro) {
          items.add(bro);
        });
      });
    });
  }

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
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 8.0,
                margin:
                    new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                  child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(
                                    width: 1.0, color: Colors.white24
                                )
                            )
                        ),
                        child:
                            Icon(Icons.person, color: Colors.white, size: 30.0),
                      ),
                      title: Text(
                        '${items[index].name}',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Icon(Icons.account_balance_wallet,
                              color: Colors.yellowAccent),
                          Text('${items[index].amount}',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete,
                            color: Colors.white, size: 30.0),
                        onPressed: () => {},
                      )
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => {},
        ),
      ),
    );
  }
}
