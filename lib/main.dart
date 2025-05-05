import 'dart:io';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'platform/app_wrappers.dart';

void main() {
  runApp(const PDFMergeApp());

  doWhenWindowReady(() {
    const initialSize = Size(600, 450);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class PDFMergeApp extends StatefulWidget {
  const PDFMergeApp({super.key});

  @override
  State<StatefulWidget> createState() => _PDFMergeState();
}

class _PDFMergeState extends State<PDFMergeApp> {
  bool _isDark = true;

  void _toggleTheme(bool val) => setState(() => _isDark = val);

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows)
      return WindowsApp(isDark: _isDark, onToggleTheme: _toggleTheme);
    if (Platform.isMacOS)
      return MacApp(isDark: _isDark, onToggleTheme: _toggleTheme);
    if (Platform.isIOS)
      return IOSApp(isDark: _isDark, onToggleTheme: _toggleTheme);
    return MaterialAppWrapper(isDark: _isDark, onToggleTheme: _toggleTheme);
  }
}
