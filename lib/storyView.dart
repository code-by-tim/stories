import 'package:flutter/material.dart';
import 'package:stories/editor.dart';

class StoryView extends StatefulWidget {
  StoryView.addStory() : _isInEditMode = true;

  final bool _isInEditMode;

  StoryView.viewStory() : _isInEditMode = false;

  @override
  _StoryViewState createState() => _StoryViewState(_isInEditMode);
}

class _StoryViewState extends State<StoryView> {
  _StoryViewState(bool editMode) {
    _inEditMode = editMode;
  }

  bool _inEditMode;

  void _switchEditMode() {
    setState(() {
      _inEditMode = !_inEditMode;
    });
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
      body: Editor(),
    );
  }
}
