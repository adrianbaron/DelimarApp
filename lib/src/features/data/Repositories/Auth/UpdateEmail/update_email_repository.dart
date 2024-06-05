import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Interfaces/AuthFirebaseInterface.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Services/update_email_user_service.dart';

class DefaultUpdateEmailRepository extends UpdateEmailRepository {
  // * Dependencies
  final UpdateEmailUserService _updateEmailUserService;

  DefaultUpdateEmailRepository({UpdateEmailUserService? updateEmailUserService})
      : _updateEmailUserService =
            updateEmailUserService ?? DefaultUpdateEmailUserService();

  @override
  Future<dynamic> updateEmail(
      {required String oldEmail,
      required String newEmail,
      required String password}) async {
    try {
      final result = await _updateEmailUserService.updateEmail(
          password: password, oldEmail: oldEmail, newEmail: newEmail);
      return result;
    } on Failure catch (f) {
      return Future.error(Failure.getFirebaseAuthErrorMessage(error: f.error));
    }
  }
}
