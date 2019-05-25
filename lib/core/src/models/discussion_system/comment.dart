import 'package:app19022019/core/src/models/discussion_system/answer.dart';
import 'package:app19022019/core/src/models/user_model.dart';
import 'package:app19022019/utils/date_format/date_format.dart';
import 'package:meta/meta.dart';



class Comment {

  final String id;
  final DateTime date;
  final String text;
  final String tempId;
  final User user;
  final List<Answer> answers;

  Comment({
    @required this.id,
    @required this.date,
    @required this.text,
    @required this.tempId,
    @required this.user,
    @required this.answers,
  });


  factory Comment.parseJson(dynamic json) {

    return Comment(
      id:       json['id'],
      text:     json['text'],
      tempId:   json['tempId'],
      user:     User.fromJson(json['user']),
      date:     DateTime.parse(json['date']),
      answers:  Answer.parseJsonList(json['answers']),
      // answers:  [],
    );
  }

  String parseDate() {
    return dateFormat(date, ['dd', ' ',  MM, ' ', 'yyyy', ' - ', 'hh', ':', 'nn', ' ', am]);
  }

}