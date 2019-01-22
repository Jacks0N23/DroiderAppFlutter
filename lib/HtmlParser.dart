import 'package:html/parser.dart';

class HtmlParser {
  final String articleHtml;
  String parsedHtml = """<html><body>hello</body></html>""";

  HtmlParser(this.articleHtml);

  String parseHtml() {
    final document = parse(articleHtml);
    final articles = document.querySelectorAll("article[id^=post]");
    if (articles.isNotEmpty) {
      final articleBody = articles[0].querySelectorAll(".article-body");
      var _articleHtml = _setupHtml(articleBody[0].outerHtml);
      print(_articleHtml);
      parsedHtml = _articleHtml;
      return _articleHtml;
    } else
      return parsedHtml;
  }

  String _setupHtml(String html) {
    return """<html><body><div class="container">$html</div></body></html>""";
  }
}
