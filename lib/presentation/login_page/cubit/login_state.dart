part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.errror(String err) = _Errror;
  const factory LoginState.success(Authentication authData) = _Success;
}
