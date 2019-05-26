import 'package:flutter/material.dart';

class DeleteCommentDialog extends StatelessWidget {

  final Function() onDelete;
  final BuildContext context;

  const DeleteCommentDialog({
    Key key,
    @required this.onDelete,
    @required this.context,
  }) : super(key: key);


  bool onCancel() {

    return Navigator.pop(this.context);

  }


  void onDeleteComment() {

    Navigator.pop(this.context);
    this.onDelete();

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Card(
        margin: EdgeInsets.symmetric( horizontal: 20.0 ),
        child:  Padding(
          padding: EdgeInsets.only( left: 20.0, right: 20.0, bottom: 10.0 ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  '¿Realmente quieres eliminar tu comentario?',
                  style: TextStyle( fontSize: 18.0 ),
                  textAlign: TextAlign.center,
                ),
              ),

              Container(
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  textColor: Colors.white,
                  color: Colors.red,
                  child: Text('Eliminar'),
                  onPressed: onDeleteComment,
                ),
              ),

              Container(
                child: FlatButton(
                  // color: Colors.red,
                  textColor: Colors.blue,
                  onPressed: onCancel,
                  child: Text('Cancelar'),
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

}