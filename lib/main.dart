import 'package:flutter/material.dart';
import 'homePage.dart';
import 'model.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<AppModel>(
      model: AppModel(),
      child: ScopedModelDescendant<AppModel>(
        builder: (context, child, model) {
          return MaterialApp(
            title: '随机游戏',
            home: HomePage(),
            theme: model.themeData,
          );
        },
      ),
    );
  }
}
