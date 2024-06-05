import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Interfaces/AuthFirebaseInterface.dart';

class DefaultSingInService extends SingInService {
  @override
  Future<Map<String, dynamic>> signIn(
      {required Map<String, dynamic> bodyParameters}) {
    return apiService.getDataFromPostRequest(
        bodyParameters: bodyParameters, url: enpoint);
  }

  @override
  Future<String> getIdToken(
      {required Map<String, dynamic> bodyParameters}) async {
    try {
      final userData = await signIn(bodyParameters: bodyParameters);
      return userData['idToken'] as String;
    } on Failure catch (f) {
      return Future.error(Failure.getFirebaseAuthErrorMessage(error: f.error));
    }
  }
}
