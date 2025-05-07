import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:macos_ui/macos_ui.dart' as macos;
import '../ui/home_page.dart';

class WindowsApp extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onToggleTheme;
  final bool? showDebugBanner;

  const WindowsApp({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
    this.showDebugBanner,
  });

  @override
  Widget build(BuildContext context) {
    return fluent.FluentApp(
      title: "PDF Merge",
      themeMode: isDark ? fluent.ThemeMode.dark : fluent.ThemeMode.light,
      theme: fluent.FluentThemeData.light(),
      darkTheme: fluent.FluentThemeData.dark(),
      debugShowCheckedModeBanner: showDebugBanner ?? false,
      home: PDFMergeHomePage(
        title: "PDF Merge",
        isDark: isDark,
        onToggleTheme: onToggleTheme,
      ),
    );
  }
}

class MacApp extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onToggleTheme;
  final bool? showDebugBanner;

  const MacApp({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
    this.showDebugBanner,
  });

  @override
  Widget build(BuildContext context) {
    return macos.MacosApp(
      title: "PDF Merge",
      theme:
          isDark ? macos.MacosThemeData.dark() : macos.MacosThemeData.light(),
      debugShowCheckedModeBanner: showDebugBanner ?? false,
      home: PDFMergeHomePage(
        title: "PDF Merge",
        isDark: isDark,
        onToggleTheme: onToggleTheme,
      ),
    );
  }
}

class IOSApp extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onToggleTheme;
  final bool? showDebugBanner;

  const IOSApp({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
    this.showDebugBanner,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "PDF Merge",
      theme: CupertinoThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),
      debugShowCheckedModeBanner: showDebugBanner ?? false,
      home: PDFMergeHomePage(
        title: "PDF Merge",
        isDark: isDark,
        onToggleTheme: onToggleTheme,
      ),
    );
  }
}

class MaterialAppWrapper extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onToggleTheme;
  final bool? showDebugBanner;

  const MaterialAppWrapper({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
    this.showDebugBanner,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PDF Merge",
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: showDebugBanner ?? false,
      home: PDFMergeHomePage(
        title: "PDF Merge",
        isDark: isDark,
        onToggleTheme: onToggleTheme,
      ),
    );
  }
}
