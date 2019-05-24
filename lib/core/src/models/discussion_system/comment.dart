import 'package:app19022019/core/src/models/discussion_system/answers.dart';
import 'package:app19022019/utils/date_format/date_format.dart';
import 'package:meta/meta.dart';
import './user_data.dart';



class Comment {

  /// comment id used to identify current comment
  final String   id;

  /// comment text content
  final String   text;

  /// user is usef to display user data on the screen
  final UserData user;

  /// userId is used to save comment in the database, 
  final String   userId;

  /// DateTime of comment creation
  final DateTime date;

  /// Answers of current comment
  final Answers  answers;

  /// id to associate the comments to a course
  final String   courseId;

  /// temporary id generated to handle comment transaction (save)
  final String   tempId;

  Comment({
    @required this.id,
    @required this.user,
    @required this.text,
    @required this.date,
    @required this.answers,
    @required this.courseId,
    @required this.tempId,
    @required this.userId,
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
      userId:   null,
    );
  }

  String parseDate() {
    return dateFormat(date, ['dd', ' ',  MM, ' ', 'yyyy', ' - ', 'hh', ':', 'nn', ' ', am]);
  }

}