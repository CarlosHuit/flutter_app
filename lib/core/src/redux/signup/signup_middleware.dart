import '../../models/models.dart';
import '../../networking/auth_api.dart';
import '../../redux/app/app.dart';
import '../../redux/signup/signup.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class SignupMiddleware extends MiddlewareClass<AppState> {

  final AuthApi api;

  SignupMiddleware({@required this.api});

  @override
  void call(Store<AppState> store, action, NextDispatcher next) {
    next(action);
    if (action is Signup) {

      final path =store.state.signupState;

      final AccountForm accountForm = AccountForm(
        email:      path.email,
        firstName:  path.email,
        lastName:   path.lastName,
        password:   path.password,
        password2:  path.password2,
        avatar:     path.avatar
      );

      api.signup(accountForm).then(
        (LoginResponse response) => store.dispatch(
          SignupSuccess(authLoginResponse: response.auth)
        )
      ).catchError(
        (error) => store.dispatch(
          SignupFailed(error: error)
        )
      );

    }
  }

}