
import 'package:app19022019/core/src/models/discussion_system/answer.dart';
import 'package:app19022019/ui/components/custom_circular_icon_button.dart';
import 'package:app19022019/ui/discussion_system/delete_comment_dialog.dart';
import 'package:flutter/material.dart';

class AnswerComponent extends StatefulWidget {

  final Answer data;
  final String userId;
  final Map<String, String> answersToDelete;
  final Function( String commentId, String answerId ) fnToDeleteAnswer;
  final String commentId;

  const AnswerComponent({
    Key key,
    @required this.data,
    @required this.userId,
    @required this.answersToDelete,
    @required this.fnToDeleteAnswer,
    @required this.commentId,
  }) : super(key: key);

  @override
  _AnswerComponentState createState() => _AnswerComponentState();

}

class _AnswerComponentState extends State<AnswerComponent> {

  Answer get _data => widget.data;
  String get _userId => widget.userId;
  String get _commentId => widget.commentId;
  Map<String, String> get _answersToDelete => widget.answersToDelete;
  Function(String commentId, String answerId) get _deleteAnswer => widget.fnToDeleteAnswer;

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
      builder: (_) => DeleteCommentDialog( onDelete: () => this._deleteAnswer(_commentId, _data.id), context: _ )
    );

  }



  @override
  Widget build(BuildContext context) {

    final _cardWidth = MediaQuery.of(context).size.width - 20;
    final canDelete    = _data.tempId == null && _data.user.id == _userId;
    final isProcessing = _data.tempId != null || _answersToDelete.containsKey(_data.id);

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

          Text(
            _data.text,
            style: TextStyle(

            ),
          ),


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