class ProductSelectedCardModel {
  String id;
  String photoUrl;
  double price;
  int quantity;
  String productName;
  String extras;

  ProductSelectedCardModel(
      {required this.id,
      required this.photoUrl,
      required this.price,
      required this.quantity,
      required this.productName,
      required this.extras});
}
