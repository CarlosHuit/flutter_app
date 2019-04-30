import 'package:flutter/material.dart';

import './answer.dart';

class Answers {
  final String commentId; // comment_id
  final List<Answer> answers;
  final String id; // _id

  Answers({
    @required this.commentId,
    @required this.answers,
    @required this.id
  }); 

  factory Answers.parseJson(dynamic json) {

    final answersList = List.from(json['answers']);
    final answers = answersList.map((el) => Answer.parseJson(el)).toList();

    return Answers(
      answers:   answers,
      commentId: json['comment_id'],
      id:        json['_id']
    );

  }

}