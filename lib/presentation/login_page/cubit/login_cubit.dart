import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/domain/model/model.dart';
import '/domain/usecase/login_usecase.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase _loginUsecase;

  LoginCubit(this._loginUsecase) : super(const LoginState.initial());

  Future<void> login(LoginRequest loginRequest) async {
    emit(const LoginState.loading());
    (await _loginUsecase.excute(loginRequest)).fold((failure) {
      emit(LoginState.errror(failure.message));
    }, (authData) {
      emit(LoginState.success(authData));
    });
  }
}
