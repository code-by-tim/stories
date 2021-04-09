import 'package:flutter/material.dart';
import 'package:stories/storyView/smartContent.dart';

class Toolbar extends StatelessWidget {
  const Toolbar({Key key, this.selectedType, this.onSelected})
      : super(key: key);

  final SmartContentType selectedType;
  final ValueChanged<SmartContentType> onSelected;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      // Matches the expected size of the list in the stack of the editor
      preferredSize: Size.fromHeight(56.0),
      child: Material(
        // elevation: 4.0,
        color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.format_size),
              color: selectedType == SmartContentType.HEADING
                  ? Colors.teal
                  : Colors.black,
              onPressed: () => onSelected(SmartContentType.HEADING),
            ),
            IconButton(
              icon: Icon(Icons.format_quote),
              color: selectedType == SmartContentType.QUOTE
                  ? Colors.teal
                  : Colors.black,
              onPressed: () => onSelected(SmartContentType.QUOTE),
            ),
            IconButton(
              icon: Icon(Icons.format_list_bulleted),
              color: selectedType == SmartContentType.BULLET
                  ? Colors.teal
                  : Colors.black,
              onPressed: () => onSelected(SmartContentType.BULLET),
            ),
            IconButton(
              icon: Icon(Icons.format_list_numbered),
              color: selectedType == SmartContentType.NUMERATION
                  ? Colors.teal
                  : Colors.black,
              onPressed: () => onSelected(SmartContentType.NUMERATION),
            ),
            IconButton(
              icon: Icon(Icons.mic),
              color: selectedType == SmartContentType.NUMERATION
                  ? Colors.teal
                  : Colors.black,
              onPressed: () => onSelected(SmartContentType.NUMERATION),
            ),
            IconButton(
              icon: Icon(Icons.photo_camera),
              color: selectedType == SmartContentType.NUMERATION
                  ? Colors.teal
                  : Colors.black,
              onPressed: () => onSelected(SmartContentType.NUMERATION),
            ),
          ],
        ),
      ),
    );
  }
}
