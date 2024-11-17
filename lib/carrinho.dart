import 'package:flutter/material.dart';
import 'index.dart'; // Import your Product model

class CartProvider with ChangeNotifier {
  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  double get totalAmount {
    return _cartItems.fold(0, (total, item) => total + item.price);
  }
}
