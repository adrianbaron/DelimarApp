import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Interfaces/AuthFirebaseInterface.dart';

class DefaultGetUserAuthDataService extends GetUserAuthDataService {
  @override
  Future<Map<String, dynamic>> getUserAuthData(
      {required Map<String, dynamic> bodyparameters}) {
    return apiService.getDataFromPostRequest(
        bodyParameters: bodyparameters, url: enpoint);
  }
}
