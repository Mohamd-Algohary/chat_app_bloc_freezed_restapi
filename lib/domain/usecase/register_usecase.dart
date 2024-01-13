import 'package:dartz/dartz.dart';

import '../model/model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class RegisterUsecase implements BaseUsecase<RegisterRequest, Authentication> {
  final Repository _repository;
  RegisterUsecase(
    this._repository,
  );
  @override
  Future<Either<Failure, Authentication>> excute(
      RegisterRequest registerRequest) async {
    return await _repository.register(registerRequest);
  }
}
