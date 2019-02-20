class User {

  String firstName;
  String lastName;
  String email;
  String password; 
  String password2;
  String token;

  User( this.firstName, this.lastName, this.email, this.password, this.password2, this.token );

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName  = json['lastName'];
    email     = json['email'];
    password  = json['password'];
    password2 = json['password2'];
    token     = json['token'];
  }

  String fullName() => '$firstName $lastName';


}
