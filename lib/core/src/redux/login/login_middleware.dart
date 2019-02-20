import 'package:app19022019/core/src/redux/navigation/navigation.dart';

import '../../models/credentials.dart';
import '../../models/login_response.dart';
import '../../networking/auth_api.dart';
import '../../redux/app/app_state.dart';
import '../../redux/login/login.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import './login.dart';

class LoginMiddleware extends MiddlewareClass<AppState> {

  final AuthApi api;

  LoginMiddleware({@required this.api});

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async{

    next(action);

    if (action is Login) {
      print('loggging');
      final path = store.state.loginState;
      final credentials = Credentials(path.email, path.password);

      await Future.delayed(Duration(seconds: 1));

      api.login(credentials).then(
        (LoginResponse response) {
          next(LoginSuccess(authLoginResponse: response.auth));
          next(NavigateToHome());
        }

      ).catchError(

        (error) {
          print(error);
          store.dispatch(LoginFailed(error: error));
        }

      );

    }
    

  }
  

}