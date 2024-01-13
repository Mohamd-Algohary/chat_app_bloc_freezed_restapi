import 'package:dartz/dartz.dart';
import '/domain/model/model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);
  Future<Either<Failure, String>> sendMessage(
      {required String text, required String email});
  Future<Either<Failure, List<Message>>> getMessages();
}
