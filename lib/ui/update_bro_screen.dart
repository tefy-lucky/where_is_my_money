import 'package:flutter/material.dart';
import 'package:where_is_my_money/model/bro.dart';
import 'package:where_is_my_money/util/database_helper.dart';
import 'package:where_is_my_money/util/ui.dart';

class BroScreen extends StatefulWidget {
  final Bro bro;
  BroScreen(this.bro);

  @override
  State<StatefulWidget> createState() => new _BroScreenState();
}

class _BroScreenState extends State<BroScreen> {
  DatabaseHelper db = new DatabaseHelper();

  TextEditingController _nameController;
  TextEditingController _amountController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _nameController = new TextEditingController(text: '${widget.bro.name}');
    _amountController = new TextEditingController(text: '${widget.bro.amount}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getDefaultAppBar(''),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: new InputDecoration(
                  labelText: "Name", icon: Icon(Icons.person)),
            ),
            Padding(
              padding: new EdgeInsets.all(5.0),
            ),
            TextField(
              controller: _amountController,
              decoration: new InputDecoration(
                  labelText: "Amount", icon: Icon(Icons.attach_money)),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: new EdgeInsets.all(5.0),
            ),
            RaisedButton(
              child: (widget.bro.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.bro.id != null) {
                } else {
                  db
                      .insertBro(Bro(
                    name: _nameController.text,
                    amount: double.parse(_amountController.text),
                  ))
                      .then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
