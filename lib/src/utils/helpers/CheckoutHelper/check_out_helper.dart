import 'dart:math';
import 'dart:core';

import 'package:app_delivery/src/features/logica/Entidades/DeliveryAddress/delivery_address_entity.dart';
import 'package:app_delivery/src/features/logica/Entidades/PaymentsMethods/payments_methods_entity.dart';
import 'package:app_delivery/src/utils/extensions/iterable_extensions.dart';

enum PaymentMethodsTypes { visa, mastercard, paypal }

class CheckoutHelper {
  /// Returns the asset image path for the specified payment method.
  ///
  /// [paymentMethod] should be one of the [PaymentMethods] enum values.
  static String getPaymentMethodAssetImage(
      {required PaymentMethodsTypes paymentMethod}) {
    switch (paymentMethod) {
      case PaymentMethodsTypes.visa:
        return "assets/visa.png";
      case PaymentMethodsTypes.mastercard:
        return "assets/mastercard.png";
      case PaymentMethodsTypes.paypal:
        return "assets/paypal.png";
    }
  }

  /// Returns the obfuscated version of the given card number.
  ///
  /// [cardNumber] is the credit card number to obfuscate.
  /// [obfuscationChar] is the character used to replace the digits (default is '*').
  static String obfuscateCardNumber(String cardNumber,
      {String obfuscationChar = '*'}) {
    int len = cardNumber.length;
    int visibleDigits = 4;

    if (len <= visibleDigits) {
      return cardNumber;
    }

    String obfuscated = cardNumber
        .substring(0, len - visibleDigits)
        .replaceAll(RegExp(r'\d'), obfuscationChar);
    String visible = cardNumber.substring(len - visibleDigits);

    return obfuscated + visible;
  }

  /// Generates a random UUID (Version 4) and returns it as a string.
  static String generateUuid() {
    final random = Random();

    String generatePart(int length) {
      return List.generate(length, (_) => random.nextInt(16).toRadixString(16))
          .join('');
    }

    return '${generatePart(8)}-${generatePart(4)}-4${generatePart(3)}-a${generatePart(3)}-${generatePart(12)}';
  }

  /// Validates the name on the credit card.
  /// Returns `true` if the name is not empty and contains only alphabetic characters and spaces.
  static bool isValidCardName(String name) {
    // Remove leading and trailing whitespace and check if the result is not empty
    return name.trim().isNotEmpty && RegExp(r'^[a-zA-Z\s]*$').hasMatch(name);
  }

  /// Validates the credit card number.
  /// Returns `true` if the card number has 15 or 16 digits, ignoring spaces.
  /// Note: This method does not perform Luhn algorithm validation for more robust card number validation.
  static bool isValidCardNumber(String cardNumber) {
    // Remove spaces from the card number
    final sanitizedCardNumber = cardNumber.replaceAll(RegExp(r'\s'), '');
    // Check if the sanitized card number has 15 or 16 digits
    return RegExp(r'^\d{15,16}$').hasMatch(sanitizedCardNumber);
  }

  /// Validates the Card Verification Code (CVC) of the credit card.
  /// Returns `true` if the CVC contains exactly 3 or 4 digits.
  static bool isValidCvc(String cvc) {
    // Check if the CVC contains 3 or 4 digits
    return RegExp(r'^\d{3,4}$').hasMatch(cvc);
  }

  /// Checks if the given input has a valid credit card expiry date format (MM/YY).
  ///
  /// This method validates the input string to ensure it follows the MM/YY format
  /// and checks if the month and year values are valid.
  ///
  /// [input] - A string representing the credit card expiry date.
  ///
  /// Returns `true` if the input has a valid expiry date format, otherwise `false`.
  static bool isValidExpiryDate(String input) {
    // Check if the input matches the MM/YY format
    RegExp expiryDatePattern = RegExp(r'^\d{2}/\d{2}$');
    if (!expiryDatePattern.hasMatch(input)) {
      return false;
    }

    // Split the input into month and year parts
    List<String> parts = input.split('/');
    int month = int.parse(parts[0]);
    int year = int.parse(parts[1]);

    // Check if the month is valid (between 01 and 12)
    if (month < 1 || month > 12) {
      return false;
    }

    // Check if the year is valid (not in the past)
    int currentYear =
        DateTime.now().year % 100; // Get the last 2 digits of the current year
    if (year < currentYear) {
      return false;
    }

    return true;
  }

  /// Checks if the given email is valid.
  ///
  /// This method uses a regular expression to validate the email format.
  /// It returns `true` if the email is valid, `false` otherwise.
  ///
  /// Example usage:
  /// ```
  /// bool isValid = isValidEmail(email: "example@example.com");
  /// ```
  ///
  /// {@tool snippet}
  /// ```dart
  /// String email = "example@example.com";
  /// bool isValid = isValidEmail(email: email);
  /// print("Is the email valid? $isValid"); // Output: Is the email valid? true
  /// ```
  /// {@end-tool}
  ///
  /// @param email The email string to be validated.
  /// @return A boolean value indicating whether the email is valid or not.
  static bool isValidEmail({required String email}) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(email);
  }

  static String formatPriceInEuros(double price) {
    return "${price.toStringAsFixed(3)} COP";
  }

  static DeliveryAddressListEntity getMainDeliveryAddress(
      {required DeliveryAddressListEntity entity}) {
    var newEntity = entity;
    newEntity.deliveryAddressList = entity.deliveryAddressList
        .map((address) {
          if (address.isMainDeliveryAddress) {
            return address;
          } else {
            return null;
          }
        })
        .compactMap()
        .toList();
    return newEntity;
  }

  static PaymentMethodsEntity getMainPaymentMethods(
      {required PaymentMethodsEntity entity}) {
    var newEntity = entity;
    newEntity.paymentMethods = entity.paymentMethods
        .map((address) {
          if (address.isMainPaymentMethod) {
            return address;
          } else {
            return null;
          }
        })
        .compactMap()
        .toList();
    return newEntity;
  }
}
