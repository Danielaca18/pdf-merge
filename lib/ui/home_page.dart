import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'file_tile.dart';
import 'bottom_bar.dart';
import '../platform/platform_widgets.dart';

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
  List<String> _pdfFiles = [];
  Set<String> _selectedPaths = {};

  void _pickFiles() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      color: Theme.of(context).colorScheme.primary,
      width: 1,
      child: Column(
        children: [
          WindowTitleBarBox(
            child: Row(
              children: [
                Expanded(child: MoveWindow(child: _buildAppBar())),
                WindowButtons(),
              ],
            ),
          ),
          Expanded(
            child: Scaffold(
              body: ReorderableListView.builder(
                itemCount: _pdfFiles.length,
                onReorder: _onReorder,
                itemBuilder: _buildFileTile,
              ),
              bottomNavigationBar: BottomBar(
                onMergeAll: _mergeAll,
                onMergeSelected: _mergeSelected,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _mergeSelected() {
    // TODO: Merge file subset
  }

  void _mergeAll() {
    // TODO: Marge all selection
  }

  Widget _buildFileTile(context, index) {
    final path = _pdfFiles[index];
    return FileTile(
      key: ValueKey("${_pdfFiles[index]}_${_selectedPaths.contains(path)}"),
      filePath: _pdfFiles[index],
      isSelected: _selectedPaths.contains(path),
      onTap: () => _toggleSelect(index),
      onDelete: () => _removeFile(index),
    );
  }

  void _removeFile(int index) {
    setState(() {
      _pdfFiles.removeAt(index);
    });
  }

  void _toggleSelect(int index) {
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

  AppBar _buildAppBar() => AppBar(
    title: Text(widget.title),
    actions: [
      IconButton(onPressed: _pickFiles, icon: Icon(Icons.upload_file)),
      PlatformSwitch(value: widget.isDark, onChanged: widget.onToggleTheme),
    ],
  );
}

final buttonColors = WindowButtonColors(
  iconNormal: const Color(0xFF805306),
  mouseOver: const Color(0xFFF6A00C),
  mouseDown: const Color(0xFF805306),
  iconMouseOver: const Color(0xFF805306),
  iconMouseDown: const Color(0xFFFFD500),
);

final closeButtonColors = WindowButtonColors(
  mouseOver: const Color(0xFFD32F2F),
  mouseDown: const Color(0xFFB71C1C),
  iconNormal: const Color(0xFF805306),
  iconMouseOver: Colors.white,
);

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
