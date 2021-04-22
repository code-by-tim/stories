import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:stories/stateManagement/editorModel.dart';
import 'package:stories/storyView/smartContent.dart';
import 'package:stories/storyView/toolbar.dart';

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
      body: Editor(
        inEditMode: _inEditMode,
      ),
    );
  }
}

// This widget provides a view of several Textfields,
// changing slightly depending on if the StoryView is in EditMode or not
// Build the ListView of SmartTextFields here
// and show the toolbar if the keyboard is visible.
// I don't need to implement keyboard actions, that is all handled by the TextFields,
//
// Editor has access to its EditorModel through Consumer<EditorModel>
class Editor extends StatelessWidget {
  Editor({this.inEditMode});

  final bool inEditMode;
  final bool showToolbar = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // List of content:
        Positioned(
          top: 16,
          left: 0,
          right: 0,
          bottom: 56,
          child: Consumer<EditorModel>(
            builder: (context, editorModel, _) {
              return ListView.builder(
                itemCount: editorModel.fieldAmount,
                itemBuilder: (context, index) {
                  return Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus)
                        editorModel.setFocus(editorModel.getTypeAt(index));
                    },
                    child: SmartContent(
                      readOnly: !inEditMode,
                      type: editorModel.getTypeAt(index),
                      numerationNumber:
                          editorModel.getNumerationAt(index).toString(),
                      controller: editorModel.getControllerAt(index),
                      focusNode: editorModel.getFocusNodeAt(index),
                      date: editorModel.date,
                    ),
                  );
                },
              );
            },
          ),
        ),
        //Toolbar: The toolbar is causing everything not to be displayed
        // when not in editMode
        KeyboardVisibilityBuilder(
          builder: (context, keyboardIsVisible) {
            if (keyboardIsVisible) {
              return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Consumer<EditorModel>(
                  builder: (context, editorModel, _) {
                    return Toolbar(
                      selectedType: editorModel.selectedType,
                      onSelected: editorModel.setType,
                    );
                  },
                ),
              );
            } else {
              return Container(
                width: 0.0,
                height: 0.0,
              );
            }
          },
        )
      ],
    );
  }
}
