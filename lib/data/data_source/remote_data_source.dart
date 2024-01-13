import '../network/api2.dart';
import '/data/response/response.dart';
import '/domain/model/model.dart';

import '../network/api.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<MessageResponse> sendMessage(String text, String createdAt, String id);
  Future<Map<String, MessageResponse>> getMessages();
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final AppServiceClient _appServiceClient;
  final AppServiceClient2 _appServiceClient2;
  RemoteDataSourceImpl(
    this._appServiceClient,
    this._appServiceClient2,
  );
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password, true);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
        registerRequest.email, registerRequest.password, true);
  }

  @override
  Future<MessageResponse> sendMessage(
      String text, String createdAt, String id) async {
    return await _appServiceClient2.sendMessage(text, createdAt, id);
  }

  @override
  Future<Map<String, MessageResponse>> getMessages() async {
    return await _appServiceClient2.getMessages();
  }
}
