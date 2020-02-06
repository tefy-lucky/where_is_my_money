import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar getDefaultAppBar(String title) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
  );
}

void showSimpleAlert(BuildContext context, String title, String content) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.check),
                  Text(" OK, I'm sorry!!!")
                ],
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
