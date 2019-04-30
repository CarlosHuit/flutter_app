import 'package:app19022019/utils/date_format/date_format.dart';
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

  factory Answer.parseJson(dynamic json) {

    return Answer(
      commentId: null,
      tempId:    null,
      date:      DateTime.parse(json['date']),
      id:        json['_id'],
      text:      json['text'],
      user:      UserData.parseJson(json['user'])
    );

  }

  String parseDate() {
    return dateFormat(date, ['dd', ' ',  'MM', ' ', 'yyyy', ' - ', 'hh', ':', 'nn', ' ', am]);
  }


}