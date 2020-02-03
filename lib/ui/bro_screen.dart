import 'package:flutter/material.dart';
import 'package:where_is_my_money/model/bro.dart';
import 'package:where_is_my_money/util/database_helper.dart';

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

    _nameController = new TextEditingController(text: widget.bro.name);
    _amountController = new TextEditingController(text: widget.bro.amount);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}