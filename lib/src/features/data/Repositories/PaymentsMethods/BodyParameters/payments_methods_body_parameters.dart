import 'dart:convert';

class PaymentMethodsBodyParameters {
  final List<PaymentMethodBodyParameters> paymentMethods;

  PaymentMethodsBodyParameters({
    required this.paymentMethods,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'paymentMethods': paymentMethods.map((card) => card.toMap()).toList(),
    };
  }

  factory PaymentMethodsBodyParameters.fromMap(Map<String, dynamic> json) {
    return PaymentMethodsBodyParameters(
      paymentMethods: List<PaymentMethodBodyParameters>.from(
          json['paymentMethods']
              .map((card) => PaymentMethodBodyParameters.fromMap(card))),
    );
  }

  static PaymentMethodsBodyParameters getEmptyPaymentMethods() {
    return PaymentMethodsBodyParameters(paymentMethods: []);
  }
}

class PaymentMethodBodyParameters {
  final String nameInTheCard;
  final String cardNumber;
  final String monthAndYear;
  final String cvc;
  final String country;
  final String type;
  final String email;
  final String id;
  final bool isMainPaymentMethod;

  PaymentMethodBodyParameters(
      {required this.nameInTheCard,
      required this.cardNumber,
      required this.monthAndYear,
      required this.cvc,
      required this.country,
      required this.type,
      required this.email,
      required this.id,
      required this.isMainPaymentMethod});

  factory PaymentMethodBodyParameters.fromMap(Map<String, dynamic> json) {
    return PaymentMethodBodyParameters(
        nameInTheCard: json['nameInTheCard'],
        cardNumber: json['cardNumber'],
        monthAndYear: json['monthAndYear'],
        cvc: json['cvc'],
        country: json['country'],
        type: json['type'],
        email: json['email'],
        id: json['id'],
        isMainPaymentMethod: json['isMainPaymentMethod']);
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'nameInTheCard': nameInTheCard,
      'cardNumber': cardNumber,
      'monthAndYear': monthAndYear,
      'cvc': cvc,
      'country': country,
      'type': type,
      'email': email,
      'id': id,
      'isMainPaymentMethod': isMainPaymentMethod
    };
  }
}
