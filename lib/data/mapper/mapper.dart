import '/app/extention.dart';
import '../../domain/model/model.dart';
import '../response/response.dart';

extension AuthenticationResponseMapper on AuthenticationResponse {
  Authentication toDomain() {
    return Authentication(
        localId.orEmpty(),
        email.orEmpty(),
        displayName.orEmpty(),
        idToken.orEmpty(),
        registered ?? false,
        refreshToken.orEmpty(),
        expiresIn.orEmpty());
  }
}

extension MessageResponseMapper on MessageResponse {
  Message toDomain() {
    return Message(text.orEmpty(), id.orEmpty());
  }
}
