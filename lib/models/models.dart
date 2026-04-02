class Category {
  final String id;
  final String name;
  final String imageUrl;

  Category({required this.id, required this.name, required this.imageUrl});
}

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String categoryId;
  final String category;
  final bool isNewArrival;
  final bool isBestSeller;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    required this.category,
    this.isNewArrival = false,
    this.isBestSeller = false,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class Order {
  final String id;
  final DateTime date;
  final String status;
  final List<CartItem> items;
  final double totalAmount;

  Order({
    required this.id,
    required this.date,
    required this.status,
    required this.items,
    required this.totalAmount,
  });
}

class UserProfile {
  final String id;
  final String name;
  final String email;

  UserProfile({required this.id, required this.name, required this.email});
}
