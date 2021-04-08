import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';
import 'stateManagement/storyModel.dart';

void main() {
  runApp(MyApp());
}

// This widget is the root of the application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diary',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ChangeNotifierProvider(
        create: (context) => StoryModel(),
        child: MyHomePage(title: 'Personal Diary'),
      ),
    );
  }
}
