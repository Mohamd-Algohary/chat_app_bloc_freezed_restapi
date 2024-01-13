import 'package:dartz/dartz.dart';

import '../model/model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class LoginUsecase implements BaseUsecase<LoginRequest, Authentication> {
  final Repository _repository;
  LoginUsecase(
    this._repository,
  );
  @override
  Future<Either<Failure, Authentication>> excute(
      LoginRequest loginRequest) async {
    return await _repository.login(loginRequest);
  }
}
