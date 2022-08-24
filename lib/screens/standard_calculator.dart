import 'package:flutter/material.dart';

import '../widgets/display.dart';
import '../widgets/calc_drawer.dart';
import '../widgets/keyboards/keyboard.dart';
import '../widgets/keyboards/standard_keyboard.dart';

class StandardCalculator extends StatelessWidget {
  const StandardCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Standard'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      drawer: const CalcDrawer(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Display(),
            Keyboard(),
          ],
        ),
      ),
    );
  }
}
