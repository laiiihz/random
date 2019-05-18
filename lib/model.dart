import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
class AppModel extends Model{
  ThemeData _themeData=ThemeData.light();
  bool _darkModeOn=false;
  get themeData=>_themeData;
  get darkModeOn=>_darkModeOn;
  setDarkMode(bool value){
    _darkModeOn=value;
    if(value){
      _themeData=ThemeData.dark();
    }else _themeData=ThemeData.light();
    notifyListeners();
  }


}