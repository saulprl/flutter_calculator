import 'package:flutter/material.dart';

class DisplayProvider with ChangeNotifier {
  List<String> _display = [];

  List<String> get display => [..._display];

  String getDisplayAsString() {
    String concatenated = '';
    for (String char in _display) {
      concatenated += char;
    }
    return concatenated;
  }

  void clearDisplay() {
    _display.clear();
    notifyListeners();
  }

  void typeNumber(String number) {
    _display.add(number);
    notifyListeners();
  }

  void plusSymbol() {
    _display.addAll([' ', '+', ' ']);
    notifyListeners();
  }

  void minusSymbol() {
    _display.addAll([' ', '-', ' ']);
    notifyListeners();
  }

  void multiplySymbol() {
    _display.addAll([' ', 'x', ' ']);
    notifyListeners();
  }

  void divideSymbol() {
    _display.addAll([' ', '÷', ' ']);
    notifyListeners();
  }

  void equals() {
    final reversed = _display.reversed;

    for (String char in reversed) {}
  }
}
