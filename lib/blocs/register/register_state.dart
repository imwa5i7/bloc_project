import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterInitialState extends RegisterState {}

class RegisterProcessingState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String? error;

  RegisterErrorState(this.error);

  @override
  List<Object> get props => [error!];
}

class RegisterFinishedState extends RegisterState {}
