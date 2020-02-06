import 'package:flutter/cupertino.dart';
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
  TextEditingController _substractionController;
  TextEditingController _additionController;
  bool lock = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.bro.id == null) {
      setState(() {
        lock = false;
      });
    }

    _nameController = new TextEditingController(text: '${widget.bro.name}');
    _amountController = new TextEditingController(text: '${widget.bro.amount}');
    _additionController = new TextEditingController(text: '${0.0}');
    _substractionController = new TextEditingController(text: '${0.0}');
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
                  labelText: "Name",
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
            Padding(
              padding: new EdgeInsets.all(5.0),
            ),
            TextField(
              controller: _amountController,
              decoration: new InputDecoration(
                  labelText: "Amount",
                  icon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: new EdgeInsets.all(5.0),
            ),
            TextField(
              controller: _additionController,
              decoration: new InputDecoration(
                  icon: Icon(Icons.add),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              keyboardType: TextInputType.number,
              enabled: lock,
            ),
            Padding(
              padding: new EdgeInsets.all(5.0),
            ),
            TextField(
              controller: _substractionController,
              decoration: new InputDecoration(
                  icon: Icon(Icons.remove),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              keyboardType: TextInputType.number,
              enabled: lock,
            ),
            Padding(
              padding: new EdgeInsets.all(5.0),
            ),
            RaisedButton(
              child: (widget.bro.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.bro.id != null) {
                  var bro = Bro(
                      id: widget.bro.id,
                      name: widget.bro.name,
                      amount: double.parse(_amountController.text));
                  db.updateBro(bro).then((_) {
                    Navigator.pop(context, 'update');
                  });
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
