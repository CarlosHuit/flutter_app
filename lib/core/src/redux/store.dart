import 'package:app19022019/core/src/models/auth_login_response.dart';
import 'package:app19022019/core/src/redux/auth/auth_middleware.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:key_value_store/key_value_store.dart';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';
import 'dart:convert';

import './navigation/navigation_middleware.dart';
import '../redux/signup/signup_middleware.dart';
import '../redux/login/login_middleware.dart';
import '../redux/app/app_state.dart';
import '../networking/auth_api.dart';
import './app/app_reducer.dart';
import '../redux/courses/courses.dart';


Future<Store<AppState>> createStore({
  @required Client client,
  @required KeyValueStore keyValueStore,
  @required FlutterSecureStorage secureStorage
}) async {
  
  
  final AuthApi authApi = AuthApi(client: client);
  final String authJson = await secureStorage.read(key: 'auth');
  final AuthLoginResponse auth = authJson != null ? AuthLoginResponse.fromJson(json.decode(authJson)) : null;


  return Store(
    appReducer,
    distinct: true,
    initialState: AppState.initialState( keyValueStore: keyValueStore, auth: auth ),
    middleware: [
      LoginMiddleware(api: authApi),
      SignupMiddleware(api:authApi),
      AuthMiddleware(secureStorage: secureStorage),
      CoursesMiddleware(),
      NavigationMiddleware(),
    ]
  );
  
  
}