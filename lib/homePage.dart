import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stories/editorModel.dart';
import 'package:stories/storyModel.dart';
import 'package:stories/storyView.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Creates a new story and pushes that route
  // It also creates or overgives the suitable editor model
  void _createStory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider<EditorModel>(
          create: (context) => EditorModel(),
          child: StoryView.addStory(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryModel>(builder: (context, storyModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
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
