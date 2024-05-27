// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<Product> productsFromJson(List data) =>
    List<Product>.from(data.map((x) => Product.fromJson(x)));

String productsToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  String? image;
  String? name;
  int? price;
  int? sale;
  String? id;

  Product({
    this.image,
    this.name,
    this.price,
    this.sale,
    this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        image: json["image"],
        name: json["name"],
        price: json["price"],
        sale: json["sale"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "price": price,
        "sale": sale,
        "id": id,
      };
}
