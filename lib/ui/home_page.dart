import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'bottom_bar.dart';
import 'file_list/file_list.dart';
import 'title_bar.dart';

class PDFMergeHomePage extends StatefulWidget {
  const PDFMergeHomePage({
    super.key,
    required this.title,
    required this.isDark,
    required this.onToggleTheme,
  });

  final String title;
  final bool isDark;
  final ValueChanged<bool> onToggleTheme;

  @override
  State<PDFMergeHomePage> createState() => _PDFMergeHomePageState();
}

class _PDFMergeHomePageState extends State<PDFMergeHomePage> {
  final List<String> _pdfFiles = [];
  final Set<String> _selectedPaths = {};
  bool _isPickingFiles = false;

  void _pickFiles() async {
    if (_isPickingFiles) return;

    _isPickingFiles = true;
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["pdf"],
        allowMultiple: true,
      );

      if (result != null) {
        setState(() {
          _pdfFiles.addAll(
            result.paths.whereType<String>().where(
              (element) => !_pdfFiles.contains(element),
            ),
          );
        });
      }
    } finally {
      _isPickingFiles = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return WindowBorder(
      color: colorScheme.primary,
      width: 1,
      child: Column(
        children: [
          TitleBar(
            isDark: widget.isDark,
            onToggleTheme: widget.onToggleTheme,
            onPickFiles: _pickFiles,
          ),
          Expanded(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(40),
                child: AppBar(
                  backgroundColor: colorScheme.surface,
                  actions: [
                    IconButton(
                      icon: Icon(
                        widget.isDark
                            ? Icons.dark_mode_outlined
                            : Icons.light_mode_outlined,
                      ),
                      onPressed: () => widget.onToggleTheme(!widget.isDark),
                    ),
                  ],
                ),
              ),
              body: FileList(
                files: _pdfFiles,
                selected: _selectedPaths,
                onDelete: _removeFile,
                onTap: _onSelect,
                onReorder: _onReorder,
              ),
              bottomNavigationBar: BottomBar(onMerge: _merge),
            ),
          ),
        ],
      ),
    );
  }

  void _merge() {
    // TODO: Merge file subset
  }

  void _removeFile(int index) {
    setState(() {
      _pdfFiles.removeAt(index);
    });
  }

  void _onSelect(int index) {
    final path = _pdfFiles[index];
    setState(() {
      if (_selectedPaths.contains(path)) {
        _selectedPaths.remove(path);
      } else {
        _selectedPaths.add(path);
      }
    });
  }

  void _onReorder(oldIndex, newIndex) {
    setState(() {
      if (oldIndex < newIndex) newIndex--;
      final element = _pdfFiles.removeAt(oldIndex);
      _pdfFiles.insert(newIndex, element);
    });
  }
}
