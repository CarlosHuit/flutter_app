import 'package:meta/meta.dart';

import './user_data.dart';

class Answer {
  final UserData user;
  final String text;
  final DateTime date;
  final String commentId;
  final String id;
  final String tempId; //tempId

  Answer({
    @required this.user,
    @required this.text,
    @required this.date,
    @required this.commentId,
    @required this.id,
    @required this.tempId
  });
}