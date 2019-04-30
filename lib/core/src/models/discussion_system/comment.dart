import 'package:app19022019/core/src/models/discussion_system/answers.dart';
import 'package:app19022019/utils/date_format/date_format.dart';
import 'package:meta/meta.dart';
import './user_data.dart';



class Comment {

  final String   id;
  final UserData user;
  final String   text;
  final DateTime date;
  final Answers  answers;
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

  factory Comment.parseJson(dynamic json) {


    return Comment(
      id:       json['_id'],
      date:     DateTime.parse(json['date']),
      text:     json['text'],
      user:     UserData.parseJson(json['user_id']),
      tempId:   null,
      answers:  Answers.parseJson(json['answers_id']),
      courseId: null,
    );
  }

  String parseDate() {
    return dateFormat(date, ['dd', ' ',  MM, ' ', 'yyyy', ' - ', 'hh', ':', 'nn', ' ', am]);
  }

}