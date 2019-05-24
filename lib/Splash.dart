import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  void go2HomePage() {
    Navigator.of(context).pushReplacementNamed('/HomePage');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppModel model = ScopedModel.of(context);
    Future<bool> testShared() async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      print('shared:' +
          sharedPreferences.getBool('darkMode' ?? false).toString());
      return sharedPreferences.getBool('darkMode' ?? false);
    }

    Future<bool> test = testShared();
    test.then((onValue) {
      model.setDarkMode(onValue ?? false);
    });

    Future.delayed(Duration(milliseconds: 1000), go2HomePage);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Color(0x33ffffff),
      child: Center(
        child: Image.asset(
          'assets/splash.png',
          width: 64,
        ),
      ),
    );
  }
}
