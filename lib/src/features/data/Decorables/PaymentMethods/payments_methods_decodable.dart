import 'dart:convert';

class PaymentMethodsDecodable {
  final List<PaymentMethodDecodable> paymentMethods;

  PaymentMethodsDecodable({
    required this.paymentMethods,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'paymentMethods': paymentMethods.map((card) => card.toMap()).toList(),
    };
  }

  factory PaymentMethodsDecodable.fromMap(Map<String, dynamic> json) {
    return PaymentMethodsDecodable(
      paymentMethods: List<PaymentMethodDecodable>.from(json['paymentMethods']
          .map((card) => PaymentMethodDecodable.fromMap(card))),
    );
  }

  static PaymentMethodsDecodable getEmptyPaymentMethods() {
    return PaymentMethodsDecodable(paymentMethods: []);
  }
}

class PaymentMethodDecodable {
  final String nameInTheCard;
  final String cardNumber;
  final String monthAndYear;
  final String cvc;
  final String country;
  final String type;
  final String email;
  final String id;
  final bool isMainPaymentMethod;

  PaymentMethodDecodable(
      {required this.nameInTheCard,
      required this.cardNumber,
      required this.monthAndYear,
      required this.cvc,
      required this.country,
      required this.type,
      required this.email,
      required this.id,
      required this.isMainPaymentMethod});

  factory PaymentMethodDecodable.fromMap(Map<String, dynamic> json) {
    return PaymentMethodDecodable(
        nameInTheCard: json['nameInTheCard'],
        cardNumber: json['cardNumber'],
        monthAndYear: json['monthAndYear'],
        cvc: json['cvc'],
        country: json['country'],
        type: json['type'],
        email: json['email'],
        id: json['id'],
        isMainPaymentMethod: json['isMainPaymentMethod'] ?? false);
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
