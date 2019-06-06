import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/HtmlParser.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_native_web/flutter_native_web.dart';
import 'package:http/http.dart' as http;

class Article extends StatefulWidget {
  final imageUrl;
  final title;
  final articleUrl;

  Article(this.title, this.imageUrl, this.articleUrl);

  @override
  _ArticleState createState() => new _ArticleState();
}

class _ArticleState extends State<Article> {
  String articleHtml = "";
  WebController _webController;

  loadArticle(String url) async {
    return await http.get(url).then((response) {
      setState(() {
        articleHtml = HtmlParser(response.body).parseHtml();
        urlToHtml[widget.articleUrl] = articleHtml;
        _webController.loadData(articleHtml);
      });
    });
  }

  void _onWebCreated(WebController webController) {
    print("inside initializer");
    _webController = webController;
    webController.loadData(articleHtml);
  }

  @override
  void initState() {
    if (urlToHtml.containsKey(widget.articleUrl)) {
      articleHtml = urlToHtml[widget.articleUrl];
    } else {
      loadArticle(widget.articleUrl);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text(widget.title)),
        body: new Padding(
            padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
            child: new Container(
                constraints: BoxConstraints.expand(),
                child: new FlutterNativeWeb(onWebCreated: _onWebCreated))));
  }
}
