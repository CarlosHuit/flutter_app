import 'package:app19022019/core/src/models/auth_response_model.dart';
import 'package:meta/meta.dart';

class PersistAuth {

  final AuthResponse auth;
  final String screen;

    PersistAuth({@required this.auth, @required this.screen});
  
}

class Logout {}

class RemoveAuth {}

class InvalidAuthCredentials {}