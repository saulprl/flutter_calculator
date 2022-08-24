import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/display_provider.dart';

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  late String _display;
  late String _history;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _display = Provider.of<DisplayProvider>(context).getDisplayAsString();
    _history = Provider.of<DisplayProvider>(context).getHistoryAsString();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 4.0,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 4.0,
      ),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(12.0),
      //   border: Border.all(color: Colors.black),
      // ),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _history,
              maxLines: 1,
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.grey[600], fontSize: 28.0),
            ),
            Text(
              _display,
              maxLines: 2,
              textAlign: TextAlign.right,
              // textDirection: TextDirection.rtl,
              style: const TextStyle(fontSize: 42.0),
            ),
          ],
        ),
      ),
    );
  }
}
