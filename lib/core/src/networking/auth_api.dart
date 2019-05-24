import 'dart:async';
import 'dart:convert';

import 'package:app19022019/core/src/models/auth_response_model.dart';
import 'package:app19022019/core/src/models/forms/signup_form_model.dart';
import 'package:app19022019/environments/environments.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

class AuthApi {


  http.Client client;
  final String apiUrl = '${Environments.apiUrl}/auth';


  AuthApi(this.client);


  Future<AuthResponse> login(Credentials credentials) async{
    
    final url = '$apiUrl/signin';
    print(url);
    final response = await client.post(url, body: credentials.toJson());
    final result = json.decode(response.body);
    
    if (response.statusCode == 201)
      return AuthResponse.fromJson(result);
    else
      return throw(result['error']);
    
  }


  Future<AuthResponse> signup(SignupForm accountForm) async {
    
    final url = '$apiUrl/signup';
    final response = await client.post(url, body: accountForm.toJson());
    final result = json.decode(response.body);
    
    if (response.statusCode == 201)
      return AuthResponse.fromJson(result);
    else
      return throw(result['error']);
    
  }


}