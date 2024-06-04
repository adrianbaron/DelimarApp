import 'dart:convert';

class CollectionsDecodable {
  CollectionsDecodable({
    required this.collections,
  });

  final List<Collection>? collections;

  factory CollectionsDecodable.fromJson(String str) =>
      CollectionsDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CollectionsDecodable.fromMap(Map<String, dynamic> json) =>
      CollectionsDecodable(
        collections: json["collections"] == null
            ? null
            : List<Collection>.from(
                json["collections"].map((x) => Collection.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "collections": collections == null
            ? null
            : List<dynamic>.from(collections!.map((x) => x.toMap())),
      };
}

class Collection {
  Collection({
    required this.id,
    required this.img,
    required this.name,
  });

  final int id;
  final String img;
  final String name;

  factory Collection.fromJson(String str) =>
      Collection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Collection.fromMap(Map<String, dynamic> json) => Collection(
        id: json["id"] == null ? null : json["id"],
        img: json["img"] == null ? null : json["img"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "img": img == null ? null : img,
        "name": name == null ? null : name,
      };
}
