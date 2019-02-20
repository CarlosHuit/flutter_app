import 'package:flutter/material.dart';

class OnBackPressed {

  Future<bool> validation(BuildContext context) {


    Widget actionBtnYes() {
      return FlatButton(
        textColor: Colors.red,
        child: Text(
          'SI',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)
        ),
        onPressed: () => Navigator.pop(context, true),
      );
    }


    Widget actionBtnNo() {
      return FlatButton(
        child: Text(
          'NO',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        onPressed: () => Navigator.pop(context, false),

      );
    }


    Widget dialogTitle() {
      return Text(
        '¿Realmente quieres salir de la aplicación?',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0
        ),
      );
    }


    return showDialog(

      context: context,
      builder: (context) => AlertDialog(
        title: dialogTitle(),
        actions: <Widget>[ actionBtnYes(), actionBtnNo() ],
      )

    );


  }


}