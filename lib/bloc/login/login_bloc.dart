import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olearis_test/bloc/login/login_events.dart';
import 'package:olearis_test/bloc/login/login_state.dart';
import 'package:olearis_test/extensions.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState.init()) {
    on<UpdateLoginEvent>((event, emit) => updateLogin(event, emit));
    on<UpdatePasswordEvent>((event, emit) => updatePassword(event, emit));
    on<SignInEvent>((event, emit) => signIn(event, emit));
  }

  void updateLogin(UpdateLoginEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      login: event.login,
      isLoginEnabled: validateFields(
        login: event.login,
        password: state.password,
      ),
    ));
  }

  void updatePassword(UpdatePasswordEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      password: event.password,
      isLoginEnabled: validateFields(
        login: state.login,
        password: event.password,
      ),
    ));
  }

  void signIn(SignInEvent event, Emitter<LoginState> emit) async {
    if (state.status != LoginStatus.loading) {
      emit(state.copyWith(status: LoginStatus.loading));
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: LoginStatus.success));
    }
  }

  bool validateFields({required String? login, required String? password}) {
    return !login.isNullOrEmpty && !password.isNullOrEmpty;
  }
}
