class Credentials {

  final String email;
  final String password;

  Credentials(this.email, this.password);

  Map<String, String> toJson() {
    return {
      'email':    email,
      'password': password
    };
  }

}