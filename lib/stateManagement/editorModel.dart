import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:stories/storyView/smartContent.dart';

// This class stores everything related to a single story
// and handles changes to the story
// It provides everything needed to build the story view with a List of TextFields
class EditorModel extends ChangeNotifier {
  // All variables needed to construct eacht SmartContentField
  // and more variables for the editor
  List<FocusNode> _nodes = [];
  List<TextEditingController> _controllers = [];
  List<SmartContentType> _types = [];

  SmartContentType selectedType;

  // This constructor creates the first few SmartContentFields for a new
  // and empty story.
  // An empty Story has a Heading, and in the future a
  // date and location field. (Also gonna be a type of SmartContentType)
  EditorModel.newStory() {
    selectedType = SmartContentType.HEADING;
    _types.add(selectedType);
  }

  // Getters for the different Lists
  int get fieldAmount => _types.length;
  int get focusIndex => _nodes.indexWhere((node) => node.hasFocus);

  // Some more useful methods
  FocusNode getFocusNodeAt(int index) => _nodes.elementAt(index);
  TextEditingController getControllerAt(int index) =>
      _controllers.elementAt(index);
  SmartContentType getTypeAt(int index) => _types.elementAt(index);

  // Call this method after another SmartContent Field is focused to update
  // the selected type
  void setFocus(SmartContentType focusedType) {
    selectedType = focusedType;
    notifyListeners();
  }

  // Call this method after the user changes the SmartContentType of a Field
  // through the toolbar
  void setType(SmartContentType pressedType) {
    if (pressedType == selectedType) {
      selectedType = SmartContentType.T;
    } else {
      selectedType = pressedType;
    }
    notifyListeners();
  }
}
