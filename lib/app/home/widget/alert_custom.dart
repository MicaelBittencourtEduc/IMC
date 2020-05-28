import 'package:flutter/material.dart';

class AlertCustom extends StatelessWidget {
  final String title;
  final String message;
  final Function cancel;
  final Function confirm;

  const AlertCustom(
      {Key key, this.title, this.message, this.cancel, this.confirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: cancel,
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: confirm,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    return alert;
  }
}
