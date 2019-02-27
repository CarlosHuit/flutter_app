import 'dart:convert';
import 'dart:io';
import 'package:app19022019/core/src/models/reading_course/rc_initial_data.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class ReadingCourseApi {

  http.Client client;
  final FlutterSecureStorage secureStorage;
  final String baseUrl = 'https://weduc.herokuapp.com/api/initial-data';

  ReadingCourseApi({@required this.client, @required this.secureStorage });


  Future<RCInitialData> fetchInitialData() async {


    final String token = await secureStorage.read(key: 'token');
    final Map<String, String> headers = { HttpHeaders.authorizationHeader: token };

    final http.Response response = await client.get(baseUrl, headers: headers);

    if (response.statusCode == 200) {

      final Map<String, dynamic> result = json.decode(response.body);
      final RCInitialData rcInitialData = RCInitialData.fromJson(result);
      return rcInitialData;

    } else {

      final Map<String, dynamic> result = json.decode(response.body);
      return throw(result['error']);

    }
    

  }



}