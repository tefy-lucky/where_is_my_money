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
  TextEditingController _subtractionController;
  TextEditingController _additionController;
  bool lock, nameAndAmountLock = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.bro.id == null) {
      setState(() {
        lock = false;
      });
    } else {
      nameAndAmountLock = false;
    }

    _nameController = new TextEditingController(text: '${widget.bro.name}');
    _amountController = new TextEditingController(text: '${widget.bro.amount}');
    _additionController = new TextEditingController(text: '${0.0}');
    _subtractionController = new TextEditingController(text: '${0.0}');
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
              enabled: nameAndAmountLock,
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
              enabled: nameAndAmountLock,
            ),
            Padding(
              padding: new EdgeInsets.all(5.0),
            ),
            TextField(
              controller: _additionController,
              decoration: new InputDecoration(
                  labelText: "So he/she wants more uh?",
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
              controller: _subtractionController,
              decoration: new InputDecoration(
                  labelText: "This is good",
                  icon: Icon(Icons.remove),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              keyboardType: TextInputType.number,
              enabled: lock,
            ),
            Padding(
              padding: new EdgeInsets.all(5.0),
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              child: RaisedButton(
                child: (widget.bro.id != null) ? Text('UPDATE', style: TextStyle(color: Colors.white),) : Text('ADD', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  try {
                    if (widget.bro.id != null) {
                      double addition = double.parse(_additionController.text);
                      double subtraction =
                          double.parse(_subtractionController.text);
                      double newAmount = double.parse(_amountController.text) +
                          addition -
                          subtraction;
                      if (!(newAmount > 0)) {
                        showSimpleAlert(context, "Wait, what?",
                            "Okay so now he/she must pay you Ar ${newAmount}? Everything is fine? Why don't you just delete the entry from the list if he/she doesn't owe you money anymore?");
                      } else {
                        var bro = Bro(
                            id: widget.bro.id,
                            name: widget.bro.name,
                            amount: newAmount);
                        db.updateBro(bro).then((_) {
                          Navigator.pop(context, 'update');
                        });
                      }
                    } else {
                      if (_nameController.text.trim() == '') {
                        showSimpleAlert(context, "No name",
                            "So your bro doesn't have a name uh?");
                      } else {
                        db
                            .insertBro(Bro(
                          name: _nameController.text.trim(),
                          amount: double.parse(_amountController.text.trim()),
                        ))
                            .then((_) {
                          Navigator.pop(context, 'save');
                        });
                      }
                    }
                  } on FormatException {
                    showSimpleAlert(context, "Invalid amout",
                        "You serious right now? Please use the format provided.");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
