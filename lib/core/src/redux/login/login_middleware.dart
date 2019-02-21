import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import '../../models/credentials.dart';
import '../../models/login_response.dart';
import '../../networking/auth_api.dart';
import '../../redux/auth/auth_actions.dart';
import '../../redux/courses/courses_actions.dart';
import '../../redux/app/app_state.dart';
import '../../redux/login/login.dart';
import './login.dart';

class LoginMiddleware extends MiddlewareClass<AppState> {

  final AuthApi api;

  LoginMiddleware({@required this.api});

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async{

    next(action);

    if (action is Login) {

      final path = store.state.loginState;
      final credentials = Credentials(path.email, path.password);


      try {

        final LoginResponse response = await api.login(credentials);
        next(SetCourses(courses: response.courses));
        next(PersistAuth(auth: response.auth, screen: 'login'));

      } catch (e) {

        next(LoginFailed(error: e));

        Future.delayed(
          Duration(milliseconds: 100),
          () => next(RemoveLoginError())
        );

      }


    }
    

  }
  

}