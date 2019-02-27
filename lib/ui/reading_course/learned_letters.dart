import 'package:app19022019/core/src/viewmodels/reading_course/reading_course_view_model.dart';
import 'package:flutter/material.dart';

Widget learnedLetters( BuildContext context, ReadingCourseViewModel viewModel ) {

  print('IsLoading? ${viewModel.isLoading}');

  if (viewModel.isLoading == true) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      alignment: Alignment.topCenter,
      child: CircularProgressIndicator(),
    );
  }

  if (viewModel.isLoading == false) {
    return Container(
      alignment: Alignment.center,
      child:    Text( 'learnedLetters' )
    );
  }
  return null;
}

Widget tabLearnedLetters() {
  return Tab(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.favorite, color: Colors.red,),
        SizedBox(width: 5.0,),
        Text(
          'Aprendidas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0
          ),
        ),
      ],
    ),
  );
}