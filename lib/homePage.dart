import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stories/stateManagement/editorModel.dart';
import 'package:stories/stateManagement/storyModel.dart';
import 'package:stories/storyView/storyView.dart';

// This widget has access to the StoryModel through Consumer<StoryModel>
// (see main.dart)
class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    // Creates a new story and provides an Editor Model,
    // which can be accessed in the StoryView with Consumer<EditorModel>
    void _createStory() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<EditorModel>(
            create: (context) => EditorModel.newStory(),
            child: StoryView.addStory(),
          ),
        ),
      );
    }

    return Consumer<StoryModel>(builder: (context, storyModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(
            'This is the homepage',
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _createStory,
          tooltip: 'Create Story',
          child: Icon(Icons.post_add, size: 30.0),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Icon(Icons.menu),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Icon(Icons.cake_rounded),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
