import 'package:flutter/material.dart';

// This widget displays the StoryView PAGE
// It displays it's content slightly different depending if it is in EditMode or not.
// This state is handled with a stateful widget, not in the EditorModel.
// That might be changed later.
//
// This was provided with the fitting EditorModel through ChangeNotifierProvider.
// It can be accessed here with Consumer etc.
class StoryView extends StatefulWidget {
  StoryView.addStory() : _startInEditMode = true;
  StoryView.viewStory() : _startInEditMode = false;

  final bool _startInEditMode;

  @override
  _StoryViewState createState() => _StoryViewState(_startInEditMode);
}

class _StoryViewState extends State<StoryView> {
  //Initialize state with the right editMode
  _StoryViewState(bool editMode) {
    _inEditMode = editMode;
  }

  bool _inEditMode;

  // Switches the EditMode to the contrary Mode and calls setState()
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
        body: Editor());
  }
}

// This widget provides a view of several Textfields,
// changing slightly depending on if the StoryView is in EditMode or not
// Build the ListView of SmartTextFields here
// and show the toolbar if the keyboard is visible.
// I don't need to implement keyboard actions, that is all handled by the TextFields,
class Editor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
