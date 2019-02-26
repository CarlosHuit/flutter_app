import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class ReadingCourseApi {

  http.Client client;
  final FlutterSecureStorage secureStorage;
  final String baseUrl = 'https://weduc.herokuapp.com/api/initital-data';

  ReadingCourseApi({@required this.client, @required this.secureStorage });


  Future<void> fetchInitialData() async {


    final String token = await secureStorage.read(key: 'token');
    final Map<String, String> headers = { HttpHeaders.authorizationHeader: token };

    final http.Response response = await client.get(baseUrl, headers: headers);

    if (response.statusCode == 200) {

      print(response);

    } else {

      final Map<String, dynamic> result = json.decode(response.body);
      print( result['error'] );
      return throw(result['error']);

    }
    

  }



}