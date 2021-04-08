import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homePage.dart';
import 'storyModel.dart';

void main() {
  runApp(MyApp());
}

// This widget is the root of your application.
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
