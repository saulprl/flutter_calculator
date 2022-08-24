import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import '../../providers/display_provider.dart';

import '../key_button.dart';

class StandardKeyboard extends StatelessWidget {
  StandardKeyboard({Key? key}) : super(key: key);

  final List<KeyButton> _buttons = [
    KeyButton(
      label: '%', /*onTap: (BuildContext context) {}*/
    ),
    KeyButton(
        label: 'CE',
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).clearEntry();
        }),
    KeyButton(
        label: 'C',
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).clearDisplay();
        }),
    KeyButton(
        icon: Icons.backspace_outlined,
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).backspace();
        }),
    KeyButton(
      tex: Math.tex(
        r'\frac 1 x',
        textStyle: const TextStyle(
            fontSize: 22.0), //TODO: Refactor this array for a simpler one.
      ),
      // onTap: (BuildContext context) {}
    ),
    KeyButton(
        tex: Math.tex(
          r'x^2',
          textStyle: const TextStyle(fontSize: 22.0, color: Colors.white),
        ),
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).powerSymbol();
          Provider.of<DisplayProvider>(context, listen: false).typeNumber('2');
        }),
    KeyButton(
      tex: Math.tex(
        r'\sqrt x',
        textStyle: TextStyle(fontSize: 22.0, color: Colors.grey[600]),
      ),
      // onTap: (BuildContext context) {
      //   Provider.of<DisplayProvider>(context, listen: false).radicalSymbol();
      // }
    ),
    KeyButton(
        label: '÷',
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).divideSymbol();
        }),
    KeyButton(
        label: '7',
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).typeNumber('7');
        }),
    KeyButton(
        label: '8',
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).typeNumber('8');
        }),
    KeyButton(
        label: '9',
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).typeNumber('9');
        }),
    KeyButton(
        label: 'x',
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).multiplySymbol();
        }),
    KeyButton(
        label: '4',
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).typeNumber('4');
        }),
    KeyButton(
        label: '5',
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).typeNumber('5');
        }),
    KeyButton(
        label: '6',
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).typeNumber('6');
        }),
    KeyButton(
        label: '-',
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).minusSymbol();
        }),
    KeyButton(
        label: '1',
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).typeNumber('1');
        }),
    KeyButton(
        label: '2',
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).typeNumber('2');
        }),
    KeyButton(
        label: '3',
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).typeNumber('3');
        }),
    KeyButton(
        label: '+',
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).plusSymbol();
        }),
    KeyButton(
      tex: Math.tex(
        r'\frac + -',
        textStyle: TextStyle(fontSize: 22.0, color: Colors.grey[600]),
      ),
      // onTap: (BuildContext context) {}
    ),
    KeyButton(
        label: '0',
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).typeNumber('0');
        }),
    KeyButton(
        label: '•',
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).typeNumber('.');
        }),
    KeyButton(
        label: '=',
        onTap: (BuildContext context) {
          Provider.of<DisplayProvider>(context, listen: false).equals();
        }),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      children: _buttons,
    );
  }
}
