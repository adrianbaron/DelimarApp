import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/AuthFirebaseInterface.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/BodyParameters/UpdatePasswordBodyParameters.dart';

class DefaultUpdatePasswordUserService extends UpdatePasswordUserService {
  final String _requestType = "PASSWORD_RESET";
  @override
  Future<Map<String, dynamic>> updatePassword({required String email}) {
    final _params =
        UpdatePasswordBodyParameters(email: email, requestType: _requestType);
    return apiService.getDataFromPostRequest(
        bodyParameters: _params.toJson(), url: enpoint);
  }
}
