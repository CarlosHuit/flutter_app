
import 'package:app19022019/core/src/models/discussion_system/comment.dart';
import 'package:flutter/material.dart';

class CommentComponent extends StatefulWidget {

  final Comment data;

  const CommentComponent({Key key, @required this.data}) : super(key: key);

  @override
  _CommentComponentState createState() => _CommentComponentState();

}


class _CommentComponentState extends State<CommentComponent> {

  Comment get _data => widget.data;

  EdgeInsets _padding = EdgeInsets.symmetric(
    vertical:   12.0,
    horizontal: 20.0
  );

  EdgeInsets _margin = EdgeInsets.symmetric(
    horizontal: 2.0,
    vertical:   4.0
  );

  BoxDecoration _boxDecoration = BoxDecoration(
    color:        Colors.white,
    borderRadius: BorderRadius.circular(4.0),
    boxShadow: [
      BoxShadow( color: Colors.black26, offset: Offset(-0.2, 0.2) )
    ]
  );

  @override
  Widget build(BuildContext context) {

    final _cardWidth = MediaQuery.of(context).size.width - 20;

    return Container(
      width:   _cardWidth,
      padding: _padding,
      margin:  _margin,
      decoration: _boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Row(
            children: <Widget>[
              CircleAvatar(
                maxRadius: 22.0,
                backgroundImage: getImage(),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _data.user.fullName(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                      ),
                    ),
                    Text(
                      '${_data.parseDate()}',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12.0
                      ),
                    )
                  ],
                ),
              )
            ],
          ),

          Divider( color: Colors.grey[400] ),

          Text(
            _data.text,
            style: TextStyle(

            ),
          ),


        ],
      ),
    );
 
  }

  AssetImage getImage() {
    return AssetImage('assets/${_data.user.avatar}.png');
  }

}

