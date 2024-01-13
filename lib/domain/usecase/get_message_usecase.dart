import 'package:dartz/dartz.dart';

import '/domain/model/model.dart';
import '/domain/usecase/base_usecase.dart';

import '../repository/repository.dart';

class GetMessageUSecase extends BaseUsecase<String, List<Message>> {
  final Repository _repository;
  GetMessageUSecase(
    this._repository,
  );
  @override
  Future<Either<Failure, List<Message>>> excute(String input) async {
    return await _repository.getMessages();
  }
}
