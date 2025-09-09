import 'package:capcell/tree_view.dart';
import 'package:flutter/material.dart';

void main() {
  // listFiles("/Users/hasuiketakaya/development/flutter-project");
  runApp(MyApp());
  // runApp(FilePickerDemo());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        splashColor: Colors.transparent, // 波紋色
        highlightColor: Colors.transparent, // 長押し時のハイライト
        hoverColor: Colors.transparent, // Hover時(Web/デスクトップ)
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TreeViewPage();
  }
}
