import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_task/data/models/auth_requests.dart';
import 'package:job_task/data/repository/authentication_repository.dart';
import '../../data/remote/api_response.dart';
import 'register.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRepository _authenticationRepository;
  RegisterBloc(this._authenticationRepository) : super(RegisterInitialState()) {
    on(_register);
  }

  _register(RegisterPressed event, Emitter<RegisterState> emit) async {
    emit(RegisterInitialState());
    ApiResponse response = await _authenticationRepository.register(
        RegisterRequest(
            event.firstName, event.lastName, event.email, event.password, ''));
    if (response.status == Status.completed) {
      emit(RegisterFinishedState());
    } else {
      emit(RegisterErrorState(response.message!));
    }
  }
}
