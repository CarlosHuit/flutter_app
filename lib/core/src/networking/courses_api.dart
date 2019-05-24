import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

class CoursesApi {

  http.Client client;
  final FlutterSecureStorage secureStorage;
  final String baseUrl = 'https://weduc.herokuapp.com/api/courses';

  CoursesApi(this.client, this.secureStorage);


  Future<List<Course>> fetchCourses() async{
    

    final token = await secureStorage.read(key: 'token');
    final headers  = { HttpHeaders.authorizationHeader: token };
    final response = await client.get(baseUrl, headers: headers);


    

    if (response.statusCode == 200) {

      List<dynamic> result = json.decode(response.body);
      List<Course> coursesList = [];

      result.forEach((c) =>  coursesList.add(Course.fromJson(c)));

      return coursesList;

    } else {

      final result = json.decode(response.body);
      return throw(result['error']);

    }
    

  }



}