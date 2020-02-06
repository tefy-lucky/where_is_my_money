import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:where_is_my_money/model/bro.dart';
import 'package:where_is_my_money/ui/update_bro_screen.dart';
import 'package:where_is_my_money/util/database_helper.dart';
import 'package:where_is_my_money/util/ui.dart';

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
  var f = new NumberFormat("#,###,###.##");

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
        appBar: getDefaultAppBar('List'),
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
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(
                                  width: 1.0, color: Colors.white24))),
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
                        Text(' Ar ${f.format(items[index].amount)}',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () =>
                              _delete(context, items[index], index),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.archive,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () =>
                              _delete(context, items[index], index),
                        ),
                      ],
                    ),
                    onTap: () => _navigateToEditPage(context, items[index]),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _new(context),
        ),
      ),
    );
  }

  void _delete(BuildContext context, Bro bro, int position) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("This one is paid?"),
            content: Text(
                "I must ask, [${bro.name}] has paid you the full amount of [Ar ${f.format(bro.amount)}], you sure?"),
            actions: <Widget>[
              FlatButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[Icon(Icons.insert_emoticon), Text(" YES")],
                ),
                onPressed: () {
                  databaseHelper.deleteBro(bro.id).then((_) {
                    setState(() {
                      items.removeAt(position);
                    });
                  });
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[Icon(Icons.cancel), Text(" Wait, NO")],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _navigateToEditPage(BuildContext context, Bro bro) async {
    String result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => BroScreen(bro)));

    if (result == 'update') {
      databaseHelper.bros().then((bros) {
        setState(() {
          items.clear();
          bros.forEach((bro) {
            items.add(bro);
          });
        });
      });
    }
  }

  void _new(BuildContext context) async {
    final Bro bro = Bro(id: null, name: '', amount: 0.0, isPaid: false);
    String result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => BroScreen(bro)));

    if (result == 'save') {
      databaseHelper.bros().then((bros) {
        setState(() {
          items.clear();
          bros.forEach((bro) {
            items.add(bro);
          });
        });
      });
    }
  }
}
