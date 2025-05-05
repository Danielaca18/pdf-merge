import 'package:flutter/material.dart';

class FileTile extends StatelessWidget {
  final String filePath;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const FileTile({
    super.key,
    required this.filePath,
    required this.isSelected,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey("$filePath $isSelected"),
      title: Text(filePath.split("/").last),
      tileColor:
          isSelected
              ? Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3)
              : null,
      trailing: IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
      onTap: onTap,
    );
  }
}
