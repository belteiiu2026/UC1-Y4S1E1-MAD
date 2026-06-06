import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product {
  int? id;
  String? title;
  String? description;
  num? price;
  String? image;

  Product({
    this.id, this.title, this.description, this.price, this.image
});

  // Manual Serialization
  // Map<String , dynamic> toMap() =>
  //    {
  //     "id": id,
  //     "title": title,
  //     "description" : description,
  //     "price" : price,
  //     "image" : image
  //   };
  //
  // factory Product.fromMap(Map<String,dynamic> map) => Product(
  //   id: map["id"],
  //     title: map["title"],
  //   description: map["description"],
  //   price: map["price"],
  //     image: map["image"]
  // );

  // Auto Serialization
  Map<String , dynamic> toJson() => _$ProductToJson(this);

  factory Product.fromJson(Map<String,dynamic> json) => _$ProductFromJson(json);
}