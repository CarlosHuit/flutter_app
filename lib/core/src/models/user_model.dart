import 'package:meta/meta.dart';

class User {

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;

  User({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.avatar
  }); 


  factory User.fromJson(Map<String, dynamic> json) {

    return User(
      id:        json['id'],
      firstName: json['firstName'],
      lastName:  json['lastName'],
      email:     json['email'],
      avatar:    json['avatar'],
    );

  }

  Map<String, String> toJson() {

    return {
      'id':        id,
      'firstName': firstName,
      'lastName':  lastName,
      'email':     email,
      'avatar':    avatar,
    };

  }

  String fullName() => '$firstName $lastName';


}
