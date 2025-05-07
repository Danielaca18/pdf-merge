import 'dart:io';
import 'package:flutter/material.dart';

class FileTile extends StatelessWidget {
  final String filePath;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final int? reorderIndex;

  const FileTile({
    super.key,
    required this.filePath,
    required this.isSelected,
    required this.onTap,
    required this.onDelete,
    this.reorderIndex,
  });

  @override
  Widget build(BuildContext context) {
    final tile = ListTile(
      key: ValueKey("$filePath $isSelected"),
      title: Text(filePath.split(Platform.pathSeparator).last),
      tileColor:
          isSelected
              ? Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3)
              : null,
      trailing: IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
      onTap: onTap,
    );

    if (reorderIndex != null) {
      if (Platform.isAndroid || Platform.isIOS) {
        return ReorderableDelayedDragStartListener(
          index: reorderIndex!,
          child: tile,
        );
      } else {
        return ReorderableDragStartListener(index: reorderIndex!, child: tile);
      }
    }

    return tile;
  }
}
