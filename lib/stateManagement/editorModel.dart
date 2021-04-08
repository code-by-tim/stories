import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:stories/storyView/smartContent.dart';

// This class stores everything related to a single story
// and handles changes to the story
// It provides everything needed to build the story view with a List of TextFields
class EditorModel extends ChangeNotifier {
  //A collection of lists needed for constructing each SmartTextField
  List<FocusNode> _nodes = [];
  List<TextEditingController> _controllers = [];
  List<SmartContentType> _types = [];

  //Other variables
  SmartContentType selectedType;

  EditorModel.newStory() {
    selectedType = SmartContentType.HEADING;
  }

// Getters for the different Lists
  int get fieldAmount => _types.length;
  int get focusIndex => _nodes.indexWhere((node) => node.hasFocus);

  FocusNode getFocusNodeAt(int index) => _nodes.elementAt(index);
  TextEditingController getControllerAt(int index) =>
      _controllers.elementAt(index);
  SmartContentType getTypeAt(int index) => _types.elementAt(index);
}
