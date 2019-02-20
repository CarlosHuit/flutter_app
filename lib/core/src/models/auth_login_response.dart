class AuthLoginResponse {
  final String token;
  final String message;
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;

  AuthLoginResponse(
    this.token,
    this.message,
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.avatar
  );

  Map<String, dynamic> toJson() {
    return {
      'token':     token,
      'message':   message,
      'userId':    userId,
      'firstName': firstName,
      'lastName':  lastName,
      'email':     email,
      'avatar':    avatar,
    };
  }

}