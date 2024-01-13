import 'package:freezed_annotation/freezed_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class AuthenticationResponse {
  @JsonKey(name: 'localId')
  String? localId;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'displayName')
  String? displayName;
  @JsonKey(name: 'idToken')
  String? idToken;
  @JsonKey(name: 'registered')
  bool? registered;
  @JsonKey(name: 'refreshToken')
  String? refreshToken;
  @JsonKey(name: 'expiresIn')
  String? expiresIn;

  AuthenticationResponse(
    this.localId,
    this.email,
    this.displayName,
    this.idToken,
    this.registered,
    this.refreshToken,
    this.expiresIn,
  );

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class MessageResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "text")
  String? text;

  MessageResponse(this.id, this.text);
  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MessageResponseToJson(this);
}
