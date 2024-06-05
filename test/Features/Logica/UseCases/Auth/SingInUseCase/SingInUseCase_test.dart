import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Auth/SingInUseCase/SingInUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Auth/SingInUseCase/SingInUseCaseBodyParameters.dart';
import 'package:app_delivery/src/features/logica/Entidades/Auth/SingInEntity/SingInEntity.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Decorable/AuthErrorDecorable.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';
import 'package:flutter_test/flutter_test.dart';

abstract class _Constants {
  static String correctEmail = "adrianbaron17@gmail.com";
  static String correctPass = "123456";
  static String wrongEmail = "adrianbarohjghjgn12@gmail.com";
  static String wrongPass = "12345HGgfh678";
}

void main() {
  //GIVEN
  final SingInUseCase sut = DefaultSignInUseCase();

  group("Test sucess response to SingInUseCase", () {
    test("Test sucess singIn features with correct email password", () async {
      //GIVEN
      final SignInUseCaseParameters _params = SignInUseCaseParameters(
          email: _Constants.correctEmail, password: _Constants.correctPass);

      //
      var result = await sut.execute(params: _params);

      switch (result.status) {
        case ResultStatus.success:
          // THEN
          expect(result.value, isA<SingInEntity>());
        case ResultStatus.error:
          // THEN
          expect(result.error, Failure);
      }
    });
//
  });

  group("Failure response to singInUseCase", () {
    test("Email no valido", () async {
      //GIVEN
      final SignInUseCaseParameters _params = SignInUseCaseParameters(
          email: _Constants.wrongEmail, password: _Constants.wrongPass);

      try {
        final _ = await sut.execute(params: _params);
      } on Failure catch (f) {
        AuthErrorDecodable _error = f as AuthErrorDecodable;
        //THEN
        expect(_error.error!.message, FBFailureMessages.emailNotFoundMessage);
      }
    });

    test("Contraseña no valida", () async {
      //GIVEN
      final SignInUseCaseParameters _params = SignInUseCaseParameters(
          email: _Constants.correctEmail, password: _Constants.wrongPass);

      try {
        final _ = await sut.execute(params: _params);
      } on Failure catch (f) {
        AuthErrorDecodable _error = f as AuthErrorDecodable;
        //THEN
        expect(_error.error!.message, FBFailureMessages.invalidPasswordMessage);
      }
    });
  });
}
