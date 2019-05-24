import 'dart:async';
import 'dart:convert';

import 'package:app19022019/environments/environments.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

class AuthApi {


  http.Client client;
  final String apiUrl = '${Environments.apiUrl}/auth';


  AuthApi(this.client);


  Future<LoginResponse> login(Credentials credentials) async{
    
    final url = '$apiUrl/signin';
    print(url);
    final response = await client.post(url, body: credentials.toJson());
    final result = json.decode(response.body);

    print(result);
    
    // if (response.statusCode == 200)
    //   return LoginResponse.fromJson(result);
    // else
    //   return throw(result['error']);
    
  }


  Future<LoginResponse> signup(AccountForm accountForm) async {
    
    final url = '$apiUrl/signup';
    final response = await client.post(url, body:accountForm.toJson());
    final result = json.decode(response.body);
    
    if (response.statusCode == 201)
      return LoginResponse.fromJson(result);
    else
      return throw(result['error']);
    
  }


}