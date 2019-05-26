
import 'package:app19022019/core/src/models/discussion_system/comment.dart';
import 'package:app19022019/core/src/viewmodels/discussion_system_view_model.dart';
import 'package:app19022019/ui/discussion_system/answer_component.dart';
import 'package:app19022019/ui/discussion_system/comment_component.dart';
import 'package:app19022019/ui/discussion_system/text_field_write_answer.dart';
import 'package:flutter/material.dart';


class CommentThreadComponent extends StatefulWidget {

  final Comment data;
  final DiscussionSystemViewModel viewModel;

  const CommentThreadComponent({
    Key key,
    @required this.data,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _CommentThreadComponentState createState() => _CommentThreadComponentState();

}


class _CommentThreadComponentState extends State<CommentThreadComponent> {

  Comment get data => widget.data;
  DiscussionSystemViewModel get vm => widget.viewModel;

  bool showAnswers;
  bool hasAnswers;
  bool showBoxWriteAnswer;

  @override
  void initState() {

    super.initState();
    showAnswers = false;
    hasAnswers = data.answers.length > 0;
    showBoxWriteAnswer = false;

  }

  void toggleShowAnswersStatus() {

    setState(() {
      showAnswers = !showAnswers;
    });

  }

  void toggleShowBoxAnswer() {
    setState(() {
      showBoxWriteAnswer = !showBoxWriteAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {

    final _cardWidth = MediaQuery.of(context).size.width - 20;


    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300], width: 1.0)
        )
      ),
      child: Column(
        children: <Widget>[

          CommentComponent(
            data: data,
            userId: vm.userId,
            answersToDelete: vm.answersToDelete,
            commentsToDelete: vm.commentsToDelete,
            fnToDeleteComment: vm.deleleComment,

          ),

          Container(
            width: _cardWidth,
            child: Stack(
              fit: StackFit.passthrough,
              children: <Widget>[

                buildThreadDecoration(),

                Container(
                  margin: EdgeInsets.only(left: 45.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[

                      showAnswers && hasAnswers ? buildAnswersList() : SizedBox(),
                      showAnswers && hasAnswers ? buildShowAnswers() : SizedBox(),
                      !showAnswers && hasAnswers ? buildHideAnswers() : SizedBox(),

                      showBoxWriteAnswer ? TextFieldWriteAnswer(
                        onSubmit: (String term) => print('answer: $term'),
                      ) : SizedBox(),

                      buildAnswerButton()

                    ],
                  ),
                )

              ],
            ),
          )

        ],
      ),
    );


  }


  Widget buildAnswersList() {

    return Container(
      child: Column(
        children: List.generate(
          data.answers.length,
          (i) {

            return AnswerComponent(
              data: data.answers[i]
            );

          }
        ),
      ),
    );

  }


  Widget buildShowAnswers() {

    return  Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      alignment: Alignment.center,
      child: InkWell(
        onTap: toggleShowAnswersStatus,
        child: Text(
          'Ocultar todas las respuestas',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline
          ),
        ),
      ),
    );

  }


  Widget buildHideAnswers() {

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      alignment: Alignment.center,
      child: InkWell(
        onTap: toggleShowAnswersStatus,
        child: Text(
          'Ver todas las respuestas',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline
          ),
        ),
      ),

    );
  }


  Widget buildAnswerButton() {

    return Container(
      alignment: Alignment.centerLeft,
      height: 40.0,
      child:  MaterialButton(

        highlightColor: Colors.transparent,
        color:     Colors.white,
        textColor: Theme.of(context).primaryColor,
        onPressed: toggleShowBoxAnswer,

        child:     Text(
          !showBoxWriteAnswer ? 'Responder' : 'Ocultar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0
          ),
        ),

      ),
    );

  }


  Widget buildThreadDecoration() {

    final _primaryColor = Theme.of(context).primaryColor;

    return Positioned(
      top:    0,
      left:   15.0,
      bottom: 20.0,
      width:  25.0,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left:   BorderSide(color: _primaryColor, width: 2.0 ),
            bottom: BorderSide(color: _primaryColor, width: 2.0 )
          ),
        ),
      ),
    );

  }

}
