import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class AboutPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_AboutState();

}

class _AboutState extends State<AboutPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: false,
            pinned: true,
            snap: false,
            expandedHeight: 200.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('关于'),
              background: Text('关于',style: TextStyle(fontSize: 150,color: Color(0x33000000)),),
            ),
          ),
          SliverFixedExtentList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Center(
                  child: FlatButton(onPressed: (){
                    launch('https://github.com/laiiihz');//http://www.coolapk.com/u/748141
                  },child:new RichText(
                      text:new TextSpan(
                        children: [
                          TextSpan(
                              text: 'Laiiihz',
                              style: TextStyle(fontWeight: FontWeight.w300,color: Colors.black,fontSize: 50)
                          ),
                          new TextSpan(
                            text: 'Github',
                            style: TextStyle(fontWeight: FontWeight.w700,color: Colors.blue,fontSize: 50),
                          )
                        ],
                      )
                  ) ),
                ),
                Center(
                  child: FlatButton(onPressed: (){
                    launch('http://www.coolapk.com/u/748141');
                  },child:new RichText(
                      text:new TextSpan(
                        children: [
                          TextSpan(
                              text: 'Laihz',
                              style: TextStyle(fontWeight: FontWeight.w300,color: Colors.black,fontSize: 50)
                          ),
                          new TextSpan(
                            text: 'Coolapk',
                            style: TextStyle(fontWeight: FontWeight.w700,color: Colors.green,fontSize: 50),
                          )
                        ],
                      )
                  ) ),
                ),
              ],
            ),
            itemExtent: 120,
          )
        ],

      ),
    );
  }

}