import 'package:app_delivery/src/services/GoogleSingInService/Entities/GoogleSignInUserEntity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInMapper {
  static GoogleSignInUserEntity mapUserCredential(
      UserCredential credential, String idToken) {
    return GoogleSignInUserEntity(credential.user, idToken);
  }
}
