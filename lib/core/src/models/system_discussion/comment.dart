import 'package:meta/meta.dart';
import './user_data.dart';



class Comment {

  final String   id;
  final UserData user;
  final String   text;
  final DateTime date;
  final dynamic  answers;
  final String   courseId;
  final String   tempId;

  Comment({
    @required this.id,
    @required this.user,
    @required this.text,
    @required this.date,
    @required this.answers,
    @required this.courseId,
    @required this.tempId
  });

  factory Comment.parseJson(Map<String, dynamic> json) {
    return Comment(
      id:  null,
      date: null,
      text:  null,
      user:   null,
      tempId:  null,
      answers:  null,
      courseId:  null,
    );
  }

}