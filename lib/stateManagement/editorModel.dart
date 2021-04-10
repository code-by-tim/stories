import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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

  SmartContentType selectedType;

  // This constructor creates the first few SmartContent Fields for a new
  // and empty story.
  // An empty Story has a Heading, and in the future a
  // date and location field. (Also gonna be a type of SmartContentType)
  EditorModel.newStory() {
    selectedType = SmartContentType.HEADING;
    _types.add(selectedType);
    _controllers.add(TextEditingController());
    _nodes.add(FocusNode());
  }

  // Getters for the different Lists
  int get fieldAmount => _types.length;
  int get activeFocusIndex => _nodes.indexWhere((node) => node.hasFocus);

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
  // through the toolbar.
  void setType(SmartContentType pressedType) {
    if (pressedType == selectedType) {
      selectedType = SmartContentType.T;
    } else {
      selectedType = pressedType;
    }
    // Update _types
    _types.removeAt(activeFocusIndex);
    _types.insert(activeFocusIndex, selectedType);
    notifyListeners();
  }
}
