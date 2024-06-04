import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/AuthFirebaseInterface.dart';

class DefaultSingUpService extends SingUpService {
  @override
  Future<Map<String, dynamic>> signUp(
      {required Map<String, dynamic> bodyParameters}) {
    return apiService.getDataFromPostRequest(
        bodyParameters: bodyParameters, url: enpoint);
  }
}
