import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../app/constants.dart';
import '/domain/model/model.dart';
import '../../../domain/usecase/register_usecase.dart';
part 'register_state.dart';
part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUsecase _registerUsecase;
  RegisterCubit(this._registerUsecase) : super(const RegisterState.initial());

  Future<void> register(RegisterRequest registerRequest) async {
    emit(const RegisterState.loading());
    (await _registerUsecase.excute(registerRequest)).fold((failure) {
      emit(RegisterState.errror(failure.message));
    }, (auth) {
      Constants.token = auth.idToken;
      emit(const RegisterState.success());
    });
  }
}
