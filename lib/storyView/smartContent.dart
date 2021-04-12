import 'package:flutter/material.dart';
// This whole document is responsible for defining and displaying different
// types of text correctly.
// First, the text types and styles are defined
// Then, the class ___ is defined, which is displaying
// the text type

// Defines the different types of text which can be displayed in a story,
// including the text type picture and audioFile
enum SmartContentType {
  T,
  HEADING,
  QUOTE,
  BULLET,
  NUMERATION
} // PICTURE, AUDIO to be added

// Defines style, padding etc. for each text type
extension SmartTextStyle on SmartContentType {
  TextStyle get textStyle {
    switch (this) {
      case SmartContentType.HEADING:
        return TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);
        break;
      case SmartContentType.QUOTE:
        return TextStyle(
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
            color: Colors.grey[600]);
        break;
      default:
        return TextStyle(fontSize: 16.0);
    }
  }

  EdgeInsets get padding {
    switch (this) {
      case SmartContentType.HEADING:
        return EdgeInsets.fromLTRB(16, 24, 16, 8);
        break;
      case SmartContentType.NUMERATION:
      case SmartContentType.BULLET:
        return EdgeInsets.fromLTRB(24, 8, 16, 8);
      default:
        return EdgeInsets.fromLTRB(16, 8, 16, 8);
    }
  }

  TextAlign get align {
    switch (this) {
      case SmartContentType.QUOTE:
        return TextAlign.center;
        break;
      default:
        return TextAlign.start;
    }
  }

  // Returns null, a bullet point or the fitting number
  String get prefix {
    switch (this) {
      case SmartContentType.BULLET:
        return '\u2022 ';
        break;
      case SmartContentType.NUMERATION:
        return '1. ';
        break;
      default:
        return null;
    }
  }
}

// This widget displays the text-Type
class SmartContent extends StatelessWidget {
  SmartContent(
      {Key key, this.readOnly, this.type, this.controller, this.focusNode})
      : super(key: key);

  final SmartContentType type;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      //Here in the future ask for type, if it is picture or audio,
      //then return respective widget
      autofocus: true,
      // Setting this to true updates the UI and the User Input disappears
      readOnly: readOnly,
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      textAlign: type.align,
      style: type.textStyle,
      decoration: InputDecoration(
          border: InputBorder.none,
          prefixText: type.prefix,
          prefixStyle: type.textStyle,
          isDense: true,
          contentPadding: type.padding),
    );
  }
}
