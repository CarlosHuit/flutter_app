import 'package:app19022019/ui/components/custom_circular_icon_button.dart';
import 'package:flutter/material.dart';

class SystemDiscussion extends StatefulWidget {

  @override
  _SystemDiscussionState createState() => _SystemDiscussionState();
}

class _SystemDiscussionState extends State<SystemDiscussion> {

  TextEditingController controller;
  
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            TextFieldWriteComment(),

            SingleChildScrollView(
              child: Column(
                children: List.generate(3, (i) => CommentComponent()),

              ),
            )

          ],
        ),
      ),
    );
  }
}


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


class CommentComponent extends StatefulWidget {
  @override
  _CommentComponentState createState() => _CommentComponentState();
}

class _CommentComponentState extends State<CommentComponent> {

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
                backgroundImage: AssetImage('assets/woman.png'),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Huit Carlos',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                      ),
                    ),
                    Text(
                      'Jan 15, 2019',
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
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only f.',
            style: TextStyle(

            ),
          ),


        ],
      ),
    );

  }
}