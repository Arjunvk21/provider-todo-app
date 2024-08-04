import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final List<Map<String, TextEditingController>> _controllers = [];

  ProductProvider() {
    addNewRow();
  }
  List<Map<String, TextEditingController>> get controllers => _controllers;

  void addNewRow() {
    _controllers.add({
      'productname': TextEditingController(),
      'productprice': TextEditingController(),
    });
    notifyListeners();
  }

  void removeRow(int index) {
    _controllers.removeAt(index);
    notifyListeners();
  }

  double calculateSubtotal() {
    double subtotal = 0.0;
    for (var controller in _controllers) {
      double price = double.tryParse(controller['productprice']!.text) ?? 0.0;
      subtotal = subtotal + price;
    }
    return subtotal;
  }
}
