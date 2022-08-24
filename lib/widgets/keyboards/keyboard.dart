import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../providers/display_provider.dart';

import '../key_button.dart';

class Keyboard extends StatefulWidget {
  const Keyboard({Key? key}) : super(key: key);

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  var _isInit = false;
  late List<KeyButton> _standard;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      _standard = [
        KeyButton(
          label: Provider.of<DisplayProvider>(context).display.isEmpty
              ? 'C'
              : 'CE',
          onTap: (BuildContext context) {
            if (Provider.of<DisplayProvider>(context, listen: false)
                .display
                .isEmpty) {
              Provider.of<DisplayProvider>(context, listen: false)
                  .clearDisplay();
            } else {
              Provider.of<DisplayProvider>(context, listen: false).clearEntry();
            }
          },
        ),
        KeyButton(
          icon: Icons.backspace_outlined,
          onTap: (BuildContext context) {
            Provider.of<DisplayProvider>(context, listen: false).backspace();
          },
        ),
        const KeyButton(
          icon: FontAwesomeIcons.percent,
        ),
        KeyButton(
          icon: FontAwesomeIcons.divide,
          onTap: (context) {
            Provider.of<DisplayProvider>(context, listen: false).divideSymbol();
          },
        ),
        KeyButton(
          label: '7',
          onTap: (context) {
            Provider.of<DisplayProvider>(context, listen: false)
                .typeNumber('7');
          },
        ),
        KeyButton(
          label: '8',
          onTap: (context) {
            Provider.of<DisplayProvider>(context, listen: false)
                .typeNumber('8');
          },
        ),
        KeyButton(
          label: '9',
          onTap: (context) {
            Provider.of<DisplayProvider>(context, listen: false)
                .typeNumber('9');
          },
        ),
        KeyButton(
          icon: FontAwesomeIcons.xmark,
          onTap: (context) {
            Provider.of<DisplayProvider>(context, listen: false)
                .multiplySymbol();
          },
        ),
        KeyButton(
          label: '4',
          onTap: (context) {
            Provider.of<DisplayProvider>(context, listen: false)
                .typeNumber('4');
          },
        ),
        KeyButton(
          label: '5',
          onTap: (context) {
            Provider.of<DisplayProvider>(context, listen: false)
                .typeNumber('5');
          },
        ),
        KeyButton(
          label: '6',
          onTap: (context) {
            Provider.of<DisplayProvider>(context, listen: false)
                .typeNumber('6');
          },
        ),
        KeyButton(
          icon: FontAwesomeIcons.minus,
          onTap: (context) {
            Provider.of<DisplayProvider>(context, listen: false).minusSymbol();
          },
        ),
        KeyButton(
          label: '1',
          onTap: (context) {
            Provider.of<DisplayProvider>(context, listen: false)
                .typeNumber('1');
          },
        ),
        KeyButton(
          label: '2',
          onTap: (context) {
            Provider.of<DisplayProvider>(context, listen: false)
                .typeNumber('2');
          },
        ),
        KeyButton(
          label: '3',
          onTap: (context) {
            Provider.of<DisplayProvider>(context, listen: false)
                .typeNumber('3');
          },
        ),
        KeyButton(
          icon: FontAwesomeIcons.plus,
          onTap: (context) {
            Provider.of<DisplayProvider>(context, listen: false).plusSymbol();
          },
        ),
        const KeyButton(label: ''),
        KeyButton(
          label: '0',
          onTap: (context) {
            Provider.of<DisplayProvider>(context, listen: false)
                .typeNumber('0');
          },
        ),
        KeyButton(
          label: '•',
          onTap: (context) {
            Provider.of<DisplayProvider>(context, listen: false)
                .typeNumber('.');
          },
        ),
        KeyButton(
          icon: FontAwesomeIcons.equals,
          onTap: (context) {
            Provider.of<DisplayProvider>(context, listen: false).equals();
          },
        ),
      ];
      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      children: _standard,
    );
  }
}
