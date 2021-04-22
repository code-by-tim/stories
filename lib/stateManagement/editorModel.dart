import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stories/storyView/smartContent.dart';

// This class stores everything related to a single story
// and handles changes to that story
// It provides everything needed to build the story view with a List of SmartContent
class EditorModel extends ChangeNotifier {
  // All variables needed to construct eacht SmartContentField
  // and more variables for the editor
  List<SmartContentType> _types = [];
  List<FocusNode> _nodes = [];
  List<TextEditingController> _controllers = [];
  List<int> _numeration = [];

  DateTime date;

  SmartContentType selectedType;

  // This constructor creates the first few SmartContent Fields for a new
  // and empty story.
  // An empty Story has a Heading, and in the future a
  // date and location field. (Also gonna be a type of SmartContentType)
  EditorModel.newStory() {
    selectedType = SmartContentType.HEADING;
    insertContent(index: 0, type: selectedType);
    date = DateTime.now();
    insertContent(index: 1, type: SmartContentType.LocationDate);
  }

  // Some useful methods
  int get fieldAmount => _types.length;
  int get activeFocusIndex {
    // Differ here cause DateLocation has no FocusNode
    if (_nodes.first.hasFocus) return 0;
    return _nodes.indexWhere((node) => node.hasFocus, 2);
  }

  FocusNode getFocusNodeAt(int index) => _nodes.elementAt(index);
  TextEditingController getControllerAt(int index) =>
      _controllers.elementAt(index);
  SmartContentType getTypeAt(int index) => _types.elementAt(index);
  int getNumerationAt(int index) => _numeration.elementAt(index);

  // Call this method after another SmartContent Field is focused to update
  // the selected type
  void setFocus(SmartContentType focusedType) {
    selectedType = focusedType;
    notifyListeners();
  }

  // Updates the numeration, starting at startIndex.
  // Stops if it reached the end of the SmartContentFields or
  // if a field is not a Numeration anymore
  void _updateNumeration({int startIndex}) {
    int index = startIndex;
    while (index <= fieldAmount - 1 &&
        getTypeAt(index) == SmartContentType.NUMERATION) {
      _numeration.removeAt(index);
      _numeration.insert(index, getNumerationAt(index - 1) + 1 ?? 1);
      index++;
    }
  }

  // Call this method after the user changes the SmartContentType of a Field
  // through the toolbar.
  void setType(SmartContentType pressedType) {
    if (activeFocusIndex != 0) {
      if (pressedType == selectedType) {
        selectedType = SmartContentType.T;
      } else {
        selectedType = pressedType;
      }

      // Update _types
      _types.removeAt(activeFocusIndex);
      _types.insert(activeFocusIndex, selectedType);

      // Update _numeration
      if (selectedType == SmartContentType.NUMERATION) {
        _numeration.removeAt(activeFocusIndex);
        _numeration.insert(
            activeFocusIndex, getNumerationAt(activeFocusIndex - 1) + 1);
      } else {
        _numeration.removeAt(activeFocusIndex);
        _numeration.insert(activeFocusIndex, 0);
      }
      _updateNumeration(startIndex: activeFocusIndex + 1);
    }

    notifyListeners();
  }

  // This method inserts the specified content at the specified index
  // It also registers a listener for editing changes.
  //
  // To mark the beginning of a SmartContent, the text starts with the empty
  // sign '\u200B'.
  // To check if a new SmartContent should be created,
  // we check if the text contains '\n'.
  //
  // This method itself does not call notifyListeners. Only the listener for
  // editing changes does.
  void insertContent({int index, SmartContentType type, String text}) {
    TextEditingController controller;
    if (type != SmartContentType.LocationDate) {
      controller = TextEditingController(
        text: '\u200B' + (text ?? ''),
      );
    } else {
      controller = null;
    }

    // Handle editing changes
    if (type != SmartContentType.LocationDate) {
      controller.addListener(() {
        bool deletionHappened = false;

        // Deletion and Merging
        if (!controller.text.startsWith('\u200B')) {
          final int index = _controllers.indexOf(controller);
          if (index > 2) {
            TextEditingController controllerBefore = _controllers[index - 1];
            controllerBefore.value = TextEditingValue(
              text: controllerBefore.text += controller.text,
              selection: TextSelection.fromPosition(
                TextPosition(
                    offset: controllerBefore.text.characters.length -
                        controller.text.characters.length),
              ),
            );
            getFocusNodeAt(index - 1).requestFocus();
            _types.removeAt(index);
            _controllers.removeAt(index);
            _nodes.removeAt(index);
            _numeration.removeAt(index);
            _updateNumeration(startIndex: index);
            notifyListeners();
          } else if (index <= 2) {
            // If the user deletes '\u200B' from the first normal text block
            // put it back again
            controller.value = TextEditingValue(
                text: controller.text = '\u200B' + controller.text,
                selection: TextSelection.fromPosition(TextPosition(offset: 1)));
          }
          deletionHappened = true;
        }

        // Creation after Enter
        if (controller.text.contains('\n')) {
          if (index >= 2) {
            final int index = _controllers.indexOf(controller);
            List<String> _splittetText = controller.text.split('\n');
            controller.text = _splittetText.first;
            insertContent(
              index: index + 1,
              type: selectedType,
              text: _splittetText.last,
            );
            getControllerAt(index + 1).selection = TextSelection.fromPosition(
              TextPosition(offset: 1),
            );
            getFocusNodeAt(index + 1).requestFocus();
          } else if (index == 0) {
            // If the user presses enter in the story title, insert textField
            controller.text = controller.text.replaceFirst('\n', '');
            insertContent(
              index: 2,
              type: SmartContentType.T,
            );
            getControllerAt(2).selection = TextSelection.fromPosition(
              TextPosition(offset: 1),
            );
            getFocusNodeAt(2).requestFocus();
          }
          notifyListeners();
        }

        // if text contains '\u200B' more than once, just keep the first instance
        if (controller.text.lastIndexOf('\u200B') > 3) {
          controller.text =
              '\u200B' + controller.text.substring(1).replaceAll('\u200B', '');
        }

        // If selection is before or contains the '\u200B', set Selection behind
        if (controller.selection.base.offset == 0 && !deletionHappened) {
          if (controller.selection.isCollapsed) {
            controller.selection =
                TextSelection.fromPosition(TextPosition(offset: 1));
          } else {
            controller.selection = TextSelection(
              baseOffset: controller.selection.baseOffset + 1,
              extentOffset: controller.selection.extentOffset,
            );
          }
        }
      });
    }

    _types.insert(index, type);
    _nodes.insert(
        index, (type != SmartContentType.LocationDate) ? FocusNode() : null);
    _controllers.insert(index, controller);
    _numeration.insert(
        index,
        (type == SmartContentType.NUMERATION)
            ? getNumerationAt(index - 1) + 1
            : 0);
  }
}
