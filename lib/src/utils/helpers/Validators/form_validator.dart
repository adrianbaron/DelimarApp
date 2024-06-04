class EmailFromValidator {
  static String message = "El email no es valido";
  static String? validateEmail({required String email}) {
    String pattern =
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(email) ? null : message;
  }
}

class PasswordFormValidator {
  static String message = "Password invalida";
  static String? validatePassword({required String password}) {
    return password.isNotEmpty && password.length >= 6 ? null : message;
  }
}

class DefaultFormValidator {
  static String message = "El campo esta vacio";
  static String? validateIsNotEmpy({required String value}) {
    return value.isNotEmpty ? null : message;
  }
}
