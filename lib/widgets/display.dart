import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/display_provider.dart';

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  bool _isInit = false;
  late String _display;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      _display = Provider.of<DisplayProvider>(context).getDisplayAsString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.15,
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 4.0,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 4.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.black),
      ),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          _display,
          textAlign: TextAlign.right,
          // textDirection: TextDirection.rtl,
          style: const TextStyle(fontSize: 36.0),
        ),
      ),
    );
  }
}
