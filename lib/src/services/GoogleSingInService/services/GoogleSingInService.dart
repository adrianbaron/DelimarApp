import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Interfaces/interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Services/realTimeDatabaseService.dart';
import 'package:app_delivery/src/services/GoogleSingInService/Entities/GoogleSignInUserEntity.dart';
import 'package:app_delivery/src/services/GoogleSingInService/Interfaces/interface.dart';
import 'package:app_delivery/src/services/GoogleSingInService/Mappers/GoogleSignInMapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DefaultGoogleSignInService extends GoolgleSignInService {
  final String _path = "users/";

  //DEPENDENCIA
  final RealtimeDataBaseService _realTimeDataBaseService;

  DefaultGoogleSignInService({RealtimeDataBaseService? realTimeDataBaseService})
      : _realTimeDataBaseService =
            realTimeDataBaseService ?? DefaultRealtimeDatabaseService();

  @override
  Future<bool> isUserInDatabase({required String uid}) async {
    final fullPath = _path + uid;
    try {
      final result = await _realTimeDataBaseService.getData(path: fullPath);
      return result.isNotEmpty;
    } on Failure catch (f) {
      return false;
    }
  }

  @override
  Future<GoogleSignInUserEntity> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return GoogleSignInMapper.mapUserCredential(
        userCredential, googleAuth?.idToken ?? "");
  }
}
