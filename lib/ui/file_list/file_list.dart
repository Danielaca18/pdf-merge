import 'package:flutter/material.dart';
import 'file_tile.dart';

class FileList extends StatelessWidget {
  final List<String> files;
  final Set<String> selected;
  final void Function(int) onDelete;
  final void Function(int) onTap;
  final void Function(int, int) onReorder;

  const FileList({
    super.key,
    required this.files,
    required this.selected,
    required this.onDelete,
    required this.onTap,
    required this.onReorder,
  });

  Widget _buildFileTile(context, index) {
    final path = files[index];
    return FileTile(
      key: ValueKey("${path}_${selected.contains(path)}"),
      filePath: path,
      isSelected: selected.contains(path),
      onTap: () => onTap(index),
      onDelete: () => onDelete(index),
      reorderIndex: index,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      buildDefaultDragHandles: false,
      itemCount: files.length,
      onReorder: onReorder,
      itemBuilder: _buildFileTile,
    );
  }
}
