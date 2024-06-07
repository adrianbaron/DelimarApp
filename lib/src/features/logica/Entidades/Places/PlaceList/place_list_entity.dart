import 'dart:convert';

import 'package:app_delivery/src/utils/extensions/iterable_extensions.dart';

class PlaceListEntity {
  PlaceListEntity({
    required this.placeList,
  });

  List<PlaceDetailEntity>? placeList;
  factory PlaceListEntity.fromJson(String str) =>
      PlaceListEntity.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory PlaceListEntity.fromMap(Map<String, dynamic> json) => PlaceListEntity(
        placeList: json["placeList"] == null
            ? null
            : List<PlaceDetailEntity>.from(
                json["placeList"].map((x) => PlaceDetailEntity.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "placeList": placeList == null
            ? null
            : List<dynamic>.from(placeList!.map((x) => x.toMap())),
      };
}

class PlaceDetailEntity {
  String address;
  String adminId;
  String averageDelivery;
  double averagePrice;
  List<PlaceCategoryEntity> categories;
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
  List<PlaceRatingEntity> placeRatings;

  PlaceDetailEntity(
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

  factory PlaceDetailEntity.fromMap(Map<String, dynamic> json) =>
      PlaceDetailEntity(
          address: json["address"],
          adminId: json["adminId"],
          averageDelivery: json["averageDelivery"],
          averagePrice: json["averagePrice"],
          categories:
              List<
                      PlaceCategoryEntity>.from(
                  json["categories"]
                      .map((x) => PlaceCategoryEntity.fromJson(x))),
          city: json["city"],
          collectionId: json["collectionId"],
          country: json["country"],
          description: json["description"],
          email: json["email"],
          favourites: List<String>.from(json["favourites"].map((x) => x)),
          hasAlcohol: json["hasAlcohol"],
          hasFreeDelivery: json["hasFreeDelivery"],
          imgs: List<String>.from(json["imgs"].map((x) => x)),
          isNovelty: json["isNovelty"],
          isOpenNow: json["isOpenNow"],
          isPopularThisWeek: json["isPopularThisWeek"],
          lat: json["lat"]?.toDouble(),
          long: json["long"]?.toDouble(),
          phoneNumber: json["phoneNumber"],
          placeId: json["placeId"],
          placeName: json["placeName"],
          ratingAverage: json["ratingAverage"]?.toDouble(),
          ratings: json["ratings"],
          status: json["status"],
          zipCode: json["zipCode"],
          placeRatings: json[
                      "placeRatings"] ==
                  null
              ? []
              : List<PlaceRatingEntity>.from(json["placeRatings"]!
                  .map((x) => PlaceRatingEntity.fromJson(x))));

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

class PlaceCategoryEntity {
  String categoryId;
  String categoryName;
  List<PlaceProductEntity> products;

  PlaceCategoryEntity({
    required this.categoryId,
    required this.categoryName,
    required this.products,
  });

  factory PlaceCategoryEntity.fromJson(Map<String, dynamic> json) =>
      PlaceCategoryEntity(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        products: List<PlaceProductEntity>.from(
            json["products"].map((x) => PlaceProductEntity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class PlaceProductEntity {
  int amount;
  String id;
  List<String> imgs;
  String productDescription;
  String productName;
  double productPrice;
  List<PlaceProductExtrasEntity> options;

  PlaceProductEntity({
    required this.amount,
    required this.id,
    required this.imgs,
    required this.productDescription,
    required this.productName,
    required this.productPrice,
    required this.options,
  });

  factory PlaceProductEntity.fromJson(Map<String, dynamic> json) =>
      PlaceProductEntity(
        amount: json["amount"],
        id: json["id"],
        imgs: List<String>.from(json["imgs"].map((x) => x)),
        productDescription: json["productDescription"],
        productName: json["productName"],
        productPrice: json["productPrice"],
        options: json["options"] == null
            ? []
            : List<PlaceProductExtrasEntity>.from(json["options"]!
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

  String getExtras() {
    var extrasJoined = "";
    options.forEach((option) {
      extrasJoined = option.extras
          .map((extra) {
            if (extra.isSelected) {
              return extra.title;
            }
          })
          .compactMap()
          .join(", ");
    });
    return extrasJoined;
  }
}

class PlaceProductExtrasEntity {
  String id;
  List<PlaceProductExtra> extras;
  bool isRequired;
  int maxExtras;
  String title;

  PlaceProductExtrasEntity({
    required this.id,
    required this.extras,
    required this.isRequired,
    required this.maxExtras,
    required this.title,
  });

  factory PlaceProductExtrasEntity.fromJson(Map<String, dynamic> json) =>
      PlaceProductExtrasEntity(
        id: json["id"],
        extras: List<PlaceProductExtra>.from(
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

  selectExtra({required String extraId, required bool isSelected}) {
    extras = extras.map((extra) {
      var newExtra = extra;
      if (newExtra.id == extraId) {
        newExtra.isSelected = isSelected;
      }
      return newExtra;
    }).toList();
  }

  bool isExtraSelected({required String extraId}) {
    return extras.where((extra) => extra.isSelected == true).isNotEmpty;
  }

  disableAllExtras() {
    extras.forEach((extra) {
      extra.isSelected = false;
    });
  }
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
          isSelected: json["isSelected"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "price": price, "title": title, "isSelected": isSelected};
}

class PlaceRatingEntity {
  String userId;
  String userName;
  int userRatingsCount;
  String userAvatar;
  String comment;
  int rating;
  String ratingId;

  PlaceRatingEntity({
    required this.userId,
    required this.userName,
    required this.userRatingsCount,
    required this.userAvatar,
    required this.comment,
    required this.rating,
    required this.ratingId,
  });

  factory PlaceRatingEntity.fromJson(Map<String, dynamic> json) =>
      PlaceRatingEntity(
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
