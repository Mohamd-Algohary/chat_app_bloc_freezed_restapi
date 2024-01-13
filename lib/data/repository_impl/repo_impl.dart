import 'package:dartz/dartz.dart';

import '/data/data_source/remote_data_source.dart';
import '/data/mapper/mapper.dart';
import '/data/network/error_handler.dart';
import '../network/network_info.dart';
import '/domain/model/model.dart';
import '/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  List<Message> messageList = [];
  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (_networkInfo.isConnected) {
      try {
        var res = await _remoteDataSource.login(loginRequest);
        return Right(res.toDomain());
      } catch (err) {
        return Left(ErrorHandler.handle(err).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (_networkInfo.isConnected) {
      try {
        var res = await _remoteDataSource.register(registerRequest);
        return Right(res.toDomain());
      } catch (err) {
        return Left(ErrorHandler.handle(err).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Message>>> getMessages() async {
    if (_networkInfo.isConnected) {
      try {
        var res = await _remoteDataSource.getMessages();
        messageList.clear();
        res.forEach((key, msg) {
          messageList.add(msg.toDomain());
        });
        return Right(messageList);
      } catch (err) {
        return Left(ErrorHandler.handle(err).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> sendMessage(
      {required String text, required String email}) async {
    //scholar-chat-1cc87
    //https://fcm.googleapis.com/v1/projects/scholar-chat-1cc87/messages:send
    if (_networkInfo.isConnected) {
      try {
        var res = await _remoteDataSource.sendMessage(
            text, DateTime.now().toIso8601String(), email);

        return Right(res.toDomain().text);
      } catch (err) {
        return Left(ErrorHandler.handle(err).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
