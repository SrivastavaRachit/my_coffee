import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  void addItem(CartItem item) {
    final index =
        _cartItems.indexWhere((cartItem) => cartItem.title == item.title);
    if (index != -1) {
      _cartItems[index].quantity += item.quantity;
    } else {
      _cartItems.add(item);
    }
    notifyListeners();
  }

  void removeItem(String title) {
    _cartItems.removeWhere((cartItem) => cartItem.title == title);
    notifyListeners();
  }

  void increaseQuantity(String title) {
    final index = _cartItems.indexWhere((cartItem) => cartItem.title == title);
    if (index != -1) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(String title) {
    final index = _cartItems.indexWhere((cartItem) => cartItem.title == title);
    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
        notifyListeners();
      } else {
        removeItem(title);
      }
    }
  }

  int get totalQuantity =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);
  bool get isEmpty => _cartItems.isEmpty;
}

class CartItem {
  final String title;
  final String image;
  final String category;
  final int price;
  int quantity;

  CartItem({
    required this.title,
    required this.image,
    required this.category,
    required this.price,
    this.quantity = 1,
  });
}
