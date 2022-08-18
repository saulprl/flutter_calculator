import 'package:flutter/material.dart';

class CalcDrawer extends StatelessWidget {
  const CalcDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
