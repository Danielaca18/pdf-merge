import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import '../platform/platform_widgets.dart';

class BottomBar extends StatelessWidget {
  final VoidCallback onMergeAll;
  final VoidCallback onMergeSelected;

  const BottomBar({
    super.key,
    required this.onMergeAll,
    required this.onMergeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PlatformButton(
            onPressed: onMergeSelected,
            child: Text("Merge Selected"),
          ),
          PlatformButton(onPressed: onMergeAll, child: Text("Merge All")),
        ],
      ),
    );
  }
}
