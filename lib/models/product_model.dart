import 'dart:convert';

List<Dish> dishFromJson(String str) => List<Dish>.from(json.decode(str).map((x) => Dish.fromJson(x)));

String dishToJson(List<Dish> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dish {
  Dish({
    this.id,
    this.name,
    this.category,
    this.price,
    this.quantity,
    this.isLike,
    this.image,
  });

  int? id;
  String? name;
  String? category;
  int? price;
  int? quantity;
  String? isLike;
  String? image;

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    category: json["category"] ?? "",
    price: json["price"] ?? 0,
    quantity: json["quantity"] ?? 0,
    isLike: json["isLike"] ?? "",
    image: json["image"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category": category,
    "price": price,
    "quantity": quantity,
    "isLike": isLike,
    "image": image,
  };
}

List<Dish> products = [
  Dish(
    id: 1,
    name: "Avpdac Salad",
    category: "Food",
    price: 15,
    quantity: 1,
    isLike: "false",
    image: "assets/images/foodDish.png"
  ),
  Dish(
    id: 2,
    name: "Salad",
    category: "Food",
    price: 20,
    quantity: 1,
    isLike: "true",
    image: "assets/images/Like.png"
  ),
  Dish(
    id: 3,
    name: "Manchurian",
    category: "Food",
    price: 5,
    quantity: 1,
    isLike: "true",
    image: "assets/images/unLike.png"
  ),
];

