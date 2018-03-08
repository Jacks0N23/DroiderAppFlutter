import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Droider List',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new FeedPage(title: 'Droider'),
    );
  }
}

class FeedPage extends StatefulWidget {
  FeedPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FeedPageState createState() => new _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  var _views = [];


  _loadData() async {
    var httpClient = new HttpClient();
    var link = 'http://droider.ru/wp-content/themes/droider/feed.php?category=0&slug=main&count=12&offset=0';
//    var uri = new Uri.http('http://droider.ru', '/wp-content/themes/droider/feed.php',
//        {'category': '0', 'slug':'main', 'count': '12', 'offset': '0'});
    /**
     * FIXME Эта строчка падает в рантайме при попытке вычленить из имени домена "droider.ru" номер порта
     * FIXME Он пробует сделать radix-чётотам и падает
     */
    var uri = Uri.parse(link);
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(UTF8.decoder).join();

    Map data = JSON.decode(responseBody);

    List items = data['posts'];

    var htmlUnEscape = new HtmlUnescape();

    var views = items.map((element) =>
    new Padding(padding: new EdgeInsets.all(8.0),
        child: new Card(child: new Column(children: <Widget>[
          new Image.network(element['picture_wide']),
          new Text(htmlUnEscape.convert(element['title']),
              style: new TextStyle(height: 4.0, fontWeight: FontWeight.bold))
        ],))));


    setState(() {
      _views = views.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadData();

    return new Scaffold(
      appBar: new AppBar(

        title: new Text(widget.title),
      ),
      body: new ListView(children: _views),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _loadData();
        },
        tooltip: 'Update data',
        child: new Icon(Icons.update),
      ),
    );
  }
}
