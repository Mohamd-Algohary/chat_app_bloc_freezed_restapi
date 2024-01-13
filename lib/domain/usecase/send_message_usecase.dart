import 'package:dartz/dartz.dart';

import '/domain/model/model.dart';
import '/domain/usecase/base_usecase.dart';
import '../repository/repository.dart';

class SendMessageUSecase extends BaseUsecase<Message, String> {
  final Repository _repository;
  SendMessageUSecase(
    this._repository,
  );
  @override
  Future<Either<Failure, String>> excute(Message input) async {
    return await _repository.sendMessage(text: input.text, email: input.id);
  }
}
