import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_task/data/models/auth_requests.dart';
import 'package:job_task/data/remote/api_response.dart';
import 'package:job_task/data/repository/authentication_repository.dart';

import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;
  LoginBloc(this._authenticationRepository) : super(LoginInitialState()) {
    on(_login);
  }

  _login(LoginPressed event, Emitter<LoginState> emit) async {
    emit(LoginProcessingState());
    ApiResponse response = await _authenticationRepository
        .login(LoginRequest(event.email, event.password));
    if (response.status == Status.completed) {
      emit(LoginFinishedState());
    } else {
      emit(LoginErrorState(response.message!));
    }
  }
}
