import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/AuthFirebaseInterface.dart';

class DefaultSingInService extends SingInService {
  @override
  Future<Map<String, dynamic>> signIn(
      {required Map<String, dynamic> bodyParameters}) {
    return apiService.getDataFromPostRequest(
        bodyParameters: bodyParameters, url: enpoint);
  }
}
