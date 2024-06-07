import 'package:app_delivery/src/features/logica/Entidades/DeliveryAddress/delivery_address_entity.dart';
import 'package:app_delivery/src/features/logica/Entidades/PaymentsMethods/payments_methods_entity.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/utils/helpers/CheckoutHelper/check_out_helper.dart';

/*
  Order status can be:
  "Not Confirmed" - The order is empty or not confirmed by the user.
  "Confirmed" - The order is confirmed and pay it by the user.
  "Preparing" - The place is preparing the order.
  "OnTheWay" - The rider is on the way with the order.
  "Completed" - The user have ther order and every body is happy.
  "NotCompleted" - Something bad happened and the order was not delivered to the user by the place.
*/

class OrderEntity {
  late String orderId;
  late String placeId;
  late String userId;
  late double totalAmount;
  late double deliveryFee;
  late double fee;
  late bool needCutlery;
  late String status;
  late DeliveryAddressEntity deliveryAddress;
  late PaymentMethodEntity paymentMethod;
  late List<ProductOrderEntity> products;

  OrderEntity({
    required this.orderId,
    required this.placeId,
    required this.userId,
    required this.totalAmount,
    required this.deliveryFee,
    required this.fee,
    required this.needCutlery,
    required this.status,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.products,
  });

  OrderEntity.fromPlaceId({required String placeId}) {
    orderId = CheckoutHelper.generateUuid();
    placeId = placeId;
    userId = MainCoordinator.sharedInstance?.userUid ?? "";
    totalAmount = 0;
    deliveryFee = 3.99; // You can set this dynamic from remote config file 😉
    fee = 3.99; // You can set this dynamic from remote config file 😉
    needCutlery = false;
    status = "Not Confirmed";
    deliveryAddress = DeliveryAddressEntity.getEmptyDeliveryAddress();
    paymentMethod = PaymentMethodEntity.getEmptyPaymentMethod();
    products = [];
  }

  factory OrderEntity.fromJson(Map<String, dynamic> json) => OrderEntity(
      orderId: json["orderId"],
      placeId: json["placeId"],
      userId: json["userId"],
      totalAmount: json["totalAmount"]?.toDouble(),
      deliveryFee: json["deliveryFee"]?.toDouble(),
      fee: json["fee"]?.toDouble(),
      needCutlery: json["needCutlery"],
      status: json["status"],
      deliveryAddress: DeliveryAddressEntity.fromMap(json["deliveryAddress"]),
      paymentMethod: PaymentMethodEntity.fromMap(json["paymentMethod"]),
      products: json["products"] == null
          ? []
          : List<ProductOrderEntity>.from(
              json["products"]!.map((x) => ProductOrderEntity.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "placeId": placeId,
        "userId": userId,
        "totalAmount": totalAmount,
        "deliveryFee": deliveryFee,
        "fee": fee,
        "needCutlery": needCutlery,
        "status": status,
        "deliveryAddress": deliveryAddress.toMap(),
        "paymentMethod": paymentMethod.toJson(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };

  bool isEmpty() {
    return products.isEmpty;
  }

  updateTotalPrice() {
    totalAmount = 0;
    products.forEach((product) {
      totalAmount = totalAmount + product.totalPrice;
    });
  }
}

class ProductOrderEntity {
  String id;
  int amount;
  List<String> imgs;
  String productDescription;
  String productName;
  double productPrice;
  List<PlaceProductExtrasEntity> options;
  double get totalPrice => _getTotalPrice();

  ProductOrderEntity({
    required this.amount,
    required this.id,
    required this.imgs,
    required this.productDescription,
    required this.productName,
    required this.productPrice,
    required this.options,
  });

  factory ProductOrderEntity.fromJson(Map<String, dynamic> json) =>
      ProductOrderEntity(
        amount: json["amount"],
        id: json["id"],
        imgs: List<String>.from(json["imgs"].map((x) => x)),
        productDescription: json["productDescription"],
        productName: json["productName"],
        productPrice: json["productPrice"],
        options: json["options"] == null
            ? []
            : List<PlaceProductExtrasEntity>.from(json["extras"]!
                .map((x) => PlaceProductExtrasEntity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "id": id,
        "imgs": List<dynamic>.from(imgs.map((x) => x)),
        "productDescription": productDescription,
        "productName": productName,
        "productPrice": productPrice,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
      };

  double _getTotalPrice() {
    double totalPrice = productPrice;
    options.forEach((option) {
      option.extras.forEach((extra) {
        if (extra.isSelected) {
          totalPrice = totalPrice + extra.price;
        }
      });
    });
    totalPrice = totalPrice * amount;
    return totalPrice;
  }
}
