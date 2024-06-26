import 'package:app_delivery/src/Base/APIservice/ApiService.dart';

abstract class BaseFirebaseService {
  ApiService apiService = DefaultApiService();
  static String baseUrl = "https://identitytoolkit.googleapis.com/v1/";
  static String adminToken = "AIzaSyCa15EBWaFZnIPFaAMM23QbgRwtoKFBd8I";
  static String registrarse = "accounts:signUp?key=";
  static String iniciarSesion = "accounts:signInWithPassword?key=";
  static String updatePasswordEnpoint = "accounts:signInWithCustomToken?key=";
  static String getUserDataEnpoint = "accounts:lookup?key=";
  static String updateEmailEndpoint = "accounts:update?key=";
}

abstract class SingUpService extends BaseFirebaseService {
  String enpoint = BaseFirebaseService.baseUrl +
      BaseFirebaseService.registrarse +
      BaseFirebaseService.adminToken;

  Future<Map<String, dynamic>> signUp(
      {required Map<String, dynamic> bodyParameters});
}

abstract class SingInService extends BaseFirebaseService {
  String enpoint = BaseFirebaseService.baseUrl +
      BaseFirebaseService.iniciarSesion +
      BaseFirebaseService.adminToken;

  Future<Map<String, dynamic>> signIn(
      {required Map<String, dynamic> bodyParameters});

  Future<String> getIdToken({required Map<String, dynamic> bodyParameters});
}

abstract class UpdatePasswordUserService extends BaseFirebaseService {
  String endpoint = BaseFirebaseService.baseUrl +
      BaseFirebaseService.updatePasswordEnpoint +
      BaseFirebaseService.adminToken;
  Future<Map<String, dynamic>> updatePassword({required String email});
}

abstract class UpdateEmailUserService extends BaseFirebaseService {
  String endpoint = BaseFirebaseService.baseUrl +
      BaseFirebaseService.updateEmailEndpoint +
      BaseFirebaseService.adminToken;
  Future<Map<String, dynamic>> updateEmail(
      {required String oldEmail,
      required String newEmail,
      required String password});
}

abstract class GetUserAuthDataService extends BaseFirebaseService {
  String enpoint = BaseFirebaseService.baseUrl +
      BaseFirebaseService.getUserDataEnpoint +
      BaseFirebaseService.adminToken;

  Future<Map<String, dynamic>> getUserAuthData(
      {required Map<String, dynamic> bodyparameters});
}
