import 'package:flutter/material.dart';
import 'package:stories/storyView/smartContent.dart';

class Toolbar extends StatelessWidget {
  const Toolbar({Key key, this.selectedType, this.onSelected})
      : super(key: key);

  final SmartContentType selectedType;
  final ValueChanged<SmartContentType> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
