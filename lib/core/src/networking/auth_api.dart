import 'dart:async';
import 'dart:convert';

import '../models/models.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class AuthApi {

  http.Client client;
  final String baseUrl = 'https://weduc.herokuapp.com/api/auth';

  AuthApi({@required this.client });


  Future<LoginResponse> login(Credentials credentials) async{
    
    final url = '$baseUrl/signin';
    final response = await client.post(url, body: credentials.toJson());
    final result = json.decode(response.body);
    
    if (response.statusCode == 200)
      return LoginResponse.fromJson(result);
    else
      return throw(result['error']);
    
  }


  Future<LoginResponse> signup(AccountForm accountForm) async {
    
    final url = '$baseUrl/signup';
    final response = await client.post(url, body:accountForm.toJson());
    final result = json.decode(response.body);
    
    if (response.statusCode == 201)
      return LoginResponse.fromJson(result);
    else
      return throw(result['error']);
    
  }


}