import 'dart:math';

import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Auth/SingUpUseCase/SingUpCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Auth/SingUpUseCase/SingUpUseCaseParameters.dart';
import 'package:app_delivery/src/features/logica/Entidades/Auth/SingUpEntity/SingUpEntity.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Decorable/AuthErrorDecorable.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';
import 'package:flutter_test/flutter_test.dart';

abstract class _Constants {
  static String correctEmail = "adrianbaron127@gmail.com";
  static String correctPass = "123456";
  static String wrongEmail = "adrianbaron12@gmail.com";
  static String wrongPass = "12345678";
}

void main() {
  //GIVEN
  final SingUpUseCase sut = DefaultSingUpUseCase();

  group("Test sucess singUp user", () {
    test("Test succes singUp user in Firebase", () async {
      final SingUpUseCaseParameters params = SingUpUseCaseParameters(
          username: "Pulpo",
          email: _Constants.correctEmail,
          password: _Constants.correctPass,
          phone: "3112334421",
          date: "22/10/2001");

      //WHEN

      final result = await sut.execute(params: params);

      switch (result.status) {
        case ResultStatus.success:
          // THEN
          expect(result.value, isA<SingUpEntity>());
        case ResultStatus.error:
          // THEN
          expect(result.error, Failure);
      }
    });
  });

  group("Si algo sale mal", () {
    test("Error al registrase en firebase", () async {
      try {
        //WHEN
        final SingUpUseCaseParameters params = SingUpUseCaseParameters(
            username: "Pulpo",
            email: _Constants.correctEmail,
            password: _Constants.correctPass,
            phone: "3112334421",
            date: "22/10/2001");
        final _ = await sut.execute(params: params);
      } on Failure catch (f) {
        //THEN
        AuthErrorDecodable _error = f as AuthErrorDecodable;
        expect(_error.error!.message, FBFailureMessages.emailExistMessage);
      }
    });
  });
}
