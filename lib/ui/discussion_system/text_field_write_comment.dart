import 'package:app19022019/ui/components/custom_circular_icon_button.dart';
import 'package:flutter/material.dart';

class TextFieldWriteComment extends StatefulWidget {
  @override
  _TextFieldWriteCommentState createState() => _TextFieldWriteCommentState();
}


class _TextFieldWriteCommentState extends State<TextFieldWriteComment> {

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 60.0,
      child: Row(
        children: <Widget>[


          Expanded(
            child: Container(
              margin:    EdgeInsets.only(
                left: 15.0,
                right: 0.0
              ),
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 2.0
                    )
                  ]
                ),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder:  InputBorder.none,
                    disabledBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),


          Container(
            width:     60.0,
            height:    60.0,
            alignment: Alignment.center,
            child: CustomCircularIconButton(
              height: 48,
              width:  48,
              icon: Icon(
                Icons.send,
                color: Colors.blue,
                size: 32.0,
              ),
              onTap:  () {},
              splashColor: Colors.blue[50],
            )
          )


        ],
      ),
    );

  }


}


