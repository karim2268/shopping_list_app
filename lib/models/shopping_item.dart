class ShoppingItem {
  String id;
  String name;
  double price;
  bool isPurchased;

  ShoppingItem(
      {required this.id,
      required this.name,
      this.price = 0.0,
      this.isPurchased = false});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'isPurchased': isPurchased,
    };
  }

  factory ShoppingItem.fromJson(Map<String, dynamic> json) {
    return ShoppingItem(
      id: json['id'],
      name: json['name'],
      price: json['price'] ?? 0.0,
      isPurchased: json['isPurchased'] ?? false,
    );
  }
}
