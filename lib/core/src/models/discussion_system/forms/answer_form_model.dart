import 'package:meta/meta.dart';

class AnswerForm {

  final String text;
  final DateTime date;
  final String tempId;
  final String userId;
  final String commentId;

  AnswerForm({
    @required this.text,
    @required this.date,
    @required this.tempId,
    @required this.userId,
    @required this.commentId,
  });

  Map<String, String> toJson() {
    return {
      'text': text,
      'date': date.toString(),
      'tempId': tempId,
      'userId': userId,
      'commentId': commentId,
    };
  }

}