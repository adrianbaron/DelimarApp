abstract class AppFailureMessages {
  // Error Messages
  static String unExpectedErrorMessage = "Ha occurrido un error inesperado";
}

abstract class FBFailureMessages {
  // Error Messages
  static String emailNotFoundMessage =
      "There is no user record corresponding to this identifier. The user may have been deleted.";
  static String invalidPasswordMessage =
      "The password is invalid or the user does not have a password.";
  static String emailExistMessage =
      "La dirección de correo electrónico ya está siendo utilizada por otra cuenta.";
  static String tooManyAttemptsMessage =
      "Hemos bloqueado todas las solicitudes de este dispositivo debido a una actividad inusual. Vuelve a intentarlo más tarde.";
  static String invalidIdTokenMessage =
      "La credencial del usuario ya no es válida. El usuario debe iniciar sesión nuevamente.";
  static String userNotFoundMessage =
      "No hay ningún registro de usuario que corresponda a este identificador. Es posible que se haya eliminado al usuario.";
}
