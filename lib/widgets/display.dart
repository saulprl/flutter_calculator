import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../providers/display_provider.dart';

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  late String _display;
  late String _history;
  late String _result;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _display = Provider.of<DisplayProvider>(context).getDisplayAsString();
    _history = Provider.of<DisplayProvider>(context).getHistoryAsString();
    _result = Provider.of<DisplayProvider>(context).getResultAsString();

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
              style: const TextStyle(color: Colors.white30, fontSize: 22.0),
            ),
            AutoSizeText(
              _display,
              maxLines: 3,
              style: const TextStyle(fontSize: 38.0),
            ),
            if (_result.isNotEmpty)
              Text(
                _result,
                maxLines: 1,
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.white70, fontSize: 28.0),
              ),
          ],
        ),
      ),
    );
  }
}
