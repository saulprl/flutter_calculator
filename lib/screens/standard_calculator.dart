import 'package:flutter/material.dart';

import '../widgets/display.dart';
import '../widgets/keyboards/basic_keyboard.dart';

class StandardCalculator extends StatelessWidget {
  const StandardCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Display(),
            BasicKeyboard(),
          ],
        ),
      ),
    );
  }
}
