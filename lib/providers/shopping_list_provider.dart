import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_list_app/models/shopping_item.dart';

class ShoppingListProvider with ChangeNotifier {
  List<ShoppingItem> _items = [];

  List<ShoppingItem> get items => _items;

  double get totalPrice => _items
      .where((item) => item.isPurchased)
      .map((item) => item.price)
      .fold(0.0, (a, b) => a + b);

  ShoppingListProvider() {
    _loadItems();
  }

  void _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = prefs.getStringList('shopping_items') ?? [];

    _items = itemsJson
        .map((itemJson) => ShoppingItem.fromJson(json.decode(itemJson)))
        .toList();

    notifyListeners();
  }

  void _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = _items.map((item) => json.encode(item.toJson())).toList();

    prefs.setStringList('shopping_items', itemsJson);
  }

  void addItem(ShoppingItem item) {
    _items.add(item);
    _saveItems();
    notifyListeners();
  }

  void updateItem(ShoppingItem updatedItem) {
    final index = _items.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      _items[index] = updatedItem;
      _saveItems();
      notifyListeners();
    }
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    _saveItems();
    notifyListeners();
  }

  void togglePurchaseStatus(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index].isPurchased = !_items[index].isPurchased;
      _saveItems();
      notifyListeners();
    }
  }
}
