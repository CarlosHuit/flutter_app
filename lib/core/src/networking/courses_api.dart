import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class CoursesApi {

  http.Client client;
  final FlutterSecureStorage secureStorage;
  final String baseUrl = 'https://weduc.herokuapp.com/api/courses';

  CoursesApi({@required this.client, @required this.secureStorage });


  Future<List<Course>> login(Credentials credentials) async{
    

    final String token = await secureStorage.read(key: 'token');
    final Map headers  = { HttpHeaders.authorizationHeader: token };


    final http.Response response = await client.get(baseUrl, headers: headers);
    

    if (response.statusCode == 200) {

      final List<Map<String, dynamic>> result = json.decode(response.body);
      final List<Course> coursesList = [];

      result.forEach((c) =>  coursesList.add(Course(c)));

      return coursesList;

    } else {

      final Map<String, dynamic> result = json.decode(response.body);
      return throw(result['error']);

    }
    

  }



}