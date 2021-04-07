import 'package:flutter/foundation.dart';

import 'editorModel.dart';

class StoryModel extends ChangeNotifier {
  final List<EditorModel> _editorModels = [];

  void addStory(EditorModel editorModel) {
    _editorModels.add(editorModel);
    notifyListeners();
  }
}
