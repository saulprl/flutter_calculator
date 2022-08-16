import 'dart:math';

import 'package:flutter/material.dart';

class DisplayProvider with ChangeNotifier {
  List<String> _display = [];
  List<String> _history = [];

  List<String> get display => [..._display];

  List<String> get history => [..._history];

  String getDisplayAsString() {
    String concatenated = '';
    for (String char in _display) {
      concatenated += char;
    }
    return concatenated;
  }

  String getHistoryAsString() {
    String concatenated = '';
    for (String char in _history) {
      concatenated += char;
    }
    return concatenated;
  }

  void backspace() {
    _display.removeLast();
    notifyListeners();
  }

  void clearEntry() {
    _display.clear();
    notifyListeners();
  }

  void clearDisplay() {
    _display.clear();
    _history.clear();
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

  void powerSymbol() {
    _display.addAll([' ', '^', ' ']);
    notifyListeners();
  }

  void radicalSymbol() {
    _display.addAll([' ', '√', ' ']);
    notifyListeners();
  }

  void equals() {
    String concatenated = '';
    for (String digit in _display) {
      concatenated += digit;
    }
    debugPrint('Postfix');
    final postFix = _toPostFix(concatenated);
    for (dynamic item in postFix) {
      debugPrint(item.toString());
    }
    _evaluatePostFix(postFix);
  }

  void _evaluatePostFix(List<dynamic> postFix) {
    List<double> output = [];
    double? firstOperand;
    double? secondOperand;
    while (postFix.isNotEmpty) {
      if (postFix.first.runtimeType == double) {
        output.insert(0, postFix.removeAt(0));
      } else {
        try {
          secondOperand = output.removeAt(0);
          firstOperand = output.removeAt(0);

          switch (postFix.removeAt(0)) {
            case '+':
              output.insert(0, firstOperand + secondOperand);
              break;
            case '-':
              output.insert(0, firstOperand - secondOperand);
              break;
            case 'x':
              output.insert(0, firstOperand * secondOperand);
              break;
            case '÷':
              output.insert(0, firstOperand / secondOperand);
              break;
            case '^':
              double powered = 1.0;
              for (int i = 0; i < secondOperand; i++) {
                powered *= firstOperand;
              }
              output.insert(0, powered);
              break;
            default:
              break;
          }
          firstOperand = null;
          secondOperand = null;
        } catch (error) {
          if (postFix.contains('√')) {
            debugPrint(secondOperand!.toString());
            output.insert(0, sqrt(secondOperand));
            break;
          }
        }
      }
    }
    _history.clear();
    _history.addAll(_display);
    _display.clear();
    _display.addAll(output.map((e) => e.toString()));
    notifyListeners();
  }

  List<dynamic> _toPostFix(String expression) {
    List<dynamic> output = [];
    List<String> operators = [];
    for (String segment in expression.split(' ')) {
      try {
        if (!_isOperator(segment)) {
          output.add(double.parse(segment));
        } else {
          if (_precedence(segment) > _precedence(operators.first)) {
            operators.insert(0, segment);
          } else {
            while (_precedence(segment) <= _precedence(operators.first)) {
              output.add(operators.removeAt(0));
            }
            operators.insert(0, segment);
          }
        }
      } catch (error) {
        operators.insert(0, segment);
      }
    }

    while (operators.isNotEmpty) {
      output.add(operators.removeAt(0));
    }
    return output;
  }

  bool _isOperator(String symbol) {
    switch (symbol) {
      case '+':
      case '-':
      case 'x':
      case '÷':
      case '^':
      case '√':
      case '(':
      case ')':
        return true;
      default:
        return false;
    }
  }

  int _precedence(String operator) {
    switch (operator) {
      case '+':
      case '-':
        return 1;
      case 'x':
      case '÷':
        return 2;
      case '^':
      case '√':
        return 3;
      default:
        return 0;
    }
  }
}
