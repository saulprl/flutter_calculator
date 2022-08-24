import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import '../providers/display_provider.dart';

class KeyButton extends StatelessWidget {
  final Math? tex;
  final String? label;
  final IconData? icon;
  final Function(BuildContext context)? onTap;

  const KeyButton({
    Key? key,
    this.tex,
    this.icon,
    this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<ContinuousRectangleBorder>(
          ContinuousRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.background,
              width: 2.0,
            ),
          ),
        ),
      ),
      onPressed: onTap == null
          ? null
          : () {
              onTap!(context);
            },
      child: tex ??
          (label != null
              ? label! == 'C'
                  ? Text(
                      Provider.of<DisplayProvider>(context).isEntryEmpty()
                          ? 'C'
                          : 'CE',
                      style: const TextStyle(fontSize: 22.0),
                    )
                  : Text(
                      label!,
                      style: const TextStyle(fontSize: 22.0),
                    )
              : Icon(icon!)),
    );
  }
}
