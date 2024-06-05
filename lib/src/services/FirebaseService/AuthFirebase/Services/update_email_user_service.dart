import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Interfaces/AuthFirebaseInterface.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Services/SingInAuthService.dart';

class DefaultUpdateEmailUserService extends UpdateEmailUserService {
  // * Dependencies
  final SingInService _signInService;

  DefaultUpdateEmailUserService({SingInService? signInService})
      : _signInService = signInService ?? DefaultSingInService();

  @override
  Future<Map<String, dynamic>> updateEmail(
      {required String oldEmail,
      required String newEmail,
      required String password}) async {
    try {
      final Map<String, dynamic> signInBodyParameters = {
        'email': oldEmail,
        'password': password,
        'returnSecureToken': true,
      };

      final idToken =
          await _signInService.getIdToken(bodyParameters: signInBodyParameters);

      final Map<String, dynamic> bodyParameters = {
        'email': newEmail,
        'idToken': idToken,
        'returnSecureToken': true,
      };

      return apiService.getDataFromPostRequest(
          bodyParameters: bodyParameters, url: endpoint);
    } on Failure catch (f) {
      return Future.error(Failure.getFirebaseAuthErrorMessage(error: f.error));
    }
  }
}
