
import 'package:app19022019/core/src/models/discussion_system/comment.dart';
import 'package:app19022019/ui/components/custom_circular_icon_button.dart';
import 'package:app19022019/ui/discussion_system/delete_comment_dialog.dart';
import 'package:flutter/material.dart';

class CommentComponent extends StatefulWidget {

  final Comment data;
  final String userId;
  final Map<String, String> answersToDelete;
  final Map<String, String> commentsToDelete;
  final Function(String commentId) fnToDeleteComment;

  const CommentComponent({
    Key key,
    @required this.data,
    @required this.userId,
    @required this.answersToDelete,
    @required this.commentsToDelete,
    @required this.fnToDeleteComment,
  }) : super(key: key);

  @override
  _CommentComponentState createState() => _CommentComponentState();

}


class _CommentComponentState extends State<CommentComponent> {


  Comment get _data => widget.data;
  String get _userId => widget.userId;
  Function(String commentId) get deleteComment =>  widget.fnToDeleteComment;


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


  void showDialogDeleteComment(BuildContext ctx) {

    showDialog(
      context: ctx,
      barrierDismissible: true,
      builder: (_) => DeleteCommentDialog( onDelete: () => this.deleteComment(_data.id), context: _ )
    );

  }


  @override
  Widget build(BuildContext context) {

    final _cardWidth   = MediaQuery.of(context).size.width - 20;
    final canDelete    = _data.tempId == null && _data.answers.length == 0 && _data.user.id == _userId;
    final isProcessing = _data.tempId != null || widget.commentsToDelete.containsKey(_data.id);

    return Container(

      width:      _cardWidth,
      padding:    _padding,
      margin:     _margin,
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
              Expanded(
                child: Container(
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
                ),
              ),

              buildStatusComment(canDelete, isProcessing),

            ],
          ),

          Divider( color: Colors.grey[400] ),

          Text( _data.text ),

        ],
      ),
    );
 
  }


  Widget buildStatusComment(bool canDelete, bool isProcessing) {


    if ( isProcessing ) {

      return Container(
        width: 36.0,
        height: 36.0,
        alignment: Alignment.center,
        child: Container(
          width:  20.0,
          height: 20.0,
          child:  CircularProgressIndicator( strokeWidth: 3.0 ),
        ),
      );

    }


    if ( canDelete ) {

      return Container(
        width:     36.0,
        height:    36.0,
        alignment: Alignment.center,
        child: CustomCircularIconButton(
          height: 36.0,
          width:  36.0,
          onTap:  () => showDialogDeleteComment(context),
          splashColor: Colors.red[50],
          icon: Icon(
            Icons.delete_forever,
            color: Colors.red
          ),
        ),
      );

    }

    return SizedBox();

  }


  AssetImage getImage() {

    return AssetImage('assets/${_data.user.avatar}.png');

  }


}

