import 'package:flutter/cupertino.dart';

class WishListItem {
  final String name;
  final String imageUrl;
  final String category;
  final int price;

  WishListItem(
    this.name,
    this.imageUrl,
    this.category,
    this.price, {
    required int likes,
  });
}

class WishListProvider with ChangeNotifier{
  List<WishListItem> _wishListItems = [];

  List<WishListItem> get wishListItems => _wishListItems;

  void addToWishList(WishListItem item){
    if(!_wishListItems.any((existingItem) => existingItem.name ==item.name)){
      _wishListItems.add(item);
      notifyListeners();
    }
  }
  void removeFromWishList(String itemName){
    _wishListItems.removeWhere((item) => item.name == itemName);
    notifyListeners();
  }

  bool isInWishList(String itemName) {
    return _wishListItems.any((item) => item.name == itemName);
  }
}