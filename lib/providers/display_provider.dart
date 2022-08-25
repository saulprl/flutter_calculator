import 'dart:math';

import 'package:flutter/material.dart';

import '../models/eval_exception.dart';

class DisplayProvider with ChangeNotifier {
  List<String> _display = ['0'];
  List<String> _history = [];
  List<String> _result = [];

  List<String> get display => [..._display];
  List<String> get history => [..._history];
  List<String> get result => [..._result];

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

  String getResultAsString() {
    String concatenated = '';
    for (String char in _result) {
      concatenated += char;
    }
    return concatenated;
  }

  bool isEntryEmpty() {
    return (_display.length == 1 && _display.contains('0'));
  }

  bool _isInteger(num value) => value is int || value == value.roundToDouble();

  void backspace() {
    if (!isEntryEmpty()) {
      _display.removeLast();
      if (_display.isEmpty) {
        _display.add('0');
      }
      notifyListeners();
    }
  }

  void clearEntry() {
    _display.clear();
    _display.add('0');
    _result.clear();
    notifyListeners();
  }

  void clearDisplay() {
    _display.clear();
    _history.clear();
    _result.clear();
    _display.add('0');
    notifyListeners();
  }

  void typeNumber(String number) {
    if (isEntryEmpty() && number != '.') {
      _display.removeLast();
    } else if (number == '.') {
      final concat = getDisplayAsString();
      final segments = concat.split(' ');
      final lastOperand = segments[segments.length - 1];
      if (lastOperand.contains('.')) return;
    }
    _display.add(number);
    _evaluateOnTheFly();
    notifyListeners();
  }

  void plusSymbol() {
    if (_display.last != ' ') {
      _display.addAll([' ', '+', ' ']);
      _evaluateOnTheFly();
      notifyListeners();
    }
  }

  void minusSymbol() {
    if (_display.last != ' ') {
      _display.addAll([' ', '-', ' ']);
      _evaluateOnTheFly();
      notifyListeners();
    }
  }

  void multiplySymbol() {
    if (_display.last != ' ') {
      _display.addAll([' ', 'x', ' ']);
      _evaluateOnTheFly();
      notifyListeners();
    }
  }

  void divideSymbol() {
    if (_display.last != ' ') {
      _display.addAll([' ', '÷', ' ']);
      _evaluateOnTheFly();
      notifyListeners();
    }
  }

  void percentSymbol() {
    if (!isEntryEmpty() && _display.last != ' ') {
      if (!_display.contains(' ')) {
        List<String> lastNumber = [];
        String number = '';
        while (_display.isNotEmpty &&
            _display.last != ' ' &&
            !_isOperator(_display.last)) {
          lastNumber.insert(0, _display.removeLast());
        }
        for (String char in lastNumber) {
          number += char;
        }
        double parsed = double.parse(number) / 100;
        String parsedCheck =
            _isInteger(parsed) ? parsed.round().toString() : parsed.toString();

        _display.add(parsedCheck);
        _result.clear();
        _result.addAll(['= ', parsedCheck]);
      } else if (_display.contains('+') || _display.contains('-')) {
        String firstNumber = '';
        String secondNumber = '';
        List<String> secondNumberList = [];
        for (String char in _display) {
          if (char == ' ') break;
          firstNumber += char;
        }

        double firstOperand = double.parse(firstNumber);
        while (_display.last != ' ') {
          secondNumberList.insert(0, _display.removeLast());
        }
        for (String char in secondNumberList) {
          secondNumber += char;
        }

        double secondOperand = double.parse(secondNumber);
        double result = firstOperand * (secondOperand / 100);
        String parsed =
            _isInteger(result) ? result.round().toString() : result.toString();

        _display.add(parsed);
        _evaluateOnTheFly();
      }
    }
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
    try {
      final output = _evaluatePostFix(postFix);
      _history.clear();
      _history.addAll(_display);
      _display.clear();
      _display.addAll(output
          .map((e) => _isInteger(e) ? e.round().toString() : e.toString()));
      _result.clear();
    } on EvalException catch (error) {
      _result.clear();
      _display.clear();
      _history.clear();
      _result.add(error.toString());
    }
    notifyListeners();
  }

  void _evaluateOnTheFly() {
    _result.clear();
    if (_display.last == '.') {
      _result.addAll(['= ', ..._display.map((e) => e.toString())]);
      return;
    }

    try {
      final postFix = _toPostFix(getDisplayAsString());
      final output = _evaluatePostFix(postFix);
      _result.addAll([
        '= ',
        ...output
            .map((e) => _isInteger(e) ? e.round().toString() : e.toString()),
      ]);
    } on EvalException catch (error) {
      _result.clear();
      _display.clear();
      _history.clear();
      _result.add(error.toString());
    }
  }

  List<double> _evaluatePostFix(List<dynamic> postFix) {
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
        } on RangeError catch (rangeError) {
          // if (postFix) {
          //   throw Exception('Syntax error');
          // }
          if (firstOperand == null) {
            if (secondOperand == null) {
              throw EvalException('Syntax error');
            }
            output.insert(0, secondOperand);
            break;
          }
          // if (postFix.contains('√')) {
          //   debugPrint(secondOperand!.toString());
          //   output.insert(0, sqrt(secondOperand));
          //   break;
          // }
          // else if (postFix.contains('-')) {
          //   debugPrint(secondOperand!.toString());
          //   output.insert(0, secondOperand * -1);
          //   postFix.removeAt(0);
          // }
        }
      }
    }
    // _history.clear();
    // _history.addAll(_display);
    // _display.clear();
    // _display.add('= ');
    // _display.addAll(output.map((e) => e.toString()));

    // notifyListeners();
    return output;
  }

  List<dynamic> _toPostFix(String expression) {
    List<dynamic> output = [];
    List<String> operators = [];
    for (String segment in expression.split(' ')) {
      if (segment == '') {
        continue;
      }
      try {
        if (!_isOperator(segment.trim())) {
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
