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

  String fullName() => '$lastName $firstName';

  factory UserData.parseJson(dynamic json){

    return UserData(
      avatar:    json['avatar'],
      email:     null,
      firstName: json['firstName'],
      id:        json['_id'],
      lastName:  json['lastName'],

    );
  }

}