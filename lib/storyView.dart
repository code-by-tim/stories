import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stories/editorModel.dart';

class StoryView extends StatefulWidget {
  StoryView.addStory();

  StoryView();

  @override
  _StoryViewState createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EditorModel>(
      builder: (context, editor, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  icon: Icon(editor.inEditMode ? Icons.edit_off : Icons.edit),
                  onPressed: editor.switchEditMode)
            ],
          ),
        );
      },
    );
  }
}
