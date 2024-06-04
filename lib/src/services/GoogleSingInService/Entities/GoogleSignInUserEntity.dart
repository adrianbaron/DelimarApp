import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInUserEntity {
  String? displayName;
  String? email;
  bool? emailVerified;
  bool? isAnonymous;
  String? phoneNumber;
  String? photoURL;
  String? refreshToken;
  String? tenatId;
  String? uid;
  String? idToken;

  GoogleSignInUserEntity(User? user, String? token) {
    displayName = user?.displayName;
    email = user?.email;
    emailVerified = user?.emailVerified;
    isAnonymous = user?.isAnonymous;
    phoneNumber = user?.phoneNumber;
    photoURL = user?.photoURL;
    refreshToken = user?.refreshToken;
    tenatId = user?.tenantId;
    uid = user?.uid;
    idToken = token;
  }
}
