import 'dart:convert';
import 'dart:io';

import 'package:app19022019/core/src/models/course_model.dart';
import 'package:app19022019/core/src/models/discussion_system/comment.dart';
import 'package:app19022019/core/src/models/discussion_system/forms/comment_form_model.dart';
import 'package:app19022019/environments/environments.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;



class DiscussionSystemApi {

  http.Client client;
  final FlutterSecureStorage secureStorage;
  final String apiUrl = '${Environments.apiUrl}/courses';

  DiscussionSystemApi( this.client, this.secureStorage );


  Future<List<Comment>> getCommentsCourse(Course course) async {


    final url = '$apiUrl/${course.subtitle}/comments';
    final token = await secureStorage.read(key: 'token');
    final headers = { HttpHeaders.authorizationHeader: token };


    final response = await client.get( url, headers: headers );


    if (response.statusCode ==  200) {

      final result = json.decode(response.body);
      final commentsListJson = List.from(result);


      if (commentsListJson.length > 0) {
        return parseComments(commentsListJson);
      }

      return [];

    }


    return throw('No hay comentarios para mostrar');


  }


  List<Comment> parseComments(List<dynamic> commentsListJson ){

    final comments =
        commentsListJson.map((comment) => Comment.parseJson(comment)).toList();

    return comments;

  }



  Future<Comment> addComment(CommentForm comment, Course course) async {
  
    final url = '$apiUrl/${course.subtitle}/comments';
    final token  = await secureStorage.read(key: 'token');
    final headers = { HttpHeaders.authorizationHeader: token };
    final response = await client.post(url, headers: headers, body: comment.toJson());
    final result = json.decode(response.body);

    print(response.statusCode); 

    if (response.statusCode == 201) {
  
      return Comment.parseJson(result);

    } else {
  
      return throw('Error al agregar comentario');
  
    }
  
  
  }


}