import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:macos_ui/macos_ui.dart' as macos;

class PlatformButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const PlatformButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows) {
      return fluent.Button(onPressed: onPressed, child: child);
    } else if (Platform.isMacOS) {
      return macos.PushButton(
        controlSize: macos.ControlSize.regular,
        onPressed: onPressed,
        child: child,
      );
    } else if (Platform.isIOS) {
      return CupertinoButton(onPressed: onPressed, child: child);
    } else {
      return ElevatedButton(onPressed: onPressed, child: child);
    }
  }
}

class PlatformSwitch extends StatelessWidget {
  final void Function(bool) onChanged;
  final bool value;

  const PlatformSwitch({
    super.key,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows) {
      return fluent.ToggleSwitch(checked: value, onChanged: onChanged);
    } else if (Platform.isMacOS) {
      return macos.MacosSwitch(value: value, onChanged: onChanged);
    } else if (Platform.isIOS) {
      return CupertinoSwitch(value: value, onChanged: onChanged);
    } else {
      return Switch(value: value, onChanged: onChanged);
    }
  }
}
