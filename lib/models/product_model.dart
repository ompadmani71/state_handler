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

List<String> images = [
  "assets/images/foodDish.png",
  "assets/images/burger.png",
  "assets/images/maggi.png",
  "assets/images/special.png",
  "assets/images/apple.png",
  "assets/images/cherry.png",
  "assets/images/strawberry.jpg",
  "assets/images/banana.png",
  "assets/images/cabbage.png",
  "assets/images/broccoli.png",
  "assets/images/tomato.png",
  "assets/images/brinjal.png",
  "assets/images/rice.jpg",
  "assets/images/chhaki_atta.png",
  "assets/images/sugar.jpg",
  "assets/images/chilli_power.jpg"
];