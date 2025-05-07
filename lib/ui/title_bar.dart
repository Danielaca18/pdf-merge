import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import '../platform/platform_widgets.dart';

class TitleBar extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onToggleTheme;
  final VoidCallback onPickFiles;

  const TitleBar({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
    required this.onPickFiles,
  });

  AppBar _buildAppBar() => AppBar(
    title: Text(""),
    actions: [
      PlatformIconButton(
        onPressed: onPickFiles,
        icon: Icon(Icons.upload_file),
        tooltip: "Pick PDF Files",
      ),
      PlatformSwitch(value: isDark, onChanged: onToggleTheme),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final background = Theme.of(context).colorScheme.surface;

    return WindowTitleBarBox(
      child: Container(
        color: background,
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: background,
                child: MoveWindow(child: _buildAppBar()),
              ),
            ),
            WindowButtons(),
          ],
        ),
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final background = colorScheme.surface;

    return Container(
      color: background,
      child: Row(
        children: [
          MinimizeWindowButton(colors: getButtonColors(colorScheme)),
          MaximizeWindowButton(colors: getButtonColors(colorScheme)),
          CloseWindowButton(colors: getCloseButtonColors(colorScheme)),
        ],
      ),
    );
  }
}

WindowButtonColors getButtonColors(ColorScheme colorScheme) {
  return WindowButtonColors(
    normal: colorScheme.surface,
    iconNormal: colorScheme.primary,
    iconMouseOver: colorScheme.secondary,
    iconMouseDown: colorScheme.primary.withValues(alpha: 0.8),
    mouseOver: colorScheme.secondary.withValues(alpha: 0.1),
    mouseDown: colorScheme.primary.withValues(alpha: 0.2),
  );
}

WindowButtonColors getCloseButtonColors(ColorScheme colorScheme) {
  return WindowButtonColors(
    normal: colorScheme.surface,
    iconNormal: colorScheme.primary,
    iconMouseOver: colorScheme.secondary,
    mouseOver: Colors.red.shade700,
    mouseDown: Colors.red.shade900,
  );
}
