import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Interfaces/AuthFirebaseInterface.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/BodyParameters/UpdatePasswordBodyParameters.dart';

class DefaultUpdatePasswordUserService extends UpdatePasswordUserService {
  final String _requestType = "PASSWORD_RESET";

  @override
  Future<Map<String, dynamic>> updatePassword({required String email}) async {
    final params =
        UpdatePasswordBodyParameters(requestType: _requestType, email: email);
    return apiService.getDataFromPostRequest(
        bodyParameters: params.toMap(), url: endpoint);
  }
}
