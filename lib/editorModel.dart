import 'package:flutter/foundation.dart';

class EditorModel extends ChangeNotifier {
  EditorModel() {
    inEditMode = true;
  }
  bool inEditMode;
}
