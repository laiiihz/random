import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model.dart';
import 'dart:math';
import 'package:dio/dio.dart';
import 'about.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _normalRandomNum = 0;
  final _maxValueController = TextEditingController();
  final _minValueController = TextEditingController();
  bool _zeroOneMode = false;
  bool _onlineMode = false;
  bool _onlineGet = false;
  String _minNum = '1';
  String _maxNum = '10';

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) {
        return new Scaffold(
          appBar: AppBar(
            title: Text('真随机数生成器'),
            actions: <Widget>[
              model.darkModeOn
                  ? Icon(Icons.brightness_3)
                  : Icon(Icons.brightness_7),
              Switch(
                onChanged: (bool value) {
                  model.setDarkMode(value);
                },
                value: model.darkModeOn,
              ),
              PopupMenuButton(
                itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                      new PopupMenuItem(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.casino),
                            Text('关于'),
                          ],
                        ),
                        value: 'about',
                      ),
                    ],
                onSelected: (value) {
                  if (value == 'about') {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => new AboutPage()));
                  }
                },
              ),
            ],
          ),
          floatingActionButton: Offstage(
              offstage: _onlineGet,
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (int.parse(_maxNum) < int.parse(_minNum)) {
                    var temp = _maxNum;
                    setState(() {
                      _maxNum = _minNum;
                      _minNum = temp;
                    });
                  }
                  setState(() {
                    if (_zeroOneMode && !_onlineMode) {
                      _normalRandomNum = Random().nextInt(2);
                    } else if (_zeroOneMode && _onlineMode) {
                      setState(() {
                        _onlineGet = true;
                      });
                      Response res;
                      void getHttp() async {
                        try {
                          res = await Dio().get(
                              'https://www.random.org/integers/?num=1&min=0&max=1&col=1&base=10&format=plain&rnd=new');
                          print(res);
                          setState(() {
                            _normalRandomNum = int.parse(res.data.toString());
                          });
                          setState(() {
                            _onlineGet = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      }

                      getHttp();
                    } else if (!_zeroOneMode && _onlineMode) {
                      setState(() {
                        _onlineGet = true;
                      });
                      Response res;
                      void getHttp() async {
                        try {
                          res = await Dio().get(
                              'https://www.random.org/integers/?num=1&min=' +
                                  _minNum +
                                  '&max=' +
                                  _maxNum +
                                  '&col=1&base=10&format=plain&rnd=new');
                          print(res);
                          setState(() {
                            _normalRandomNum = int.parse(res.data.toString());
                          });
                          setState(() {
                            _onlineGet = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      }

                      getHttp();
                    } else {
                      try {
                        _normalRandomNum = int.parse(_minNum) +
                            Random().nextInt(
                                int.parse(_maxNum) - int.parse(_minNum) + 1);
                      } catch (e) {
                        print(e);
                      }
                    }
                  });
                },
                label: Text('随机!'),
                icon: Icon(Icons.refresh),
              )),
          body: ListView(
            children: <Widget>[
              Container(
                color: Color(0x22ffffff),
                height: 300,
                child: Center(
                  child: Text(
                    _normalRandomNum.toString(),
                    style:
                        TextStyle(fontSize: 100, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 5, 5, 5),
                  child: Text(
                    '高级设置',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: TextField(
                      enabled: !_zeroOneMode,
                      controller: _maxValueController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '最大值',
                        hintText: '默认10',
                        filled: true,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() => _maxNum = value);
                        if (value.length == 0 || value.isEmpty) {
                          setState(() => _maxNum = '10');
                        } else {
                          try {
                            print(int.parse(value));
                          } catch (e) {
                            setState(() {
                              _maxNum = '10';
                              _maxValueController.clear();
                            });
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return new AlertDialog(
                                    title: Text('不能包含特殊字符'),
                                  );
                                });
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: TextField(
                      enabled: !_zeroOneMode,
                      controller: _minValueController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: '最小值',
                        hintText: '默认0',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() => _minNum = value);
                        if (value.length == 0 || value.isEmpty) {
                          setState(() => _minNum = '0');
                        } else {
                          try {
                            print(int.parse(value));
                          } catch (e) {
                            setState(() {
                              _minNum = '0';
                              _minValueController.clear();
                            });
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return new AlertDialog(
                                    title: Text('不能包含特殊字符'),
                                  );
                                });
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  Checkbox(
                      value: _onlineMode,
                      onChanged: (value) {
                        setState(() => _onlineMode = value);
                      }),
                  Text(
                    '真随机数模式',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  Checkbox(
                      value: _zeroOneMode,
                      onChanged: (value) {
                        setState(() => _zeroOneMode = value);
                      }),
                  Text(
                    '0/1模式',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  Offstage(
                    offstage: !_onlineGet,
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Text(
                      'API',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text(
                      'by',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text(
                      'RANDOM.ORG',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
