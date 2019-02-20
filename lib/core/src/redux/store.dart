import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../networking/auth_api.dart';
import '../redux/app/app_state.dart';
import '../redux/login/login_middleware.dart';
import '../redux/signup/signup_middleware.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:key_value_store/key_value_store.dart';
import 'package:http/http.dart';
import './app/app_reducer.dart';
import './navigation/navigation_middleware.dart';

Store<AppState> createStore({
  @required Client client,
  @required KeyValueStore keyValueStore,
  @required FlutterSecureStorage secureStorage
}) {

  final authApi = AuthApi(client: client);

  return Store(
    appReducer,
    initialState: AppState.initialState(keyValueStore: keyValueStore),
    distinct: true,
    middleware: [
      LoginMiddleware(api: authApi),
      SignupMiddleware(api:authApi),
      NavigationMiddleware(),
    ]
  );


}