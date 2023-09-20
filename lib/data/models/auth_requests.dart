class LoginRequest {
  String email, password;
  LoginRequest(this.email, this.password);
}

class RegisterRequest {
  String firstName, lastName;
  String email, password;
  String contact;

  RegisterRequest(
      this.firstName, this.lastName, this.email, this.password, this.contact);
}
