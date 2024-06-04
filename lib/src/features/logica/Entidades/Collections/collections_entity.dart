import 'dart:convert';

class CollectionsEntity {
  CollectionsEntity({
    required this.collections,
  });

  final List<CollectionDetailEntity>? collections;

  factory CollectionsEntity.fromJson(String str) =>
      CollectionsEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CollectionsEntity.fromMap(Map<String, dynamic> json) =>
      CollectionsEntity(
        collections: json["collections"] == null
            ? null
            : List<CollectionDetailEntity>.from(json["collections"]
                .map((x) => CollectionDetailEntity.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "collections": collections == null
            ? null
            : List<dynamic>.from(collections!.map((x) => x.toMap())),
      };
}

class CollectionDetailEntity {
  CollectionDetailEntity({
    required this.img,
    required this.name,
    required this.id,
  });

  final String img;
  final String name;
  final int id;

  factory CollectionDetailEntity.fromJson(String str) =>
      CollectionDetailEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CollectionDetailEntity.fromMap(Map<String, dynamic> json) =>
      CollectionDetailEntity(
        img: json["img"],
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "img": img,
        "name": name,
        "id": id,
      };
}
