import 'package:flutter/material.dart';
import '../models/models.dart';

class MockDataProvider extends ChangeNotifier {
  final List<Category> _categories = [
    Category(
      id: 'c1',
      name: 'Rings',
      imageUrl:
          'https://images.unsplash.com/photo-1605100804763-247f66156cee?auto=format&fit=crop&q=80&w=600',
    ),
    Category(
      id: 'c2',
      name: 'Necklaces',
      imageUrl:
          'https://images.unsplash.com/photo-1599643478524-fb66f7f6eed9?auto=format&fit=crop&q=80&w=600',
    ),
    Category(
      id: 'c3',
      name: 'Earrings',
      imageUrl:
          'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?auto=format&fit=crop&q=80&w=600',
    ),
    Category(
      id: 'c4',
      name: 'Bracelets',
      imageUrl:
          'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?auto=format&fit=crop&q=80&w=600',
    ),
    Category(
      id: 'c5',
      name: 'Bangles',
      imageUrl:
          'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?auto=format&fit=crop&q=80&w=600',
    ),
    Category(
      id: 'c6',
      name: 'Chains',
      imageUrl:
          'https://images.unsplash.com/photo-1599643478524-fb66f7f6eed9?auto=format&fit=crop&q=80&w=600',
    ),
    Category(
      id: 'c7',
      name: 'Pendants',
      imageUrl:
          'https://images.unsplash.com/photo-1599643478524-fb66f7f6eed9?auto=format&fit=crop&q=80&w=600',
    ),
    Category(
      id: 'c8',
      name: 'New',
      imageUrl:
          'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?auto=format&fit=crop&q=80&w=600',
    ),
  ];
  List<Category> get categories => _categories;

  final List<Product> _products = [
    Product(
      id: 'p1',
      name: 'The Golden Embrace',
      description: 'A delicate 18k gold ring with a single bezel-set diamond.',
      price: 1250.00,
      imageUrl:
          'https://images.unsplash.com/photo-1605100804763-247f66156cee?auto=format&fit=crop&q=80&w=600',
      categoryId: 'c1',
      category: 'Rings',
      isNewArrival: true,
      isBestSeller: true,
    ),
    Product(
      id: 'p2',
      name: 'Midnight Pearl Drop',
      description: 'Elegant Tahitian pearl pendant on a fine silver chain.',
      price: 850.00,
      imageUrl:
          'https://images.unsplash.com/photo-1599643478524-fb66f7f6eed9?auto=format&fit=crop&q=80&w=600',
      categoryId: 'c2',
      category: 'Necklaces',
      isNewArrival: true,
    ),
    Product(
      id: 'p3',
      name: 'Solstice Chandelier Earrings',
      description:
          'Geometric cascading elements catching light from every angle.',
      price: 600.00,
      imageUrl:
          'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?auto=format&fit=crop&q=80&w=600',
      categoryId: 'c3',
      category: 'Earrings',
    ),
    Product(
      id: 'p4',
      name: 'Oceanside Bangle',
      description: 'Hammered gold finish evoking the motion of waves.',
      price: 450.00,
      imageUrl:
          'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?auto=format&fit=crop&q=80&w=600',
      categoryId: 'c4',
      category: 'Bracelets',
      isBestSeller: true,
    ),
    Product(
      id: 'p5',
      name: 'Royal Crest Ring',
      description: 'Classic dome ring with engraved royal motifs.',
      price: 1380.00,
      imageUrl:
          'https://images.unsplash.com/photo-1605100804763-247f66156cee?auto=format&fit=crop&q=80&w=600',
      categoryId: 'c1',
      category: 'Rings',
      isBestSeller: true,
    ),
    Product(
      id: 'p6',
      name: 'Lotus Halo Ring',
      description: 'Floral halo silhouette with radiant stone detailing.',
      price: 1190.00,
      imageUrl:
          'https://images.unsplash.com/photo-1605100804763-247f66156cee?auto=format&fit=crop&q=80&w=600',
      categoryId: 'c1',
      category: 'Rings',
      isNewArrival: true,
    ),
    Product(
      id: 'p7',
      name: 'Moonlit Layer Necklace',
      description: 'Layered necklace set crafted for festive styling.',
      price: 980.00,
      imageUrl:
          'https://images.unsplash.com/photo-1599643478524-fb66f7f6eed9?auto=format&fit=crop&q=80&w=600',
      categoryId: 'c2',
      category: 'Necklaces',
      isNewArrival: true,
    ),
    Product(
      id: 'p8',
      name: 'Antique Coin Necklace',
      description: 'Statement necklace inspired by heritage coin jewelry.',
      price: 1125.00,
      imageUrl:
          'https://images.unsplash.com/photo-1599643478524-fb66f7f6eed9?auto=format&fit=crop&q=80&w=600',
      categoryId: 'c2',
      category: 'Necklaces',
    ),
    Product(
      id: 'p9',
      name: 'Sunburst Drop Earrings',
      description: 'Lightweight drops with intricate radial pattern work.',
      price: 690.00,
      imageUrl:
          'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?auto=format&fit=crop&q=80&w=600',
      categoryId: 'c3',
      category: 'Earrings',
      isBestSeller: true,
    ),
    Product(
      id: 'p10',
      name: 'Temple Filigree Bangle',
      description: 'Fine filigree bangle with temple-inspired artistry.',
      price: 520.00,
      imageUrl:
          'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?auto=format&fit=crop&q=80&w=600',
      categoryId: 'c4',
      category: 'Bracelets',
      isNewArrival: true,
    ),
  ];
  List<Product> get products => _products;

  final List<CartItem> _cart = [];
  List<CartItem> get cart => _cart;
  List<CartItem> get cartItems => _cart;

  int _cartCount = 0;
  double _cartTotal = 0.0;

  void _recalcCart() {
    _cartCount = _cart.fold(0, (s, i) => s + i.quantity);
    _cartTotal = _cart.fold(0.0, (s, i) => s + i.product.price * i.quantity);
  }

  void addToCart(Product product, {int quantity = 1}) {
    final index = _cart.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _cart[index].quantity += quantity;
    } else {
      _cart.add(CartItem(product: product, quantity: quantity));
    }
    _recalcCart();
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _cart.removeWhere((item) => item.product.id == productId);
    _recalcCart();
    notifyListeners();
  }

  void updateQuantity(String productId, int delta) {
    final index = _cart.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _cart[index].quantity += delta;
      if (_cart[index].quantity <= 0) {
        _cart.removeAt(index);
      }
      _recalcCart();
      notifyListeners();
    }
  }

  double get cartTotal => _cartTotal;
  int get cartCount => _cartCount;

  List<Product> getProductsByCategory(String categoryId) {
    return _products.where((p) => p.categoryId == categoryId).toList();
  }

  final UserProfile _user = UserProfile(
    id: 'u1',
    name: 'Jane Doe',
    email: 'jane@digitalatelier.com',
  );
  UserProfile get user => _user;
}
