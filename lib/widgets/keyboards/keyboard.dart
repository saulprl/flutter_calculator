import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_math_fork/flutter_math.dart';

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
          label: Provider.of<DisplayProvider>(context, listen: false)
                  .display
                  .isEmpty
              ? 'C'
              : 'CE',
        ),
      ];
      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('xd'),
    );
  }
}
