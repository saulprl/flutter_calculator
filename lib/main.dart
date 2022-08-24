import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/display_provider.dart';

import './screens/standard_calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => DisplayProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Calculator',
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(
            primary: Colors.pink,
            onPrimary: Colors.white,
          ),
        ),
        home:
            const StandardCalculator(), //TODO: Add tabs for conversion calculators.
      ),
    );
  }
}
