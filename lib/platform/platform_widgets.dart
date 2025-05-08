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

class PlatformListTile extends StatelessWidget {
  final Widget title;
  final bool selected;
  final VoidCallback onTap;
  final Color tileColor;
  final Widget? trailing;

  const PlatformListTile({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
    required this.tileColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    if (Platform.isWindows) {
      return fluent.ListTile(
        key: key,
        title: title,
        tileColor: WidgetStatePropertyAll(
          selected ? tileColor : Colors.transparent,
        ),
        onPressed: onTap,
        trailing: trailing,
      );
    }
    if (Platform.isMacOS) {
      return Container(
        color: selected ? tileColor : Colors.transparent,
        child: macos.MacosListTile(
          leading: trailing,
          title: title,
          onClick: onTap,
        ),
      );
    }
    if (Platform.isIOS) {
      return CupertinoListTile(
        title: title,
        onTap: onTap,
        trailing: trailing,
        backgroundColor: selected ? tileColor : Colors.transparent,
      );
    } else {
      return ListTile(
        title: title,
        selected: selected,
        onTap: onTap,
        trailing: trailing,
      );
    }
  }
}

class PlatformIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String? tooltip;

  const PlatformIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows) {
      return fluent.Tooltip(
        message: tooltip ?? '',
        child: fluent.IconButton(icon: icon, onPressed: onPressed),
      );
    } else if (Platform.isMacOS) {
      return macos.MacosTooltip(
        message: tooltip ?? '',
        child: macos.MacosIconButton(onPressed: onPressed, icon: icon),
      );
    } else if (Platform.isIOS) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: icon,
      );
    } else {
      return Tooltip(
        message: tooltip ?? '',
        child: IconButton(onPressed: onPressed, icon: icon, tooltip: tooltip),
      );
    }
  }
}

class PlatformTheme {
  final BuildContext context;

  const PlatformTheme({required this.context});

  /// Returns the appropriate platform theme object
  dynamic get theme {
    if (Platform.isIOS) {
      return CupertinoTheme.of(context);
    } else if (Platform.isAndroid) {
      return Theme.of(context);
    } else if (Platform.isWindows) {
      // return fluent_ui.FluentTheme.of(context);
      return Theme.of(context); // fallback
    } else if (Platform.isMacOS) {
      // return MacosTheme.of(context);
      return Theme.of(context); // fallback
    } else if (Platform.isLinux) {
      return Theme.of(context);
    } else {
      return Theme.of(context); // default fallback
    }
  }
}
