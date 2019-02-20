import '../../networking/auth_api.dart';
import '../../redux/app/app_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class AuhtMiddleware extends MiddlewareClass<AppState> {

  final AuthApi api;
  AuhtMiddleware({@required this.api});

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async {
    
    next(action);


  }
  
}