import 'package:flutter/material.dart';
import '../models/models.dart';

class MockDataProvider extends ChangeNotifier {
  // API_HOOK: Replace with GET /api/categories — fetch from Firestore/backend
  final List<Category> _categories = [
    Category(id: 'c1', name: 'Rings', imageUrl: 'https://images.unsplash.com/photo-1605100804763-247f66156cee?auto=format&fit=crop&q=80&w=600'),
    Category(id: 'c2', name: 'Necklaces', imageUrl: 'https://images.unsplash.com/photo-1599643478524-fb66f7f6eed9?auto=format&fit=crop&q=80&w=600'),
    Category(id: 'c3', name: 'Earrings', imageUrl: 'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?auto=format&fit=crop&q=80&w=600'),
    Category(id: 'c4', name: 'Bracelets', imageUrl: 'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?auto=format&fit=crop&q=80&w=600'),
    Category(id: 'c5', name: 'Watches', imageUrl: 'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?auto=format&fit=crop&q=80&w=600'),
  ];
  List<Category> get categories => _categories;

  // API_HOOK: Replace with GET /api/products — fetch paginated product list from Firestore/backend
  final List<Product> _products = [
    Product(
      id: 'p1',
      name: 'The Golden Embrace',
      description: 'A delicate 18k gold ring with a single bezel-set diamond.',
      price: 1250.00,
      imageUrl: 'https://images.unsplash.com/photo-1605100804763-247f66156cee?auto=format&fit=crop&q=80&w=600',
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
      imageUrl: 'https://images.unsplash.com/photo-1599643478524-fb66f7f6eed9?auto=format&fit=crop&q=80&w=600',
      categoryId: 'c2',
      category: 'Necklaces',
      isNewArrival: true,
    ),
    Product(
      id: 'p3',
      name: 'Solstice Chandelier Earrings',
      description: 'Geometric cascading elements catching light from every angle.',
      price: 600.00,
      imageUrl: 'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?auto=format&fit=crop&q=80&w=600',
      categoryId: 'c3',
      category: 'Earrings',
    ),
    Product(
      id: 'p4',
      name: 'Oceanside Bangle',
      description: 'Hammered gold finish evoking the motion of waves.',
      price: 450.00,
      imageUrl: 'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?auto=format&fit=crop&q=80&w=600',
      categoryId: 'c4',
      category: 'Bracelets',
      isBestSeller: true,
    ),
  ];
  List<Product> get products => _products;

  // API_HOOK: Replace with real cart synced to user session (Firestore/backend)
  // On app start, fetch cart from GET /api/cart?userId=...
  final List<CartItem> _cart = [];
  List<CartItem> get cart => _cart;
  List<CartItem> get cartItems => _cart;

  void addToCart(Product product, {int quantity = 1}) {
    // API_HOOK: Call POST /api/cart/add { productId, quantity }
    final index = _cart.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _cart[index].quantity += quantity;
    } else {
      _cart.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    // API_HOOK: Call DELETE /api/cart/remove?productId=...
    _cart.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void updateQuantity(String productId, int delta) {
    // API_HOOK: Call PATCH /api/cart/update { productId, delta }
    final index = _cart.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _cart[index].quantity += delta;
      if (_cart[index].quantity <= 0) {
        _cart.removeAt(index);
      }
      notifyListeners();
    }
  }

  double get cartTotal {
    return _cart.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  int get cartCount {
    return _cart.fold(0, (sum, item) => sum + item.quantity);
  }

  // Get products by category
  List<Product> getProductsByCategory(String categoryId) {
    return _products.where((p) => p.categoryId == categoryId).toList();
  }

  // API_HOOK: Replace with authenticated user from Firebase Auth / JWT session
  // Fetch from GET /api/user/profile after login
  final UserProfile _user = UserProfile(
    id: 'u1',
    name: 'Jane Doe',
    email: 'jane@digitalatelier.com',
  );
  UserProfile get user => _user;
}
