import 'package:flutter/material.dart';

class StoryView extends StatefulWidget {
  @override
  _StoryViewState createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  bool _inEditMode = true;

  void _switchEditMode() {
    print("blabla");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(_inEditMode ? Icons.edit_off : Icons.edit),
              onPressed: _switchEditMode)
        ],
      ),
    );
  }
}
