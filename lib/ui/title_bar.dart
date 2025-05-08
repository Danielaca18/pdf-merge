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

  Widget _buildMenuBar(BuildContext context, Color bgColor) {
    return Material(
      color: bgColor,
      child: Row(
        children: [
          _menu("File", []),
          _menu("Edit", []),
          _menu("View", []),
          _menu("Help", []),
        ],
      ),
    );
  }

  Widget _menu(String label, List<PopupMenuEntry> items) {
    return Material(
      type: MaterialType.transparency,
      child: PopupMenuButton(
        itemBuilder: (_) => items,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(label, style: const TextStyle(fontSize: 14)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        PlatformTheme(context: context).theme.colorScheme;

    return WindowTitleBarBox(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(
            bottom: BorderSide(
              color: colorScheme.surfaceBright.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: MoveWindow(
                child: _buildMenuBar(context, colorScheme.surface),
              ),
            ),
            WindowButtons(isDark: isDark),
          ],
        ),
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  final bool isDark;

  const WindowButtons({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final colorScheme = PlatformTheme(context: context).theme.colorScheme;
    final background = colorScheme.surface;

    return Material(
      child: Row(
        children: [
          MinimizeWindowButton(colors: getButtonColors(colorScheme, isDark)),
          MaximizeWindowButton(colors: getButtonColors(colorScheme, isDark)),
          CloseWindowButton(colors: getCloseButtonColors(colorScheme)),
        ],
      ),
    );
  }
}

WindowButtonColors getButtonColors(ColorScheme colorScheme, bool isDark) {
  return WindowButtonColors(
    iconNormal: colorScheme.primary,
    iconMouseOver: colorScheme.primary,
    iconMouseDown: colorScheme.primary.withValues(alpha: 0.8),
    mouseOver:
        isDark
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.black.withValues(alpha: 0.1),
    mouseDown: colorScheme.surface.withValues(alpha: 0.2),
  );
}

WindowButtonColors getCloseButtonColors(ColorScheme colorScheme) {
  return WindowButtonColors(
    iconNormal: colorScheme.primary,
    iconMouseOver: colorScheme.secondary,
    mouseOver: Colors.red.shade700,
    mouseDown: Colors.red.shade900,
  );
}
