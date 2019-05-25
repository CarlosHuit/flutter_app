import 'dart:convert';
import 'dart:io';

import 'package:app19022019/core/src/models/discussion_system/comment.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;



class DiscussionSystemApi {

  http.Client client;
  final FlutterSecureStorage secureStorage;
  final String baseUrl = 'https://weduc.herokuapp.com/api/comments';


  DiscussionSystemApi( this.client, this.secureStorage );


  Future<List<Comment>> getAllComments(String courseId) async {

    await Future.delayed(Duration(milliseconds: 1200));

    final url = '$baseUrl/$courseId';
    final token = await secureStorage.read(key: 'token');
    final headers = { HttpHeaders.authorizationHeader: token };

    final response = await client.get( url, headers: headers );

    if (response.statusCode ==  200) {


      final result = json.decode(response.body);
      final commentsListJson = List.from(result);

      if (commentsListJson.length > 0)
        return parseComments(commentsListJson);
      else
        return [];


    } else {

      return throw('No hay comentarios para mostrar');

    }


  }


  List<Comment> parseComments(List<dynamic> commentsListJson ){

    final comments = commentsListJson
        .map((comment) => Comment.parseJson(comment)).toList();

    return comments;

  }



  // Future<Comment> addComment(Comment comment) async {
  addComment(Comment comment) async {
  
  
    final data  = json.encode(comment);
    final token  = await secureStorage.read(key: 'token');
    final headers = { HttpHeaders.authorizationHeader: token };
    final response = await client.post(baseUrl, headers: headers, body: data);
  
    if (response.statusCode == 200) {
  
      final result = json.decode(response.body);
  
    } else {
  
      return throw('Error al agregar comentario');
  
    }
  
  
  }


}