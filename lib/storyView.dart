import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stories/editorModel.dart';

class StoryView extends StatefulWidget {
  StoryView.addStory() {
    final EditorModel _editor = EditorModel();
  }

  EditorModel _editor = EditorModel();

  StoryView.viewStory() {
    // Somehow get the right EditorModel
    final EditorModel _editor = EditorModel();
  }

  StoryView() {
    final EditorModel _editor = EditorModel();
  }

  @override
  _StoryViewState createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  void _switchEditMode() {
    setState(() {
      widget._editor.inEditMode = !widget._editor.inEditMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditorModel>(
      create: (context) => EditorModel(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  icon: Icon(
                      widget._editor.inEditMode ? Icons.edit_off : Icons.edit),
                  onPressed: _switchEditMode)
            ],
          ),
        );
      },
    );
  }
}
