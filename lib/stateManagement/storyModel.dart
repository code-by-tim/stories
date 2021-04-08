import 'package:flutter/foundation.dart';
import '../stateManagement/editorModel.dart';

// This class stores the different stories within a List of EditorModels
class StoryModel extends ChangeNotifier {
  final List<EditorModel> _editorModels = [];

  //Inserts the specified EditorModel at the top of the List
  void addStory(EditorModel editorModel) {
    _editorModels.insert(0, editorModel);
    notifyListeners();
  }
}
