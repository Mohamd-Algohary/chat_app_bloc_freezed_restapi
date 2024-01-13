class Authentication {
  String localId;
  String email;
  String displayName;
  String idToken;
  bool registered;
  String refreshToken;
  String expiresIn;
  Authentication(
    this.localId,
    this.email,
    this.displayName,
    this.idToken,
    this.registered,
    this.refreshToken,
    this.expiresIn,
  );
}

class LoginRequest {
  String email;
  String password;
  LoginRequest(
    this.email,
    this.password,
  );
}

class RegisterRequest {
  String email;
  String password;
  RegisterRequest(
    this.email,
    this.password,
  );
}

class Failure {
  int statusCode;
  String message;
  Failure(
    this.statusCode,
    this.message,
  );
}

class Message {
  final String text;
  final String id;
  Message(this.text, this.id);
}
