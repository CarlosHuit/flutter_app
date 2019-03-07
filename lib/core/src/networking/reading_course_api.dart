import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app19022019/core/src/models/reading_course/rc_initial_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class ReadingCourseApi {

  http.Client client;
  final FlutterSecureStorage secureStorage;
  final String baseUrl = 'https://weduc.herokuapp.com/api/initial-data';

  ReadingCourseApi(this.client, this.secureStorage);


  Future<RCInitialData> fetchInitialData() async {

    await Future.delayed(Duration(seconds: 2));

    final token = await secureStorage.read(key: 'token');
    final headers = { HttpHeaders.authorizationHeader: token };
    final response = await client.get(baseUrl, headers: headers);


    if (response.statusCode == 200) {

      final result = json.decode(response.body);
      final  rcInitialData = RCInitialData.fromJson(result);
      return rcInitialData;

    } else {

      final result = json.decode(response.body);
      return throw(result['error']);

    }
    

  }



}