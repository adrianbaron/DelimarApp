import 'package:app_delivery/src/services/GoogleSingInService/Entities/GoogleSignInUserEntity.dart';

abstract class GoolgleSignInService {
  Future<GoogleSignInUserEntity> signInWithGoogle();
  Future<bool> isUserInDatabase({required String uid});
}
