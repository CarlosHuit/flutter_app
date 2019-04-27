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

  factory Answers.parseJson() {

    return Answers(
      answers: null,
      commentId: null,
      id: null
    );

  }

}