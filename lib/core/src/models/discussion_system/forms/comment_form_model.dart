import 'package:meta/meta.dart';

class CommentForm {

  final String text;
  final DateTime date;
  final String tempId;
  final String userId;
  final String courseId;

  CommentForm({
    @required this.text,
    @required this.date,
    @required this.tempId,
    @required this.userId,
    @required this.courseId,
  });

  Map<String, dynamic> toJson() {

    return {
      'date': date.toIso8601String(),
      'text': text,
      'userId': userId,
      'tempId': tempId,
      'courseId': courseId,
    };

  }

}