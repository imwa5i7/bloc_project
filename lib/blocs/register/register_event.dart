import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterPressed extends RegisterEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  RegisterPressed(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password});

  @override
  List<Object> get props => [email, password];
}
