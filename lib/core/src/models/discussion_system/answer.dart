import 'package:app19022019/core/src/models/user_model.dart';
import 'package:app19022019/utils/date_format/date_format.dart';
import 'package:meta/meta.dart';


class Answer {

  final String id;
  final DateTime date;
  final String tempId;
  final String text;
  final User user;

  Answer({
    @required this.user,
    @required this.text,
    @required this.date,
    @required this.id,
    @required this.tempId
  });

  factory Answer.parseJson(dynamic json) {

    return Answer(
      tempId: json['tempId'],
      date:   DateTime.parse(json['date']),
      id:     json['id'],
      text:   json['text'],
      user:   User.fromJson(json['user'])
    );

  }

  static List<Answer> parseJsonList(dynamic jsonAnswers) {

    final answers =
        List.generate(jsonAnswers.length, (i) => Answer.parseJson(jsonAnswers[i]));

    return answers;

  }

  String parseDate() {
    return dateFormat(date, ['dd', ' ',  'MM', ' ', 'yyyy', ' - ', 'hh', ':', 'nn', ' ', am]);
  }


}