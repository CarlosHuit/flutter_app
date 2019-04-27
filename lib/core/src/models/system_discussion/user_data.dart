import 'package:meta/meta.dart';

class UserData {
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;
  final String id;

  UserData({
    @required this.email,
    @required this.firstName,
    @required this.lastName,
    @required this.avatar,
    @required this.id
  });

  factory UserData.parseJson(Map<String, String> json){
    return UserData(
      avatar: null,
      email: null,
      firstName: null,
      id: null,
      lastName: null,
    );
  }

}