import 'package:flutter/material.dart';

AppBar getDefaultAppBar(String title) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
  );
}

void showAlert(BuildContext context, String title, String content) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
