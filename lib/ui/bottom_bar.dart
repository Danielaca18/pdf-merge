import 'package:flutter/material.dart';
import '../platform/platform_widgets.dart';

class BottomBar extends StatelessWidget {
  final VoidCallback onMerge;

  const BottomBar({super.key, required this.onMerge});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PlatformTheme(context: context).theme.colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [PlatformButton(onPressed: onMerge, child: Text("Merge"))],
      ),
    );
  }
}
