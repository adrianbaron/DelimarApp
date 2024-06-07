import 'dart:convert';

class PlaceListDecodable {
  PlaceListDecodable({
    required this.placeList,
  });
  List<PlaceDetailDecodable>? placeList;
  factory PlaceListDecodable.fromJson(String str) =>
      PlaceListDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlaceListDecodable.fromMap(Map<String, dynamic> json) =>
      PlaceListDecodable(
        placeList: json["placeList"] == null
            ? null
            : List<PlaceDetailDecodable>.from(
                json["placeList"].map((x) => PlaceDetailDecodable.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "placeList": placeList == null
            ? null
            : List<dynamic>.from(placeList!.map((x) => x.toMap())),
      };
}

class PlaceDetailDecodable {
  String address;
  String adminId;
  String averageDelivery;
  double averagePrice;
  List<PlaceCategoryDecodable> categories;
  String city;
  int collectionId;
  String country;
  String description;
  String email;
  List<String> favourites;
  bool hasAlcohol;
  bool hasFreeDelivery;
  List<String> imgs;
  bool isNovelty;
  bool isOpenNow;
  bool isPopularThisWeek;
  double lat;
  double long;
  String phoneNumber;
  String placeId;
  String placeName;
  double ratingAverage;
  int ratings;
  String status;
  String zipCode;
  List<PlaceRatingDecodable> placeRatings;

  PlaceDetailDecodable(
      {required this.address,
      required this.adminId,
      required this.averageDelivery,
      required this.averagePrice,
      required this.categories,
      required this.city,
      required this.collectionId,
      required this.country,
      required this.description,
      required this.email,
      required this.favourites,
      required this.hasAlcohol,
      required this.hasFreeDelivery,
      required this.imgs,
      required this.isNovelty,
      required this.isOpenNow,
      required this.isPopularThisWeek,
      required this.lat,
      required this.long,
      required this.phoneNumber,
      required this.placeId,
      required this.placeName,
      required this.ratingAverage,
      required this.ratings,
      required this.status,
      required this.zipCode,
      required this.placeRatings});

  factory PlaceDetailDecodable.fromMap(Map<String, dynamic> json) =>
      PlaceDetailDecodable(
          address: json["address"] ?? "",
          adminId: json["adminId"] ?? "",
          averageDelivery: json["averageDelivery"] ?? "",
          averagePrice: json["averagePrice"] ?? 0,
          categories: json["categories"] == null
              ? []
              : List<PlaceCategoryDecodable>.from(json["categories"]!
                  .map((x) => PlaceCategoryDecodable.fromJson(x))),
          city: json["city"] ?? "",
          collectionId: json["collectionId"] ?? 0,
          country: json["country"] ?? "",
          description: json["description"] ?? "",
          email: json["email"] ?? "",
          favourites: json["favourites"] == null
              ? []
              : List<String>.from(json["favourites"].map((x) => x)),
          hasAlcohol: json["hasAlcohol"] ?? false,
          hasFreeDelivery: json["hasFreeDelivery"] ?? false,
          imgs: json["imgs"] == null
              ? []
              : List<String>.from(json["imgs"].map((x) => x)),
          isNovelty: json["isNovelty"] ?? false,
          isOpenNow: json["isOpenNow"] ?? false,
          isPopularThisWeek: json["isPopularThisWeek"] ?? false,
          lat: json["lat"]?.toDouble() ?? 0,
          long: json["long"]?.toDouble() ?? 0,
          phoneNumber: json["phoneNumber"] ?? "",
          placeId: json["placeId"] ?? "",
          placeName: json["placeName"] ?? "",
          ratingAverage: json["ratingAverage"]?.toDouble() ?? 0,
          ratings: json["ratings"] ?? 0,
          status: json["status"] ?? "",
          zipCode: json["zipCode"] ?? "",
          placeRatings: json["placeRatings"] == null
              ? []
              : List<PlaceRatingDecodable>.from(json["placeRatings"]!
                  .map((x) => PlaceRatingDecodable.fromJson(x))));

  Map<String, dynamic> toMap() => {
        "address": address,
        "adminId": adminId,
        "averageDelivery": averageDelivery,
        "averagePrice": averagePrice,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "city": city,
        "collectionId": collectionId,
        "country": country,
        "description": description,
        "email": email,
        "favourites": List<dynamic>.from(favourites.map((x) => x)),
        "hasAlcohol": hasAlcohol,
        "hasFreeDelivery": hasFreeDelivery,
        "imgs": List<dynamic>.from(imgs.map((x) => x)),
        "isNovelty": isNovelty,
        "isOpenNow": isOpenNow,
        "isPopularThisWeek": isPopularThisWeek,
        "lat": lat,
        "long": long,
        "phoneNumber": phoneNumber,
        "placeId": placeId,
        "placeName": placeName,
        "ratingAverage": ratingAverage,
        "ratings": ratings,
        "status": status,
        "zipCode": zipCode,
        "placeRatings": List<dynamic>.from(placeRatings.map((x) => x.toJson())),
      };

  bool isUserFavourite({required String? userUid}) {
    return favourites.contains(userUid);
  }
}

class PlaceCategoryDecodable {
  String categoryId;
  String categoryName;
  List<PlaceProductDecodable> products;

  PlaceCategoryDecodable({
    required this.categoryId,
    required this.categoryName,
    required this.products,
  });

  factory PlaceCategoryDecodable.fromJson(Map<String, dynamic> json) =>
      PlaceCategoryDecodable(
          categoryId: json["categoryId"],
          categoryName: json["categoryName"],
          products: json["products"] == null
              ? []
              : List<PlaceProductDecodable>.from(json["products"]!
                  .map((x) => PlaceProductDecodable.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class PlaceProductDecodable {
  int amount;
  String id;
  List<String> imgs;
  String productDescription;
  String productName;
  double productPrice;
  List<PlaceProductExtras>? options;

  PlaceProductDecodable({
    required this.amount,
    required this.id,
    required this.imgs,
    required this.productDescription,
    required this.productName,
    required this.productPrice,
    this.options,
  });

  factory PlaceProductDecodable.fromJson(Map<String, dynamic> json) =>
      PlaceProductDecodable(
        amount: json["amount"],
        id: json["id"],
        imgs: List<String>.from(json["imgs"].map((x) => x)),
        productDescription: json["productDescription"],
        productName: json["productName"],
        productPrice: json["productPrice"],
        options: json["options"] == null
            ? []
            : List<PlaceProductExtras>.from(
                json["options"]!.map((x) => PlaceProductExtras.fromJson(x))),
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
}

class PlaceProductExtras {
  String id;
  List<PlaceProductExtra> extras;
  bool isRequired;
  int maxExtras;
  String title;

  PlaceProductExtras({
    required this.id,
    required this.extras,
    required this.isRequired,
    required this.maxExtras,
    required this.title,
  });

  factory PlaceProductExtras.fromJson(Map<String, dynamic> json) =>
      PlaceProductExtras(
        id: json["id"],
        extras: json["extras"] == null
            ? []
            : List<PlaceProductExtra>.from(
                json["extras"].map((x) => PlaceProductExtra.fromJson(x))),
        isRequired: json["isRequired"],
        maxExtras: json["maxExtras"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "extras": List<dynamic>.from(extras.map((x) => x.toJson())),
        "isRequired": isRequired,
        "maxExtras": maxExtras,
        "title": title,
      };
}

class PlaceProductExtra {
  String id;
  double price;
  String title;
  bool isSelected;

  PlaceProductExtra(
      {required this.id,
      required this.price,
      required this.title,
      required this.isSelected});

  factory PlaceProductExtra.fromJson(Map<String, dynamic> json) =>
      PlaceProductExtra(
          id: json["id"],
          price: json["price"]?.toDouble(),
          title: json["title"],
          isSelected: json["isSelected"] == null ? false : json["isSelected"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "title": title,
        "isSelected": isSelected,
      };
}

class PlaceRatingDecodable {
  String userId;
  String userName;
  int userRatingsCount;
  String userAvatar;
  String comment;
  int rating;
  String ratingId;

  PlaceRatingDecodable({
    required this.userId,
    required this.userName,
    required this.userRatingsCount,
    required this.userAvatar,
    required this.comment,
    required this.rating,
    required this.ratingId,
  });

  factory PlaceRatingDecodable.fromJson(Map<String, dynamic> json) =>
      PlaceRatingDecodable(
        userId: json["userId"],
        userName: json["userName"],
        userRatingsCount: json["userRatingsCount"],
        userAvatar: json["userAvatar"],
        comment: json["comment"],
        rating: json["rating"],
        ratingId: json["ratingId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "userRatingsCount": userRatingsCount,
        "userAvatar": userAvatar,
        "comment": comment,
        "rating": rating,
        "ratingId": ratingId,
      };
}
